import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class StorageService extends GetxController {
  final _box = GetStorage();
  bool _isLoggedIn = false;
  bool _hasSeenOnboarding = false;
  String? _currentUserString;
  // User? _currentUser;
  String? _token = "";
  String? _deviceToken = "";
  String? _phoneNumber = "";
  String? _fullName = "";
  String? _role = "";
  String? _profileImageUrl = "";
  String? _email = "";
  String? _id = "";
  Locale? _locale;

  StorageService() {
    // Initialize values from storage or default values
    token = _box.read('token');
    deviceToken = _box.read('deviceToken');
    
    // token = _box.read('token');
    role = _box.read('role');
    _profileImageUrl = _box.read('profileImageUrl');
    email = _box.read('email');
    id = _box.read('id');
    phoneNumber = _box.read('phoneNumber');
    fullName = _box.read('fullName');
    currentUserString = _box.read('user') ?? "";
    isLoggedIn = _box.read('isLoggedIn') ??false;
    hasSeenOnboarding = _box.read('hasSeenOnboarding')??false;
    _locale = Locale(_box.read("locale")?["code"] ?? "en",
        _box.read("locale")?["country"] ?? "US");

    print("Loaded Token: $token");
    print("Loaded Token: $deviceToken");
    print("Loaded phonenumber: $phoneNumber");
    print("Loaded Full Name: $fullName");
    print("Loaded ID: $id");
    print("Loaded Role: $role");
    print("Loaded email: $email");
  }

  String? get token => _token;
  set token(String? value) {
    _token = value;
    _box.write('token', value);
    update();
  }

  String? get deviceToken => _deviceToken;
  set deviceToken(String? value) {
    _deviceToken = value;
    _box.write('deviceToken', value);
    update();
  }



  String? get phoneNumber => _phoneNumber;
  set phoneNumber(String? value) {
    _phoneNumber = value;
    _box.write('phoneNumber', value);
    update();
  }

  String? get fullName => _fullName;
  set fullName(String? value) {
    _fullName = value;
    _box.write('fullName', value);
    update();
  }

  String? get role => _role;
  set role(String? value) {
    _role = value;
    _box.write('role', value);
    update();
  }

  String? get profileImageUrl => _profileImageUrl;
  set profileImageUrl(String? value) {
    _profileImageUrl = value;
    _box.write('profileImageUrl', value);
    update();
  }

  
  String? get email => _email;
  set email(String? value) {
    _email = value;
    _box.write('email', value);
    update();
  }

  String? get id => _id;
  set id(String? value) {
    _id = value;
    _box.write('id', value);
    update();
  }

  String? get currentUserString => _currentUserString;
  set currentUserString(String? value) {
    _currentUserString = value;
    _box.write('user', value);
    // if (value != null) {
    //   currentUser = userFromJson(value);
    // }
    update();
  }


  bool get isLoggedIn => _isLoggedIn;
  set isLoggedIn(bool value) {
    _isLoggedIn = value;
    _box.write('isLoggedIn', value);
    update();
  }

  bool get hasSeenOnboarding => _hasSeenOnboarding;
  set hasSeenOnboarding(bool value) {
    _hasSeenOnboarding = value;
    _box.write('hasSeenOnboarding', value);
    update();
  }

  Locale? get locale => _locale;
  set locale(Locale? locale) {
    _box.write("locale",
        {"country": locale!.countryCode, "code": locale.languageCode});
    update();
  }

  // Save data to storage
  Future<void> saveData({required String key, required dynamic value}) async {
    await _box.write(key, value);
  }

  // Read data from storage
  dynamic readData({required String key}) {
    return _box.read(key);
  }

  // Remove data from storage
  Future<void> removeData({required String key}) async {
    await _box.remove(key);
  }

  // Clear all data from storage
  Future<void> clearStorage() async {
    await _box.erase();
  }


//method to get user smaiwallet 

  //smai logout
  Future<void> logout() async {

    await removeData(key: "isLoggedIn");
    await removeData(key: "user");
    await removeData(key: "phoneNumber");
    await removeData(key: "fullName");
    await removeData(key: "id");
    await removeData(key: "role");
    await removeData(key: "email");
    await removeData(key: "token");
    await removeData(key: "userWallet");
    await removeData(key: "profileImageUrl");
  }
}
