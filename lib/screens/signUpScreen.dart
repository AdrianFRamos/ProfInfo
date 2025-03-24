import 'package:profinfo/const/colors.dart';
import 'package:profinfo/controllers/signupController.dart';
import 'package:profinfo/models/userModel.dart';
import 'package:profinfo/screens/loginScreen.dart';
import 'package:profinfo/utils/helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpScreen extends StatelessWidget {
  static const routeName = "/SignUpScreen";
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignUpController());
    final _formKey = GlobalKey<FormState>();
    
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            color:const Color.fromARGB(255, 245, 200, 229),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget> [
                Image(image: AssetImage(Helper.getAssetName("mulheraceno.png", "icons")),
                height: 150,
                ),
                const SizedBox(
                          height: 15,
                        ),
                Text(
                  "Faça Seu Cadastro",
                  style: Helper.getTheme(context).displaySmall
                ),
                const SizedBox(
                          height: 15,
                        ),
                Form(
                  key: _formKey,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 3),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        TextFormField(
                          controller: controller.fullname,
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.person_outline_rounded),
                            labelText: "Nome Completo",
                            hintText: "Nome Completo",
                            border: OutlineInputBorder()
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          controller: controller.email,
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.email_rounded),
                            labelText: "E-mail",
                            hintText: "E-mail",
                            border: OutlineInputBorder()
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          controller: controller.celular,
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.phone_android_outlined),
                            labelText: "Telefone",
                            hintText: "Telefone",
                            border: OutlineInputBorder()
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          controller: controller.password,
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.key),
                            labelText: "Senha",
                            hintText: "Senha",
                            border: OutlineInputBorder()
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.key_rounded),
                            labelText: "Confirme sua senha",
                            hintText: "Confirme sua senha",
                            border: OutlineInputBorder()
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: (){
                              if(_formKey.currentState!.validate()){
                                //SignUpController.instance.registerUser(controller.email.text.trim(), controller.password.text.trim());
                                
                                //SignUpController.instance.phoneAuthentication(controller.celular.text.trim());
                                
                                final user = User(
                                  email: controller.email.text.trim(), 
                                  fullName: controller.fullname.text.trim(), 
                                  password: controller.password.text.trim(),
                                  celular: controller.celular.text.trim(), 
                                );
                                SignUpController.instance.createUser(user);
                              }
                            },
                            child: const Text(
                              "Cadastre-se",
                              style: TextStyle(
                                color: AppColor.secondary,
                                fontSize: 15
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Align(
                          child: Text(
                            "Ou",
                            style: Helper.getTheme(context).labelLarge
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: OutlinedButton.icon(
                            icon: Image(image: AssetImage(Helper.getAssetName("google.png", "logos")),width: 20,),
                            onPressed: (){}, 
                            label: Text(
                              "Registre-se com o Google",
                              style: Helper.getTheme(context).labelLarge
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Align(
                          child: TextButton(
                            onPressed: () {
                              Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
                            },
                            child: Text.rich(
                              TextSpan(
                                text: "Voce já tem uma conta ? ",
                                children: [
                                  const TextSpan(
                                    text: "Faça Login"
                                  )
                                ],
                                style: Helper.getTheme(context).labelLarge
                              )
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}