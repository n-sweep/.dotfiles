import requests
import socket
import pandas as pd
import plotly.io as pio
import plotly.graph_objects as go

# pandas setup
pd.options.plotting.backend = 'plotly'

# plotly setup
pio.templates.default = "plotly_dark"


# overriding plotly's Figure.show()
_show = go.Figure.show
def modified_show(self, *args, **kwargs) -> None:
    r = requests.get(f'http://{get_lan_ip()}:5619/plot', json=self.to_json())
    if r.status_code != 200:
        _show(self, *args, **kwargs)
go.Figure.show = modified_show


def get_lan_ip() -> None:
    """get the LAN IP address of the machine running the server"""
    try:
        s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
        s.connect(('8.8.8.8', 80))
        return s.getsockname()[0]
    except socket.error:
        return None


def show_df(df: pd.DataFrame, updates: dict = {}) -> None:
    """plots a table of a pandas dataframe in plotly"""
    fig = go.Figure(data=go.Table(
       header=dict(values=df.columns),
        cells=dict(values=[df[col] for col in df.columns]),
    )).update_layout(updates)
    fig.show()
