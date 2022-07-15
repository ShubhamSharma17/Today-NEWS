// ignore_for_file: prefer_const_constructors, unnecessary_null_comparison, non_constant_identifier_names, use_build_context_synchronously
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pet_api/Screen/HomePage/HomePage.dart';

class VerifyOTP extends StatefulWidget {
  final String verificationId;
  const VerifyOTP({Key? key, required this.verificationId}) : super(key: key);

  @override
  State<VerifyOTP> createState() => _VerifyOTPState();
}

class _VerifyOTPState extends State<VerifyOTP> {
  TextEditingController otpController = TextEditingController();

  void verifyOTP() async {
    String OTP = otpController.text.trim();

    PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(
        verificationId: widget.verificationId, smsCode: OTP);

    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(phoneAuthCredential);
      if (userCredential != null) {
        Navigator.popUntil(context, (route) => route.isFirst);
        Navigator.pushReplacement(
            context, CupertinoPageRoute(builder: (context) => HomePage()));
      }
    } on FirebaseException catch (e) {
      // log(ex.code.toString());
      final snackBar = SnackBar(
        content: Text(e.code.toString()),
        backgroundColor: Colors.black,
        duration: Duration(seconds: 3),
        elevation: 10,
        width: MediaQuery.of(context).size.width * .9,
        behavior: SnackBarBehavior.floating,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Verifing OTP')),
      body: Column(children: [
        TextFormField(
          keyboardType: TextInputType.number,
          maxLength: 6,
          controller: otpController,
          decoration: InputDecoration(
              labelText: 'Verify OTP', hintText: 'Enter Verify OTP'),
        ),
        SizedBox(height: 20),
        CupertinoButton(
            child: Text('Verify'),
            onPressed: () {
              verifyOTP();
            })
      ]),
    );
  }
}
