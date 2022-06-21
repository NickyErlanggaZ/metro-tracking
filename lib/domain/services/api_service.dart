import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:metro_tracking_new/config/api_config.dart';

class ApiService {
  final String url = ApiConfig.baseUrl;
  final client = http.Client();
  
}
