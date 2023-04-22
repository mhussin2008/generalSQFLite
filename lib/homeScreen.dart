import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'userData.dart';
import 'hSimpleTable.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key, required this.title});
  final String title;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  User myUser = User();
  late List<String> cmdCaptions;
  Image wrightIcon = Image.asset(
    'assets/icons/wright.png',
    width: 40,
    height: 40,
  );
  Image wrongIcon = Image.asset(
    'assets/icons/wrong.png',
    width: 40,
    height: 40,
  );
  late List<bool> cmdStatus;

  // (cmdStatus[entry.key] = true) ? wrightIcon : wrongIcon

  late List<ElevatedButton> btnList = cmdCaptions
      .asMap()
      .entries
      .map(
        (entry) => ElevatedButton(
            onPressed: () => btnClicked(entry.key),
            child: Text(cmdCaptions[entry.key])),
      )
      .toList();

  late List<Image> chkList;

  @override
  void initState() {
    myUser.initData(100);
    cmdCaptions = [
      'Create DB',
      'Create Table',
      'Add Data',
      'Update Data',
      'Read Data',
      'Delete Data',
      'Delete Table',
      'Delete DB',
      'Clear Scr Data'
    ];
    cmdStatus = List.generate(cmdCaptions.length, (index) => false);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    chkList = cmdStatus
        .asMap()
        .entries
        .map((e) => (cmdStatus[e.key] == true) ? wrightIcon : wrongIcon)
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      drawer: SafeArea(
        child: Container(
          width: 200,
          decoration: BoxDecoration(
            border: Border.all(
              width: 10,
              color: Colors.red,
            ),
            borderRadius: const BorderRadius.all(
              Radius.circular(10),
            ),
            color: Colors.cyanAccent,
          ),
          child: Row(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: btnList,
              ),
              SizedBox(
                width: 10,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: chkList,
              )
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: SimpleTablePage(
          user: myUser,
        ),
      ),
    );
  }

  //////Methods
  void btnClicked(int idx) async {
    var databasesPath = await getDatabasesPath();
    var dbFilePath = '$databasesPath/my_dbase.db';
    var dbExists = await File(dbFilePath).existsSync();
    late Database db;

    switch (idx) {
      case 0:
        if (dbExists) {
          setState(() {
            cmdStatus[0] = true;
            cmdStatus[7] = false;
          });
          print('data base already exists');
          print(dbFilePath);
          break;
        } else {
          db = await openDatabase('my_dbase.db');
          if (db.isOpen) {
            setState(() {
              cmdStatus[0] = true;
              cmdStatus[7] = false;
            });
            print('dbase created now');
          }
        }
        break; //Create Database
      case 1:
        if (dbExists) {
          db = await openDatabase('my_dbase.db');
          try {
            await db.execute('''
        create table datatable (
        userId TEXT ,
        status TEXT,
        phone TEXT,
        register TEXT,
        termination TEXT
       )''');
          } catch (err) {
            if (err.toString().contains('DatabaseException') == true) {
              setState(() {
                cmdStatus[0] = true;
                cmdStatus[1] = true;
              });
            }
            //print(err.toString().substring(0,30));
          }
        }
        setState(() {
          cmdStatus[1] = true;
        });
        break;
      case 2:
        print('started inserting data');
        db = await openDatabase('my_dbase.db');

        myUser.userInfo.forEach((e) async {
          //'''INSERT INTO datatable ( userId, status, phone,register,termination) VALUES ( '${e.name.toString()}', '${e.status.toString()}','${e.phone.toString()}','${e.registerDate.toString()}','${e.terminationDate.toString()}' )''';
          String insertString =
              '''INSERT INTO datatable ( userId, status, phone,register,termination) VALUES ( ${e.toLine()} )''';
          print(insertString);
          await db.execute(insertString);
          // return null;
        });
        setState(() {
          cmdStatus[2] = true;
        });

        break;


      // reading data
      case 4:
        db = await openDatabase('my_dbase.db');
        List<Map> gotlist =
            await db.database.rawQuery('SELECT * FROM datatable');
        print(gotlist.length);
        //print(gotlist);
        print(gotlist[0]);
        //print(myUser.userInfo[0]);
        myUser.userInfo.clear();
        if(gotlist.length>0){
          setState(() {
           myUser.insertData(gotlist);
          });
        }


        print(myUser.userInfo.length);
        print('added all');
        setState(() {
          cmdStatus[4] = true;
        });
        break;

      case 7:
        await databaseFactory.deleteDatabase(dbFilePath);
        dbExists = await File(dbFilePath).existsSync();
        if (!dbExists) {
          setState(() {
            cmdStatus[0] = false;
            cmdStatus[1] = false;
            cmdStatus[7] = true;
          });
          print('dbase deleted');
        }

        break;
      case 8:
        //delete table screen
        cmdStatus[8] = true;
        setState(() {
          myUser.userInfo.clear();
        });

        break;

      default:
        print(idx.toString());
    }
  }
}
