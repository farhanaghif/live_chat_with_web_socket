import 'package:get_storage/get_storage.dart';

class HelperStorage {
  GetStorage get box => GetStorage();

  String? get getUsername => box.read<String?>('username');

  set setUsername(String username) => box.write('username', username);

  remove(String key) => box.remove(key);
}
