from pythonosc.dispatcher import Dispatcher
from pythonosc.osc_server import BlockingOSCUDPServer

ip = "127.0.0.1"
port = 1337

def print_handler(address, *args):
    print(f"{address}: {args}")

def default_handler(address, *args):
    print(f"DEFAULT {address}: {args}")

dispatcher = Dispatcher()
server = BlockingOSCUDPServer((ip, port), dispatcher)

dispatcher.map("/event/*", print_handler)
dispatcher.set_default_handler(default_handler)

server.serve_forever()  # Blocks forever