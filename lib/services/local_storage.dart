import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  late SharedPreferences storage;

  Future<void> init() async {
    storage = await SharedPreferences.getInstance();
  }

  void storeData(String tasks) {
    storage.setString("tasks", tasks);
  }

  String? getTasks() => storage.getString('tasks');
}
