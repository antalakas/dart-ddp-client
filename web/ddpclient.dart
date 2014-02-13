import 'dart:html';
import 'dart:async';
import 'dart:js';

class DDPClient {
  
  WebSocket webSocket;
  
  String host;
  int port;
  String path;
  
  DDPClient([String host = 'localhost', int port = 3000, String path = 'websocket']) {
    
    this.host = host;
    this.port = port;
    this.path = path;
    
    var connectButton = querySelector("#connect");
    connectButton.onClick.listen((ev) => connectClick(ev));
    
    var closeButton = querySelector("#close");
    closeButton.onClick.listen((ev) => closeClick(ev));
  }
 
  void connectClick(ev) {
    connect(); 
  }

  void closeClick(ev) {
    close(); 
  }
  
  void connect([int retrySeconds = 2]) {

    String protocol = 'ws://';
    String socketURL = protocol + host + ':' + port.toString() + '/' + path;
    
    bool reconnectScheduled = false;
    outputMsg("Connecting to webSocket");
    webSocket = new WebSocket(socketURL);
    
    void scheduleReconnect([bool reconnectScheduled = false]) {
      if (!reconnectScheduled) {
        new Timer(new Duration(milliseconds: 1000 * retrySeconds), () => connect(retrySeconds * 2));
      }
    }
    
    webSocket.onOpen.listen((e) {
      outputMsg('Connected to webSocket');
      var connectionPayload = new JsObject(context['connectionPayload']);
      send(connectionPayload);
    });

    webSocket.onClose.listen((e) {
      outputMsg('webSocket closed');
      scheduleReconnect(true);
    });

    webSocket.onError.listen((e) {
      outputMsg("Error connecting to webSocket, retrying in $retrySeconds seconds");
      scheduleReconnect();
    });

    webSocket.onMessage.listen((MessageEvent e) {
      outputMsg('Received message: ${e.data}');
      handleMessage(e.data);
    });
  } 
  
  void send(var data) {
    webSocket.send(data);
  }
  
  // handle a message from the server
  // data
  void handleMessage(var data) {
  }
  
  void close() {
    webSocket.close();
  }
  
  // call a method on the server,
  //
  // callback = function(err, result)
  // name, params, callback
  void callServerMethod() {
    //var id = self._nextId();

    //if (callback)
    //  callbacks[id] = callback;

    //send({msg: 'method', id: id, method: name, params: params});
  }
  
  // open a subscription on the server, callback should handle on ready and nosub
  // name, params, callback
  void subscribe() {
    //var id = self._nextId();

    //if (callback)
    //  callbacks[id] = callback;

    //send({msg: 'sub', id: id, name: name, params: params});
  }
  
  // id
  void unsubscribe() {
    // send({msg: 'unsub', id: id});
  }
}

void outputMsg(String msg) {
  var output = querySelector("#output");
  var text = msg;
  if (!output.text.isEmpty) {
    text = "${output.text}\n${text}";
  }
  output.text = text;
}

void main() {
  
  DDPClient ddpClient = new DDPClient(); 
}
