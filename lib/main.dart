import 'package:profinfo/const/colors.dart';
import 'package:profinfo/controllers/infoController.dart';
import 'package:profinfo/firebase_options.dart';
import 'package:profinfo/repository/authRepository.dart';
import 'package:profinfo/screens/forgetPassword.dart';
import 'package:profinfo/screens/homeScreen.dart';
import 'package:profinfo/screens/introScreen.dart';
import 'package:profinfo/screens/loginScreen.dart';
import 'package:profinfo/screens/mailScreen.dart';
import 'package:profinfo/screens/otpScreen.dart';
import 'package:profinfo/screens/profileScreen.dart';
import 'package:profinfo/screens/secondScreen.dart';
import 'package:profinfo/screens/signUpScreen.dart';
import 'package:profinfo/screens/splashScreen.dart';
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
      theme: ThemeData(
        fontFamily: "Montserrat-itallic",
        primarySwatch: Colors.orange,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all(
             AppColor.orange,
            ),
            shape: WidgetStateProperty.all(
              const StadiumBorder(),
            ),
            elevation: WidgetStateProperty.all(0)
          )
        ),
        textTheme: const TextTheme(
          titleLarge: TextStyle(
            color: AppColor.primary,
            fontSize: 20
          ),
          bodyMedium: TextStyle(
            color: AppColor.secondary
          )
        )
      ),
      home: const SplashScreen(),
      routes: {
        SplashScreen.routeName: (context) => const SplashScreen(),
        IntroScreen.routeName: (context) => const IntroScreen(),
        LoginScreen.routeName: (context) => const LoginScreen(),
        SignUpScreen.routeName: (context) => const SignUpScreen(),
        ForgetPasswordScreen.routeName: (context) => const ForgetPasswordScreen(),
        MailScreen.routeName: (context) => const MailScreen(),
        OTPScreen.routeName: (context) => const OTPScreen(),
        HomeScreen.routeName: (context) => const HomeScreen(),
        SecondScreen.routeName: (context) => const SecondScreen(),
        ThirdScreen.routeName: (context) => const ThirdScreen(infoList: []),
        FourteenScreen.routeName: (context) => const FourteenScreen(),
        ProfileScreen.routeName: (context) => const ProfileScreen(),
        InfoPersonScreen.routeName: (context) => const InfoPersonScreen(),
      },
    );
  }
} 