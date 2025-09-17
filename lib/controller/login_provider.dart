// ignore_for_file: avoid_print, use_build_context_synchronously

import 'dart:convert';

import 'package:ayurseva/core/utils/app_urls.dart';
import 'package:ayurseva/core/utils/snackbar_helper.dart';
import 'package:ayurseva/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginProvider extends ChangeNotifier {
  bool? isLoading;
  final TextEditingController userName = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  UserDetailsModel? userModel;

  Future<void> userLogin(
    BuildContext context,
    String name,
    String password,
  ) async {
    final pref = await SharedPreferences.getInstance();

    isLoading = true;
    notifyListeners();

    String url = ApiUrls.loginUrl.trim();
    print("Login URL: $url");

    try {
      final response = await http.post(
        Uri.parse(url),
        body: {"username": name, "password": password},
      );

      print("Status Code: ${response.statusCode}");
      print("Response Body: ${response.body}");

      var data = jsonDecode(response.body);

      if (data['status'] == true &&
          data['token'] != null &&
          data['user_details'] != null) {
        userModel = UserDetailsModel.fromJson(data['user_details']);
        await pref.setString("token", data['token']);

        SnackbarHelper.show(
          context,
          data['message'] ?? 'Login successful',
          backgroundColor: Colors.green,
        );

        // Navigator.pushNamed(context, HomeView.routeName);
      } else {
        SnackbarHelper.show(
          context,
          data['message'] ?? 'Login failed',
          backgroundColor: Colors.red,
        );
      }
    } catch (e) {
      SnackbarHelper.show(
        context,
        'Error: ${e.toString()}',
        backgroundColor: Colors.red,
      );
      print("Login error: $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void onClear() {
    isLoading = false;
    userName.clear();
    passwordController.clear();
    notifyListeners();
  }
}