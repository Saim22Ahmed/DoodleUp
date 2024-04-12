import 'dart:developer';

import 'package:socket_io_client/socket_io_client.dart' as io;
import 'package:flutter/material.dart';

class DrawingScreen extends StatefulWidget {
  const DrawingScreen({super.key});

  @override
  State<DrawingScreen> createState() => _DrawingScreenState();
}

class _DrawingScreenState extends State<DrawingScreen> {
  // initialization
  late io.Socket _socket;

  @override
  void initState() {
    // TODO: implement initState
    connectSocket();
    super.initState();
  }

  void connectSocket() {
    _socket = io.io("http://192.168.43.27:3000", <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });
    _socket.connect();

    //listening to socket
    _socket.onConnect((data) => {
          log("connected"),
        });
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
