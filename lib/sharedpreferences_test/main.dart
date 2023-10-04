import 'package:flutter/material.dart';
import 'package:generaldbase/sharedpreferences_test/shared_main.dart';

void main(){
  runApp(MaterialApp(home: shared_test()));
}

class shared_test extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return shared_main();
  }

}