import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';
import 'package:passenger/controllers/login/logincontroller.dart';
import 'package:passenger/screens/homepage.dart';
import 'package:passenger/screens/login/loginview.dart';
import 'package:passenger/statics/appcolors.dart';
import 'controllers/profile/profilecontroller.dart';
import 'controllers/register/registercontroller.dart';
import 'controllers/rent/rentcarcontroller.dart';
import 'controllers/schedulecontroller/schedulecontroller.dart';
import 'controllers/wallet/walletcontroller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  await GetStorage.init();
  Get.put(ProfileController());
  Get.put(ScheduleController());
  Get.put(RentCarController());
  Get.put(WalletController());
  Get.put(LoginController());
  Get.put(MyRegistrationController());
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  final storage = GetStorage();
  bool hasToken = false;
  late String uToken = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (storage.read("token") != null) {
      uToken = storage.read("token");
      setState(() {
        hasToken = true;
      });
    } else {
      setState(() {
        hasToken = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      defaultTransition: Transition.leftToRight,
      theme: ThemeData(
          primaryColor: primaryYellow,
          appBarTheme: const AppBarTheme(
            elevation: 0,
            backgroundColor: defaultYellow,
          )),
      home: hasToken ? const HomePage() : const NewLogin(),
    );
  }
}
