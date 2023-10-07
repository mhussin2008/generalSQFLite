import 'package:flutter/material.dart';
import 'package:generaldbase/sharedpreferences/shared_main_screen.dart';

void main(){
  runApp(MaterialApp(home: shared_test()));
}

class shared_test extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return shared_main_screen();
  }

}