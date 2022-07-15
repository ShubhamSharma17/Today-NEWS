// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, sort_child_properties_last, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables, file_names
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pet_api/Authentication/LoginPage/login.dart';
import 'package:pet_api/Screen/NewsPage/newsScreen.dart';
import 'package:pet_api/API/API_model/api_model.dart';
import 'package:pet_api/API/API_data/apidata.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoading = true;
  List<APIModel> list = [];

  @override
  void initState() {
    getData().then((value) {
      setState(() {
        if (value.isNotEmpty) {
          list = value;
          isLoading = false;
        } else {
          final snackBar = SnackBar(
            content: Text('Something went wrong'),
            backgroundColor: Colors.black,
            duration: Duration(seconds: 3),
            elevation: 10,
            width: MediaQuery.of(context).size.width * .9,
            behavior: SnackBarBehavior.floating,
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          // log('Something went wrong');
        }
      });
    });
    super.initState();
  }

  //log out function
  void signOut() {
    FirebaseAuth.instance.signOut();
    // log('SignOut Successfilly!');
    final snackBar = SnackBar(
      content: Text('SignOut Successfilly!'),
      backgroundColor: Colors.black,
      duration: Duration(seconds: 3),
      elevation: 10,
      width: MediaQuery.of(context).size.width * .9,
      behavior: SnackBarBehavior.floating,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    Navigator.popUntil(context, (route) => route.isFirst);
    Navigator.pushReplacement(
        context,
        CupertinoPageRoute(
          builder: (context) => LoginPage(),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // drawer: Drawer(
        //   width: 250,
        //   backgroundColor: Colors.grey[400],
        //   child: Column(
        //     crossAxisAlignment: CrossAxisAlignment.start,
        //     children: [
        //       Padding(
        //         padding: const EdgeInsets.only(top: 50, left: 10),
        //         child: Column(
        //           crossAxisAlignment: CrossAxisAlignment.start,
        //           children: [
        //             Container(
        //               child: CircleAvatar(
        //                   radius: 40,
        //                   child: ClipOval(
        //                     child: Image.asset(
        //                       'Assets/Images/IMG_20220609_235656_257.jpg',
        //                       fit: BoxFit.contain,
        //                     ),
        //                   )),
        //             ),
        //             SizedBox(height: 15),
        //             //NAME
        //             Text('Shubham Sharma'),
        //             SizedBox(height: 10),
        //             //GMAIL ADDRESS
        //             Text('shubhamsharma706568@gmail.com'),
        //           ],
        //         ),
        //       ),
        //       SizedBox(height: 10),
        //       Divider(
        //         color: Colors.black,
        //       ),
        //       SizedBox(height: 5),
        //     ],
        //   ),
        // ),
        appBar: AppBar(
          actions: [
            //for exit the app
            IconButton(
                onPressed: () {
                  signOut();
                },
                icon: Icon(
                  Icons.exit_to_app,
                  color: Colors.black,
                ))
          ],
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: Colors.white,
          title: Row(children: [
            Container(
              child: Text(
                'ToDay',
                style: TextStyle(color: Colors.black, fontSize: 25),
              ),
            ),
            SizedBox(width: 5),
            Container(
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: Text(
                  'NEWS',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              color: Colors.black,
            ),
          ]),
        ),
        body: isLoading
            ? Align(
                alignment: Alignment.center,
                child: Container(
                  height: 50,
                  width: 50,
                  child: CircularProgressIndicator(),
                ),
              )
            : ListView.builder(
                itemCount: list.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => NewsPage(
                          content: list[index].content,
                          date: list[index].publishedAt,
                          description: list[index].description,
                          image: list[index].urlToImage,
                          title: list[index].title,
                          url: list[index].url,
                        ),
                      ));
                    },
                    child: Card(
                      clipBehavior: Clip.antiAlias,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      // shadowColor: Colors.amber,
                      child: Column(
                        children: [
                          //for image
                          Container(
                            height: MediaQuery.of(context).size.height * .4,
                            // height: 100,
                            width: MediaQuery.of(context).size.width,
                            child: Image.network(
                              list[index].urlToImage,
                              errorBuilder: (context, error, stackTrace) {
                                return Image.network(
                                    'https://demofree.sirv.com/nope-not-here.jpg');
                              },
                              fit: BoxFit.fill,
                            ),
                          ),
                          SizedBox(height: 10),
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: Container(
                              child: Text(
                                list[index].title,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 5),
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.person,
                                ),
                                SizedBox(width: 10),
                                Text(
                                  list[index].author != 'null'
                                      ? list[index].author
                                      : 'Not Available',
                                  style: TextStyle(
                                    fontSize: 15,
                                    // fontWeight: FontWeight.w500,
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                      elevation: 10,
                      // color: Colors.white60,
                      margin: EdgeInsets.only(top: 10, left: 5, right: 5),
                    ),
                  );
                },
              ));
  }
}
