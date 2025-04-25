import 'package:profinfo/const/colors.dart';
import 'package:profinfo/screens/allInfoScreen.dart';
/*import 'package:profinfo/screens/homeScreen.dart';
import 'package:profinfo/screens/infoPersonScreen.dart';
import 'package:profinfo/screens/updateprofileScreen.dart'; */
import 'package:profinfo/utils/helper.dart';
import 'package:profinfo/widgets/profileMenuWidget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../repository/authRepository.dart';

class ProfileScreen extends StatelessWidget {
  static const routeName = "/profilescreen";
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: softBlue,
        title: Text(
          "Perfil",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Container(
            color: WhiteBlue,
            padding:  const EdgeInsets.all(8),
            child: Column(
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
                          color: softBlue,
                        ),
                        child: Icon(
                          Icons.edit,
                          color: Colors.black,
                          size: 20,
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "ProfInfo - Administrador",
                  style: Theme.of(context).textTheme.headlineMedium
                ),
                /* Text(
                  "teste@teste.com",
                  style: Theme.of(context).textTheme.bodyMedium,
                ), */
                SizedBox(
                  height: 20,
                ),
                /* SizedBox(
                  width: 200,
                  child: ElevatedButton(
                    onPressed: () => Get.to(() => UpdateProfileScreen()), 
                    style: ElevatedButton.styleFrom(
                      backgroundColor: softBlue,
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
                ), */
                SizedBox(
                  height: 30,
                ),
                ProfileMenuWidget(
                  title: "Cadastrar Informações",
                  icon: Icons.info_outline,
                  onPress: () => Get.to(() => AllInfoScreen()), 
                ),
                ProfileMenuWidget(
                  title: "Informações",
                  icon: Icons.info_outline,
                  onPress: () => Get.to(() => AllInfoScreen()), 
                ),
                ProfileMenuWidget(
                  title: "Sair",
                  icon: Icons.output,
                  textColor: Colors.red,
                  endIcon: false,
                  onPress: (){
                    AuthRepository.instance.logout();
                  },
                ),
              ],
            ),
          ),
        )
      ),
    );
  }
}
