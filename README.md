dart-ddp-client
===============

Dart DDP Client

An experiment, trying to enable dart to subscribe to meteor collections using ddp protocol.

Based on:
--------
https://github.com/oortcloud/node-ddp-client
https://github.com/dart-lang/dart-samples/tree/master/web/html5/websockets/basics
https://github.com/meteor/meteor/blob/devel/packages/livedata/DDP.md

You need the posts collection from microscope sample application.

You need also the ddp-analyzer:
http://meteorhacks.com/discover-meteor-ddp-in-realtime.html

What works:
----------
1. Connect to web socket

2. Login(plain text)/Connection to the ddp server

3. Subscribe/Unsubscribe to collections.


To do:
-----
1. Handling collection(s) retrieval on the client

2. Calling server side methods


Sample output:
--------------
Connecting to webSocket

Connected to webSocket

OUT: {"msg":"connect", "version":"pre1", "support":"['pre1']"}

Received message: {"server_id":"0"}

Received message: {"msg":"connected","session":"S6CHc3FsrF5SbZ6MS"}

OUT: {"msg":"sub", "id":"RuEMs6rwo5PdCv9qJ", "name":"meteor_autoupdate_clientVersions", "params":[]}

Received message: {"msg":"added","collection":"meteor_autoupdate_clientVersions","id":"55f6b5c711a158082fe91949041fa4e1d53af5fc","fields":{"current":true}}

Received message: {"msg":"ready","subs":["RuEMs6rwo5PdCv9qJ"]}

OUT: {"msg":"sub", "id":"NnJSdQsnDf5o8HLkE", "name":"meteor.loginServiceConfiguration", "params":[]}

Received message: {"msg":"ready","subs":["NnJSdQsnDf5o8HLkE"]}

OUT: {"msg":"sub", "id":"iQjpD7mYfm3D4ybEF", "name":"posts", "params":[]}

Received message: {"msg":"added","collection":"posts","id":"WAy3TbFzujvmq4xyB","fields":{"title":"Introducing Telescope","author":"Sacha Greif","url":"http://sachagreif.com/introducing-telescope/"}}

Received message: {"msg":"added","collection":"posts","id":"GEoTK9wbyc4jBvaqJ","fields":{"title":"Meteor","author":"Tom Coleman","url":"http://meteor.com"}}

Received message: {"msg":"added","collection":"posts","id":"o2tFc64QJxX42Nmwz","fields":{"title":"The Meteor Book","author":"Tom Coleman","url":"http://themeteorbook.com"}}

Received message: {"msg":"ready","subs":["iQjpD7mYfm3D4ybEF"]}

OUT: {"msg":"unsub", "id":"iQjpD7mYfm3D4ybEF"}

Received message: {"msg":"removed","collection":"posts","id":"WAy3TbFzujvmq4xyB"}

Received message: {"msg":"removed","collection":"posts","id":"GEoTK9wbyc4jBvaqJ"}

Received message: {"msg":"removed","collection":"posts","id":"o2tFc64QJxX42Nmwz"}

Received message: {"msg":"nosub","id":"iQjpD7mYfm3D4ybEF"}

webSocket closed