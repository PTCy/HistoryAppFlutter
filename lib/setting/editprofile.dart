import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class EditProfile extends StatefulWidget {
  final String user_id;
  final String name;
  final String email;
  final String paswword;

  EditProfile(
      {Key? key,
      required this.user_id,
      required this.name,
      required this.email,
      required this.paswword})
      : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  Future editProfile() async {
    try {
      var url = Uri.parse('http://10.0.2.2/historyproject/editProfile.php');
      var response = await http.post((url), body: {
        'user_id': widget.user_id,
        'name': nameController.text,
        'email': emailController.text,
        'password': passwordController.text,
      });
      var data = json.decode(response.body);
      return data;
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nameController.text = widget.name;
    emailController.text = widget.email;
    passwordController.text = widget.paswword;
  }

  //Variables
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        title: Text('ตั้งค่าโปรไฟล์'),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFFDAD9D9),
                Color(0xFFEBEAEA),
                Color(0xFFEDECEC),
                Color(0xFFF6F6F6),
              ],
            ),
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
              size: 40,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(right: 20, left: 20, top: 65),
        child: Container(
          child: Column(
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
                          color: Color.fromARGB(197, 0, 0, 0).withOpacity(0.5),
                          blurRadius: 2,
                          offset: Offset(2, 3)),
                    ]),
                child: TextFormField(
                  controller: nameController,
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
                height: 25,
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
                          color: Color.fromARGB(197, 0, 0, 0).withOpacity(0.5),
                          blurRadius: 2,
                          offset: Offset(2, 3)),
                    ]),
                child: TextFormField(
                  controller: emailController,
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
                height: 25,
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
                          color: Color.fromARGB(197, 0, 0, 0).withOpacity(0.5),
                          blurRadius: 2,
                          offset: Offset(2, 3)),
                    ]),
                child: TextFormField(
                  controller: passwordController,
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

              SizedBox(
                height: 55,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 40, left: 40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //Btuton Cancen
                    Container(
                      height: 45,
                      width: 110,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                                color: Color.fromARGB(197, 0, 0, 0)
                                    .withOpacity(0.5),
                                blurRadius: 2,
                                offset: Offset(2, 3)),
                          ]),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          primary:
                              Color.fromARGB(255, 255, 84, 3), // background
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Center(
                          child: Text(
                            'ยกเลิก',
                            style: GoogleFonts.kanit(
                              textStyle: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  color: Color.fromARGB(255, 255, 255, 255)),
                            ),
                          ),
                        ),
                      ),
                    ),

                    //Btuton conferme
                    Container(
                      height: 45,
                      width: 110,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                                color: Color.fromARGB(197, 0, 0, 0)
                                    .withOpacity(0.5),
                                blurRadius: 2,
                                offset: Offset(2, 3)),
                          ]),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          primary:
                              Color.fromARGB(255, 255, 84, 3), // background
                        ),
                        onPressed: () {
                          setState(() {
                            if (nameController.text.isEmpty ||
                                emailController.text.isEmpty ||
                                passwordController.text.isEmpty) {
                              Fluttertoast.showToast(
                                  msg: "กรุณาตรวจสอบข้อมูลให้ถูกต้อง",
                                  toastLength: Toast.LENGTH_LONG,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.red,
                                  textColor: Colors.white,
                                  fontSize: 16.0);
                            } else {
                              Fluttertoast.showToast(
                                msg: "บันทึกข้อมูลสำเร็จ",
                                toastLength: Toast.LENGTH_LONG,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.black,
                                textColor: Colors.white,
                                fontSize: 16.0,
                              );
                              editProfile();
                            }
                          });
                        },
                        child: Center(
                          child: Text(
                            'ยืนยัน',
                            style: GoogleFonts.kanit(
                              textStyle: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  color: Color.fromARGB(255, 255, 255, 255)),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
