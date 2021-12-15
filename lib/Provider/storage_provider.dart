import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

///Storage : A class to store users data e.g token, username etc
class Database extends ChangeNotifier {
  ///Users data will be stored using shared preference for efficiency
  Future<SharedPreferences> _pref = SharedPreferences.getInstance();

  ///Setters
  String? _setToken = '';
  String? _setEmail = '';
  String? _setName = '';
  String? _setId = '';
  String? _userProfileImage = '';

  ///Getters
  String get token => _setToken!;
  String get email => _setEmail!;
  String get name => _setName!;
  String get id => _setId!;
  String get userProfileImage => _userProfileImage!;

  ///Save User Token
  void saveToken({String? token}) async {
    SharedPreferences _instancePref = await _pref;

    _instancePref.setString("token", token!);
  }

  void saveId({String? id}) async {
    SharedPreferences _instancePref = await _pref;

    _instancePref.setString("id", id!);
  }

  ///save user profile image
  void saveProfileImage({String? image}) async {
    SharedPreferences _instancePref = await _pref;

    _instancePref.setString("image", image!);
  }

  ///Save User Token
  void saveUsername({String? name}) async {
    SharedPreferences _instancePref = await _pref;

    _instancePref.setString("name", name!);
  }

  ///Save User email
  void saveEmail({required String email}) async {
    SharedPreferences _instancePref = await _pref;

    _instancePref.setString("email", email);
  }

  ///Get user token
  Future<String> getToken() async {
    SharedPreferences _instancePref = await _pref;

    if (_instancePref.containsKey("token")) {
      String? _token = _instancePref.getString("token");

      _setToken = _token;
      notifyListeners();

      return _token!;
    } else {
      _setToken = "";
      notifyListeners();
      return "";
    }
  }

  /// Get user id
  Future<String> getId() async {
    SharedPreferences _instancePref = await _pref;

    if (_instancePref.containsKey("id")) {
      String? _id = _instancePref.getString("id");

      _setId = _id;
      notifyListeners();

      return _id!;
    } else {
      _setId = "";
      notifyListeners();
      return "";
    }
  }

  ///Get profile image
  Future<String> getProfileImage() async {
    SharedPreferences _instancePref = await _pref;

    if (_instancePref.containsKey("image")) {
      String? _image = _instancePref.getString("image");

      _userProfileImage = _image;
      notifyListeners();

      return _image!;
    } else {
      _userProfileImage = "";
      notifyListeners();
      return "";
    }
  }

  ///GET USER NAME
  Future<String> getName() async {
    SharedPreferences _instancePref = await _pref;

    if (_instancePref.containsKey("name")) {
      String? _name = _instancePref.getString("name");

      _setName = _name;
      notifyListeners();
      return _name!;
    } else {
      _setName = '';
      notifyListeners();
      return "";
    }
  }

  ///Get user email
  Future<String> getEmail() async {
    SharedPreferences _instancePref = await _pref;

    if (_instancePref.containsKey("email")) {
      String? _email = _instancePref.getString("email");
      _setEmail = _email;
      notifyListeners();
      return _email!;
    } else {
      _setEmail = '';
      notifyListeners();
      return "";
    }
  }

  Future<void> logOut() async {
    SharedPreferences _instancePref = await _pref;

    _instancePref.clear();
  }
}
