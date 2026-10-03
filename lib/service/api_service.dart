import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:user_app_task/model/register_model.dart';

import '../model/login_model.dart';
import '../model/user_list_model.dart';
import '../model/user_update_model.dart';

class ApiService {
  static const String appUrl = "https://dummyjson.com";
  static const String loginUrl = '${appUrl}/auth/login';
  static const String registerUrl = '${appUrl}/users/add';
  static const String userListUrl = '$appUrl/users?limit=0';
  static const String userUpdateUrl = '$appUrl/users'; // + '/$id'
  static const String userDeleteUrl = '$appUrl/users'; // + '/$id'

  Future<LoginResponse> login(LoginRequest request) async {
    // Send POST request
    final response = await http.post(
      Uri.parse(loginUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(request.toJson()),
    );
    // Check status code
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      // debugPrint("Login Api Response is : $data");
      return LoginResponse.fromJson(data);
    } else {
      throw Exception('Login failed: $response.statusCode');
    }
  }

  Future<RegisterResponse> register(RegisterRequest request) async {
    // Send POST request
    final response = await http.post(
      Uri.parse(registerUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(request.toJson()),
    );
    // Check status code
    if (response.statusCode == 200 || response.statusCode == 201) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      // debugPrint("Register Api Response is : $data");
      return RegisterResponse.fromJson(data);
    } else {
      throw Exception('Register failed: $response.statusCode');
    }
  }

  Future<UserListResponse> getUsers() async {
    final response = await http.get(
      Uri.parse(userListUrl),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      // debugPrint("get Users Api response is : $data");
      return UserListResponse.fromJson(data);
    } else {
      throw Exception('Get users failed: ${response.statusCode}');
    }
  }

  Future<UserUpdateResponse> updateUser(
    int userId,
    Map<String, dynamic> body,
  ) async {
    final response = await http.put(
      Uri.parse('$appUrl/users/$userId'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(body),
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      // debugPrint("update Users Api response is : $data");
      return UserUpdateResponse.fromJson(data);
    } else {
      throw Exception('Update user failed: ${response.statusCode}');
    }
  }

  Future<bool> deleteUser(int userId) async {
    final response = await http.delete(Uri.parse('$appUrl/users/$userId'));
    // debugPrint("delete Users Api response is : $response");
    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Delete user failed: ${response.statusCode}');
    }
  }
}
