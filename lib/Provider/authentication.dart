import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_banking_app/Constants/route.dart';
import 'package:flutter_banking_app/Constants/url.dart';
import 'package:flutter_banking_app/Provider/storage_provider.dart';
import 'package:flutter_banking_app/widgets/bottom_nav.dart';
import 'package:http/http.dart' as http;

class AuthenticationProvider extends ChangeNotifier {
  bool _isLoading = false;
  String _resMessage = '';

  ///Field Getters
  bool get isLoading => _isLoading;

  String get resMessage => _resMessage;

  ///Registration :
  void registerUser({
    required String email,
    required String password,
    required String username,
    BuildContext? context,
  }) async {
    _isLoading = true;
    _resMessage = 'Please wait !';
    notifyListeners();

    ///Authentication url
    String _url = '$requestBaseUrl/register';

    Map<String, dynamic> body = {
      'email': email,
      'name': username,
      'password': password,
      'password_confirmation': password
    };

    print(body);

    try {
      http.Response res = await http.post(Uri.parse(_url),
          body: json.encode(body),
          headers: {'Content-Type': 'application/json; charset=UTF-8'});

      // print(res.statusCode);
      if (res.statusCode == 200) {
        String req = res.body;

        final successBody = json.decode(req);
        print(successBody);

        ///Get token from response
        String _token = successBody['token'];
        final _user = successBody['user'];

        // ///Save user token
        Database().saveToken(token: _token);

        Database().saveId(id: _user['id'].toString());
        Database().saveEmail(email: _user['email']);
        Database().saveProfileImage(image: _user['profile_photo_url']);

        // ///Save user name
        Database().saveUsername(name: _user['name']);

        _isLoading = false;
        _resMessage = 'Account created!';
        notifyListeners();

        PageNavigator(context: context!)
            .nextPageAndUntil(page: const BottomNav());
      } else {
        ///Request was not successful
        ///print error
        String req = res.body;
        final errorBody = json.decode(req);

        print(req);
        _isLoading = false;
        _resMessage = errorBody['message'];
        notifyListeners();
      }
    } on SocketException catch (_) {
      _isLoading = false;
      _resMessage = 'Internet connection is not available';
      notifyListeners();
    } catch (e) {
      print("dkfkdfdfdkfddf $e");
      _isLoading = false;
      _resMessage = 'Please try again';
      notifyListeners();
    }
  }

  ///Login User
  void loginUser({
    required String email,
    required String password,
    BuildContext? context,
  }) async {
    _isLoading = true;
    _resMessage = "Please wait !";
    notifyListeners();

    ///Login url
    String _url = "$requestBaseUrl/login";

    Map<String, dynamic> body = {"email": email, "password": password};

    try {
      http.Response res = await http.post(Uri.parse(_url),
          body: json.encode(body),
          headers: {'Content-Type': 'application/json; charset=UTF-8'});
      print(res.statusCode);
      if (res.statusCode == 200) {
        String req = res.body;

        ///Request was successfully
        final successBody = json.decode(req);
        print(successBody);

        String _token = successBody['token'];
        final _user = successBody['user'];

        // ///Save user token
        Database().saveToken(token: _token);

        Database().saveId(id: _user['id'].toString());
        Database().saveEmail(email: _user['email']);
        Database().saveProfileImage(image: _user['profile_photo_url']);

        // ///Save user name
        Database().saveUsername(name: _user['name']);

        _isLoading = false;
        _resMessage = "Login was successful!";
        notifyListeners();

        PageNavigator(context: context!)
            .nextPageAndUntil(page: const BottomNav());
      } else {
        ///Request was not successful
        ///print error
        String req = res.body;
        final errorBody = json.decode(req);

        print(req);
        _isLoading = false;
        _resMessage = errorBody["message"];
        notifyListeners();
      }
    } on SocketException catch (_) {
      _isLoading = false;
      _resMessage = "Internet connection is not available";
      notifyListeners();
    } catch (e) {
      print(e);
      _isLoading = false;
      _resMessage = "Please try again";
      notifyListeners();
    }
  }

  ///Forgot password
  void forgotPassword({
    required String emailOrUsername,
    BuildContext? context,
  }) async {
    _isLoading = true;
    _resMessage = "Please wait !";
    notifyListeners();

    ///Forgot password url
    String _url = "$requestBaseUrl/forgotpassword";

    Map<String, dynamic> body = {"email": emailOrUsername};

    print(body);

    try {
      http.Response res = await http.post(Uri.parse(_url),
          body: json.encode(body),
          headers: {'Content-Type': 'application/json; charset=UTF-8'});

      print(res.statusCode);
      if (res.statusCode == 200) {
        String req = res.body;
        final successBody = json.decode(req);

        ///Request was successfully
        print(successBody);
        _isLoading = false;
        // _resMessage = successBody["data"]["message"] + "`";
        notifyListeners();

        ///Save email
        // String email = successBody["data"]["email"];
        // print(email);
        // Database().saveEmail(email: email);

        // PageNavigator(context: context!).nextPage(page: const NewPassword());
      } else {
        ///Request was not successful
        ///print error
        String req = res.body;
        final errorBody = json.decode(req);

        print(errorBody);
        _isLoading = false;
        // _resMessage = errorBody["data"];
        notifyListeners();
      }
    } on SocketException catch (_) {
      _isLoading = false;
      _resMessage = "Internet connection is not available";
      notifyListeners();
    } catch (e) {
      print(e);
      _isLoading = false;
      _resMessage = "Please try again";
      notifyListeners();
    }
  }

  ///New password
  void newPassword({
    required String email,
    required String code,
    required String password,
    BuildContext? context,
  }) async {
    _isLoading = true;
    _resMessage = "Please wait !";
    notifyListeners();

    ///Get new password url
    String _url = "$requestBaseUrl/change_password?email=$email";

    Map<String, dynamic> body = {
      "token": code,
      "password": password,
      'password_confirmation': password
    };
    print(body);

    try {
      http.Response res = await http.post(Uri.parse(_url),
          body: json.encode(body),
          headers: {'Content-Type': 'application/json; charset=UTF-8'});

      print(res.statusCode);
      if (res.statusCode == 200) {
        String req = res.body;

        ///Request was successfully
        print(req);

        _isLoading = false;
        _resMessage = "Password was successfully changed !";
        notifyListeners();

        // PageNavigator(context: context!).nextPage(page: Login());
      } else {
        ///Request was not successful
        ///print error
        String req = res.body;
        final errorBody = json.decode(req);

        print(req);

        _isLoading = false;
        _resMessage = errorBody["data"];
        notifyListeners();
      }
    } on SocketException catch (_) {
      _isLoading = false;
      _resMessage = "Internet connection is not available";
      notifyListeners();
    } catch (_) {
      _isLoading = false;
      _resMessage = "Please try again";
      notifyListeners();
    }
  }

  ///Clear response message
  void clearMessage() {
    _resMessage = '';
    _isLoading = false;
    notifyListeners();
  }
}
