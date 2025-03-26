import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:profinfo/const/colors.dart';

class BottomBarWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.0,
      color: softBlue,
      padding: EdgeInsets.symmetric(horizontal: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset(
            'assets/images/BottomBar1.jpg',
            height: 200.0,
            width: 200.0,
            fit: BoxFit.contain,
          ),
          Flexible(
            child: Text(
              'Designed by: TheSentinel',
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.bebasNeue(fontSize: 20, color: Colors.black),
            ),
          ),
          Image.asset(
            'assets/images/BottomBar2.jpg',
            height: 200.0,
            width: 200.0,
            fit: BoxFit.contain,
          ),
        ],
      ),
    );
  }
}
