import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;

import 'description.dart';

class ListTechnology extends StatefulWidget {
  final String user_id;
  ListTechnology({Key? key, required this.user_id}) : super(key: key);

  @override
  State<ListTechnology> createState() => _ListTechnologyState();
}

class _ListTechnologyState extends State<ListTechnology> {
  Future getdata() async {
    var url = Uri.parse("http://10.0.2.2//historyproject/joinTechnology.php");
    var response = await http.get(url);
    return json.decode(response.body);
  }

  Set<String> savedData = Set<String>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('ด้านเทคโนโลยี'),
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

        //Container
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
                          var data = list[index]['id_person'];
                          bool isSaved = savedData.contains(data);
                          return Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                                    width: 1,
                                    color: Color.fromARGB(115, 0, 0, 0)),
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
                                         child:  IconButton(
                                           icon: isSaved ? Icon(Icons.star,color: Color(0xFFF78812),size: 40)
                                          :Icon(Icons.star ,color: Colors.white,size: 40),
                                           onPressed: (){
                                            setState(() {
                                              if(isSaved){
                                                savedData.remove(data);
                                                 var url1 = Uri.parse("http://10.0.2.2//historyproject/delete.php");
                                                      http.post(url1, body: {
                                                        'user_id': widget.user_id,
                                                        'id_person' : list[index]['id_person'],
                                                      });
                                              }else{
                                                savedData.add(data);
                                                var url1 = Uri.parse("http://10.0.2.2//historyproject/insertFavour.php");
                                                      http.post(url1, body: {
                                                        'user_id': widget.user_id,
                                                        'id_person' : list[index]['id_person'],
                                                      });
                                              }
                                              print(savedData);
                                            }
                                            );
                                          },
                                        ),
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
                                          'images/imgtechnology/${list[index]['img_person']}'),
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
        ));
  }
}
