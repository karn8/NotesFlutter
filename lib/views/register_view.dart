import 'package:flutter/material.dart';
import 'dart:developer' as devtools show log;
import 'package:mynote/constants/routes.dart';
import 'package:mynote/services/auth/auth_exceptions.dart';
import 'package:mynote/services/auth/auth_service.dart';
import '../utilities/show_error_dialog.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({ Key? key }) : super(key: key);

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {

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
      appBar: AppBar(title: const Text('Register')),
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
                  await AuthService.firebase().createUser(email: email, password: password);
                  AuthService.firebase().sendEmailVerification();
                  Navigator.of(context).pushNamed(verifyEmailRoute);
                } on WeakPasswordAuthException {
                  devtools.log('weak password');
                    await showErrorDialog(
                      context, 
                      'Weak password',);
                } on EmailAlreadyInUseAuthException {
                  devtools.log('Email already in use');
                    await showErrorDialog(
                      context, 
                      'Email already in use',);
                } on InvaidEmailAuthException {
                  devtools.log('Invalid email id');
                    await showErrorDialog(
                      context, 
                      'Invalid Email ID',);
                } on GenericAuthException {
                  await showErrorDialog(
                      context, 
                      'Failed to register',);
                }

              },
              child: const Text('Register'),),
              TextButton(onPressed: (){
                Navigator.of(context).pushNamedAndRemoveUntil(loginRoute, 
              (route) => false);
              }, child: const Text('Already Registered? Login here'))
            ],
          ),
    );
  }
}

