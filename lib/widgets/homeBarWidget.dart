import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../const/colors.dart';
import '../screens/loginScreen.dart';
import '../controllers/infoController.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final InfoController infoController = InfoController.instance;

    return AppBar(
      leading: Stack(
        children: [
          IconButton(
            icon: Icon(Icons.notifications, color: AppColor.primary, size: 40),
            onPressed: () {
              Scaffold.of(context).openDrawer(); 
            },
          ),
          Obx(() {
            print(infoController.newTipo);
            if (infoController.newTipo.isNotEmpty) {
              return Positioned(
                right: 0,
                top: 0,
                child: Container(
                  padding: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                  constraints: BoxConstraints(
                    minWidth: 16,
                    minHeight: 16,
                  ),
                  child: Center(
                    child: Text(
                      '${infoController.newTipo.length}',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              );
            } else {
              return SizedBox.shrink();
            }
          }),
        ],
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 50, 
            height: 50,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/icons/educacao.png'),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(6), 
            ),
          ),
          SizedBox(width: 8),
          Container(
            margin: EdgeInsets.only(top: 8),
            child: Text(
              'formaçãodeprofessoresUVA',
              style: GoogleFonts.bebasNeue(fontSize: 40),
            ),
          ),
        ],
      ),
      backgroundColor: paleBlue,
      centerTitle: true,
      actions: <Widget>[
        SizedBox(width: 40),
        IconButton(
          onPressed: () {
            Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
          },
          icon: Icon(
            Icons.menu,
            size: 40,
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(55);
}
