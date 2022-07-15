// ignore_for_file: prefer_const_constructors

import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TempScreen extends StatefulWidget {
  const TempScreen({Key? key}) : super(key: key);

  @override
  State<TempScreen> createState() => _TempScreenState();
}

class _TempScreenState extends State<TempScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController surNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  void saveData() {
    String name = nameController.text.trim();
    String surName = surNameController.text.trim();
    String email = emailController.text.trim();

    nameController.clear();
    surNameController.clear();
    emailController.clear();

    if (name != '' && surName != '' && email != '') {
      Map<String, dynamic> userData = {
        'name': name,
        'surName': surName,
        'email': email
      };
      FirebaseFirestore.instance.collection('user').add(userData);
      log('User Data saved!');
    } else {
      log('Please enter correct credencials!');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Temp Screen')),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(children: [
          TextFormField(
            controller: nameController,
            decoration: InputDecoration(
                labelText: 'Enter Name', hintText: 'Enter Your Name here'),
          ),
          SizedBox(height: 15),
          TextFormField(
            controller: surNameController,
            decoration: InputDecoration(
                labelText: 'Enter Surname',
                hintText: 'Enter Your SurName here'),
          ),
          SizedBox(height: 15),
          TextFormField(
            controller: emailController,
            decoration: InputDecoration(
                labelText: 'Enter Email',
                hintText: 'Enter Your Email Address here'),
          ),
          SizedBox(height: 15),
          ElevatedButton(
              onPressed: () {
                saveData();
              },
              child: Text('Save')),
        ]),
      ),
    );
  }
}
