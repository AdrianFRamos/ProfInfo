import 'package:profinfo/middleware/loginErros.dart';
import 'package:profinfo/screens/homeScreen.dart';
import 'package:profinfo/screens/loginScreen.dart';
import 'package:profinfo/screens/profileScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../middleware/exceptions.dart';

class AuthRepository extends GetxController {
  static AuthRepository get instance => Get.find();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  late final Rx<User?> _firebaseUser;
  var verificationId = ''.obs;

  User? get firebaseUser => _firebaseUser.value;

  @override
  void onReady() {
    super.onReady();
    _firebaseUser = Rx<User?>(_auth.currentUser);
    _firebaseUser.bindStream(_auth.userChanges());
    setInitialScreen(_firebaseUser.value);
  }

  void setInitialScreen(User? user) {
    if (user == null) {
      Get.offAll(() => const HomeScreen());
    } else if (user.emailVerified) {
      Get.offAll(() => const ProfileScreen());
    } else {
      Get.offAll(() => const ProfileScreen());
    }
  }

  //-----------------------CELULAR-------------------------//

  Future<void> loginWithCelular(String phoneNumber) async {
    try {
      await _auth.signInWithPhoneNumber(phoneNumber);
    } on FirebaseAuthException catch (e) {
      if (e.code == "invalid-phone-number") {
        Get.snackbar("Erro", "Número de telefone inválido.");
      }
    } catch (_) {
      Get.snackbar("Erro", "Ocorreu algo de errado.");
    }
  }

  Future<void> phoneAuthentication(String celular) async {
    await _auth.verifyPhoneNumber(
      phoneNumber: celular,
      verificationCompleted: (credential) async {
        await _auth.signInWithCredential(credential);
      },
      codeSent: (verificationId, resendToken) {
        this.verificationId.value = verificationId;
      },
      codeAutoRetrievalTimeout: (verificationId) {
        this.verificationId.value = verificationId;
      },
      verificationFailed: (e) {
        if (e.code == 'invalid-phone-number') {
          Get.snackbar("Erro", "O número disponibilizado não é válido");
        } else {
          Get.snackbar("Erro", "Algo errado ocorreu. Tente novamente");
        }
      },
    );
  }

  Future<bool> verifyOTP(String otp) async {
    var credentials = await _auth.signInWithCredential(
      PhoneAuthProvider.credential(
        verificationId: verificationId.value,
        smsCode: otp,
      ),
    );
    return credentials.user != null;
  }

  //-----------------------EMAIL e SENHA-------------------------//

  Future<void> createUserWithEmailAndPassword(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(email: email, password: password);
      _firebaseUser.value != null
          ? Get.offAll(() => const HomeScreen())
          : Get.offAll(() => const LoginScreen());
    } on FirebaseAuthException catch (e) {
      final ex = SignUpFailure.code(e.code);
      print('Firebase Auth Exception - ${ex.message}');
      throw ex;
    } catch (_) {
      const ex = SignUpFailure();
      print('Exception - ${ex.message}');
      throw ex;
    }
  }

  Future<String?> loginWithEmailAndPassword(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('Usuário não encontrado para o email: $email');
        return 'Email não cadastrado.';
      } else if (e.code == 'wrong-password') {
        print('Senha incorreta para o email: $email');
        return 'Senha incorreta.';
      } else if (e.code == 'invalid-email') {
        print('Email inválido: $email');
        return 'Formato de email inválido.';
      } else if (e.code == 'network-request-failed') {
        print('Falha de rede ao tentar logar: $email');
        return 'Falha na conexão. Verifique sua internet.';
      } else {
        print('Erro não tratado: ${e.message}');
        return 'Ocorreu um erro durante o login. Por favor, tente novamente mais tarde.';
      }
    } catch (e) {
      print('Erro inesperado: $e');
      return 'Ocorreu um erro inesperado durante o login.';
    }
  }


  Future<void> sendEmailVerification() async {
    try {
      await _auth.currentUser?.sendEmailVerification();
    } on FirebaseAuthException catch (e) {
      final ex = TExceptions.fromCode(e.code);
      throw ex.message;
    } catch (_) {
      const ex = TExceptions();
      throw ex.message;
    }
  }

  //-----------------------GOOGLE SIGN-IN-------------------------//

  Future<UserCredential?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      return await _auth.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      final ex = TExceptions.fromCode(e.code);
      throw ex.message;
    } catch (_) {
      const ex = TExceptions();
      throw ex.message;
    }
  }

  //-----------------------LOGOUT-------------------------//

  Future<void> logout() async {
  try {
    await _auth.signOut();
    //await GoogleSignIn().signOut();
    Get.offAll(() => const HomeScreen());
  } on FirebaseAuthException catch (e) {
    print('Erro ao deslogar do Firebase: ${e.message}');
    throw 'Erro ao deslogar. Tente novamente.';
  } catch (e) {
    print('Erro inesperado ao deslogar: $e');
    throw 'Logout não concluído. Tente novamente';
  }
}

}
