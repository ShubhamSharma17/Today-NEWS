// ignore_for_file: file_names, prefer_const_constructors, sized_box_for_whitespace
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pet_api/Authentication/login_with_phone/verify_otp.dart';

class SignInWithPhonee extends StatefulWidget {
  const SignInWithPhonee({Key? key}) : super(key: key);

  @override
  State<SignInWithPhonee> createState() => _SignInWithPhoneeState();
}

class _SignInWithPhoneeState extends State<SignInWithPhonee> {
  TextEditingController phoneController = TextEditingController();
  bool isLoading = true;

  void sendOTP() async {
    String phone = '+91${phoneController.text.trim()}';
    if (phone == '+91' || phone.length < 13) {
      final snackBar = SnackBar(
        content: Text('Wrong Number!'),
        backgroundColor: Colors.black,
        duration: Duration(seconds: 3),
        elevation: 10,
        width: MediaQuery.of(context).size.width * .9,
        behavior: SnackBarBehavior.floating,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phone,
        verificationCompleted: (credential) {
          final snackBar = SnackBar(
            content: Text('Complete hai!'),
            backgroundColor: Colors.black,
            duration: Duration(seconds: 3),
            elevation: 10,
            width: MediaQuery.of(context).size.width * .9,
            behavior: SnackBarBehavior.floating,
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        },
        verificationFailed: (e) {
          final snackBar = SnackBar(
            content: Text(e.code.toString()),
            backgroundColor: Colors.black,
            duration: Duration(seconds: 3),
            elevation: 10,
            width: MediaQuery.of(context).size.width * .9,
            behavior: SnackBarBehavior.floating,
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        },
        codeAutoRetrievalTimeout: (verificationId) {},
        timeout: Duration(seconds: 30),
        codeSent: (verificationId, resendToken) {
          Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (context) => VerifyOTP(verificationId: verificationId),
              ));
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign in with phone'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(children: [
          TextFormField(
            keyboardType: TextInputType.phone,
            controller: phoneController,
            decoration: InputDecoration(
                labelText: 'Phone', hintText: 'Enter Phone Number'),
          ),
          SizedBox(height: 20),
          CupertinoButton(
              color: Colors.blue,
              child: Text('Sign In'),
              onPressed: () {
                sendOTP();
              })
        ]),
      ),
    );
  }
}
