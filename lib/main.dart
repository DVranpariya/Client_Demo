import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:future_contract/Resource/PrefManager.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sizer/sizer.dart';

import 'Resource/controller.dart';
import 'View/HomeScreen.dart';
import 'View/Sigin-Screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();

  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // String? isCheckLogin = PrefManager.getName() ?? '';
    return Sizer(
      builder: (context, orientation, deviceType) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          initialBinding: BaseBinding(),
          home: PrefManager.getMobileNumber() == null
              ? LoginScreen()
              : HomeScreen(),
        );
      },
    );
  }
}

class BaseBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => StateChange());
  }
}
