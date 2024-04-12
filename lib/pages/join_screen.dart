import 'dart:developer';

import 'package:doodle_up/components/myTextfield.dart';
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
  joinRoom() {}

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

                  // create room button
                  ElevatedButton(
                    onPressed: joinRoom(),
                    child: Text(
                      'Join Room',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 18.sp),
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
