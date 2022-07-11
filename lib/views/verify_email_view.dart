import 'package:flutter/material.dart';
import 'package:mynote/services/auth/auth_service.dart';
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
              AuthService.firebase().sendEmailVerification();
             }, child: const Text('Resend Email Verification'),),
             TextButton(onPressed:() async {
            await AuthService.firebase().logOut();
            Navigator.of(context).pushNamedAndRemoveUntil(
              registerRoute,
             (route) => false);
          }, 
          child: const Text('Restart'))
          ],),
    );
  }
}