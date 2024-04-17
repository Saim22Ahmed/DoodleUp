import 'dart:developer';

import 'package:doodle_up/models/MyCustomPainter.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;
import 'package:flutter/material.dart';

class DrawingScreen extends StatefulWidget {
  const DrawingScreen(
      {super.key, required this.data, required this.screenFrom});

  final Map data;
  final String screenFrom;

  @override
  State<DrawingScreen> createState() => _DrawingScreenState();
}

class _DrawingScreenState extends State<DrawingScreen> {
  // initialization
  Map roomData = {};
  List points = [];
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

    if (widget.screenFrom == 'createRoom') {
      _socket.emit('create-room', widget.data);
    } else {
      _socket.emit('join-room', widget.data);
    }

    _socket.connect();

    //listening to socket
    _socket.onConnect((data) => {
          log("connected"),
          _socket.on('updateRoom', (Roomdata) {
            setState(() {
              roomData = Roomdata;
            });

            // if isJoin is false it means all the players are joined and ready to play

            if (Roomdata['isJoin'] == false) {
              //start the timer
            }
          })
        });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
        body: Stack(
      children: [
        Column(
          children: [
            // Drawing Screen
            Container(
                height: height * 0.55,
                width: width,
                color: Colors.yellow,
                child: GestureDetector(
                  onPanUpdate: (details) {},
                  onPanStart: (details) {},
                  onPanEnd: (details) {},
                  child: SizedBox.expand(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: RepaintBoundary(
                        child: CustomPaint(
                          size: Size.infinite,
                          // painter: MyCustomPainter(pointsList: points),
                        ),
                      ),
                    ),
                  ),
                ))
          ],
        )
      ],
    ));
  }
}
