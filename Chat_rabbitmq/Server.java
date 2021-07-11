import java.io.*;
import java.util.*;
import com.rabbitmq.client.*;

public class Server{

  private final static List<String> queue_list = new ArrayList<String>();
  private static ConnectionFactory factory;
  private static Connection connection;
  private static Channel channel;
  static int id = 0;

  public static void sendFile(String message, String tag){
    for (int i = 1; i < queue_list.size(); i++) {
      try {
        String queue_name = queue_list.get(i);
        if(tag.compareTo(queue_name) == 0){
		continue;
	}
	channel.queueDeclare(queue_name, false, false, false, null);
        channel.basicPublish("", queue_name, null, message.getBytes("UTF-8"));
      } catch (Exception e) {
        continue;
      }  
    } 
  }

 public static void downloadFile(String fileName, String message){
	try{
	String path = "server";
        new File(path).mkdir();
        FileWriter output = new FileWriter(path+"/"+fileName);
        output.write(message);
        output.close();
	}catch(Exception e){
		return;
	}
 }

  public static void main(String[] argv) throws Exception {
    factory = new ConnectionFactory();
    factory.setHost("localhost");
    connection = factory.newConnection();
    channel = connection.createChannel();
    queue_list.add("gasparini_frohlich_server");

    channel.queueDeclare(queue_list.get(0), false, false, false, null);
    System.out.println("Waiting for new messages...");

    Consumer consumer = new DefaultConsumer(channel) {
      @Override
      public void handleDelivery(String consumerTag, Envelope envelope, AMQP.BasicProperties properties, byte[] body) throws IOException {
        String message = new String(body, "UTF-8");
        if(message.startsWith("::ADD USER::")){
	  String name = message.substring(12);
	  queue_list.add(name);
          Channel aux;
	  aux = connection.createChannel();
	  aux.queueDeclare(queue_list.get(queue_list.size()-1), false, false, false, null);
	  System.out.println("*<" + queue_list.get(queue_list.size()-1) + "> connected");
        }else{
	  id++;
	  int idx = message.indexOf("#HEAD#");
	  String tag = message.substring(0, idx);
	  System.out.println("*<" +tag +  "> sent a file");
          downloadFile(tag + "-" + id  + ".serv", message.substring(idx+4));
	  sendFile(message, tag);
        }
      }
    };
    while(true){
	try{
    		channel.basicConsume(queue_list.get(0), true, consumer);
    	}catch(Exception e){
		break;
	}
    }
    channel.close();
    connection.close();
  }
}
