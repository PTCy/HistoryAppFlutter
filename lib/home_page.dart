import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'category/searchdescription.dart';

class HomePage extends StatefulWidget {
  final String user_id;
  HomePage({Key? key, required this.user_id}) : super(key: key);
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  void initState() {
    // TODO: implement initState
    super.initState();
    // getMember();
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


  final SearchController = TextEditingController();

  void searchData(String Search) async {
    var url = Uri.parse('http://10.0.2.2/historyproject/searchData.php');
    var response = await http.post(url, body: {
      'name': Search,
    });
    var data = jsonDecode(response.body);
    if (data == "Fail") {
      Fluttertoast.showToast(
          msg: "ไม่พบข้อมูล",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
          );
      return;
    } else {
      String id_person = data[0]['id_person'].toString();
      searchCategory(id_person);
    }
  }
    void searchCategory(String id_person) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SearchDescription(id_person: id_person),
        ),
      );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFEFDFD),
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(0),
        child: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          //  brightness: Brightness.light,
        ),
      ),
      body: getBody(),
    );
  }

//body
  Widget getBody() {
    var size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: [
          Stack(
            alignment: Alignment.topCenter,
            children: [
              // bg มน
              ClipPath(
                child: Container(
                  width: size.width,
                  height: 265,
                  decoration: BoxDecoration(
                    color: Color(0xff2B2B2B),
                    borderRadius: BorderRadius.vertical(
                      bottom: Radius.elliptical(
                          MediaQuery.of(context).size.width, 90),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(1),
                        spreadRadius: 2,
                        blurRadius: 4,
                        offset: Offset(0, 4), // changes position of shadow
                      ),
                    ],
                  ),
                ),
              ),

              //text titel
              Padding(
                padding: EdgeInsets.only(left: 25, right: 25, top: 15),
                child: Column(
                  children: [
                    SizedBox(
                      height: 60,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "ยินดีต้อนรับ!",
                              style: GoogleFonts.kanit(
                                textStyle: TextStyle(
                                  color: Colors.white,
                                  fontSize: 35,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            Text(
                              "เข้าสู่ดินแดนชีวประวติบุคคลสำคัญ",
                              style: GoogleFonts.kanit(
                                textStyle: TextStyle(
                                    color: Colors.white, fontSize: 16),
                              ),
                            ),
                            Text(
                              "ของโลก",
                              style: GoogleFonts.kanit(
                                textStyle: TextStyle(
                                    color: Colors.white, fontSize: 16),
                              ),
                            ),
                          ],
                        ),
                        FutureBuilder(
                            future: getMember(),
                            builder:
                                (BuildContext context, AsyncSnapshot snapshot) {
                              if (snapshot.data == null) {
                                return Container(
                                  child: Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                );
                              } else {
                                return Container(
                                  width: 110,
                                  height: 110,
                                  //border image
                                  foregroundDecoration: BoxDecoration(
                                    border: Border.all(
                                        width: 2, color: Colors.white),
                                    borderRadius: BorderRadius.circular(100),
                                  ),

                                  //image
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(100),
                                    child: Image.network(
                                      snapshot.data[0]['img_user'] == ''
                                          ? 'http://10.0.2.2/historyproject/uploadProfile/profile.jpg'
                                          : 'http://10.0.2.2/historyproject/uploadProfile/${snapshot.data[0]['img_user']}',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                );
                              }
                            })
                      ],
                    ),

                    //Search Bar
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      width: 500,
                      height: 50,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                              width: 0.5, color: Color.fromARGB(62, 0, 0, 0)),
                          borderRadius: BorderRadius.circular(29.5),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey.withOpacity(1),
                                blurRadius: 3,
                                offset: Offset(0, 3)),
                          ]),
                      child: Padding(
                        padding: EdgeInsets.only(left: 20, right: 20),
                        child: TextField(
                          controller: SearchController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "ค้นหา",
                            hintStyle: GoogleFonts.kanit(
                              textStyle: TextStyle(
                                  color: Color.fromARGB(84, 0, 0, 0),
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400),
                            ),

                            //Icon Search
                            suffixIcon: Padding(
                              padding: const EdgeInsets.only(top: 3, bottom: 3),
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Color(0xffFF5403),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.grey.withOpacity(0.9),
                                          blurRadius: 2,
                                          offset: Offset(3, 1)),
                                    ]),
                                child: IconButton(
                                  onPressed: () {
                                    searchData(SearchController.text);
                                  },
                                  color: Colors.white,
                                  iconSize: 30,
                                  icon: Icon(
                                    Icons.search,
                                  ),
                                ),
                              ),
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

          //Content
          SizedBox(
            height: 20,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 25,
                    ),
                    child: Container(
                      width: 200,
                      height: 250,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                            bottomLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(1),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: Offset(3, 2), // changes position of shadow
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20), // Image border
                        child: Image.asset('images/imgscience/albert.jpg',
                            fit: BoxFit.cover),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  Container(
                    child: Text(
                      "- Albert Einstein -",
                      style: GoogleFonts.merriweather(
                        textStyle: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 1,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              //text slogan
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '"Learn from',
                        style: GoogleFonts.kanit(
                          textStyle: TextStyle(
                            fontSize: 23,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1,
                          ),
                        ),
                      ),
                      Text(
                        'yesterday,',
                        style: GoogleFonts.kanit(
                          textStyle: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      Text(
                        'live for today,',
                        style: GoogleFonts.kanit(
                          textStyle: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      Text(
                        'hope for tomorrow.',
                        style: GoogleFonts.kanit(
                          textStyle: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      Text(
                        'The important',
                        style: GoogleFonts.kanit(
                          textStyle: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      Text(
                        'thing is not to ',
                        style: GoogleFonts.kanit(
                          textStyle: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      Text(
                        'stop questioning"',
                        style: GoogleFonts.kanit(
                          textStyle: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      //line
                      SizedBox(
                        height: 5,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Container(
                          height: 4,
                          width: 80,
                          decoration: BoxDecoration(
                            color: Color(0xffFF5403),
                            borderRadius: BorderRadius.circular(100),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(1),
                                spreadRadius: 2,
                                blurRadius: 4,
                                offset:
                                    Offset(1, 2), // changes position of shadow
                              ),
                            ],
                          ),
                        ),
                      ),

                      //text ไทย
                      SizedBox(
                        height: 7,
                      ),
                      Text(
                        '"เรียนรู้จากวันวานใช้ชีวิต',
                        style: GoogleFonts.kanit(
                          textStyle: TextStyle(
                            fontSize: 13,
                          ),
                        ),
                      ),
                      Text(
                        'อยู่ในวันนี้ มีความหวังกับ ',
                        style: GoogleFonts.kanit(
                          textStyle: TextStyle(
                            fontSize: 13,
                          ),
                        ),
                      ),
                      Text(
                        'วันพรุ่งนี้ สิ่งสำคัญคือ',
                        style: GoogleFonts.kanit(
                          textStyle: TextStyle(
                            fontSize: 13,
                          ),
                        ),
                      ),
                      Text(
                        'อย่าหยุดตั้งคำถาม',
                        style: GoogleFonts.kanit(
                          textStyle: TextStyle(
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          //Slogan2
          SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25, right: 25, bottom: 20),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15),
                        bottomLeft: Radius.circular(15),
                        bottomRight: Radius.circular(15)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(1),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(2, 4), // changes position of shadow
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.asset(
                      "images/imgscience/lincon.jpg",
                      width: 350,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  '"Its not the years in your life that',
                  style: GoogleFonts.kanit(
                    textStyle: TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                Text(
                  'count. its the life in your years"',
                  style: GoogleFonts.kanit(
                    textStyle: TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                SizedBox(
                  height: 6,
                ),
                Container(
                  height: 4,
                  width: 100,
                  decoration: BoxDecoration(
                    color: Color(0xffFF5403),
                    borderRadius: BorderRadius.circular(100),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(1),
                        spreadRadius: 2,
                        blurRadius: 4,
                        offset: Offset(1, 2), // changes position of shadow
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 6,
                ),
                Text(
                  '"สุดท้าย มันไม่สำคัญว่าคุณมีชีวิตอยู่กี่ปี ที่สำคัญกว่า',
                  style: GoogleFonts.kanit(
                    textStyle: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                Text(
                  'คือช่วงที่มีชีวิตอยู่คุณได้ใช้มันดีแค่ไหน"',
                  style: GoogleFonts.kanit(
                    textStyle: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  "- Abraham Lincoln -",
                  style: GoogleFonts.merriweather(
                    textStyle: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 1,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
