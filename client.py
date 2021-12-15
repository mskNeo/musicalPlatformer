from pythonosc.udp_client import SimpleUDPClient

ip = "127.0.0.1"
port = 1337

client = SimpleUDPClient(ip, port)

def hitObj(obj): 
    client.send_message(f"/event/hit/{obj}", True)   # Send float message
