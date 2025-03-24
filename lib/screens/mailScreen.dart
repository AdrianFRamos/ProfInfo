import 'package:profinfo/repository/authRepository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/mailController.dart';

class MailScreen extends StatelessWidget {
  static const routeName = '/MailScreen';
  const MailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MailController());
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            top: 50, 
            left: 10,
            right: 10,
            bottom: 20,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(Icons.mail, size: 100,),
              SizedBox(
                height: 20,
              ),
              Text(
                "Teste",
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'teste',
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                width: 200,
                child: OutlinedButton(
                  onPressed: () => controller.manuallyCheckEmailVerificationStatus(), 
                  child: Text(
                   'Continue', 
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextButton(
                onPressed: () => controller.sendEmailVerification(), 
                child: Text(
                  'Continue',
                ),
              ),
              TextButton(
                onPressed: () => AuthRepository.instance.logout(), 
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.arrow_back),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Voltar para o login'.tr.toLowerCase(),
                    )
                  ],
                )
              )
            ],
          ),
        ),
      ),
    );
  }
}