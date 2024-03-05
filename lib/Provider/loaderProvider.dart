import 'package:flutter/material.dart';

class LoaderProvider extends ChangeNotifier{
  bool loader=false;
loaderUse(bool value){
    loader=value;
    notifyListeners();
  }
}