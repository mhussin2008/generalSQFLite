import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'shared_class.dart';

class shared_main extends StatefulWidget {
  const shared_main({super.key});

  @override
  State<shared_main> createState() => _shared_mainState();
}

class _shared_mainState extends State<shared_main> {
  shared_class shared_inst=shared_class();
  int?  int_data=null;


  @override
  void initState() {
    // TODO: implement initState

    super.initState();

  }

  @override

  Widget build(BuildContext context) {

   // shared_inst.initialize();
  return  Scaffold(
      appBar: AppBar(title : Text('shared prefs')),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [

              ElevatedButton(onPressed:  () async {
                 await shared_inst.save_data(10);
                },
                  child: Text('Set data to 10',style: TextStyle(fontSize: 20))),

              ElevatedButton(
                onPressed: () async {
                int_data= await shared_inst.get_data();
                print(int_data);
                setState(() {

                });
                },
                child: Text('get data',style: TextStyle(fontSize: 20),),
              ),
              Text(int_data.toString(),style: TextStyle(fontSize: 20),)
            ],
          ),
        ),
      ),
    );
  }
}
