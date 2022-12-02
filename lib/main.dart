import 'package:flutter/material.dart';
import 'package:ui_project/category/description.dart';
import 'package:ui_project/home_page.dart';
import 'package:ui_project/login.dart';
import 'package:ui_project/root_app.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ui_project/setting/editprofile.dart';
import 'category/maincategory.dart';
import 'category/listscience.dart';
import 'register.dart';
import 'setting/setting.dart';
import 'splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          centerTitle: true,
          toolbarHeight: 80,
          titleTextStyle: GoogleFonts.kanit(
            textStyle: TextStyle(
                fontSize: 35, color: Colors.black, fontWeight: FontWeight.w400),
          ),
        ),
      ),
      home: SplashScreen(),
    );
  }
}
