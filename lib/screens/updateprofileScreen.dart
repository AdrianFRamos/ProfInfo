import 'package:profinfo/controllers/profileController.dart';
import 'package:profinfo/utils/helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/userModel.dart';

class UpdateProfileScreen extends StatelessWidget {
  const UpdateProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProfilerController());
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.back(), 
          icon: Icon(Icons.arrow_back_ios_new),
        ),
        title: Text(
          "Edite seu Perfil",
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding:  const EdgeInsets.all(8),
          child: FutureBuilder(
            future: controller.getUserData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  User user = snapshot.data as User;
                  final id = TextEditingController(text: user.id);
                  final email = TextEditingController(text: user.email);
                  final password = TextEditingController(text: user.password);
                  final fullname = TextEditingController(text: user.fullName);
                  final celular = TextEditingController(text: user.celular);

                  return Column(
                    children: <Widget>[
                      Stack(
                        children: [
                          SizedBox(
                            width: 120,
                            height: 120,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: Image(image: AssetImage(Helper.getAssetName('educacao.png', 'images'))),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              width: 35,
                              height: 35,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100), 
                                color: Colors.pink[50],
                              ),
                              child: Icon(
                                Icons.camera_alt,
                                color: Colors.black,
                                size: 20,
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      Form(
                        child: Column(
                          children: <Widget>[
                            TextFormField(
                              controller: fullname,
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
                              controller: email,
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
                              controller: celular,
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
                              controller: password,
                              decoration: const InputDecoration(
                                prefixIcon: Icon(Icons.key),
                                labelText: "Senha",
                                hintText: "Senha",
                                border: OutlineInputBorder()
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () async {
                                  final userData = User(
                                    id: id.text.trim(),
                                    email: email.text.trim(), 
                                    fullName: fullname.text.trim(), 
                                    password: password.text.trim(), 
                                    celular: celular.text.trim()
                                  );
                                  await controller.updateRecord(userData);
                                }, 
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.pink[50],
                                  side: BorderSide.none,
                                  shape: StadiumBorder(),
                                ),
                                child: Text(
                                  "Edit Profile",
                                  style: TextStyle(
                                    color: Colors.white
                                  ),
                                )
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text.rich(
                                  TextSpan(
                                    text: "Juntou-se em ",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.black
                                    ),
                                    children: [
                                      TextSpan(
                                        text: "15 de Março de 2024",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 13,
                                          color: Colors.black
                                        )
                                      )
                                    ]
                                  )
                                ),
                                ElevatedButton(
                                  onPressed: (){}, 
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.redAccent.withOpacity(0.1),
                                    foregroundColor: Colors.red,
                                    shape: StadiumBorder(),
                                    side: BorderSide.none,
                                    elevation: 0
                                  ),
                                  child: Text(
                                    "Delete",
                                  )
                                )
                              ],
                            )
                          ],
                        )
                      )
                    ]
                  );
                }else if(snapshot.hasError){
                  return Center(
                    child: Text(snapshot.error.toString()),
                  );
                }else{
                  return const Center(
                    child: Text("Ocorreu algo de errado"),
                  );
                }
              }else{
                return const Center(
                  child: CircularProgressIndicator()
                );
              }
            },
          )
        )
      )
    );
  }
}