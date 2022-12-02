// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:flutter/material.dart';
// import 'package:flutter/src/foundation/key.dart';
// import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'register.dart';
import 'root_app.dart';

class LogIn extends StatefulWidget {
  const LogIn({Key? key}) : super(key: key);

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  TextEditingController user = TextEditingController();
  TextEditingController pass = TextEditingController();

  Future login() async {
    var url = Uri.parse("http://10.0.2.2/historyproject/login.php");

    var response = await http.post(url, body: {
      "email": user.text,
      "password": pass.text,
    });
    var data = json.decode(response.body);
    print(data.toString());

    if (data == "Fail") {
      Fluttertoast.showToast(
          msg: "อีเมล หรือ รหัสผ่าน ไม่ถูกต้อง",
          toastLength: Toast.LENGTH_LONG,
          // gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      Fluttertoast.showToast(
          msg: "ล็อกอินสำเร็จ",
          toastLength: Toast.LENGTH_LONG,
          // gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0);
      String user_id = data[0]['id_user'].toString();
      goRoot(user_id);
    }
  }

  void goRoot(String user_id) {
     Navigator.push(
          context, MaterialPageRoute(builder: (context) => RootApp(user_id:user_id)));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xffF8F8F8),
                Color(0xffC3C3C3),
                Color(0xff5C5C5C),
                Color(0xff1B1B1B),
              ]),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 60,
              ),
              child: Center(
                child: Container(
                  child: Image.asset(
                    'images/icon/logo.png',
                    width: 500,
                    height: 300,
                  ),
                ),
              ),
            ),
            //Input Email
            Container(
              width: 350,
              height: 55,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                        color: Color.fromARGB(197, 0, 0, 0).withOpacity(0.5),
                        blurRadius: 2,
                        offset: Offset(1, 2)),
                  ]),
              child: TextField(
                controller: user,
                style: GoogleFonts.kanit(
                  textStyle: TextStyle(fontSize: 20, color: Colors.grey[700]),
                ),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Color.fromARGB(255, 245, 245, 245),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  prefixIcon: Icon(Icons.mail),
                  hintText: '| อีเมล ',
                  hintStyle: GoogleFonts.kanit(
                    textStyle: TextStyle(
                        color: Color.fromARGB(80, 0, 0, 0),
                        fontSize: 20,
                        fontWeight: FontWeight.w400),
                  ),
                ),
              ),
            ),

            //Input Password
            SizedBox(
              height: 15,
            ),
            Container(
              width: 350,
              height: 55,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                        color: Color.fromARGB(197, 0, 0, 0).withOpacity(0.5),
                        blurRadius: 2,
                        offset: Offset(1, 2)),
                  ]),
              child: TextField(
                controller: pass,
                style: GoogleFonts.kanit(
                  textStyle: TextStyle(fontSize: 20, color: Colors.grey[700]),
                ),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Color.fromARGB(255, 245, 245, 245),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  prefixIcon: Icon(Icons.key),
                  hintText: '| รหัสผ่าน ',
                  hintStyle: GoogleFonts.kanit(
                    textStyle: TextStyle(
                        color: Color.fromARGB(80, 0, 0, 0),
                        fontSize: 20,
                        fontWeight: FontWeight.w400),
                  ),
                ),
              ),
            ),

            //Loin Buttom
            SizedBox(
              height: 30,
            ),
            Container(
              height: 50,
              width: 180,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                        color: Color.fromARGB(197, 39, 39, 39).withOpacity(0.8),
                        blurRadius: 3,
                        offset: Offset(2, 4)),
                  ]),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  primary: Color.fromARGB(255, 255, 84, 3), // background
                ),
                onPressed: () {
                  login();
                },
                child: Center(
                  child: Text(
                    'เข้าสู่ระบบ',
                    style: GoogleFonts.kanit(
                      textStyle: TextStyle(
                          fontSize: 20,
                          color: Color.fromARGB(255, 255, 255, 255)),
                    ),
                  ),
                ),
              ),
            ),

            SizedBox(
              height: 25,
            ),
            Text(
              'คุณยังไม่มีผู้ใช้ ?',
              style: GoogleFonts.kanit(
                textStyle: TextStyle(
                    fontSize: 17, color: Color.fromARGB(255, 255, 255, 255)),
              ),
            ),
            SizedBox(
              height: 1,
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: ((context) => RegigterPage()),
                  ),
                );
              },
              child: Text(
                'ลงทะเบียน',
                style: GoogleFonts.kanit(
                  textStyle: TextStyle(
                      fontStyle: FontStyle.italic,
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      decoration: TextDecoration.underline,
                      color: Color.fromARGB(255, 255, 255, 255)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
