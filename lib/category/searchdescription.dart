import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SearchDescription extends StatefulWidget {
  final String id_person;

  SearchDescription({
    Key? key,
    required this.id_person,
  }) : super(key: key);
  @override
  State<SearchDescription> createState() => _SearchDescriptionState();
}

class _SearchDescriptionState extends State<SearchDescription> {
  Future getSearch() async {
    try {
      var url =
          Uri.parse('http://10.0.2.2/historyproject/searchDescrition.php');
      var response = await http.post((url), body: {
        'id_person': widget.id_person,
      });
      var data = json.decode(response.body);
      return data;
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        title: Text('วิทยาศาสตร์'),
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

      //Body
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: FutureBuilder(
            future: getSearch(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.data == null) {
                return Container(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              } else {
                return Container(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 5,
                      ),
                      //Image
                      Center(
                        child: Container(
                          width: 210,
                          height: 250,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(1),
                                blurRadius: 1,
                                offset:
                                    Offset(4, 4), // changes position of shadow
                              ),
                            ],
                            image: DecorationImage(
                              image: AssetImage('images/imgdescription/${snapshot.data[0]['img_person']}'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),

                      //Text
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            border: Border.all(
                                width: 1, color: Color.fromARGB(20, 0, 0, 0)),
                            color: Colors.grey[100],
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.9),
                                blurRadius: 2,
                                offset:
                                    Offset(4, 4), // changes position of shadow
                              ),
                            ]),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text.rich(
                                TextSpan(
                                  // default text style
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: 'ชื่อ : ',
                                        style: GoogleFonts.kanit(
                                          textStyle: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w600),
                                        )),
                                    TextSpan(
                                        text:  snapshot.data[0]['name_des'],
                                        style: GoogleFonts.kanit(
                                      textStyle: const TextStyle(
                                        fontSize: 20,
                                      ),
                                    )),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 2,
                              ),
                              Text.rich(
                                TextSpan(
                                  // default text style
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: 'วันเกิด : ',
                                        style: GoogleFonts.kanit(
                                          textStyle: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w600),
                                        )),
                                    TextSpan(
                                        text:  snapshot.data[0]['birthday'],
                                        style: GoogleFonts.kanit(
                                      textStyle: const TextStyle(
                                        fontSize: 20,
                                      ),
                                    )),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 2,
                              ),
                              Text(
                                 snapshot.data[0]['description'],
                                  style: GoogleFonts.kanit(
                                    textStyle: const TextStyle(
                                      fontSize: 16,
                                    ),
                                  )),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }
            }),
      ),
    );
  }
}
