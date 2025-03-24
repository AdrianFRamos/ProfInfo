import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:profinfo/models/userModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  Future<void> createUser(User user) async{
    await _db.collection("Users").add(user.toJson()).whenComplete( 
      () => Get.snackbar(
        "Sucesso", "Sua conta foi criada.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green.withOpacity(0.1),
        colorText: Colors.green,
      )
    )
    // ignore: body_might_complete_normally_catch_error
    .catchError((error, stackTrace){
      Get.snackbar(
        "Problema", "Ocorreu algo de errado. Tente novamente.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent.withOpacity(0.1),
        colorText: Colors.red,
      );
      print("Error - $error");
    });
  }

  Future<User> getUserDetails(String email) async {
    final snapshot = await _db.collection("Users").where("Email", isEqualTo: email).get();
    final userData = snapshot.docs.map((e) => User.fromSnapshot(e)).single;
    return userData;
  }

  Future<List<User>> allUser() async {
    final snapshot = await _db.collection("Users").get();
    final userData = snapshot.docs.map((e) => User.fromSnapshot(e)).toList();
    return userData;
  }

  Future<void> updateUser(User user) async{
    await _db.collection("Users").doc(user.id).update(user.toJson());
  }

}