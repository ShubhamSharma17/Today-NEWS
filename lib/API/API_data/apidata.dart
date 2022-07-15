import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:pet_api/API/API_model/api_model.dart';

Future getData() async {
  Uri uri = Uri.parse(
      'https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=6b24801c6cda43eaa65915fe8b946bf2');
  var response = await http.get(uri);

  if (response.statusCode == 200 || response.statusCode == 201) {
    Map<String, dynamic> decodeResponse = jsonDecode(response.body);
    List articlesList = decodeResponse['articles'];

    List<APIModel> dataList =
        articlesList.map((map) => APIModel.fromjson(map)).toList();
    return dataList;
  } else {
    log('Something went wrong');
    return [];
  }
}
