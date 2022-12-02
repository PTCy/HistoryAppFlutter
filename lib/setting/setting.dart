import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ui_project/login.dart';
import 'package:ui_project/setting/editprofile.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SettingProfile extends StatefulWidget {
  final String user_id;
  SettingProfile({Key? key, required this.user_id}) : super(key: key);

  @override
  State<SettingProfile> createState() => _SettingProfileState();
}

class _SettingProfileState extends State<SettingProfile> {
  @override
  void initState() {
    super.initState();
    // print('test2'+widget.user_id);
  }

  Future getMember() async {
    try {
      var url = Uri.parse('http://10.0.2.2/historyproject/selectUser.php');
      var response = await http.post((url), body: {
        'user_id': widget.user_id,
      });
      var data = json.decode(response.body);
      return data;
    } catch (e) {
      print(e);
    }
  }

  File? _image;
  final picker = ImagePicker();

  Future uploadImage() async {
    final uri = Uri.parse('http://10.0.2.2/historyproject/editImage.php');
    var request = http.MultipartRequest('POST',uri,);
    request.fields['user_id'] = widget.user_id;
    var pic = await http.MultipartFile.fromPath("image", _image!.path);
    request.files.add(pic);
    var response = await request.send();
    var body = await response.stream.bytesToString();
    if (response.statusCode == 200) {
      print('Image Uploded');
    } else {
      print('Image Not Uploded');
    }
    setState(() {});
  }

  Future choiceImage() async {
    // ignore: deprecated_member_use
    var pickedImage = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      _image = File(pickedImage!.path);
      uploadImage();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ตั้งค่า'),
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
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          FutureBuilder(
            future: getMember(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.data == null) {
                return Container(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              } else {
                return Column(
                  children: [
                    Center(
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Color.fromARGB(255, 193, 192, 192),
                            width: 6,
                          ),
                          borderRadius: BorderRadius.circular(120),
                        ),
                        child: CircleAvatar(
                          backgroundImage: _image == null
                              ? Image.network('http://10.0.2.2/historyproject/uploadProfile/${snapshot.data[0]['img_user']}').image
                              : FileImage(File(_image!.path)),
                          // (เงื่อนไข) ? เป็นจริง : ไม่เป็นจริง
                          maxRadius: 110,
                          child: Align(
                            alignment: Alignment.bottomRight,
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(right: 8, bottom: 10),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Color(0xffFF5403),
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                child: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      choiceImage();
                                    });
                                  },
                                  icon: Icon(Icons.border_color),
                                  iconSize: 30,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    GestureDetector(
                      child: Container(
                        height: 70,
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                                width: 2.0, color: Color.fromARGB(20, 0, 0, 0)),
                          ),
                          color: Color.fromARGB(7, 0, 0, 0),
                        ),
                        child: Row(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(right: 25, left: 30),
                              child: Image(
                                image:
                                    AssetImage('images/icon/user-profile.png'),
                                width: 50,
                              ),
                            ),
                            Text(
                              'ตั้งค่าโปรไฟล์',
                              style: GoogleFonts.kanit(
                                textStyle: const TextStyle(
                                    fontSize: 29, letterSpacing: 1),
                              ),
                            ),
                          ],
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => EditProfile(
                                      user_id: widget.user_id,
                                      name: snapshot.data[0]['name'],
                                      email: snapshot.data[0]['email'],
                                      paswword: snapshot.data[0]['password'],
                                    )));
                      },
                    ),
                  ],
                );
              }
            },
          ),

          //Exit
          SizedBox(
            height: 1,
          ),
          GestureDetector(
            child: Container(
              height: 70,
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                      width: 2.0, color: Color.fromARGB(25, 0, 0, 0)),
                ),
                color: Color.fromARGB(8, 0, 0, 0),
              ),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 25, left: 35),
                    child: Image(
                      image: AssetImage('images/icon/log-out.png'),
                      width: 45,
                    ),
                  ),
                  Text(
                    'ออกจากระบบ',
                    style: GoogleFonts.kanit(
                      textStyle:
                          const TextStyle(fontSize: 29, letterSpacing: 1),
                    ),
                  ),
                ],
              ),
            ),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => LogIn()));
            },
          )
        ],
      ),
    );
  }
}
