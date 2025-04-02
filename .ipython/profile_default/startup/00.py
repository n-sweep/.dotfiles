import json
import http.client
import socket


# if plotly isn't installed, we don't care to do any of this
try:
    import plotly.graph_objects as go
    import plotly.io as pio

    # plotly setup
    pio.templates.default = "plotly_dark"


    def get_lan_ip() -> None:
        """get the LAN IP address of the machine running the server"""
        try:
            s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
            s.connect(('8.8.8.8', 80))
            return s.getsockname()[0]
        except socket.error:
            return None


    def patch_figure_show():
        # overriding plotly's Figure.show()
        _show = go.Figure.show

        def modified_show(self: go.Figure, *args, **kwargs) -> None:
            fig_json = json.loads(j if (j:=self.to_json()) is not None else '')

            for i, data in enumerate(fig_json['data']):
                if 'bdata' in data['y']:
                    data['y'] = self.data[i].y.tolist()  # type: ignore

            conn = http.client.HTTPConnection(f'http://{get_lan_ip()}:5619/plot')
            conn.request('GET', '/plot', body=json.dumps(fig_json), headers={'Content-Type': 'application/json'})
            r = conn.getresponse()

            if r.status != 200:
                _show(self, *args, **kwargs)

        go.Figure.show = modified_show


except:
    exit()


# if pandas isn't installed, we can just skip over the pandas portion
try:
    import pandas as pd

    # pandas setup
    pd.options.plotting.backend = 'plotly'


    def show_df(df: pd.DataFrame, updates: dict = {}) -> None:
        """plots a table of a pandas dataframe in plotly"""
        fig = go.Figure(data=go.Table(
           header=dict(values=df.columns),
            cells=dict(values=[df[col] for col in df.columns]),
        )).update_layout(updates)
        fig.show()

except:
    pass


patch_figure_show()
