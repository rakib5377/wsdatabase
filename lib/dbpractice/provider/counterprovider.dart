import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CounterProvider extends ChangeNotifier{
  int _count1 = 0;

  int getCount()=> _count1;

  void increment(int value){
    _count1+=value;
    notifyListeners();
  }
  void decrement(int value){
    if(_count1>0){
      _count1-=value;
      notifyListeners();
    }
  }
}