import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter_banking_app/Constants/url.dart';

void sendTransactionRef({String? transactionRef}) async {
  const callBackUrl = '$requestBaseUrl/verify-payment';

  Map<String, dynamic> body = {'transaction_id': transactionRef};

  print(body);

  try {
    http.Response res = await http.post(Uri.parse(callBackUrl),
        body: json.encode(body),
        headers: {'Content-Type': 'application/json; charset=UTF-8'});

    // print(res.statusCode);
    if (res.statusCode == 200) {
      String req = res.body;

      final successBody = json.decode(req);
      print(successBody);
    } else {
      ///Request was not successful
      ///print error
      String req = res.body;
      final errorBody = json.decode(req);

      print(req);
    }
  } on SocketException catch (e) {
    print("dkfkdfdfdkfddf $e");
  } catch (e) {
    print("dkfkdfdfdkfddf $e");
  }
}
