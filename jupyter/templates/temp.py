# ---
# jupyter:
#   jupytext:
#     text_representation:
#       extension: .py
#       format_name: percent
#       format_version: '1.3'
#       jupytext_version: 1.15.1
#   kernelspec:
#       display_name: Python3
#       language: python
#       name: Python3
# ---

# %% [markdown]
# # Template Notebook

# %%
import closedloop.api_private as api
import plotly.express as px
import plotly.io as pio
import pandas as pd

# plotly setup
pio.renderers.default = 'notebook'
pd.options.plotting.backend = 'plotly'

# plot using CL colors
cl_colors = ['#207DBA', '#F7C31A', '#1fad58', '#7f52e0']
cl_template = pio.templates['plotly']
cl_template.layout.colorway = cl_colors
pio.templates['cl_template'] = cl_template
pio.templates.default = 'cl_template'


def pwrite(fig, plt='/tmp/vis/plot.json'):
    fig = fig.update_layout(autosize=False)
    fig.write_json(plt)


# %%
cl = api.ClosedLoopClientPrivate("PROD")
psId = "ltc_aco"
cl.getPersonStore(psId).name

# %%
# %%
# %%
