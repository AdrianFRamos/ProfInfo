import 'package:profinfo/models/userModel.dart';
import 'package:profinfo/repository/authRepository.dart';
import 'package:profinfo/repository/userRepository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController {
  static SignUpController get instance => Get.find();

  final email = TextEditingController();
  final password = TextEditingController();
  final fullname = TextEditingController();
  final celular = TextEditingController();
  final isLoading = false.obs;
  GlobalKey<FormState> signFormKey = GlobalKey<FormState>();

  void dispose() {
  email.dispose();
  password.dispose();
  fullname.dispose();
  celular.dispose();
  super.dispose();
}

  final userRepository = Get.put(UserRepository());

  void registerUser(String email, String password) {
    String? error = AuthRepository.instance.createUserWithEmailAndPassword(email, password) as String?;
    if (error != null) {
      Get.showSnackbar(GetSnackBar(message: error.toString()));
    }
  }

  Future<void> createUser(User user) async{
    try {
      isLoading.value = true;
      if (!signFormKey.currentState!.validate()) {
        isLoading.value = false;
        return;
      }

      //SignUpController.instance.phoneAuthentication(controller.celular.text.trim);
      //Get.to(() => const OTPScreen());

      //final user = UserModel{
      //  email: email.text.trim();
      //  password: password.text.trim();
      //  fullname: fulname.text.trim();
      //  celular: celular.text.trim();
      //};

      final auth = AuthRepository.instance;
      await AuthRepository.instance.createUserWithEmailAndPassword(user.email, user.password);
      await UserRepository.instance.createUser(user);
      auth.setInitialScreen(auth.firebaseUser);

    } catch (e) {
      isLoading.value = false;
      Get.snackbar("erro", e.toString(), snackPosition: SnackPosition.BOTTOM, duration: Duration(seconds: 3));
    }
  }

  Future<void> phoneAuthentication(String celular) async {
    try {
      //await AuthRepository.instance.phoneAuthentication(celular);
    } catch (e) {
      throw e.toString;
    }
  }
}
