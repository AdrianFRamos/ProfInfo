import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:profinfo/const/colors.dart';

class BottomBarWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 25.0),
      height: 60.0,
      color: softBlue,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset(
            'images/BottomBar1.jpg',
            height: 200.0,
            width: 200.0,
          ),
          Text(
            'Designed by: TheSentinel', 
            selectionColor: Colors.black,
            style: GoogleFonts.bebasNeue(fontSize: 20),
          ),
          Image.asset(
            'images/BottomBar2.jpg',
            height: 200.0,
            width: 200.0,
          ),
        ],
      ),
    );
  }
}