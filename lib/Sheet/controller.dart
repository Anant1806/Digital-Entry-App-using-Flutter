import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:registration/Sheet/form.dart';

class Controller {

  static const String URL = "https://script.google.com/macros/s/AKfycbxRymh9eICQlDWUmwCjJ4-UfXJzvkiZQ3WgoVzNyiBSNRhgqLpTJZwSdrtgM_cDvRwxBA/exec";

  static const STATUS_SUCCESS = "SUCCESS";

  void submitForm(
      Register form, void Function(String) callback) async {
    try {
      await http.post(URL, body: form.toJson()).then((response) async {
        if (response.statusCode == 302) {
          var url = response.headers['location'];
          await http.get(url).then((response) {
            callback(convert.jsonDecode(response.body)['status']);
          });
        } else {
          callback(convert.jsonDecode(response.body)['status']);
        }
      });
    } catch (e) {
      print(e);
    }
  }
}