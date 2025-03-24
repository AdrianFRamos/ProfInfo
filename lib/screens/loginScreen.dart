import 'package:profinfo/const/colors.dart';
import 'package:profinfo/controllers/loginController.dart';
import 'package:profinfo/screens/forgetPassword.dart';
//import 'package:profinfo/screens/signUpScreen.dart';
import 'package:profinfo/utils/helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';


import '../widgets/forgetPasswordWidget.dart';

class LoginScreen extends StatelessWidget {
  static const routeName = "/loginScreen";
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Container(
              color: softBlue,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 80),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget> [
                  Image.asset(Helper.getAssetName("mulheraceno.png", "icons"),
                  height: 200,
                  ),
                  Text(
                    "Faça Seu Login",
                    style: GoogleFonts.montserrat(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Form(
                    key: controller.loginFormKey,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 3),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          TextFormField(
                            controller: controller.email,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Digite seu e-mail';
                              } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                                return 'Digite um e-mail válido';
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                              prefixIcon: Icon(Icons.person_outline_outlined),
                              labelText: "E-mail",
                              hintText: "E-nail",
                              border: OutlineInputBorder()
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Obx(() => 
                            TextFormField(
                              controller: controller.password,
                              obscureText: !controller.showPassword.value,
                              validator: (value) {
                                if (value!.isEmpty) return 'Digite sua senha';
                                return null;
                              },
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.key),
                                labelText: "Senha",
                                hintText: "Senha",
                                border: const OutlineInputBorder(),
                                suffixIcon: IconButton(
                                  onPressed: () => controller.showPassword.value = !controller.showPassword.value,
                                  icon: Icon(controller.showPassword.value ? Icons.visibility : Icons.visibility_off),
                                ),
                              ),
                            )
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () {
                                showModalBottomSheet(
                                  backgroundColor: const Color.fromARGB(255, 245, 200, 229),
                                  context: context, 
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                  builder: (context) => Container(
                                    padding: const EdgeInsets.all(8),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        const Text(
                                          "Selecione uma das opções",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 30,
                                            fontWeight: FontWeight.bold
                                          ),
                                        ),
                                       const Text(
                                          "Selecione uma das opções para fazer um reset da sua senha",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 30,
                                        ),
                                        ForgetPasswordWidget(
                                          title: "E-mail",
                                          description: "Resete via verificação por e-mail",
                                          icon: Icons.email,
                                          onTap: (){
                                            Navigator.of(context).restorablePushReplacementNamed(ForgetPasswordScreen.routeName);
                                          },
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        ForgetPasswordWidget(
                                          title: "Telefone",
                                          description: "Resete via verificação por telefone",
                                          icon: Icons.mobile_friendly,
                                          onTap: (){},
                                        ),
                                      ],
                                    ),
                                  )
                                );
                              },
                              child: Text(
                                "Esqueceu sua senha ?",
                                style: Helper.getTheme(context).labelLarge,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor: WidgetStatePropertyAll(WhiteIce)
                              ),
                              onPressed: () => controller.login(),
                              child: Text(
                                "LOGIN",
                                style: GoogleFonts.montserrat(
                                  color: Colors.black,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ),
                          /* const SizedBox(
                            height: 20,
                          ),
                          Align(
                            child: Text(
                              "Ou",
                              style: Helper.getTheme(context).labelLarge,
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: OutlinedButton.icon(
                              icon: const Image(image: AssetImage("assets/logos/google.png"),width: 20,),
                              onPressed: (){}, 
                              label:  Text(
                                "Faça Login com o Google",
                                style: Helper.getTheme(context).labelLarge,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ), */
                          //Align(
                          //  child: TextButton(
                          //    onPressed: () {
                          //      Navigator.of(context).pushReplacementNamed(SignUpScreen.routeName);
                          //    },
                          //  child: Text.rich(
                          //    TextSpan(
                          //      text: "Voce ainda não tem uma conta ? ",
                          //      children: [
                          //        TextSpan(
                          //          text: "Cadastre-se",
                          //          style: Helper.getTheme(context).labelLarge,
                          //        )
                          //      ],
                          //      style: Helper.getTheme(context).labelLarge,
                          //    )
                          //  ),
                          //  ),
                          //)
                        ],
                      ),
                    )
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
