import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../const/colors.dart';
import '../middleware/iconsHomeScreen.dart';
import '../screens/secondScreen.dart';

Widget buildGridItem(String area) {
    final IconData icon = getIconForArea(area);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: GestureDetector(
        onTap: () {
          Get.to(() => SecondScreen(area: area), transition: Transition.fadeIn);
        },
        child: Container(
          width: 170,
          height: 160,
          decoration: BoxDecoration(
            color: paleBlue,
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 48,
                color: Colors.black,
              ),
              SizedBox(height: 8),
              Text(
                area,
                style: GoogleFonts.montserrat(
                  color: Colors.black,
                  fontSize: 15,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }