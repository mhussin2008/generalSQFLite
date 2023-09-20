import 'package:flutter/material.dart';
//import 'package:generaldbase/dbHelper/tableViewerPage.dart';
import 'package:generaldbase/dbHelper/testHelperHome.dart';
import 'package:generaldbase/dbHelper/theData.dart';
//import 'dbaseHelper.dart';

class testHelper extends StatefulWidget {
  const testHelper({super.key});

  @override
  State<testHelper> createState() => _testHelperState();
}

class _testHelperState extends State<testHelper> {
  // dbaseHelper mydbHelper = dbaseHelper();
  // Records myRecords = Records();
@override
void initState() {

    super.initState();
    mydbHelper.readFromDatabase();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: testHelperHome()
    );
  }


}
