import 'package:firebase_auth/firebase_auth.dart';

Future<void> logout() async {
  final auth = FirebaseAuth.instance;
  if (auth.currentUser != null) {
    await auth.signOut();
    print('Usuário deslogado automaticamente');
  }
}
