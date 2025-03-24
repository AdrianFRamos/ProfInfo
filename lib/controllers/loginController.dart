//import 'package:profinfo/repository/authRepository.dart';
import 'package:profinfo/utils/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../repository/authRepository.dart';

class LoginController extends GetxController {
  static LoginController get instance => Get.find();

  final showPassword = false.obs;
  final email = TextEditingController();
  final password = TextEditingController();
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  final isLoading = false.obs;
  final isGoogleLoading = false.obs;
  final isFacebookLoading = false.obs;

  Future<void> login() async {
    try {
      isLoading.value = true;
      if (!loginFormKey.currentState!.validate()) {
        isLoading.value = false;
        return;
      }
      final auth = AuthRepository.instance;
      print("Tentando login para ${email.text.trim()}");
      String? error = await auth.loginWithEmailAndPassword(email.text.trim(), password.text.trim());
      
      if (error != null) {
        print("Erro no login: $error");
        Get.showSnackbar(GetSnackBar(message: error.toString(),));
      } else {
        print("Login bem-sucedido, redirecionando...");
        auth.setInitialScreen(auth.firebaseUser);
      }
    } catch (e) {
      print("Exceção capturada: $e");
      isLoading.value = false;
    }
  }

  Future<void> GoogleSignIn() async {
    try {
      isGoogleLoading.value = true;
      final auth = AuthRepository.instance;
      await auth.signInWithGoogle();
      isGoogleLoading.value = false;
      auth.setInitialScreen(auth.firebaseUser);
    } catch (e) {
      isGoogleLoading.value = false;
      snackBar.errorSnackBar(title: 'Erro', message: 'Tente novamente');
    }
  }
}