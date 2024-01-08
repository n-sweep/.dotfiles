from app import app, socketio

import logging
import os
import socket
import time
import threading
import webbrowser


def ensure_dir(dir):
    if not os.path.isdir(dir):
        os.makedirs(dir)


def launch_server(host, port, config):
    app.config.update(config)
    threading.Timer(0.5, webbrowser.open_new, [app.config['url']]).start()
    socketio.run(app, host=host, port=port)


def main():
    plot_file = '/tmp/vis/plot.json'
    log_file = os.path.expanduser('~/.local/share/nvim/pvserv.log')

    logging.basicConfig(filename=log_file, level=logging.INFO)

    host_name = socket.getfqdn()
    ip = socket.gethostbyname(host_name)
    port = 5619

    config = {
        'file': plot_file,
        'interval': 0.1,
        'url': f'http://{ip}:{port}'
    }

    ensure_dir(plot_file)
    launch_server(ip, port, config)


if __name__ == "__main__":
    main()
