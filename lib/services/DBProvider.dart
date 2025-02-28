import 'package:flutter/material.dart';
import 'package:wsdtabse/services/dbhelper.dart';

class DBProvider extends ChangeNotifier{
  DBhelper dbhelper;
  DBProvider({required this.dbhelper});
  List<Map<String, dynamic>> _mData = [];

  //Events
  void addData(String title, String desc) async{
    bool check = await dbhelper.insertNote(mTitle: title, mDesc: desc);
    if(check){
      _mData = await dbhelper.getAllNotes();
      notifyListeners();
    }
  }
  void updateData(String title, String desc, int id) async {
    bool check = await dbhelper.updateNote(mTitle: title, mDesc: desc, id: id);
    if(check){
      _mData = await dbhelper.getAllNotes();
      notifyListeners();
    }
  }
  List<Map<String, dynamic>> getNotes()=> _mData;

  void getInitialNotes()async{
    _mData = await dbhelper.getAllNotes();
    notifyListeners();
  }
  void deleteData(int id) async {
    bool check = await dbhelper.deleteNote(id: id);
    if(check){
      _mData = await dbhelper.getAllNotes();
      notifyListeners();
    }
  }
}