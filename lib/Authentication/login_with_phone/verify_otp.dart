// ignore_for_file: prefer_const_constructors, unnecessary_null_comparison, non_constant_identifier_names, use_build_context_synchronously
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pet_api/Screen/HomePage/HomePage.dart';

class VerifyOTP extends StatefulWidget {
  final String verificationId;
  // final String otp;

  const VerifyOTP({
    Key? key,
    required this.verificationId,
    // required this.otp
  }) : super(key: key);

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
        content: Text(e.code.toString(), style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
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
      backgroundColor: Colors.black,
      appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          backgroundColor: Colors.black,
          title: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          )),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            'Verify Phone\nNumber',
            style: TextStyle(
                fontSize: 40, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          SizedBox(height: 10),
          Text(
            'Check your SMS message. We/'
            've sent you\nthe OTP at phonenumber',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          ),
          SizedBox(height: 30),
          TextFormField(
            style: TextStyle(color: Colors.white),
            keyboardType: TextInputType.number,
            maxLength: 6,
            controller: otpController,
            decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(color: Colors.white)),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(color: Colors.white)),
              labelText: 'Verify OTP',
              hintText: 'Enter Verify OTP',
              labelStyle: TextStyle(color: Colors.white),
              hintStyle: TextStyle(color: Colors.white),
            ),
          ),
          SizedBox(height: 20),
          InkWell(
            child: Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey,
              ),
              child: Center(
                  child: Padding(
                padding: const EdgeInsets.all(15),
                child: Text('VERIFY',
                    style: TextStyle(color: Colors.white, fontSize: 18)),
              )),
            ),
            onTap: () {
              verifyOTP();
            },
          ),
        ]),
      ),
    );
  }
}
