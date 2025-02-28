import 'package:flutter/material.dart';

class ListMapProvider extends ChangeNotifier{
  List<Map<String,dynamic>> _mData = [];

  // Events
  void addData(Map<String, dynamic> data) {
    _mData.add(data);
    notifyListeners();
  }
  List<Map<String, dynamic>> fetchData() => _mData;

  void updateData(Map<String, dynamic> updatedData, int index){
    _mData[index] = updatedData;
    notifyListeners();
  }

  void deleteData(int index){
    _mData.removeAt(index);
    notifyListeners();
  }
}