import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

import '../constants/routes.dart';

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
             const Text("We have sent you an Email verification, Please open it to verify your account\n"),
             const Text('If you havent recieved the Email, Press the button below'),
             TextButton(onPressed: () async {
              final user = FirebaseAuth.instance.currentUser;
              await user?.sendEmailVerification();
             }, child: const Text('Resend Email Verification'),),
             TextButton(onPressed:() async {
            await FirebaseAuth.instance.signOut();
            Navigator.of(context).pushNamedAndRemoveUntil(
              registerRoute,
             (route) => false);
          }, 
          child: const Text('Restart'))
          ],),
    );
  }
}