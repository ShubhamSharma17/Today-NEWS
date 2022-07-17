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
  String otp = '';

  void sendOTP() async {
    String phone = '+91${phoneController.text.trim()}';
    if (phone == '+91' || phone.length < 13) {
      final snackBar = SnackBar(
        content: Text('Wrong Number!', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
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
            content:
                Text('Complete hai!', style: TextStyle(color: Colors.black)),
            backgroundColor: Colors.white,
            duration: Duration(seconds: 3),
            elevation: 10,
            width: MediaQuery.of(context).size.width * .9,
            behavior: SnackBarBehavior.floating,
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        },
        verificationFailed: (e) {
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
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: Text('Sign in with phone'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Container(
              height: MediaQuery.of(context).size.height * .35,
              width: MediaQuery.of(context).size.width,
              child: Image(
                image: AssetImage(
                  'Assets/Images/undraw_Mobile_login_re_9ntv.png',
                ),
                fit: BoxFit.fill,
              ),
            ),
            SizedBox(height: 20),
            Text('Enter your mobile Number',
                style: TextStyle(color: Colors.white, fontSize: 25)),
            SizedBox(height: 5),
            Text('Please Enter Your mobile number\nand continue',
                style: TextStyle(color: Colors.grey, fontSize: 15)),
            SizedBox(height: 25),
            TextFormField(
              style: TextStyle(color: Colors.white),
              keyboardType: TextInputType.phone,
              controller: phoneController,
              decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(color: Colors.white)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(color: Colors.white)),
                  labelStyle: TextStyle(color: Colors.white),
                  hintStyle: TextStyle(color: Colors.white),
                  labelText: 'Mobile Phone',
                  hintText: 'Enter Mobile Number'),
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
                  child: Text('CONTINUE',
                      style: TextStyle(color: Colors.white, fontSize: 18)),
                )),
              ),
              onTap: () {
                sendOTP();
              },
            ),
            // CupertinoButton(
            //     minSize: 30,
            //     color: Colors.blue,
            //     child: Text('Sign In'),
            //     onPressed: () {
            //       sendOTP();
            //     })
          ]),
        ),
      ),
    );
  }
}
