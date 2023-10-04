import 'package:shared_preferences/shared_preferences.dart';

class shared_class{
  static final _instance = shared_class._internal();
  static late SharedPreferences shared_pref;

  factory shared_class() {
    return _instance;
  }

  shared_class._internal()  {
    // initialization logic
    initialize();
  }

  Future<void> save_data(int int_data) async{
    await shared_pref.setInt('int_data', int_data);
  }

  Future<int?> get_data() async {
    print(shared_pref.hashCode);
    return await shared_pref.getInt('int_data');
  }

   initialize()  async {
    print('initialization started');
    shared_pref=await SharedPreferences.getInstance();
    print(shared_pref.hashCode);
  }

  }