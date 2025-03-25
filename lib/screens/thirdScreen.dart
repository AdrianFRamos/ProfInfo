import 'package:profinfo/const/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/informacoesModel.dart';
import '../widgets/infoCardWidget.dart';

class ThirdScreen extends StatelessWidget {
  static const routeName = "/ThirdScreen";
  final String? area;
  final List<InfoModel> infoList;

  const ThirdScreen({Key? key, required this.infoList, this.area}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Informações',
          style: GoogleFonts.bebasNeue(
            fontSize: 40,
            color: Colors.black,
          ),
        ),
        backgroundColor: paleBlue,
        actions: <Widget>[
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.search),
          ),
        ],
      ),
      backgroundColor: WhiteBlue,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Informações sobre ${area ?? ''}',
              style: GoogleFonts.montserrat(
                color: Colors.black,
                fontSize: 20,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: infoList.length,
              itemBuilder: (context, index) {
                final info = infoList[index];
                return InfoCardWidget(info: info);
              },
            ),
          ),
        ],
      ),
    );
  }
}

