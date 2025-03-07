# ---
# jupyter:
#   jupytext:
#     text_representation:
#       extension: .py
#       format_name: hydrogen
#       format_version: '1.3'
#       jupytext_version: 1.16.4
#   kernelspec:
#     display_name: Python 3 (ipykernel)
#     language: python
#     name: python3
# ---

# %% [markdown]
# [TODO] feature name
# # `average_sum_of_procedures_in_category_<ontology-name>_<ontology-code>_2yr_dhc`

# %%
import duckdb
import glob
import pandas as pd
import yaml

# %% [markdown]
# ## Helper Functions

# %% jupyter={"source_hidden": true}
def get_ontologies(path):
    with open(path, 'r') as file:
        return yaml.safe_load(file)


def get_df_from_query_file(feature_file_name: str, filter_file_name: str = '') -> pd.DataFrame:
    """Return a dataframe from a sql file name. If a data
    filter is used, provide the name of the filter file.

    Args:
        sql_path (str): path to sql file.
        filter_file_name (str, optional): Name of data filter file. If provided,
        a filter will be loaded.
            Defaults to ''.

    Returns:
        pd.DataFrame: Dataframe from sql file data.
    """
    con = duckdb.connect(database=':memory:')

    if filter_file_name:
        with open(f'../data-filters/{filter_file_name}.sql', 'r') as file:
            data_filter_query = file.read()
        con.execute(f"CREATE VIEW {filter_file_name} AS (" + data_filter_query + ")")

    with open(f"{feature_file_name}.sql", 'r') as file:
        query = file.read()

    df_from_sql = con.execute(query).df()

    con.close()
    print("df shape:", df_from_sql.shape)
    print(df_from_sql.head())
    return df_from_sql


def generate_sql(features_to_build: dict, ontologies: list, sql_query: str, ftitle: str) -> list[str]:
    output = []
    for level in ontologies:
        for ontology in level:
            if ontology['Code'] in features_to_build:
                children_code_list = [ontology_deeper['Code'].replace(".", "") for ontology_deeper in ontology['Codes']]
                code_list_str = ', '.join([f"'{code}'" for code in children_code_list])

                label_name = features_to_build[ontology['Code']].replace(" ", "_").replace("/", "_or_").replace("-", "_")
                label_code = ontology['Code'].replace(".", "_")
                fname = ftitle.format(label_name, label_code).lower()

                output.append((fname, sql_query.format(code_list_str, fname), children_code_list))
                print(fname)

    return output


def produce_sql_file(sql_query, sql_fileloc_wi_ext):
    with open(sql_fileloc_wi_ext, 'w') as file:
        file.write(sql_query)


def get_filter_pd(filter_start_wi:str) -> pd.DataFrame:
    """Return a dataframe of data filter,
    provide the starting string of the name of the filter file.

    Args:
        filter_start_wi (str): starting string of data filter file names.

    Returns:
        pd.DataFrame
    """
    files = glob.glob(f"../../data/raw-data/{filter_start_wi}*")
    dfs = [pd.read_csv(f) for f in files]
    data_filter = pd.concat(dfs, ignore_index=True)
    return data_filter


# %% [markdown]
# ## Create new feature query

# %%
# [TODO] get correct ontologies (if any)
ontologies = [get_ontologies(o) for o in (
    "../../data/raw-data/ccspcs_procedures_ontology_level_1_created2024-05-14.yaml",
    "../../data/raw-data/ccspcs_procedures_ontology_level_2_created2024-05-14.yaml",
    "../../data/raw-data/ccspcs_procedures_ontology_level_3_created2024-05-14.yaml",
)]

# %%
# [TODO]
ftitle = 'average_sum_of_procedures_in_category_{0}_{1}_2yr_dhc'
features_to_replicate = [
    "DHC - Count of procedures in category_ Fetal monitoring_ 13_7 (2Y Average)",
    "DHC - Count of procedures in category_ Routine chest X-ray_ 16_5 (2Y Average)",
]

