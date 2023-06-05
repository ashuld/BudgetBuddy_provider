import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:money_management/db/model/userdata.dart';

class UserProvider extends ChangeNotifier {
  final userdb = 'User';

  List<UserModel> userlist = [];

  Future<void> addUser(UserModel value) async {
    final userData = await Hive.openBox<UserModel>(userdb);
    await userData.put(value.id, value);
    userlist = userData.values.toList();
    notifyListeners();
  }

  Future<void>getAllUsers() async {
    final userdata = await Hive.openBox<UserModel>(userdb);
    userlist = userdata.values.toList();
    notifyListeners();
  }

  Future<void> editUser(UserModel value) async {
    final userData = await Hive.openBox<UserModel>(userdb);
    userData.put(value.id, value);
    userlist = userData.values.toList();
    notifyListeners();
  }

  String get userName {
  if (userlist.isNotEmpty) {
    return userlist[0].name;
  }
  return '';
}

String get userPhone {
  if (userlist.isNotEmpty) {
    return userlist[0].phn;
  }
  return '';
}

String get userEmail {
  if (userlist.isNotEmpty) {
    return userlist[0].mail;
  }
  return '';
}

}
