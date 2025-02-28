import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wsdtabse/shared_pref/splashscreen.dart';

import 'home.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login"),),
      backgroundColor: Colors.white,
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset("assets/login.json",height: 200,),
              Container(
                width: 300,
                child: TextField(
                  decoration: InputDecoration(
                    labelText: "Username",
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(11)
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(11)
                    )
                  ),
                ),
              ),
              SizedBox(height: 15,),
              Container(
                width: 300,
                child: TextField(
                  decoration: InputDecoration(
                      labelText: "Password",
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(11)
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(11)
                      )
                  ),
                ),
              ),
              SizedBox(height: 15,),
              SizedBox(width:300,child: ElevatedButton(onPressed: () async{
                var SharedPref = await SharedPreferences.getInstance();
                try{
                  SharedPref.setBool(SplashscreenState.KEYLOGIN , true);
                  print("saved pref");
                }catch(e){
                  print(e);
                }
                Navigator.push(context, MaterialPageRoute(builder: (context)=>Home()));
              }, child: Text("Login")))
            ],
          ),
        ),
      ),
    );
  }
}
