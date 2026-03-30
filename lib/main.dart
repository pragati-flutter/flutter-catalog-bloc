/*
import 'package:catalog_app/core/routes/app_routes.dart';
import 'package:flutter/material.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',

      initialRoute: AppRoutes.products,
      onGenerateRoute: AppRoutes.generateRoute,
    );
  }
}
*/

import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const title = 'WebSocket Implementation';

    return const MaterialApp(
      title: title,
      home: WebSocketImplementation(title: title),
    );
  }
}

class WebSocketImplementation extends StatefulWidget {
  final String title;
  const WebSocketImplementation({super.key, required this.title});


  @override
  State<WebSocketImplementation> createState() => _WebSocketImplementationState();
}

class _WebSocketImplementationState extends State<WebSocketImplementation> {
  final TextEditingController _textCtrl = TextEditingController();
  final WebSocketChannel _webSocketChannel =WebSocketChannel.connect( Uri.parse('wss://echo.websocket.org'),);

 void _sendMessageToServer(){
   if(_textCtrl.text.isNotEmpty){
     _webSocketChannel.sink.add(_textCtrl.text);
   }
 }
 @override
 void dispose(){

  _webSocketChannel.sink.close();
  _textCtrl.dispose();
  super.dispose();
 }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo.shade400,
        title: Text(widget.title,style: TextStyle(color: Colors.white),),

      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Form(
              child: TextFormField(
                controller: _textCtrl,
                decoration: const InputDecoration(labelText: 'Send a message'),
              ),
            ),
            const SizedBox(height: 24),
            StreamBuilder(
              stream: _webSocketChannel.stream,
              builder: (context, snapshot) {
                return Text(snapshot.hasData ? '${snapshot.data}' : '');
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _sendMessageToServer,
        tooltip: 'Send message to server',
        child: const Icon(Icons.send,color: Colors.indigo,),
      ),
    ); ;
  }
}

