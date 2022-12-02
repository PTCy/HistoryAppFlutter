import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'listart.dart';
import 'listdomination.dart';
import 'listscience.dart';
import 'listsport.dart';
import 'listtechnology.dart';


class MainCategory extends StatefulWidget {
  final String user_id;
  MainCategory({Key? key, required this.user_id}) : super(key: key);

  @override
  State<MainCategory> createState() => _MainCategoryState();
}

class _MainCategoryState extends State<MainCategory> {
  void initState() {
    super.initState();
    // print('test2'+widget.user_id);
  }

  final List category = [
    {"image": "images/icon/category1.jpg", "text": "ด้านวิทยาศาสตร์"},
    {"image": "images/icon/category2.jpg", "text": "ด้านการปกครอง"},
    {"image": "images/icon/category3.jpg", "text": "ด้านศิลปะ"},
    {"image": "images/icon/category4.jpg", "text": "ด้านเทคโนโลยี"},
    {"image": "images/icon/category5.jpg", "text": "ด้านกีฬา"},
  ];

  @override
  Widget build(BuildContext context) {

    List<Route> historpage = [
      MaterialPageRoute(builder: (_) => ListScience(user_id:widget.user_id)),
      MaterialPageRoute(builder: (_) => ListDomination(user_id:widget.user_id)),
      MaterialPageRoute(builder: (_) => ListArt(user_id:widget.user_id)),
      MaterialPageRoute(builder: (_) => ListTechnology(user_id:widget.user_id)),
      MaterialPageRoute(builder: (_) => ListSport(user_id:widget.user_id)),
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text('หมวดหมู่'),
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
      body: ListView.builder(
          itemCount: category.length,
          itemBuilder: (context, index) {
            var size = MediaQuery.of(context).size;
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                //ฺButton
                onTap: () {
                  setState(() {
                    Navigator.of(context).push(historpage[index]);
                  });
                },
                child: Container(
                  width: size.width,
                  height: 130,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(35),
                      image: DecorationImage(
                          image: AssetImage(category[index]['image']),
                          fit: BoxFit.fill),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.withOpacity(1),
                            blurRadius: 2,
                            offset: Offset(3, 4)),
                      ]),

                  //Image
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(35), // Image border
                    child: SizedBox.fromSize(
                      size: Size.fromRadius(35), // Image radius
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
                        child: Container(
                          color: Colors.grey.withOpacity(0.4),
                          alignment: Alignment.center,
                          child: Text(
                            category[index]['text'],
                            style: GoogleFonts.kanit(
                              textStyle: TextStyle(
                                color: Colors.white,
                                fontSize: 35,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1,
                                shadows: [
                                  Shadow(
                                    offset: Offset(3, 4),
                                    blurRadius: 1,
                                    color: Colors.black.withOpacity(0.7),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }
}
