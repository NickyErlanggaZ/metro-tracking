import 'package:metro_tracking_new/domain/services/api_service.dart';

class AuthService extends ApiService {
  postSession(String email, String password) async {
    Map<String, dynamic> data = {
      'email': email,
      'password': password,
    };
    return await client.post(Uri.parse(url + '/session'), body: data, headers: {
      'Content-type': 'application/x-www-form-urlencoded',
      'Accept': '*/*',
    });
  }
}
