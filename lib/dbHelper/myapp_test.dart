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
                child: const Text('generate Random Data'),
              ),
              ElevatedButton(
                  onPressed: () {
                    myRecords.recordsList.clear();
                  },
                  child: const Text('delete data from memory')),
              ElevatedButton(
                  onPressed: () {
                    showDataFromMemory();
                  },
                  child: const Text('show data from memory')),
              ElevatedButton(
                  onPressed: () {
                    mydbHelper.createTable();
                  },
                  child: const Text('Create Table')),
              ElevatedButton(
                  onPressed: () {
                    mydbHelper.addDatatoTable(myRecords.recordsList);
                  },
                  child: const Text('Add data to table')),
              ElevatedButton(
                  onPressed: () {
                    mydbHelper.readFromDatabase();
                  },
                  child: const Text('read data from db')),
              ElevatedButton(
                  onPressed: () {
                    mydbHelper.deleteDataInTable();
                  },
                  child: const Text('delete all data in DB')),

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