features_to_build = {}
for feature in features_to_replicate:
    name = ' '.join(feature[:-13].split('_ ')[1:-1])
    features_to_build[feature[:-13].split("_ ")[-1].replace("_", ".")] = name

features_to_build

# %%
# [TODO] query
sql_query = """WITH agg AS (
    SELECT
        npi,
        as_of_date,
        SUM(number_procedures) AS number_procedures_per_npi_date
    FROM procedures_dhc
    WHERE
        procedure_code IN ({0})
    GROUP BY npi, as_of_date
)

SELECT
    npi,
    as_of_date,
    AVG(number_procedures_per_npi_date) OVER (
        PARTITION BY npi
        ORDER BY as_of_date
        RANGE BETWEEN INTERVAL '1 YEAR 364 DAYS' PRECEDING AND CURRENT ROW
    ) AS {1}
FROM agg
ORDER BY npi, as_of_date
"""

# %%
# generate sql queries
sql_codes = generate_sql(features_to_build, ontologies, sql_query, ftitle)
len(sql_codes)

# %%
# create files from sql queries
for fname, sql, _ in sql_codes:
    fname = f'{fname}.sql'
    produce_sql_file(sql_query=sql, sql_fileloc_wi_ext=fname)
    print(fname, 'created')

# %% [markdown]
# ## Testing

# %%
frames = {}
# [TODO] get correct filter name
filter = 'procedures_dhc'
for fname, _, _ in sql_codes:
    frames[fname] = {
        'query': get_df_from_query_file(fname, filter),
        # [TODO] get correct filter source
        'filter': get_filter_pd("Physicians_Commercial_Procedures")
    }

# %%
fname, sql, children_code_list = sql_codes[0]
query_df = frames[fname]['query'].copy()
filter_df = frames[fname]['filter'].copy()

# %%
query_df.shape
filter_df.shape

# %%
query_df.info()
filter_df.info()

# %%
# [TODO] create test dataframe & compare

# %%
# `filter_df` contains "2024 through July" again, but this time `query_df` also includes 2024 dates
query_df['AS_OF_DATE'].value_counts()
filter_df['CLAIM_YEAR'].value_counts()

# %%
for fname, sql, children_code_list in sql_codes:
    query_df = frames[fname]['query'].copy()
    filter_df = frames[fname]['filter'].copy()

    # mask procedure codes & copy dataframe
    mask = filter_df['HCPCS_CPT_CODE'].isin(children_code_list)
    test_df = filter_df.copy()[mask][['NPI', 'CLAIM_YEAR', 'NUMBER_PROCEDURES']]

    # strip " through July" from dates
    test_df.loc[m, 'CLAIM_YEAR'] = (r:=test_df['CLAIM_YEAR'].str.replace(' through July', ''))[m:=r.notna()]

    # add '-12-31' to the date formatting; convert to datetime
    test_df['CLAIM_YEAR'] = (test_df['CLAIM_YEAR'].astype(str) + '-12-31').astype({'CLAIM_YEAR': 'datetime64[ns]'})
    test_df['CLAIM_YEAR'].value_counts()

    # aggregation
    test_df = (
        test_df  # type: ignore
        .sort_values(['NPI', 'CLAIM_YEAR'])  # type: ignore
        # aggregate by NPI/date
        .groupby(['NPI', 'CLAIM_YEAR'], as_index=False)
        .sum()
        # 1y + 364 days rolling lookback
        .groupby('NPI')
        .rolling('729D', on='CLAIM_YEAR')
        .mean()
        .reset_index(level=0)
        .rename(columns={
            'CLAIM_YEAR': 'AS_OF_DATE',
            'NUMBER_PROCEDURES': fname,
        })
    )

    print(fname)
    print(test_df.shape == query_df.shape)
    print((test_df == query_df).all())

# %%
