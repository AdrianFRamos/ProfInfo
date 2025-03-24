import 'package:profinfo/repository/authRepository.dart';
import 'package:profinfo/repository/userRepository.dart';
import 'package:get/get.dart';

import '../models/userModel.dart';

class ProfilerController extends GetxController {
  static ProfilerController get instance => Get.find();

  final _authRepository = Get.put(AuthRepository());
  final _userRepository = Get.put(UserRepository());

  Future<User> getUserData() async {
    final email = _authRepository.firebaseUser?.email;
    if (email != null) {
      return _userRepository.getUserDetails(email);
    }else{
      Get.snackbar("Erro", "Logue para continuar");
      throw Exception('Usuário não autenticado');
    }
  }

  Future<List<User>> getAllUser() async{
    return await _userRepository.allUser();
  }

  updateRecord(User user) async {
    await _userRepository.updateUser(user);
  }

}