import 'package:flutter/material.dart';
import 'package:ui_project/home_page.dart';

import 'category/maincategory.dart';
import 'category/listscience.dart';
import 'favour.dart';
import 'setting/setting.dart';

class RootApp extends StatefulWidget {
  final String user_id;
  RootApp({Key? key, required this.user_id}) : super(key: key);

  @override
  State<RootApp> createState() => _RootAppState();
}

class _RootAppState extends State<RootApp> {
  @override
  int pageIndex = 0;

  void initState() {
    // TODO: implement initState
    super.initState(
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: getFooter(),
      body: getBody(),
    );
  }

  //Body
  Widget getBody() {
    return IndexedStack(
      index: pageIndex,
      children: [
        HomePage(user_id:widget.user_id),
        
        MainCategory(user_id:widget.user_id),

        Favour(user_id:widget.user_id),
        
       SettingProfile(user_id:widget.user_id),
      ],
    );
  }

  //FOOTER
  Widget getFooter() {
    List items = [
      "images/icon/home.png",
      "images/icon/book.png",
      "images/icon/star.png",
      "images/icon/user.png",
    ];
    var size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: 100,
      
      decoration: BoxDecoration(color: Color(0xffFDFDFD), boxShadow: [
        BoxShadow(
            color: Color(0Xff000000).withOpacity(0.12),
            blurRadius: 5,
            offset: Offset(0, -3)),
      ]),
      child: Padding(
        padding: const EdgeInsets.only(left: 30, right: 30, top: 30),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(items.length, (index) {
              return InkWell(
                onTap: () {
                  setState(() {
                    pageIndex = index;
                  });
                },
                child: Column(
                  children: [
                    Image.asset(
                      items[index],
                      width: 40,
                      height: 40,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    pageIndex == index
                        ? AnimatedContainer(
                            duration: Duration(milliseconds: 500),
                            child: Container(
                              height: 6,
                              width: 30,
                              decoration: BoxDecoration(
                                  color: Color(0xffFF5403),
                                  borderRadius: BorderRadius.circular(100)),
                            ),
                          )
                        : Container()
                  ],
                ),
              );
            })),
      ),
    );
  }
}
