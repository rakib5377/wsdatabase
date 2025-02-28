import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wsdtabse/dbpractice/homedb.dart';
import 'package:wsdtabse/dbpractice/provider/countapp.dart';
import 'package:wsdtabse/dbpractice/provider/counterprovider.dart';
import 'package:wsdtabse/providerpractice/list_map_provider.dart';
import 'package:wsdtabse/providerpractice/list_page.dart';
import 'package:wsdtabse/services/DBProvider.dart';
import 'package:wsdtabse/services/dbhelper.dart';
import 'package:wsdtabse/shared_pref/shared_pref.dart';

import 'shared_pref/splashscreen.dart';
import 'ui/homepage.dart';

void main(){

  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context)=> CounterProvider()),
        ChangeNotifierProvider(create: (context)=> ListMapProvider()),
        ChangeNotifierProvider(create: (context)=> DBProvider(dbhelper: DBhelper.getInstance)),
      ],
      child: NoteApp()
      ));

}

class NoteApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      theme:
      ThemeData.light(),
      //theme: ThemeData(appBarTheme: AppBarTheme(centerTitle: true,backgroundColor: Colors.pink, foregroundColor: Colors.white),scaffoldBackgroundColor: Colors.pink.shade100),
      home: HomePage(),

    );
  }
}