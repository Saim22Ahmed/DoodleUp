import 'package:doodle_up/pages/create_room_page.dart';
import 'package:doodle_up/pages/join_room_screen.dart';
import 'package:doodle_up/providers/theme_provider.dart';
import 'package:doodle_up/theme/dark_theme.dart';
import 'package:doodle_up/theme/light_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  changeTheme(WidgetRef ref) {
    ref.read(themeProvider).toggleTheme();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          'DoodleUp',
          style: TextStyle(
              fontSize: 20, fontFamily: GoogleFonts.righteous().fontFamily),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        child: Stack(
          children: [
            Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Create or Join a room',
                    style: TextStyle(
                        fontSize: 25.sp,
                        fontFamily: GoogleFonts.righteous().fontFamily),
                  ),
                  30.h.verticalSpace,

                  // create and join buttons with animations

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Create button

                      ElevatedButton(
                        style: ElevatedButton.styleFrom(elevation: 3),
                        onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CreateRoomPage())),
                        child: Text(
                          'Create',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18.sp),
                        ),
                      ),

                      20.h.horizontalSpace,

                      // Join button

                      ElevatedButton(
                        style: ElevatedButton.styleFrom(elevation: 3),
                        onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => JoinRoomPage())),
                        child: Text(
                          'Join',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18.sp),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),

            // Switch Theme
            Positioned(
              bottom: 20,
              right: 0,
              child: Switch(
                  inactiveTrackColor: Theme.of(context).colorScheme.onTertiary,
                  activeTrackColor: Theme.of(context).colorScheme.tertiary,
                  value: ref.watch(themeProvider).themeData == darkTheme,
                  onChanged: (value) => changeTheme(ref)),
            ),
          ],
        ),
      ),
    );
  }
}
