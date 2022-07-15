// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, unnecessary_null_comparison, use_build_context_synchronously, non_constant_identifier_names, sized_box_for_whitespace
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pet_api/Authentication/login_with_phone/signIN_with_phone.dart';
import 'package:pet_api/Screen/HomePage/HomePage.dart';
import '../signUp/signUp.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void Login() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    if (email == '' || password == '') {
      // log('Fill all the credencials!');
      final snackBar = SnackBar(
        content: Text('Fill all the credencials!',
            style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        duration: Duration(seconds: 3),
        elevation: 10,
        width: MediaQuery.of(context).size.width * .9,
        behavior: SnackBarBehavior.floating,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password);

        if (userCredential != null) {
          // log('Loged In!');
          final snackBar = SnackBar(
            content: Text('Loged In!'),
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
                builder: (context) => HomePage(),
              ));
        }
      } on FirebaseException catch (e) {
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
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Container(
            margin: EdgeInsets.only(left: width * .25),
            child: Row(children: [
              Text(
                'ToDay',
                style: TextStyle(
                  fontSize: 24,
                ),
              ),
              SizedBox(width: 10),
              Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 3),
                ),
                child: Text(
                  'NEWS',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ]),
          ),
        ),
        body: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              child: Image(
                image: AssetImage('Assets/Images/background Image.png'),
                fit: BoxFit.fill,
              ),
            ),
            Positioned(
              bottom: 120,
              left: 0,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Container(
                  child: Column(children: [
                    TextFormField(
                        style: TextStyle(color: Colors.white),
                        keyboardType: TextInputType.emailAddress,
                        controller: emailController,
                        decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            labelStyle: TextStyle(color: Colors.white),
                            hintStyle: TextStyle(color: Colors.white),
                            labelText: 'Email Address',
                            hintText: 'Enter Email Address Here!')),
                    SizedBox(height: 20),
                    TextFormField(
                        style: TextStyle(color: Colors.white),
                        controller: passwordController,
                        decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide:
                                    BorderSide(color: Colors.white, width: 2)),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            labelStyle: TextStyle(color: Colors.white),
                            hintStyle: TextStyle(color: Colors.white),
                            labelText: 'Password',
                            hintText: 'Enter Password Here!')),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        Login();
                      },
                      // color: Colors.blue,
                      child: Text('Login'),
                    ),
                    // SizedBox(height: 5),
                    Text('OR', style: TextStyle(color: Colors.white)),
                    // SizedBox(height: 5),
                    ElevatedButton(
                        // color: Colors.blue,
                        child: Text('Continue With Phone'),
                        onPressed: () {
                          Navigator.push(
                              context,
                              CupertinoPageRoute(
                                  builder: (context) => SignInWithPhonee()));
                        }),
                    Divider(color: Colors.white),
                    SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Not registered?',
                            style: TextStyle(color: Colors.grey)),
                        CupertinoButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                      builder: (context) => SignUp()));
                            },
                            child: Text('Create an Account',
                                style: TextStyle(color: Colors.white)))
                      ],
                    )
                  ]),
                ),
              ),
            ),
          ],
        ));
  }
}
