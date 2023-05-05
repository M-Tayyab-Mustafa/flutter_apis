import 'dart:convert';

import 'package:http/http.dart' as http;

extension APIResponse on http.Response {
  bool get isSucessful => statusCode == 200;
  bool get isCreated => statusCode == 201;
}

abstract class ApiServices {
  String get baseUrl;
  String get apiUrl;
  Uri _url({String endPoint = ''}) {
    return Uri.parse(baseUrl + apiUrl + endPoint);
  }

  Future<dynamic> get() async {
    var response = await http.get(_url());
    if (response.isSucessful) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Some Thing Went Wrong. Unable to Fetch Data');
    }
  }

  Future<bool> post({required Map<String, dynamic> map}) async {
    var response = await http.post(_url(), body: jsonEncode(map));
    if (response.isCreated) {
      return response.isCreated;
    } else {
      throw Exception('Some Thing Went Wrong. Unable to Upload Data');
    }
  }

  Future<bool> put(
      {required Map<String, dynamic> map, required String endpoint}) async {
    var response =
        await http.put(_url(endPoint: endpoint), body: jsonEncode(map));
    if (response.isSucessful) {
      return response.isSucessful;
    } else {
      throw Exception('Some Thing Went Wrong. Unable to Upload Data');
    }
  }

  Future<bool> delete({required String endpoint}) async {
    var response = await http.delete(_url(endPoint: endpoint));
    if (response.isSucessful) {
      return response.isSucessful;
    } else {
      throw Exception('Some Thing Went Wrong. Unable to Upload Data');
    }
  }
}
