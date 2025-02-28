import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wsdtabse/ui/settings.dart';
class ThemeProvider extends ChangeNotifier{

  bool _isDarkMode  = false;
  ThemeProvider() {
    _loadTheme();
  }

  bool getThemeValue () => _isDarkMode;

  // events
  void UpdateThemeMode({required bool value}) async{
    _isDarkMode = value;
    notifyListeners();
    var SharedPref = await SharedPreferences.getInstance();
    SharedPref.setBool(Settings.KEYTHEME, value);
  }

  Future<void> _loadTheme() async {
    var SharedPref = await SharedPreferences.getInstance();
    _isDarkMode =  SharedPref.getBool(Settings.KEYTHEME) ?? false;
    notifyListeners();
  }
}