import 'package:flutter/material.dart';
import 'package:money_management/screens/home/home.dart';
import 'package:money_management/screens/statistics/report.dart';

class BottomNavigationProvider extends ChangeNotifier{
  int indexColour =0;
  List screen = [const ScreenHome(), const ScreenReport()];

  void setIndexColor(int newIndexColor){
    indexColour =newIndexColor;
    notifyListeners();
  }
}