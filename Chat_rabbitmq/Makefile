COMPILER = javac
TARGET = Server.class

all: $(TARGET) setup

Server.class: Server.java
	$(COMPILER) Server.java

run_server:
	java Server

run_client:
	python client.py

clean:
	rm -rf *~ $(TARGET)