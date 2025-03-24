import 'package:profinfo/const/colors.dart';
import 'package:profinfo/controllers/otpController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';

class OTPScreen extends StatelessWidget {
  static const routeName = '/OTPScreen';
  const OTPScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    var otpController = Get.put(OTPController());
    var otp;
    return Scaffold(
      body: Container(
        color: const Color.fromARGB(255, 245, 200, 229),
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              "CODIGO",
              style: TextStyle(
                color: AppColor.orange,
                fontSize: 80,
                fontWeight: FontWeight.bold
              ),
            ),
            Text(
              "de",
              style: Theme.of(context).textTheme.headlineLarge
            ),
            const SizedBox(
              height: 30,
            ),
            Text(
              "Verificação",
              style: Theme.of(context).textTheme.displayMedium
            ),
            const SizedBox(
              height: 30,
            ),
            const Text(
              "Entre com o codigo de verificação enviado para o email teste@teste.com",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColor.primary,
                fontWeight: FontWeight.bold,
                fontSize: 15
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            OtpTextField(
              numberOfFields: 6,
              fillColor: const Color.fromARGB(255, 255, 255, 255),
              filled: true,
              onSubmit: (code){ 
                otp = code;
                OTPController.instance.verifyOTP(otp);
              },
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: (){
                  OTPController.instance.verifyOTP(otp);
                }, 
                child: const Text(
                  "Proximo",
                  style: TextStyle(
                    color: AppColor.secondary,
                    fontSize: 17
                  ),
                )
              ),
            )
          ],
        ),
      ),
    );
  }
}