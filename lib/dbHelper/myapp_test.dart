import 'package:flutter/material.dart';
import 'package:generaldbase/dbHelper/theData.dart';
import 'dbaseHelper.dart';


class testHelper extends StatefulWidget {
  const testHelper({super.key});

  @override
  State<testHelper> createState() => _testHelperState();
}

class _testHelperState extends State<testHelper> {
  dbaseHelper mydbHelper=dbaseHelper();
  Records myRecords=Records();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('test helper'),
        ),
        body: Center(
          child: ElevatedButton(onPressed: (){
            myRecords.generateData();
            print(mydbHelper.hashCode);
            print(mydbHelper.db.path);
            myRecords.printData();
          },
          child: Text('get data'),),
        ),
      ),
    );
  }
}
