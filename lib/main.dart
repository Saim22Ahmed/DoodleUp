import 'package:doodle_up/pages/create_room_page.dart';
import 'package:doodle_up/pages/drawing_screen.dart';
import 'package:doodle_up/pages/home_page.dart';
import 'package:doodle_up/providers/theme_provider.dart';
import 'package:doodle_up/theme/dark_theme.dart';
import 'package:doodle_up/theme/light_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ScreenUtilInit(
      designSize: const Size(412, 892),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Doodle Up',
        theme: ref.watch(themeProvider).themeData,
        home: HomePage(),
      ),
    );
  }
}
