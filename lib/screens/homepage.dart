import 'package:flutter/material.dart';
import 'package:passenger/controllers/login/logincontroller.dart';
import 'package:passenger/statics/appcolors.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _currentIndex = 0;
  final LoginController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(controller.agentUsername),
      ),
      bottomNavigationBar: SalomonBottomBar(
        selectedItemColor: defaultTextColor1,
        unselectedItemColor: muted,
        backgroundColor: defaultBlack,
        currentIndex: _currentIndex,
        onTap: (i) => setState(() => _currentIndex = i),
        items: [
          /// Home
          SalomonBottomBarItem(
            icon: const Icon(Icons.home),
            title: const Text("Home"),
            selectedColor: defaultTextColor1,
          ),

          /// Likes
          SalomonBottomBarItem(
            icon: const Icon(Icons.access_alarm),
            title: const Text("Rides"),
            selectedColor: defaultTextColor1,
          ),

          /// Search
          SalomonBottomBarItem(
            icon: const Icon(Icons.car_rental_outlined),
            title: const Text("Rent"),
            selectedColor: defaultTextColor1,
          ),

          /// Profile
          SalomonBottomBarItem(
            icon: const Icon(Icons.person),
            title: const Text("Profile"),
            selectedColor: defaultTextColor1,
          ),
        ],
      ),
    );
  }
}
