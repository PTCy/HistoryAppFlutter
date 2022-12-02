// ignore_for_file: prefer_const_constructors


import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
// import 'package:flutter/src/foundation/key.dart';
// import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

import 'package:image_picker/image_picker.dart';

import 'login.dart';



class RegigterPage extends StatefulWidget {
  const RegigterPage({Key? key}) : super(key: key);

  @override
  State<RegigterPage> createState() => _RegigterPageState();
}

class _RegigterPageState extends State<RegigterPage> {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  File? _image;
  final picker = ImagePicker();


Future choiceImage()async{
    // ignore: deprecated_member_use
    var pickedImage = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      _image = File(pickedImage!.path);
    });
  }

Future uploadImage()async{
    final uri = Uri.parse("http://10.0.2.2/historyproject/register.php");
    var request = http.MultipartRequest('POST',uri,);
    request.fields['name'] = name.text;
    request.fields['email'] = email.text;
    request.fields['password'] = password.text;
    var pic = await http.MultipartFile.fromPath("image", _image!.path);
    request.files.add(pic);
    var response = await request.send();

    if (response.statusCode == 200) {
      print('Image Uploded');
      
    }else{
      print('Image Not Uploded');
    }
    setState(() {
      
    });

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

        //form Register
        child: Column(
          children: [
            SizedBox(
              height: 80,
            ),
            Center(
              child: Container(
                child: Text(
                  'ลงทะเบียน',
                  style: GoogleFonts.kanit(
                    textStyle: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.w600,
                        color: Color.fromARGB(255, 0, 0, 0)),
                  ),
                ),
              ),
            ),

            //UploadProfile
            SizedBox(
              height: 10,
            ),
            Center(
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Color.fromARGB(215, 107, 107, 107),
                    width: 5,
                  ),
                  borderRadius: BorderRadius.circular(120),
                ),
                child: CircleAvatar(
                  maxRadius: 80,
                  backgroundImage: _image ==  null
                  ?Image.network('http://10.0.2.2/historyproject/uploadProfile/imgeregiter.png').image
                  :FileImage(
                    File(_image!.path)
                  ),

                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xffFF5403),
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: IconButton(
                        onPressed: () {

                          choiceImage();
                        },
                        icon: Icon(Icons.file_upload),
                        iconSize: 30,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
            ),

            //TextFile
            SizedBox(
              height: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Name
                Padding(
                  padding: const EdgeInsets.only(left: 20, bottom: 2),
                  child: Text(
                    "ชื่อ - สกุล",
                    style: GoogleFonts.kanit(
                      textStyle: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 350,
                  height: 45,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                            color:
                                Color.fromARGB(197, 0, 0, 0).withOpacity(0.5),
                            blurRadius: 2,
                            offset: Offset(1, 2)),
                      ]),
                  child: TextField(
                    controller: name,
                    style: GoogleFonts.kanit(
                      textStyle: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Color.fromARGB(255, 245, 245, 245),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      contentPadding: EdgeInsets.only(left: 20, bottom: 5),
                    ),
                  ),
                ),

                //Email
                SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, bottom: 2),
                  child: Text(
                    "อีเมล",
                    style: GoogleFonts.kanit(
                      textStyle: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 350,
                  height: 45,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                            color:
                                Color.fromARGB(197, 0, 0, 0).withOpacity(0.5),
                            blurRadius: 2,
                            offset: Offset(1, 2)),
                      ]),
                  child: TextField(
                    controller: email,
                    style: GoogleFonts.kanit(
                      textStyle: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Color.fromARGB(255, 245, 245, 245),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      contentPadding: EdgeInsets.only(left: 20, bottom: 5),
                    ),
                  ),
                ),

                //Password
                SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, bottom: 2),
                  child: Text(
                    "รหัสผ่าน",
                    style: GoogleFonts.kanit(
                      textStyle: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 350,
                  height: 45,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                            color:
                                Color.fromARGB(197, 0, 0, 0).withOpacity(0.5),
                            blurRadius: 2,
                            offset: Offset(1, 2)),
                      ]),
                  child: TextField(
                    controller: password,
                    style: GoogleFonts.kanit(
                      textStyle: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Color.fromARGB(255, 245, 245, 245),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      contentPadding: EdgeInsets.only(left: 20, bottom: 5),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              height: 50,
              width: 180,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  primary: Color(0xffFF5403), // background
                ),
                onPressed: () {
                  if (name.text.isEmpty ||
                      email.text.isEmpty ||
                      password.text.isEmpty) {
                    Fluttertoast.showToast(
                        msg: "กรุณากรอกข้อมูลให้ครบ",
                        toastLength: Toast.LENGTH_LONG,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0);
                  } else {
                    Fluttertoast.showToast(
                        msg: "ลงทะเบียนเสร็จสิ้น",
                        toastLength: Toast.LENGTH_LONG,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.black,
                        textColor: Colors.white,
                        fontSize: 16.0,
                        );
                    uploadImage();
                  }
                         
                },
                child: Center(
                  child: Text(
                    'ลงทะเบียน',
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
              height: 10,
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                'เข้าสู่ระบบ',
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
