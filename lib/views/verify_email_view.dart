import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class VerifyemailView extends StatefulWidget {
  const VerifyemailView({ Key? key }) : super(key: key);

  @override
  State<VerifyemailView> createState() => _VerifyemailViewState();
}

class _VerifyemailViewState extends State<VerifyemailView> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(title: const Text('Email Verification')),
      body: Column(children: [
             Text('Please verify your email address'),
             TextButton(onPressed: () async {
              final user = FirebaseAuth.instance.currentUser;
              await user?.sendEmailVerification();
             }, child: Text('Send Email Verification'),)
          ],),
    );
  }
}