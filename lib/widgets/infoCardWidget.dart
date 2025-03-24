import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../const/colors.dart';
import '../models/informacoesModel.dart';
import '../screens/fourteenScreen.dart';
import '../utils/daysAgo.dart';
import '../utils/limitText.dart';

class InfoCardWidget extends StatelessWidget {
  final InfoModel info;
  static const int descriptionLimit = 100;

  const InfoCardWidget({Key? key, required this.info}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: softBlue,
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: Card(
        color: paleBlue,
        elevation: 5,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(top: Radius.circular(4)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                info.nomeCurso,
                style: GoogleFonts.montserrat(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                limitText(info.descricaoCurso, descriptionLimit),
                style: GoogleFonts.montserrat(
                  color: Colors.black,
                  fontSize: 16,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                daysAgo(info.dateTime),
                style: GoogleFonts.montserrat(
                  color: Colors.grey[600],
                  fontSize: 14,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FourteenScreen(info: info),
                      ),
                    );
                  },
                  child: Text(
                    'Leia mais',
                    style: GoogleFonts.montserrat(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
  