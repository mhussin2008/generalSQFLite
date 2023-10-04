import 'dart:io';

import 'package:flutter/material.dart';

import 'package:sqflite/sqflite.dart';
import '../Archieve/userData.dart';
import '../Archieve/hSimpleTable.dart';

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
  late List<bool> cmdStatus =
      List.generate(cmdCaptions.length, (index) => true);

  // (cmdStatus[entry.key] = true) ? wrightIcon : wrongIcon

  late List<OutlinedButton> btnList;

  late List<Image> chkList;

  @override
  void initState() {
    //myUser.initData(100);

    cmdCaptions = [
      'Create DB',
      'Create Table',
      'Add Data',
      'Update Data',
      'Read Data',
      'Delete Data',
      'Delete Table',
      'Delete DB',
      'Clear Scr Data',
      'Generate New Data'
    ];

    WidgetsBinding.instance.addPostFrameCallback((_) {
      btnClicked(4);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    chkList = cmdStatus
        .asMap()
        .entries
        .map((e) => (cmdStatus[e.key] == true) ? wrightIcon : wrongIcon)
        .toList();
    TextStyle TS1=TextStyle(color: Colors.black);
    TextStyle TS2=TextStyle(color: Colors.black26);

    btnList = cmdCaptions
        .asMap()
        .entries
        .map(
          (entry) => OutlinedButton(
          onPressed: () => btnClicked(entry.key),
          child: Text(
            style:
            cmdStatus[entry.key]? TS1:TS2

            ,cmdCaptions[entry.key],
          )
    ),
    ).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      onDrawerChanged: (changed) {
        if (changed == true) {
          print('do all checks');
          doAllChecks();
        }

        print(changed.toString());
      },
      drawer: SafeArea(
        child: Container(
          width: 250,
          decoration: BoxDecoration(
            border: Border.all(
              width: 10,
              color: Colors.red,
            ),
            borderRadius: const BorderRadius.all(
              Radius.circular(10),
            ),
            color: Colors.white,
          ),
          child: Row(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: btnList,
              ),
              const SizedBox(
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
  void doAllChecks() async {
    var databasesPath = await getDatabasesPath();
    var dbFilePath = '$databasesPath/my_dbase.db';
    var dbExists = File(dbFilePath).existsSync();
    if (dbExists == false) {
      print('no such database');
      cmdStatus[0] = true;
      for (int i = 1; i < 8; i++) {
        cmdStatus[i] = false;
      }
      return;
    }
    else{cmdStatus[0]=false;
        }

    setState(() {
      cmdStatus;
    });

    late Database db;
    db = await openDatabase('my_dbase.db');
    if (db.isOpen == false) {
      print('cant open database');
      return;
    }
    var tables = await db
        .rawQuery('SELECT * FROM sqlite_master WHERE name="datatable";');

    if (tables.isEmpty) {
      // Create the table
      print('no such table');
      setState(() {
        cmdStatus[1]=true;
      });
      return;
    }else{setState(() {
  cmdStatus[1]=false;
});
}

    List<Map>? gotlist = await db.database.rawQuery('SELECT * FROM datatable');

    if (myUser.userInfo.length == 0) {
      print('Empty Screen');
      setState(() {
        cmdStatus[2]=false;
      });
      return;
    }else{
      setState(() {
        cmdStatus[2]=true;

      });
      return;

    }
  }

  void btnClicked(int idx) async {
    var databasesPath = await getDatabasesPath();
    var dbFilePath = '$databasesPath/my_dbase.db';
    var dbExists = File(dbFilePath).existsSync();
    late Database db;

    switch (idx) {
      case 0:
        if (cmdStatus[0] == false) {
          return;
        }
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
        if (cmdStatus[1] == false) {
          return;
        }
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
        if (cmdStatus[2] == false) {
          return;
        }
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
        if (cmdStatus[4] == false) {
          return;
        }
        db = await openDatabase('my_dbase.db');
        var tables = await db
            .rawQuery('SELECT * FROM sqlite_master WHERE name="datatable";');

        if (tables.isEmpty) {
          // Create the table
          print('no such table');
          break;
        }

        List<Map>? gotlist =
            await db.database.rawQuery('SELECT * FROM datatable');
        print(gotlist.length.toString());
        if (gotlist.length == 0) {
          print('Empty Table');
          break;
        }
        print(gotlist.length);
        //print(gotlist);
        print(gotlist[0]);
        //print(myUser.userInfo[0]);
        myUser.userInfo.clear();
        if (gotlist.length > 0) {
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

      /// delete data from db
      case 5:
        if (cmdStatus[5] == false) {
          return;
        }
        db = await openDatabase('my_dbase.db');
        await db.database.rawQuery('DELETE FROM datatable');
        print('deleted all rows');

        break;
      case 6:
        if (cmdStatus[6] == false) {
          return;
        }
        db = await openDatabase('my_dbase.db');
        await db.database.rawQuery('DROP TABLE IF EXISTS datatable');
        print('deleted the table');
        break;

      case 7:
        if (cmdStatus[7] == false) {
          return;
        }
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
        if (cmdStatus[8] == false) {
          return;
        }
        //delete table screen
        cmdStatus[8] = true;
        setState(() {
          myUser.userInfo.clear();
        });

        break;
      case 9:
        if (cmdStatus[9] == false) {
          return;
        }
        myUser.initData(100);
        setState(() {});

        break;

      default:
        print(idx.toString());
    }
  }
}
