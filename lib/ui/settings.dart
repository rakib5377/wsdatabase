import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wsdtabse/services/theme_provider.dart';
class Settings extends StatelessWidget {
  const Settings({super.key});
  static final String KEYTHEME = "theme";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Settings"),),
      body: Consumer<ThemeProvider>(builder: (ctx, provider, __){
        return SwitchListTile.adaptive(
            title: Text("DarkMode"),
            subtitle: Text("Change to dark mode"),
            value: provider.getThemeValue(),
            onChanged: (value) async{
              provider.UpdateThemeMode(value: value);
              var Sharedpref  = await SharedPreferences.getInstance();
              try{
                Sharedpref.setBool(KEYTHEME, value);
                print("Done");
              }catch(e){
                print("Error saving theme: $e");
              }
            });
      })
    );
  }


}
