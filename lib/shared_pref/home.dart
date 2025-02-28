import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wsdtabse/shared_pref/login.dart';
import 'package:wsdtabse/shared_pref/splashscreen.dart';
class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset("assets/home.json",),
            SizedBox(height: 15,),
            SizedBox(width:300,child: ElevatedButton(onPressed: ()async{
              var sharedpref = await SharedPreferences.getInstance();
              sharedpref.setBool(SplashscreenState.KEYLOGIN, false);
              Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
            }, child: Text("Log out")))
          ],
        ),
      ),
    );
  }
}
