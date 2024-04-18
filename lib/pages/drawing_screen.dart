import 'dart:developer';

import 'package:doodle_up/models/MyCustomPainter.dart';
import 'package:doodle_up/models/touch_points.dart';
import 'package:doodle_up/providers/drawing_screen_provider.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
  List<TouchPoints> points = [];
  late io.Socket _socket;
  StrokeCap stroketype = StrokeCap.round;
  Color selectedColor = Colors.black;

  double opacity = 1;
  double strokeWidth = 2;

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
    _socket.onConnect((data) {
      log("connected");
      _socket.on('updateRoom', (Roomdata) {
        setState(() {
          roomData = Roomdata;
        });

        // if isJoin is false it means all the players are joined and ready to play

        if (Roomdata['isJoin'] == false) {
          //start the timer
        }
      });
    });

    _socket.on('points', (point) {
      if (point['details'] != null) {
        setState(() {
          points.add(TouchPoints(
              points: Offset((point['details']['dx']).toDouble(),
                  (point['details']['dy']).toDouble()),
              paint: Paint()
                ..strokeCap = stroketype
                ..isAntiAlias = true
                ..color = selectedColor.withOpacity(opacity)
                ..strokeWidth = strokeWidth));
        });
      }
    });

    _socket.on('color-change', (colorString) {
      int value = int.parse(colorString, radix: 16);
      Color otherColor = Color(value);
      setState(() {
        selectedColor = otherColor;
      });

      _socket.on('stroke-width', (value) {
        setState(() {
          strokeWidth = value.toDouble();
        });
      });
    });
  }

  void selectColor(WidgetRef ref) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text("Select Color"),
              content: SingleChildScrollView(
                  child: BlockPicker(
                pickerColor: selectedColor,
                onColorChanged: (color) {
                  // ref.read(drawingScreenProvider).selectedColor = color;
                  String colorString = color.toString();
                  String valueString =
                      colorString.split('(0x')[1].split(')')[0];
                  log(valueString);
                  Map map = {
                    'color': valueString,
                    'roomName': widget.data['roomName'],
                  };
                  _socket.emit('color-change', map);
                },
              )),
              actions: [
                // close button
                TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      "Close",
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.tertiary,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold),
                    ))
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Consumer(
              builder: (BuildContext context, WidgetRef ref, Widget? child) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // Drawing Screen
                    Container(
                        height: height * 0.55,
                        width: width,
                        child: GestureDetector(
                          onPanUpdate: (details) {
                            log(details.localPosition.dx.toString());
                            _socket.emit('paint', {
                              'details': {
                                'dx': details.localPosition.dx,
                                'dy': details.localPosition.dy
                              },
                              'roomName': widget.data['roomName']
                            });
                          },
                          onPanStart: (details) {
                            log(details.localPosition.dx.toString());
                            _socket.emit('paint', {
                              'details': {
                                'dx': details.localPosition.dx,
                                'dy': details.localPosition.dy
                              },
                              'roomName': widget.data['roomName']
                            });
                          },
                          onPanEnd: (details) {
                            _socket.emit('paint', {
                              'details': null,
                              'roomName': widget.data['roomName']
                            });
                          },
                          child: SizedBox.expand(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: RepaintBoundary(
                                child: CustomPaint(
                                  size: Size.infinite,
                                  painter: MyCustomPainter(pointsList: points),
                                ),
                              ),
                            ),
                          ),
                        )),

                    //Color Selection
                    Row(
                      children: [
                        IconButton(
                          onPressed: () => selectColor(ref),
                          icon: Icon(Icons.color_lens),
                          color: selectedColor,
                        ),

                        // stroke slider

                        Expanded(
                            child: Slider(
                          value: strokeWidth,
                          label: 'Stroke Width $strokeWidth',
                          onChanged: (double value) {
                            Map map = {
                              'value': value,
                              'roomName': widget.data['roomName']
                            };
                            _socket.emit('stroke-width', map);
                          },
                          activeColor: selectedColor,
                          min: 1.0,
                          max: 10,
                        )),
                        // clear the drawing
                        IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.layers_clear),
                          color: selectedColor,
                        ),
                      ],
                    )
                  ],
                );
              },
            )
          ],
        ));
  }
}
