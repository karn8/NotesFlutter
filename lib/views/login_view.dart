import 'dart:developer' as devtools show log;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mynote/constants/routes.dart';
import 'package:mynote/services/auth/auth_exceptions.dart';
import 'package:mynote/services/auth/bloc/auth_bloc.dart';
import 'package:mynote/services/auth/bloc/auth_event.dart';
import '../utilities/dialogs/error_dialog.dart';


class LoginView extends StatefulWidget {
  const LoginView({ Key? key }) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final TextEditingController _email;
  late final TextEditingController _password;
  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Column(
            children: [
              TextField(controller: _email,
              enableSuggestions: false,
              autocorrect: false,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                hintText: 'Enter your Email ID',
              )
                ),
              TextField(controller: _password,
              obscureText: true ,
              enableSuggestions: false,
              autocorrect: false,
              decoration: const InputDecoration(
                hintText: 'Enter Password',
              )
                ),
              TextButton(onPressed: () async {
                final email= _email.text;
                final password= _password.text;
                try{
                  context.read<AuthBloc>().add(
                    AuthEventLogIn(
                      email, 
                      password)
                  );
                } on UserNotFoundAuthException {
                  devtools.log('User not found');
                  await showErrorDialog(
                      context, 
                      'User not found',);
                } on WrongPasswordAuthExcpetion {
                  devtools.log('Wrong Password');
                    await showErrorDialog(
                      context, 
                      'Wrong credentials',);
                } on GenericAuthException {
                  await showErrorDialog(
                      context, 
                      'Authentication Error',);
                }
              },
              child: const Text('Login'),),
              TextButton(onPressed:  () {
                Navigator.of(context).pushNamedAndRemoveUntil(registerRoute, 
                (route) => false);
              }
              , child: const Text('Not registered? Register now'))
            ],
          ),
    );
   
  
  }
}

