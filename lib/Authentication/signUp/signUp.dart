// ignore_for_file: unnecessary_null_comparison, use_build_context_synchronously, prefer_const_constructors, file_names
import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
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
        content: Text(
          'Please fill all the fields',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        duration: Duration(seconds: 3),
        elevation: 10,
        width: MediaQuery.of(context).size.width * .9,
        behavior: SnackBarBehavior.floating,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      // log('Please fill all the fields');
    } else if (password != confirmPassword) {
      final snackBar = SnackBar(
        content: Text('Password doesn\'t match',
            style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
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
          content: Text('User Created!', style: TextStyle(color: Colors.black)),
          backgroundColor: Colors.white,
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
          content:
              Text(e.code.toString(), style: TextStyle(color: Colors.black)),
          backgroundColor: Colors.white,
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
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.black,
      appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          backgroundColor: Colors.black,
          title: IconButton(
              icon: Icon(Icons.cancel),
              onPressed: () {
                Navigator.pop(context);
              },
              color: Colors.white)),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * .35,
            child: Image(image: AssetImage('Assets/Images/signup.png')),
          ),
          SizedBox(height: 10),
          Text(
            'Glad to see you!',
            style: TextStyle(
                fontSize: 30, color: Colors.white, fontWeight: FontWeight.bold),
          ),
          Divider(color: Colors.white),
          SizedBox(height: 10),
          TextFormField(
            style: TextStyle(color: Colors.white),
            keyboardType: TextInputType.emailAddress,
            controller: emailController,
            decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: Colors.white)),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: Colors.white)),
                labelStyle: TextStyle(color: Colors.white),
                hintStyle: TextStyle(color: Colors.white),
                labelText: 'Email Address',
                hintText: 'Enter email address here!'),
          ),
          SizedBox(height: 10),
          TextFormField(
            style: TextStyle(color: Colors.white),
            controller: passwordController,
            decoration: InputDecoration(
              labelText: 'Password',
              hintText: 'Enter password here!',
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(color: Colors.white)),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(color: Colors.white)),
              labelStyle: TextStyle(color: Colors.white),
              hintStyle: TextStyle(color: Colors.white),
            ),
          ),
          SizedBox(height: 10),
          TextFormField(
            style: TextStyle(color: Colors.white),
            controller: confirmPasswordController,
            decoration: InputDecoration(
              labelText: 'Confirm Password',
              hintText: 'Enter confirm password',
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(color: Colors.white)),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(color: Colors.white)),
              labelStyle: TextStyle(color: Colors.white),
              hintStyle: TextStyle(color: Colors.white),
            ),
          ),
          SizedBox(height: 25),
          GestureDetector(
            onTap: () => createAccount(),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20), color: Colors.white),
              width: MediaQuery.of(context).size.width,
              child: Center(
                  child: Padding(
                padding: const EdgeInsets.all(15),
                child: Text(
                  'Sign Up',
                  style: TextStyle(fontSize: 20),
                ),
              )),
            ),
          )
          // CupertinoButton(
          //   onPressed: () {
          //     createAccount();
          //   },
          //   color: Colors.blue,
          //   child: Text('SignUp'),
          // )
        ]),
      ),
    );
  }
}
