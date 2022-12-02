import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Description extends StatefulWidget {
  final List person;
  final int index;
  Description({Key? key, required this.person, required this.index})
      : super(key: key);
  @override
  State<Description> createState() => _DescriptionState();
}

class _DescriptionState extends State<Description> {
  TextEditingController name = TextEditingController();
  TextEditingController birthday = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController img_person = TextEditingController();
  @override
  void initState() {
    super.initState();
    if (widget.index != null) {
      name.text = widget.person[widget.index]['name_des'];
      birthday.text = widget.person[widget.index]['birthday'];
      description.text = widget.person[widget.index]['description'];
      img_person.text = widget.person[widget.index]['img_person'];
      // print(name.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        child: Container(
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
                        offset: Offset(4, 4), // changes position of shadow
                      ),
                    ],
                    image: DecorationImage(
                      image: AssetImage('images/imgdescription/' + img_person.text),
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
                        offset: Offset(4, 4), // changes position of shadow
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
                                text: name.text,
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
                                text: birthday.text,
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
                      Text(description.text,
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
        ),
      ),
    );
  }
}
