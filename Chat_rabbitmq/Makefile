COMPILER = javac
FLAGS = -cp .:/usr/share/java/amqp-client.jar:/usr/share/java/slf4j-api.jar:/usr/share/java/slf4j-simple.jar
TARGET = Server.class

all: $(TARGET) setup

Server.class: Server.java
	$(COMPILER) $(FLAGS) Server.java

run_server:
	java $(FLAGS) Server

run_client:
	python3 client.py

clean:
	rm -rf *~ $(TARGET)
