import 'dart:developer';

import 'package:doodle_up/components/myTextfield.dart';
import 'package:doodle_up/pages/drawing_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:getwidget/components/form/form_field/widgets/gf_formdropdown.dart';
import 'package:google_fonts/google_fonts.dart';

class CreateRoomPage extends ConsumerWidget {
  CreateRoomPage({super.key});
  // controllers
  TextEditingController _nameController = TextEditingController();
  TextEditingController _roomNameController = TextEditingController();

  // providers
  final maxSizeProvider = StateProvider<String>((ref) => '2'); //Max players
  final maxRoundProvider = StateProvider<String>((ref) => '5'); // Max Rounds

  // functions
  void createRoom(WidgetRef ref, BuildContext context) {
    // ensuring fields are not empty

    if (_nameController.text.isNotEmpty &&
        _roomNameController.text.isNotEmpty) {
      // when validating fields , preparing data to sent .

      Map data = {
        'userName': _nameController.text,
        'roomName': _roomNameController.text,
        'maxSize': ref.watch(maxSizeProvider),
        'maxRound': ref.watch(maxRoundProvider),
      };

      // sendind the data to the drawing screen

      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) =>
              DrawingScreen(data: data, screenFrom: 'createRoom')));
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                    'Create a room ',
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
                    keyboardType: TextInputType.text,
                    hintText: 'Enter room name',
                    obscuretext: false,
                    controller: _roomNameController,
                  ),

                  50.h.verticalSpace,

                  //

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          Text(
                            'Max Players',
                            style: TextStyle(
                                fontSize: 15,
                                fontFamily: GoogleFonts.righteous().fontFamily),
                          ),
                          15.h.verticalSpace,
                          //  dropdown button to select the max players size

                          ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Theme.of(context)
                                    .colorScheme
                                    .tertiaryContainer
                                    .withOpacity(0.8),
                              ),
                              padding: EdgeInsets.symmetric(horizontal: 20.w),
                              alignment: Alignment.center,
                              height: 50.h,
                              width: 100.w,
                              child: DropdownButton(
                                  iconEnabledColor: Colors.white,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontFamily:
                                          GoogleFonts.josefinSans().fontFamily),
                                  borderRadius: BorderRadius.circular(20),
                                  elevation: 8,
                                  isExpanded: true,
                                  alignment: Alignment.center,
                                  underline: Container(),
                                  selectedItemBuilder: (BuildContext context) {
                                    return ['2', '5', '10', '15']
                                        .map((String value) {
                                      return Container(
                                        alignment: Alignment.center,
                                        child: Text(
                                          value,
                                          style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.white,
                                          ),
                                        ),
                                      );
                                    }).toList();
                                  },
                                  value: ref.watch(maxSizeProvider),
                                  items: ['2', '5', '10', '15']
                                      .map((value) => DropdownMenuItem(
                                          value: value,
                                          child: Text(value,
                                              style: TextStyle(
                                                fontSize: 20,
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .onInverseSurface,
                                              ))))
                                      .toList(),
                                  onChanged: (value) {
                                    ref.read(maxSizeProvider.notifier).state =
                                        value!;
                                    log('Max Players ' +
                                        ref.watch(maxSizeProvider).toString());
                                  }),
                            ),
                          )
                        ],
                      ),
                      // Max Rounds size

                      Column(
                        children: [
                          Text(
                            'Rounds Limit',
                            style: TextStyle(
                                fontSize: 15,
                                fontFamily: GoogleFonts.righteous().fontFamily),
                          ),
                          15.h.verticalSpace,
                          //  dropdown button to select the max players size

                          ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Theme.of(context)
                                    .colorScheme
                                    .tertiaryContainer
                                    .withOpacity(0.8),
                              ),
                              padding: EdgeInsets.symmetric(horizontal: 20.w),
                              alignment: Alignment.center,
                              height: 50.h,
                              width: 100.w,
                              child: DropdownButton(
                                  iconEnabledColor: Colors.white,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontFamily:
                                          GoogleFonts.josefinSans().fontFamily),
                                  borderRadius: BorderRadius.circular(20),
                                  elevation: 8,
                                  isExpanded: true,
                                  alignment: Alignment.center,
                                  underline: Container(),
                                  selectedItemBuilder: (BuildContext context) {
                                    return [
                                      '5',
                                      '8',
                                      '10',
                                      '12',
                                      '16',
                                      '20',
                                      '25',
                                      '30'
                                    ].map((String value) {
                                      return Container(
                                        alignment: Alignment.center,
                                        child: Text(
                                          value,
                                          style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.white,
                                          ),
                                        ),
                                      );
                                    }).toList();
                                  },
                                  value: ref.watch(maxRoundProvider),
                                  items: [
                                    '5',
                                    '8',
                                    '10',
                                    '12',
                                    '16',
                                    '20',
                                    '25',
                                    '30'
                                  ]
                                      .map((value) => DropdownMenuItem(
                                          value: value,
                                          child: Text(value,
                                              style: TextStyle(
                                                fontSize: 20,
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .onInverseSurface,
                                              ))))
                                      .toList(),
                                  onChanged: (value) {
                                    ref.read(maxRoundProvider.notifier).state =
                                        value!;
                                    log('Max Rounds ' +
                                        ref.watch(maxRoundProvider).toString());
                                  }),
                            ),
                          )
                        ],
                      )
                    ],
                  ),

                  100.h.verticalSpace,

                  // create room button
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(elevation: 3),
                    onPressed: () => createRoom(ref, context),
                    child: Text(
                      'Create Room',
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
