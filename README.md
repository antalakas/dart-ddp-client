dart-ddp-client
===============

Dart DDP Client

An experiment, trying to enable dart to subscribe to meteor collections using ddp protocol.

Based on:

https://github.com/oortcloud/node-ddp-client
https://github.com/dart-lang/dart-samples/tree/master/web/html5/websockets/basics
https://github.com/meteor/meteor/blob/devel/packages/livedata/DDP.md

What works:

Connect to web socket
Connection to the server using ddp, server replies with server id

To do:

Subscribe/Unsubscribe to collections.
Handling collection(s) retrieval on the client
Calling server side methods
Integration with the security system