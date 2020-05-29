import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as Convert;

class HelperNetwork {
  final String url;

  final Map<String, dynamic> params;

  HelperNetwork({@required this.url, this.params});

  Future getData() async {
    http.Response response = await http.get(url);

    if (response.statusCode == 200) {
      String data = response.body;

      List<dynamic> json = Convert.jsonDecode(data);

      return json;
    } else {
      print(response.statusCode);
    }
  }

  Future postDataLogin() async {
    http.Response response = await http.post(url, body: params);

    if (response.statusCode == 200) {
      String data = response.body;

      Map<String, dynamic> json = Convert.jsonDecode(data);

      return json;
    } else {
      print(response.statusCode);
    }
  }

  Future postData() async {
    http.Response response = await http.post(url, body: params);

    if (response.statusCode == 200) {
      String data = response.body;

      List<dynamic> json = Convert.jsonDecode(data);

      return json;
    } else {
      print(response.statusCode);
    }
  }
}
