import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;

import 'category/description.dart';

class Favour extends StatefulWidget {
  final String user_id;
  Favour({Key? key, required this.user_id}) : super(key: key);

  @override
  State<Favour> createState() => _FavourState();
}

class _FavourState extends State<Favour> {
   
   Future getdata() async {
    var url = Uri.parse("http://10.0.2.2/historyproject/joinFavour.php");
    var response = await http.post((url), body: {
        'user_id': widget.user_id,
      });
      var data = json.decode(response.body);
      return data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ชื่นชอบ'),
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
       body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: FutureBuilder(
              future: getdata(),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.hasError) print(snapshot.error);
                return snapshot.hasData
                    ? GridView.builder(
                        itemCount: snapshot.data.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisExtent: 256,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                        ),
                        itemBuilder: (context, index) {
                          List list = snapshot.data;
                          return Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                                    width: 1,
                                    color: Color.fromARGB(116, 0, 0, 0)),
                                borderRadius: BorderRadius.circular(20)),
                            child: Column(
                              children: [
                                //Icon
                                Container(
                                  child: Align(
                                    alignment: Alignment.topRight,
                                    child: Container(
                                        width: 50,
                                        height: 60,
                                        decoration: BoxDecoration(
                                            color: Color.fromARGB(
                                                196, 244, 244, 244),
                                            borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(20),
                                            )),
                                        child: IconButton(
                                          icon: Icon(Icons.star),
                                          color: Color(0xFFF78812),
                                          iconSize: 40,
                                          onPressed: () {
                                            setState(() {
                                               var url = Uri.parse("http://10.0.2.2//historyproject/deleteFavour.php");
                                                      http.post(url, body: {
                                                        'id_favour' : list[index]['id_favour'],
                                                      });
                                            });
                                          },
                                        )
                                        ),
                                  ),

                                  //Image
                                  height: 190,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(20),
                                        topRight: Radius.circular(20)),
                                    image: DecorationImage(
                                      image: AssetImage(
                                          'images/imgdescription/${list[index]['img_person']}'),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Text(
                                  list[index]['name'],
                                  style: GoogleFonts.kanit(
                                    textStyle: const TextStyle(fontSize: 20),
                                  ),
                                ),
                                const SizedBox(
                                  height: 2,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => Description(
                                                person:list,
                                                index:index,
                                              )));
                                    });
                                  },
                                  child: Text(
                                    'ดูเพิ่มเติม >>',
                                    style: GoogleFonts.kanit(
                                      textStyle: const TextStyle(fontSize: 14),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        })
                    : Center(
                        child: CircularProgressIndicator(),
                      );
              }),
        )
    );
  }
}
