import 'package:profinfo/const/colors.dart';
import 'package:flutter/material.dart';

class ForgetPasswordWidget extends StatelessWidget {
  const ForgetPasswordWidget({
    required this.icon,
    required this.title,
    required this.description,
    super.key, required this.onTap,
  });

  final IconData icon;
  final String title; 
  final String description;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColor.orange,
        ),
        child: Row(
          children: <Widget>[
            Icon(
              icon,
              size: 60,
              color: Colors.white,
            ),
            const SizedBox(width: 10,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget> [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17
                  ),
                ),
                Text(
                  description,
                   style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}