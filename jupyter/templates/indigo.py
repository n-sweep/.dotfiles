# ---
# jupyter:
#   jupytext:
#     text_representation:
#       extension: .py
#       format_name: hydrogen
#       format_version: '1.3'
#       jupytext_version: 1.16.6
#   kernelspec:
#     display_name: Python 3 (ipykernel)
#     language: python
#     name: python3
# ---

# %%
import duckdb
import glob
import pandas as pd
import subprocess
import yaml

pd.options.display.width = 1000

# %% [markdown]
# ## Helper Functions

# %% jupyter={"source_hidden": true}
# get root of repository
REPO = subprocess.check_output(['git', 'rev-parse', '--show-toplevel'], text=True).strip()

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
        with open(f'{REPO}/notebooks/data-filters/{filter_file_name}.sql', 'r') as file:
            data_filter_query = file.read()
        con.execute(f"CREATE VIEW {filter_file_name} AS (" + data_filter_query + ")")

    with open(f"{feature_file_name}.sql", 'r') as file:
        query = file.read()

    df_from_sql = con.execute(query).df()

    con.close()
    print("df shape:", df_from_sql.shape)
    print(df_from_sql.head())
    return df_from_sql


def get_df_from_query(query: str, filter_file_name: str = '') -> pd.DataFrame:
    """Return a dataframe from a sql query. If a data
    filter is used, provide the name of the filter file.

    Args:
        query (str): sql query string.
        filter_file_name (str, optional): Name of data filter file. If provided,
        a filter will be loaded.
            Defaults to ''.

    Returns:
        pd.DataFrame: Dataframe from sql file data.
    """
    con = duckdb.connect(database=':memory:')

    if filter_file_name:
        with open(f'{REPO}/notebooks/data-filters/{filter_file_name}.sql', 'r') as file:
            data_filter_query = file.read()
        con.execute(f"CREATE VIEW {filter_file_name} AS ({data_filter_query})")

    df_from_sql = con.execute(query).df()

    con.close()
    print("df shape:", df_from_sql.shape)
    print(df_from_sql.head())
    return df_from_sql


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

    files = glob.glob(f"{REPO}/data/raw-data/{filter_start_wi}*")
    dfs = [pd.read_csv(f) for f in files]
    data_filter = pd.concat(dfs, ignore_index=True)

    return data_filter


# %% [markdown]
# [TODO] feature name
# # ``
# [TODO] expression
# ```
# ...
# ```

# %%
ftitle = ''  # [TODO]
filter = ''  # [TODO]

# [TODO] query
sql_query = f"""
WITH agg AS (
    SELECT
        NPI,
        AS_OF_DATE,
        ...
    FROM {filter}
)

SELECT
    npi,
    as_of_date,
    SUM(...)
        OVER (
            PARTITION BY npi
            ORDER BY as_of_date
            RANGE BETWEEN INTERVAL '364 DAYS' PRECEDING AND CURRENT ROW
        )
        AS {ftitle}
FROM agg
ORDER BY npi, as_of_date
"""

# %% [markdown]
# ## Testing
# [TODO]

# %%
query_df = get_df_from_query(sql_query, filter)
filter_df = get_filter_pd("Physicians_Commercial_Claims_Based_Payor_Mix_")


# %%
filter_df

# %%
query_df

# %%
test_df = filter_df.copy()

# %%
(query_df == test_df).all()

# %%
# create files from sql queries
# [TODO] save file
fname = f'{ftitle}.sql'
# produce_sql_file(sql_query=sql_query, sql_fileloc_wi_ext=fname)
print(fname, 'created')

# %%
