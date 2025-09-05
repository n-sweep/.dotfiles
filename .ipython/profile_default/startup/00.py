import datetime
import json
import http.client
import socket
from typing import TypeVar

ROBOT_HOUSE = '100.115.219.53'


# if plotly isn't installed, we don't care to do any of this
try:
    import plotly.graph_objects as go
    import plotly.io as pio

    # plotly setup
    pio.templates.default = "plotly_dark"


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
        T = TypeVar('T', bound=go.Figure)

        def modified_show(self: T, *args, **kwargs) -> T:
            # Manually construct the figure dictionary
            fig_dict = {
                'data': [],
                'layout': self.layout.to_plotly_json()
            }

            for trace in self.data:
                trace_dict = trace.to_plotly_json()
                for key, value in trace_dict.items():
                    if hasattr(value, 'tolist'):
                        trace_dict[key] = value.tolist()
                fig_dict['data'].append(trace_dict)

            # Convert datetime objects to ISO 8601 strings
            def default(o):
                if isinstance(o, (datetime.date, datetime.datetime)):
                    return o.isoformat()
                raise TypeError(f'Object of type {o.__class__.__name__} is not JSON serializable')

            fig_json = json.dumps(fig_dict, default=default)

            # r = send_plot(ROBOT_HOUSE, 8080, fig_json)
            r = send_plot('localhost', 8080, fig_json)

            if r.status != 200:
                # try to fall back on lan
                r = send_plot(get_lan_ip(), 8080, fig_json)
                if r.status != 200:
                    return _show(self, *args, **kwargs) # type: ignore[arg-type]

            return self

        go.Figure.show = modified_show  # type: ignore[assignment]


    try:
        import pandas as pd

        # pandas setup
        pd.options.plotting.backend = 'plotly'


    except Exception as e:
        print(e)
        pass

    patch_figure_show()

except Exception as e:
    print(e)
    exit()
