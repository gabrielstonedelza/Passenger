import 'package:get/get.dart';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:passenger/statics/appcolors.dart';

import '../../screens/login/loginview.dart';

class MyRegistrationController extends GetxController {
  bool isPosting = false;
  registerUser(String uname, String email, String fName, String phoneNumber,
      String uPassword, String uRePassword) async {
    const loginUrl = "https://taxinetghana.xyz/auth/users/";
    final myLogin = Uri.parse(loginUrl);

    http.Response response = await http.post(myLogin, headers: {
      "Content-Type": "application/x-www-form-urlencoded"
    }, body: {
      "username": uname,
      "email": email,
      "full_name": fName,
      "phone_number": phoneNumber,
      "password": uPassword,
      "re_password": uRePassword
    });

    if (response.statusCode == 201) {
      isPosting = false;
      Get.offAll(() => const NewLogin());
    } else {
      Get.snackbar("Error 😢", response.body.toString(),
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 5));
      return;
    }
  }
}
