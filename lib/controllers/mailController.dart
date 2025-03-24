import 'dart:async';
import 'package:profinfo/repository/authRepository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class MailController extends GetxController{
  // ignore: unused_field
  late Timer _timer;

  @override
  void onInit(){
    super.onInit();
    sendEmailVerification();
    setTimeForAutoRedirect();
  }
  
  Future<void> sendEmailVerification() async {
    try {
      await AuthRepository.instance.sendEmailVerification();
    } catch (error) {
      Get.showSnackbar(GetSnackBar(message: error.toString(),));
    }
  }

  void setTimeForAutoRedirect(){
    _timer = Timer.periodic(Duration(seconds: 3), (timer) { 
      FirebaseAuth.instance.currentUser?.reload();
      final user = FirebaseAuth.instance.currentUser;
      if (user!.emailVerified) {
        timer.cancel();
        AuthRepository.instance.setInitialScreen(user);
      }
    });
  }

  void manuallyCheckEmailVerificationStatus(){
    FirebaseAuth.instance.currentUser?.reload();
    final user = FirebaseAuth.instance.currentUser;
    if (user!.emailVerified) {
      AuthRepository.instance.setInitialScreen(user);
    }
  }
}