import 'package:flutter/material.dart';
import 'package:get/get.dart';

class snackBar extends GetxController {
  
  static sucessSnackBar({required title, message}){
    Get.snackbar(
      title, 
      message,
      isDismissible: true,
      shouldIconPulse: true,
      colorText: Colors.white,
      backgroundColor: Colors.green,
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 6),
      margin: const EdgeInsets.all(40),
      icon: const Icon(Icons.check_circle, color: Colors.white,),
    );
  }

  static errorSnackBar({required title, message}){
    Get.snackbar(
      title, 
      message,
      isDismissible: true,
      shouldIconPulse: true,
      colorText: Colors.white,
      backgroundColor: Colors.red,
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 6),
      margin: const EdgeInsets.all(40),
      icon: const Icon(Icons.error, color: Colors.white,),
    );
  }
}