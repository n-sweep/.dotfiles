import datetime
import http.client
import json
import socket

ROBOT_HOUSE = '100.115.219.53'


# if plotly isn't installed, we don't care to do any of this
try:
    import plotly.graph_objects as go
    import plotly.io as pio
except Exception as e:
    print(e)
    exit()

# plotly setup
pio.templates.default = "plotly_dark"


def sanitize_numpy_types(obj):
    if isinstance(obj, dict):
        return {k: sanitize_numpy_types(v) for k, v in obj.items()}
    elif isinstance(obj, list):
        return [sanitize_numpy_types(i) for i in obj]
    elif isinstance(obj, float) and obj != obj:
        return None
    elif hasattr(obj, 'tolist'):
        return sanitize_numpy_types(obj.tolist())  # type: ignore
    elif hasattr(obj, 'item'):
        return obj.item()  # type: ignore
    elif isinstance(obj, (datetime.date, datetime.datetime)):
        return obj.isoformat()
    return obj


def get_lan_ip() -> str:
    """get the LAN IP address of the machine running the server"""
    try:
        s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
        s.connect(('8.8.8.8', 80))
        return s.getsockname()[0]
    except socket.error:
        return ''


def send_plot(ip: str, port: int, fig_json: str):
    conn = http.client.HTTPConnection(ip, port)
    conn.request(
        'POST', '/plot',
        body=fig_json,
        headers={'Content-Type': 'application/json'}
    )
    return conn.getresponse()


def patch_figure_show():
    # overriding plotly's Figure.show()
    _show = go.Figure.show

    def modified_show(self: go.Figure, *args, **kwargs) -> None:
        """plotly data has to be cleaned to be properly serialized for sending over HTTPS"""

        # separate layout from data
        fig_dict = {
            'data': [sanitize_numpy_types(t.to_plotly_json()) for t in self.data],  # type: ignore
            'layout': self.layout.to_plotly_json()
        }

        fig_json = json.dumps(fig_dict)

        try:
            r = send_plot(ROBOT_HOUSE, 8080, fig_json)
        except Exception:
            r = send_plot(get_lan_ip(), 8080, fig_json)

        if r.status != 200:
            # try to fall back on lan
            r = send_plot(get_lan_ip(), 8080, fig_json)
            if r.status != 200:
                print(r.status)
                print(r.reason)
                _show(self, *args, **kwargs) # type: ignore[arg-type]

    go.Figure.show = modified_show  # type: ignore[assignment]


try:
    import pandas as pd

    # pandas setup
    pd.options.plotting.backend = 'plotly'


except Exception as e:
    print(e)
    pass

patch_figure_show()
