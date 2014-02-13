import 'dart:html';
import 'dart:async';
//import 'dart:js';
import 'dart:convert';

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
    
    var subscribeAutoUpdateButton = querySelector("#subscribeAutoUpdate");
    subscribeAutoUpdateButton.onClick.listen((ev) => subscribeAutoUpdateClick(ev));
    
    var subscribeLoginServiceButton = querySelector("#subscribeLoginService");
    subscribeLoginServiceButton.onClick.listen((ev) => subscribeLoginServiceClick(ev));
    
    var subscribeButton = querySelector("#subscribe");
    subscribeButton.onClick.listen((ev) => subscribeClick(ev));
    
    var unsubscribeButton = querySelector("#unsubscribe");
    unsubscribeButton.onClick.listen((ev) => unsubscribeClick(ev));
  }
 
  void connectClick(ev) {
    connect(); 
  }

  void closeClick(ev) {
    close(); 
  }
  
  void subscribeClick(ev) {
    subscribe(); 
  }
  
  void subscribeAutoUpdateClick(ev) {
    // 1  OUT  6  {"msg":"sub","id":"RuEMs6rwo5PdCv9qJ","name":"meteor_autoupdate_clientVersions","params":[]}
    var autoupdatePayload = '{"msg":"sub", "id":"RuEMs6rwo5PdCv9qJ", "name":"meteor_autoupdate_clientVersions", "params":[]}';
    outputMsg('OUT: $autoupdatePayload');
    send(autoupdatePayload);
  }
  
  void subscribeLoginServiceClick(ev) {
    // 1  OUT  11  {"msg":"sub","id":"NnJSdQsnDf5o8HLkE","name":"meteor.loginServiceConfiguration","params":[]}
    var loginServicePayload = '{"msg":"sub", "id":"NnJSdQsnDf5o8HLkE", "name":"meteor.loginServiceConfiguration", "params":[]}';
    outputMsg('OUT: $loginServicePayload');
    send(loginServicePayload);
  }

  void unsubscribeClick(ev) {
    unsubscribe(); 
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
     
      // 1  OUT  0  {"msg":"connect","version":"pre1","support":["pre1"]}
      var connectionPayload = '{"msg":"connect", "version":"pre1", "support":"[\'pre1\']"}';
      outputMsg('OUT: $connectionPayload');
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
  
  void handleMessage(var data) {
  }
  
  void close() {
    webSocket.close();
  }
  
  void callServerMethod() {
  }
  
  void subscribe() {    
    //  1  OUT  102  {"msg":"sub","id":"iQjpD7mYfm3D4ybEF","name":"posts","params":[]}
    var subscriptionPayload = '{"msg":"sub", "id":"iQjpD7mYfm3D4ybEF", "name":"posts", "params":[]}';
    outputMsg('OUT: $subscriptionPayload');
    send(subscriptionPayload);
  }
  
  void unsubscribe() {
    var endSubscriptionPayload = '{"msg":"unsub", "id":"iQjpD7mYfm3D4ybEF"}';
    outputMsg('OUT: $endSubscriptionPayload');
    send(endSubscriptionPayload);
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

/*
DDP Proxy Started on port: 3030
===============================
Export following env. variables and start your meteor app
  export DDP_DEFAULT_CONNECTION_URL=http://localhost:3030
  meteor

New Client: [1]

 1  OUT  0  {"msg":"connect","version":"pre1","support":["pre1"]}
 1  OUT  6  {"msg":"sub","id":"RuEMs6rwo5PdCv9qJ","name":"meteor_autoupdate_clientVersions","params":[]}
 1  OUT  11  {"msg":"sub","id":"NnJSdQsnDf5o8HLkE","name":"meteor.loginServiceConfiguration","params":[]}
 1  IN   6  {"server_id":"0"}
 1  IN   18  {"msg":"connected","session":"fh6asDzj785ALpDdD"}
 1  IN   5  {"msg":"added","collection":"meteor_autoupdate_clientVersions","id":"55f6b5c711a158082fe91949041fa4e1d53af5fc","fields":{"current":true}}
 1  IN   0  {"msg":"ready","subs":["RuEMs6rwo5PdCv9qJ"]}
 1  IN   18  {"msg":"ready","subs":["NnJSdQsnDf5o8HLkE"]}
 1  OUT  102  {"msg":"sub","id":"iQjpD7mYfm3D4ybEF","name":"posts","params":[]}
 1  IN   10  {"msg":"added","collection":"posts","id":"WAy3TbFzujvmq4xyB","fields":{"title":"Introducing Telescope","author":"Sacha Greif","url":"http://sachagreif.com/introducing-telescope/"}}
 1  IN   0  {"msg":"added","collection":"posts","id":"GEoTK9wbyc4jBvaqJ","fields":{"title":"Meteor","author":"Tom Coleman","url":"http://meteor.com"}}
 1  IN   1  {"msg":"added","collection":"posts","id":"o2tFc64QJxX42Nmwz","fields":{"title":"The Meteor Book","author":"Tom Coleman","url":"http://themeteorbook.com"}}
 1  IN   0  {"msg":"added","collection":"posts","id":"Nqsnu7E4ako5rP8KG","fields":{"url":"www.contra.gr","title":"Contra","message":"contra gr"}}
 1  IN   0  {"msg":"added","collection":"posts","id":"MvhfvGh9D99qyvhpj","fields":{"url":"www.redplanet.gr","title":"RedPlanet","message":"RedPlanet gr"}}
 1  IN   0  {"msg":"ready","subs":["iQjpD7mYfm3D4ybEF"]}
 */
