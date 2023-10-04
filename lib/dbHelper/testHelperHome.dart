import 'package:flutter/material.dart';
import 'package:generaldbase/dbHelper/tableViewerPage.dart';
import 'package:generaldbase/dbHelper/theData.dart';
import 'package:fluttertoast/fluttertoast.dart';

class testHelperHome extends StatelessWidget {
  const testHelperHome({super.key});


  @override
  Widget build(BuildContext context) {
    TextStyle _mystyle=  const TextStyle(fontSize: 25);
    return Scaffold(
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
                  mydbHelper.createDatabase();
                },
                child:  Text('Create Database',style:  _mystyle)),
            ElevatedButton(
                onPressed: () {
                  mydbHelper.createTable();
                },
                child:  Text('Create Table',style:  _mystyle)),
            ElevatedButton(

                onPressed: () {
                  mydbHelper.deleteTable();
                },
                child:  Text('Delete Table',style:  _mystyle,)),
            ElevatedButton(

                onPressed: () async {
                  await mydbHelper.deleteDatabase();
                },
                child:  Text('Delete Databse',style:  _mystyle,)),
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

            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) =>  tableViewerPage()));
                },
                child:  Text('go to table page',style:  _mystyle)),

          ],
        ),
      ),
    );
  }

  void showDataFromMemory() {
    if(myRecords.recordsList.isEmpty){

      Fluttertoast.showToast(
          msg: "Empty data at memory",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
      print('empty data at memory');
      return;
    }
    for (SingleRecord element in myRecords.recordsList) {
      print(element);
    }
  }


}
