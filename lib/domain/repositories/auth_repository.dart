import 'dart:convert';

import 'package:admin_shop/data/local/local_data.dart';
import 'package:admin_shop/data/remote/remote_data.dart';
import 'package:admin_shop/domain/models/user.dart';
import 'package:http/http.dart';

class AuthRepository {
  static Future<Map> signUp(String name, String email, String password) async {
    Map<String, String> body = {"name": name, "email": email, "password": password, "type": "admin"};
    Response response = await DataProvider.postData('sign-up', json.encode(body));
    final result = json.decode(response.body);
    if (response.statusCode == 201) {
      await JwtProvider.saveJwt(result['token']);
      await UserIdProvider.saveId(result['data']['_id']);
      return {
        'data': User.fromMap(result['data']),
        'status': 201,
      };
    }
    return {'status': response.statusCode, 'message': result['message']};
  }

  static Future<Map> signIn(String email, String password) async {
    Map<String, String> body = {"email": email, "password": password, "type": "admin"};
    Response response = await DataProvider.postData('sign-in', json.encode(body));
    final result = json.decode(response.body);
    if (response.statusCode == 200) {
      await JwtProvider.saveJwt(result['token']);
      // final jwt = await JwtProvider.getJwt();
      // print('sign-in-jwt : $jwt');
      await UserIdProvider.saveId(result['data']['_id']);
      return {
        'data': User.fromMap(result['data']),
        'status': 200,
      };
    }
    return {'status': response.statusCode, 'message': result['message']};
  }

  static Future<Map> generateOtp(String email) async {
    Map<String, String> body = {"email": email, "type": "admin"};
    Response response = await DataProvider.postData('reset-otp', json.encode(body));
    final result = json.decode(response.body);
    if (response.statusCode == 200) {
      return {
        'email': result['email'],
        'status': 200,
      };
    }
    return {'status': response.statusCode, 'message': result['message']};
  }

  static Future<Map> resetPassword(String email, String otp, String password) async {
    Map<String, String> body = {"email": email, "otp": otp, "password": password, "type": "admin"};
    Response response = await DataProvider.postData('reset', json.encode(body));
    final result = json.decode(response.body);
    if (response.statusCode == 200) {
      return {
        'id': result['userId'],
        'status': 200,
      };
    }
    return {'status': response.statusCode, 'message': result['message']};
  }

  static Future<Map> getUser() async {
    final jwt = await JwtProvider.getJwt();
    Response response = await DataProvider.getData('user/admin', jwt: jwt);
    final result = json.decode(response.body);
    if (response.statusCode == 200) {
      await UserIdProvider.saveId(result['data']['_id']);
      return {
        'data': User.fromMap(result['data']),
        'status': 200,
      };
    }
    return {'status': response.statusCode, 'message': result['message']};
  }

  static Future<Map> updateUser(User user) async {
    final jwt = await JwtProvider.getJwt();
    final updatedUser = user.toJson();
    Response response = await DataProvider.postData('user-update/admin', updatedUser, jwt: jwt);
    final result = json.decode(response.body);
    if (response.statusCode == 200) {
      await UserIdProvider.saveId(result['data']['_id']);
      return {
        'data': User.fromMap(result['data']),
        'status': 200,
      };
    }
    return {'status': response.statusCode, 'message': result['message']};
  }
}
