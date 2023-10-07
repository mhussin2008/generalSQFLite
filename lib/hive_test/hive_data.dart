import 'dart:io';

import 'package:hive/hive.dart';
part 'hive_data.g.dart';

@HiveType(typeId: 1)
class Person extends HiveObject {
  Person(
      {required this.name, required this.age, required this.friends });

  // @HiveField(0)
  // int Id;

  @HiveField(0)
  String name;

  @HiveField(1)
  int age;

  @HiveField(2)
  List<String> friends;

  @override
  String toString() {
    return 'name=$name: age=$age\n friend are ${friends.toString()}';


  }
}

class hiveOperations{
  static var path = Directory.current.path;
  static bool _initialized=false;
  static late var box;

static void initialize() async {
  print(path);
 if(_initialized){return;}

  Hive.init(path);
  try {
    Hive.registerAdapter(PersonAdapter());
  } catch (e, s) {
    print(s);
  }
  box = await Hive.openBox('testBox');
  if(box!=null){
  _initialized=true;
  }
}

static void putdata(Person d) async {
    if(_initialized==false){
      initialize();
      return;}
  print('already initialized try to put');
  try {
    await box.put('dave', d);
  } catch (e, s) {
    print(s);
  }
}


static Future<Person?> getdata() async {
  if(_initialized==false){
    initialize();
    return null;
  }
  var box = await Hive.openBox('testBox');
  Person p = box.get('dave');
  print(p);
  return p;
  // Dave: 22

}

}



