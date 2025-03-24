import 'package:profinfo/const/colors.dart';
import 'package:profinfo/screens/otpScreen.dart';
import 'package:profinfo/utils/helper.dart';
import 'package:flutter/material.dart';

class ForgetPasswordScreen extends StatelessWidget {
  static const routeName = "/ForgetPasswordScreen";
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Align(
        alignment: Alignment.center,
        child: Scaffold(
          // ignore: prefer_const_constructors
          backgroundColor: Color.fromARGB(255, 245, 200, 229),
          body: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(8),
              alignment: Alignment.center,
              
              child: Column(
                children: <Widget>[
                  const SizedBox(
                    height: 20,
                  ),
                  CircleAvatar(
                    backgroundImage: AssetImage(Helper.getAssetName("carroussel3.jpg", "images")),
                    radius: 110,
                  ),
                  const Text(
                    "Esqueceu sua senha ? ",
                    style: TextStyle(
                      color: AppColor.primary,
                      fontSize: 30,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  const Text(
                    "Utilize a opção desejada para fazer a recuperação da senha",
                    style: TextStyle(
                      color: AppColor.primary,
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Form(
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            label: Text("E-mail"),
                            hintText: "E-mail",
                            prefixIcon: Icon(Icons.mail_outline),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: (){
                              Navigator.of(context).pushReplacementNamed(OTPScreen.routeName);
                            }, 
                            child: const Text(
                              "Proximo",
                              style: TextStyle(
                                color: AppColor.secondary,
                                fontWeight: FontWeight.bold
                              ),
                            )
                          ),
                        ),
                      ],
                    ),
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