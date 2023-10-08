import 'package:flutter/material.dart';
import 'package:generaldbase/hive_test/simple_data.dart';
import 'package:hive/hive.dart';
import 'hive_data.dart';
import 'dart:io';
// dart run build_runner build

class hive_screen extends StatelessWidget {
   hive_screen({super.key});


  @override
  Widget build(BuildContext context) {
    var person = Person(
      name: 'Dave',
      age: 22,
      friends: ['Linda', 'Marc', 'Anne'],
    );
    return  Scaffold(
      appBar: AppBar(title: Text('Hive test app'),),

      body: SafeArea(child:
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(onPressed: (){
                 hiveOperations.putdata(person);
              },
                  child: Text('Save data to Hive',style: TextStyle(fontSize: 20)),
              ),

              ElevatedButton(onPressed: (){
                hiveOperations.getdata();
              },
                child: Text('get data from Hive',style: TextStyle(fontSize: 20)),
              ),
              ElevatedButton(onPressed: () async {
                simpleData.setData('name', ['Ahmed','ali','refaat']);
                simpleData.setData('age', 150);
                //simpleData.close();
                print('data saved');
              },
                child: Text('Save single data to Hive',style: TextStyle(fontSize: 20)),
              ),
              ElevatedButton(onPressed: () async {

                print(await simpleData.getData('name'));

              },
                child: Text('Get single data to Hive',style: TextStyle(fontSize: 20)),
              ),

            ],
          ),
        ),),
    );
  }


}
