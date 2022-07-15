// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pet_api/Authentication/LoginPage/login.dart';
import 'package:flutter/services.dart';
import 'package:pet_api/Screen/HomePage/HomePage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // DocumentSnapshot snapshot = await FirebaseFirestore.instance
  //     .collection('user')
  //     .doc('vcGgmHxuPSfLKnlEqhYj')
  //     .get();
  // for (var doc in snapshot.docs) {
  //   log(doc.data().toString());
  // }
  // log(snapshot.data() .toString());

  //create user data
  // Map<String, dynamic> userData = {
  //   'name': 'Kailash Upadhyay',
  //   'email': 'kailash@gmail.com'
  // };
//to add data

  //when you don't give docu ID
  // FirebaseFirestore.instance.collection('user').add(userData);
  // log('Add successfully!');

//to add data
  //when you give docu ID
  // FirebaseFirestore.instance
  //     .collection('user')
  //     .doc('give-manually-ID')
  //     .set(userData);
  // log('Add successfully!');

//to edit/update data
// //to edit/update data
//   FirebaseFirestore.instance
//       .collection('user')
//       .doc('give-manually-ID')
//       .update({'name': 'Kailash'});
//   log('User update successfully!');

//for deleteing data
  // FirebaseFirestore.instance
  //     .collection('user')
  //     .doc('give-manually-ID')
  //     .delete();
  // log('delete data!');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: FirebaseAuth.instance.currentUser != null
            ? HomePage()
            : LoginPage());
    // TempScreen());
  }
}
