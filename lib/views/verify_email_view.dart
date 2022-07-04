import 'package:firebase_auth/firebase_auth.dart';
import 'dart:developer' as devtools show log;
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
             const Text('Please verify your email address'),
             TextButton(onPressed: () async {
              final user = FirebaseAuth.instance.currentUser;
              await user?.sendEmailVerification();
             }, child: const Text('Send Email Verification'),)
          ],),
    );
  }
}