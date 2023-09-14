import 'dart:math';

import 'package:word_generator/word_generator.dart';


class Records{
  List<SingleRecord> recordsList=<SingleRecord>[];


  void generateData(){
    final wordGenerator = WordGenerator();
   var rnouns = wordGenerator.randomNouns(10);
   var rages=<int>[];
    var rng = Random();
   for(int i=0;i<10;i++){
     rages.add(rng.nextInt(100));
     recordsList.add(SingleRecord(rnouns[i], rages[i]));
   }}


   void printData(){
     for(int i=0;i<recordsList.length;i++){
       print(recordsList[i].toString());
     }

   }


  }





class SingleRecord{
  final String Name;
  final int age;

  SingleRecord(this.Name, this.age);

  @override
  String toString() {
    // TODO: implement toString
    return 'name= $Name , age= $age';
  }

}