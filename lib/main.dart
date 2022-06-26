import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mynote/firebase_options.dart';
import 'package:mynote/views/login_view.dart';
import 'package:mynote/views/register_view.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const HomePage(),
    ),);
}

class HomePage extends StatelessWidget {
  const HomePage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: FutureBuilder(
        future: Firebase.initializeApp(
              options: DefaultFirebaseOptions.currentPlatform,
              ),
        builder:(context, snapshot) {
          switch (snapshot.connectionState){
            case ConnectionState.done:
              final User = FirebaseAuth.instance.currentUser;
              
              if (User?.emailVerified ?? false){
                print('Oh its you! ');
              } else {
                print('You need to verify your email first');
              }
              return const Text('Done');
            default: 
              return const Text("I swear its the server...");  
        }
          
        },
      
      ),
    );
  }
  
}