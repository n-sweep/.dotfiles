from app import app, socketio

import logging
import os
import socket
import time
import threading
import webbrowser


def main():
    host_name = socket.getfqdn()
    ip = socket.gethostbyname(host_name)
    port = 5619

    logging.basicConfig(
        filename='~/.local/share/nvim/pvserv.log',
        level=logging.INFO
    )

    config = {
        'file': '/tmp/vis/plot.json',
        'interval': 0.1,
        'url': f'http://{ip}:{port}'
    }

    app.config.update(config)

    threading.Timer(0.5, webbrowser.open_new, [app.config['url']]).start()
    socketio.run(app, host=ip, port=port)


if __name__ == "__main__":
    main()
