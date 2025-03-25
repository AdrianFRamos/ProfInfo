import 'package:profinfo/controllers/infoController.dart';
import 'package:profinfo/firebase_options.dart';
import 'package:profinfo/middleware/authMidleware.dart';
import 'package:profinfo/repository/authRepository.dart';
import 'package:profinfo/screens/addInfoScreen.dart';
import 'package:profinfo/screens/forgetPassword.dart';
import 'package:profinfo/screens/homeScreen.dart';
//import 'package:profinfo/screens/introScreen.dart';
import 'package:profinfo/screens/loginScreen.dart';
import 'package:profinfo/screens/mailScreen.dart';
import 'package:profinfo/screens/otpScreen.dart';
import 'package:profinfo/screens/profileScreen.dart';
import 'package:profinfo/screens/secondScreen.dart';
import 'package:profinfo/screens/signUpScreen.dart';
//import 'package:profinfo/screens/splashScreen.dart';
import 'package:profinfo/screens/thirdScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'screens/fourteenScreen.dart';
import 'screens/infoPersonScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)
    .then((value) => Get.put(AuthRepository())
  );
  Get.put(InfoController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  
  Widget build(BuildContext context) {
    
    return GetMaterialApp(
      title: 'Prof Info',
      initialRoute: '/',
      getPages: [
        GetPage(
          name: '/',
          page: () => const HomeScreen(),
        ),
        GetPage(
          name: LoginScreen.routeName,
          page: () => const LoginScreen(),
        ),
        GetPage(
          name: SignUpScreen.routeName,
          page: () => const SignUpScreen(),
        ),
        GetPage(
          name: ForgetPasswordScreen.routeName,
          page: () => const ForgetPasswordScreen(),
        ),
        GetPage(
          name: MailScreen.routeName,
          page: () => const MailScreen(),
        ),
        GetPage(
          name: OTPScreen.routeName,
          page: () => const OTPScreen(),
        ),
        GetPage(
          name: AddInfoScreen.routeName,
          page: () => AddInfoScreen(),
          middlewares: [AuthMiddleware()],
        ),
        GetPage(
          name: SecondScreen.routeName,
          page: () => const SecondScreen(),
        ),
        GetPage(
          name: ThirdScreen.routeName,
          page: () => const ThirdScreen(infoList: []),
        ),
        GetPage(
          name: FourteenScreen.routeName,
          page: () => const FourteenScreen(),
        ),
        GetPage(
          name: ProfileScreen.routeName,
          page: () => const ProfileScreen(),
          middlewares: [AuthMiddleware()],
        ),
        GetPage(
          name: InfoPersonScreen.routeName,
          page: () => const InfoPersonScreen(),
          middlewares: [AuthMiddleware()],
        ),
        // (Se quiser reativar futuramente)
        // GetPage(
        //   name: SplashScreen.routeName,
        //   page: () => const SplashScreen(),
        // ),
        // GetPage(
        //   name: IntroScreen.routeName,
        //   page: () => const IntroScreen(),
        // ),
      ],
    );
  }
} 