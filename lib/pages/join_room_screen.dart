import 'dart:developer';

import 'package:doodle_up/components/myTextfield.dart';
import 'package:doodle_up/pages/drawing_screen.dart';
import 'package:doodle_up/utils/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class JoinRoomPage extends StatelessWidget {
  JoinRoomPage({super.key});
  // controllers
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _roomNameController = TextEditingController();

  // functions
  joinRoom(BuildContext context, WidgetRef ref) {
    if (_nameController.text.isNotEmpty &&
        _roomNameController.text.isNotEmpty) {
      // when validating fields , preparing data to sent .
      Map data = {
        'userName': _nameController.text,
        'roomName': _roomNameController.text,
      };
      // sendind the data to the drawing screen
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) =>
              DrawingScreen(data: data, screenFrom: 'joinRoom')));
    } else {
      log('fields are empty');
      ref.read(utilsProvider).showSnackBar(context);
    }
    ;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Center(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Join a room ',
                    style: TextStyle(
                        fontSize: 25,
                        fontFamily: GoogleFonts.righteous().fontFamily),
                  ),
                  30.h.verticalSpace,

                  // name textfield

                  MyTextFormField(
                    hintText: 'Enter your name',
                    obscuretext: false,
                    controller: _nameController,
                  ),

                  20.h.verticalSpace,
                  // room name textfield

                  MyTextFormField(
                    hintText: 'Enter room name',
                    obscuretext: false,
                    controller: _roomNameController,
                  ),

                  50.h.verticalSpace,

                  //

                  50.h.verticalSpace,

                  // join room button
                  Consumer(
                    builder:
                        (BuildContext context, WidgetRef ref, Widget? child) {
                      return ElevatedButton(
                        style: ElevatedButton.styleFrom(elevation: 3),
                        onPressed: () => joinRoom(context, ref),
                        child: Text(
                          'Join Room',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18.sp),
                        ),
                      );
                    },
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
