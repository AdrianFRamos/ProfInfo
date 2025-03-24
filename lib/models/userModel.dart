import 'package:cloud_firestore/cloud_firestore.dart';

class User{
  final String? id;
  final String fullName;
  final String email;
  final String celular;
  final String password;

  const User({
    this.id,
    required this.email,
    required this.fullName,
    required this.password,
    required this.celular,
  });

  toJson(){
    return{
      "FullName": fullName,
      "Email": email,
      "Celular": celular,
      "Password": password,
    };
  }

  factory User.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document){
    final data = document.data()!;
    return User(
      id: document.id,
      email: data["Email"], 
      fullName: data["FullName"], 
      password: data["Password"], 
      celular: data["Celular"],
    );
  }
}