import 'package:profinfo/repository/authRepository.dart';
import 'package:profinfo/screens/homeScreen.dart';
import 'package:get/get.dart';

class OTPController extends GetxController{
  static OTPController get instance => Get.find();

  void verifyOTP(String otp) async{
    var isVerified = await AuthRepository.instance.verifyOTP(otp);
    isVerified ? Get.offAll(HomeScreen()) : Get.back();
  }
}