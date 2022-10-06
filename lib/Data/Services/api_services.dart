import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pwc_movie/Constants/strings.dart';

class APIServices {
  Future<dynamic> get({required String subUrl}) async {
    var link = Uri.parse(baseUrl + subUrl);
    http.Response response = await http.get(link, headers: {
      'Content-Type': 'application/json',
    });
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception("Get - $subUrl +  " "  + ${response.statusCode}");
    }
  }
}
