import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:word_generator/word_generator.dart';
import 'shared_class.dart';


class shared_main_screen extends StatefulWidget {
  const shared_main_screen({super.key});

  @override
  State<shared_main_screen> createState() => _shared_main_screenState();
}

class _shared_main_screenState extends State<shared_main_screen> {
  //shared_class shared_inst=shared_class();
  int?  int_data=null;
  List<String>? strList=[];


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
                 //await shared_inst.save_data(10);
                //await shared_inst.save_string(generateData());
                await shared_class.save_string(generateData());
                print('string list Saved to SharedPreferences');
                },
                  child: Text('Set data to 10',style: TextStyle(fontSize: 20))),

              ElevatedButton(
                onPressed: () async {
                //int_data= await shared_inst.get_data();
                  //strList= await shared_inst.get_str_list();
                  strList= await shared_class.get_str_list();
                print(strList);
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

  List<String> generateData(){

    //final wordGenerator = WordGenerator();
    return WordGenerator().randomNouns(10);

    }

}
