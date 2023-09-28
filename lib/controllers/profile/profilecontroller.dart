import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class ProfileController extends GetxController {
  static ProfileController get to => Get.find<ProfileController>();
  bool isLoading = false;
  List profileDetails = [];
  late String userId = "";
  late String email = "";
  late Timer _timer;
  late String uToken = "";
  final storage = GetStorage();
  late String userName = "";
  late String profilePicture = "";

  @override
  void onInit() {
    if (storage.read("token") != null) {
      uToken = storage.read("token");
    }
    getUserDetails();
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (storage.read("token") != null) {
        uToken = storage.read("token");
      }
      getUserDetails();
    });
    super.onInit();
  }

  Future<void> getUserDetails() async {
    try {
      isLoading = true;

      const profileLink = "https://taxinetghana.xyz/passenger-profile/";
      var link = Uri.parse(profileLink);
      http.Response response = await http.get(link, headers: {
        "Content-Type": "application/x-www-form-urlencoded",
        "Authorization": "Token $uToken"
      });
      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        profileDetails = jsonData;
        for (var i in profileDetails) {
          userId = i['user'].toString();
          profilePicture = i['passenger_profile_pic'];
        }
        storage.write("profile_pic", profilePicture);
        update();
      } else {
        if (kDebugMode) {
          print(response.body);
        }
      }
    } catch (e) {
      // Get.snackbar("Sorry","something happened or please check your internet connection",snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading = false;
      update();
    }
  }
}
