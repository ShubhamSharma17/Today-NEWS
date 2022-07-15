// ignore_for_file: unnecessary_null_comparison, use_build_context_synchronously, prefer_const_constructors, file_names

import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  void createAccount() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    String confirmPassword = confirmPasswordController.text.trim();

    if (email == '' || password == '' || confirmPassword == '') {
      final snackBar = SnackBar(
        content: Text('Please fill all the fields'),
        backgroundColor: Colors.black,
        duration: Duration(seconds: 3),
        elevation: 10,
        width: MediaQuery.of(context).size.width * .9,
        behavior: SnackBarBehavior.floating,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      // log('Please fill all the fields');
    } else if (password != confirmPassword) {
      final snackBar = SnackBar(
        content: Text('Password doesn\'t match'),
        backgroundColor: Colors.black,
        duration: Duration(seconds: 3),
        elevation: 10,
        width: MediaQuery.of(context).size.width * .9,
        behavior: SnackBarBehavior.floating,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      log('Password doesn\'t match');
    } else {
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);
        final snackBar = SnackBar(
          content: Text('User Created!'),
          backgroundColor: Colors.black,
          duration: Duration(seconds: 3),
          elevation: 10,
          width: MediaQuery.of(context).size.width * .9,
          behavior: SnackBarBehavior.floating,
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        // log('User created');
        if (userCredential != null) {
          Navigator.pop(context);
        }
      } on FirebaseAuthException catch (e) {
        final snackBar = SnackBar(
          content: Text(e.code.toString()),
          backgroundColor: Colors.black,
          duration: Duration(seconds: 3),
          elevation: 10,
          width: MediaQuery.of(context).size.width * .9,
          behavior: SnackBarBehavior.floating,
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        // log(e.code.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('SignUp ')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(children: [
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            controller: emailController,
            decoration: InputDecoration(labelText: 'Email Address'),
          ),
          SizedBox(height: 10),
          TextFormField(
            controller: passwordController,
            decoration: InputDecoration(labelText: 'Password'),
          ),
          SizedBox(height: 10),
          TextFormField(
            controller: confirmPasswordController,
            decoration: InputDecoration(labelText: 'Confirm Password'),
          ),
          SizedBox(height: 25),
          CupertinoButton(
            onPressed: () {
              createAccount();
            },
            color: Colors.blue,
            child: Text('SignUp'),
          )
        ]),
      ),
    );
  }
}
