import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mynote/services/auth/bloc/auth_bloc.dart';
import 'package:mynote/services/auth/bloc/auth_event.dart';


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
             const Text("We have sent you an Email verification, Please open it to verify your account then head back to login\n"),
             const Text('If you haven\'t recieved the Email, Press the button below'),
             
             TextButton(onPressed: (){
              context.read<AuthBloc>().add(const AuthEventSendEmailVerification());
             }, 
             child: const Text('Resend Email Verification'),),
             
            TextButton(
              onPressed:() async {
                context.read<AuthBloc>().add(const AuthEventLogOut());
              }, 
            child: const Text('Go back to Login'))
          ],),
    );
  }
}