import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wsdtabse/shared_pref/login.dart';

import 'home.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => SplashscreenState();
}

class SplashscreenState extends State<Splashscreen> {
  static final String KEYLOGIN = "login";
  @override
  void initState() {
    super.initState();

    whereToGo();
  }
  void whereToGo() async {
    var SharedPref = await SharedPreferences.getInstance();
    var isLoggedIn = SharedPref.getBool(KEYLOGIN);
    if(isLoggedIn != null){
      if(isLoggedIn ==true){
        Timer(Duration(seconds: 2), (){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home()));
        });
      }else{
        Timer(Duration(seconds: 2), (){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()));
        });
      }

    }else{
      Timer(Duration(seconds: 2), (){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()));
      });
    }

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Center(child:
          Lottie.asset("assets/welcome.json",),
        ),
      ),
    );
  }
}
