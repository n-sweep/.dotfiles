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

# %%
import os
import json
import numpy as np
import pandas as pd
import plotly.io as pio
# import plotly.express as px

# plotly setup
pio.renderers.default = 'notebook'
pd.options.plotting.backend = 'plotly'

def pwrite(fig, plt='/tmp/vis/plot.json'):
    fig = fig.update_layout(autosize=False)
    fig.write_json(plt)

# %% [markdown]
# # Template Notebook

# %%
# %%
# %%
