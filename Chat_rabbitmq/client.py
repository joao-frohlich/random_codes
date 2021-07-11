import pika
import random
import time
import _thread
import os


def read(channel):
    channel.start_consuming()


def saveFile(recv, send, cont):
    global id
    try:
        os.makedirs(recv + "-client")
    except:
        pass
    f = open(recv + "-client/" + send + "-" + str(id) + ".client", "w+")
    f.write(cont)


def fileToString(path):
    with open(path, "r") as f:
        return f.read()


def callback(channel, method, properties, body):
    global id, tag
    idx = body.find("#XD#")
    if idx != -1:
        id += 1
        sender = body[:idx]
        print(f"<{sender}> send file")
        saveFile(tag, sender, body[idx + 4 :])


id = 0

connection = pika.BlockingConnection(pika.ConnectionParameters(host="localhost"))
connection2 = pika.BlockingConnection(pika.ConnectionParameters(host="localhost"))

channel = connection.channel()
channel.queue_declare(queue="gasparini_frohlich_server")
server_name = "gasparini_frohlich_server"

tag = input("Set a nickname!")

channel.basic_publish(exchange="", routing_key=server_name, body="::ADD USER::" + tag)
time.sleep(2)


reader = connection2.channel()
reader.basic_consume(on_message_callback=callback, queue=tag)
print("Connected")
print("Listening for new messages...")
_thread.start_new_thread(read, (reader,))
while True:
    print(
        "/send filename - To send a file located on project root folder (try with 1Mb sample named 'sample.file')"
    )
    fileName = input().replace('/send ','')
    channel.basic_publish(
        exchange="",
        routing_key=server_name,
        body=tag + "#HEAD#" + fileToString(fileName),
    )
    print("Sent!")
