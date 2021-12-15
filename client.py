from pythonosc.udp_client import SimpleUDPClient

ip = "127.0.0.1"
port = 57120

client = SimpleUDPClient(ip, port)

def hitPlatform(num): 
    client.send_message("/hit", ["platform", num])   # Send float message

def hitGoal(): 
    client.send_message("/hit", "goal")   # Send float message
