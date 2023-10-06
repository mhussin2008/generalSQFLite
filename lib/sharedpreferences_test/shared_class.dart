import 'package:shared_preferences/shared_preferences.dart';

class shared_class{
  static final _instance = shared_class._internal();
  static bool _initialized=false;
  static late SharedPreferences shared_pref;

  factory shared_class() {
    return _instance;
  }

  shared_class._internal()  {
    // initialization logic
    _initialize();
  }

  static Future<void> save_data(int int_data) async{
    if(_initialized==true){
    await shared_pref.setInt('int_data', int_data);
    }
    else{_initialize();}

  }

  static Future<void> save_string(List<String> str_list) async{
    if(_initialized==true){
    await shared_pref.setStringList('str_list', str_list);
    }
    else{_initialize();}
  }
  static Future<List<String>?> get_str_list() async {
    //print(shared_pref.hashCode);
    if(_initialized==true){
    return await shared_pref.getStringList('str_list');
    }
    else{_initialize();
    return null;}
  }

  static Future<int?> get_data() async {
    //print(shared_pref.hashCode);
    if(_initialized==true){
    return await shared_pref.getInt('int_data');
    }
    else{_initialize();
    return null;}

  }

   static  _initialize()  async {
    print('initialization started');
    shared_pref=await SharedPreferences.getInstance();
    print(shared_pref.hashCode);
    _initialized=true;
  }

  }