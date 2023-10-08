import 'package:flutter/material.dart';
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
                Box<dynamic> box = await initializeHive();

                box.put('name', ['Ahmed','ali','refaat']);
                box.put('age', 150);
                box.close();
                print('data saved');
              },
                child: Text('Save single data to Hive',style: TextStyle(fontSize: 20)),
              ),
              ElevatedButton(onPressed: () async {
                Box<dynamic> box = await initializeHive();
                print(box.values);
                var data=box.get('name');
                print(data);
              },
                child: Text('Get single data to Hive',style: TextStyle(fontSize: 20)),
              ),

            ],
          ),
        ),),
    );
  }

  Future<Box<dynamic>> initializeHive() async {
    var path = Directory.current.path;
    Hive.init(path);
    var box = await Hive.openBox('my2Box');
    return box;
  }
}
