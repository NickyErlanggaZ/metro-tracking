import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:metro_tracking_new/config/api_config.dart';

class ApiService {
  final String url = ApiConfig.baseUrl;
  final client = http.Client();

  postData(data, apiURL) async {
    var fullUrl = url + apiURL;
    return await client.post(Uri.parse(fullUrl),
        body: json.decode(data), headers: _setHeaders());
  }
  
  getData(apiURL) async {
    var fullUrl = url + apiURL;
    return await client.get(
      Uri.parse(fullUrl),
      headers: _setHeaders(),
    );
  }

  _setHeaders() => {
        'Content-type': 'application/json',
        'Accept': '*/*',
      };
}
