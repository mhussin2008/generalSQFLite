import 'package:flutter/material.dart';
import 'package:generaldbase/dbHelper/theData.dart';
import 'dbaseHelper.dart';

class testHelper extends StatefulWidget {
  const testHelper({super.key});

  @override
  State<testHelper> createState() => _testHelperState();
}

class _testHelperState extends State<testHelper> {
  // dbaseHelper mydbHelper = dbaseHelper();
  // Records myRecords = Records();
  TextStyle _mystyle=  const TextStyle(fontSize: 25);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('test helper'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                onPressed: () {
                  myRecords.generateData();
                  print(mydbHelper.hashCode);
                  print(mydbHelper.db.path);
                  myRecords.printData();
                },
                child:  Text('generate Random Data',style:  _mystyle),
              ),
              ElevatedButton(
                  onPressed: () {
                    myRecords.recordsList.clear();
                  },
                  child:  Text('delete data from memory',style:  _mystyle)),
              ElevatedButton(
                  onPressed: () {
                    showDataFromMemory();
                  },
                  child:  Text('show data from memory',style:  _mystyle)),
              ElevatedButton(
                  onPressed: () {
                    mydbHelper.createTable();
                  },
                  child:  Text('Create Table',style:  _mystyle)),
              ElevatedButton(
                  onPressed: () {
                    mydbHelper.addDatatoTable(myRecords.recordsList);
                  },
                  child:  Text('Add data to table',style:  _mystyle)),
              ElevatedButton(
                  onPressed: () {
                    mydbHelper.readFromDatabase();
                  },
                  child:  Text('read data from db',style:  _mystyle)),
              ElevatedButton(
                  onPressed: () {
                    mydbHelper.deleteDataInTable();
                  },
                  child:  Text('delete all data in DB',style:  _mystyle)),

            ],
          ),
        ),
      ),
    );
  }
  void showDataFromMemory() {
    myRecords.recordsList.forEach((element) {

      print(element);
      });
  }


}
