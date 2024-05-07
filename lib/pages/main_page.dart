
import 'package:co_i_project/pages/auth_page.dart';
import 'package:co_i_project/pages/home_page.dart';
//import 'package:co_i_project/pages/loginpage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return  StreamBuilder<User?>
      (stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot){
        if(snapshot.hasData){
          return const HomePage();
        }else{
          return const AuthPage();
        }
      }
      );
    
  }
}