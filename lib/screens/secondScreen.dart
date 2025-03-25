import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../const/colors.dart';
import '../controllers/infoController.dart';
import '../models/informacoesModel.dart';
import '../screens/thirdScreen.dart';

class SecondScreen extends StatelessWidget {
  static const routeName = "/SecondScreen";
  final String? tipo;

  const SecondScreen({Key? key, this.tipo}) : super(key: key);
  

  @override
  Widget build(BuildContext context) {
    final InfoController infoController = InfoController.instance;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          tipo ?? 'Erro ao carregar dados',
          style: GoogleFonts.bebasNeue(
            fontSize: 40,
            color: Colors.black,
          ),
        ),
        backgroundColor: paleBlue,
        actions: <Widget>[
          IconButton(
            onPressed: () {
              
            },
            icon: Icon(Icons.search, color: Colors.black),
          ),
        ],
        centerTitle: true,
      ),
      backgroundColor: WhiteBlue,
      body: FutureBuilder<List<InfoModel>>(
        future: infoController.allInfo(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erro ao carregar dados'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('Nenhuma informação disponível'));
          } else {
            final informacoes = snapshot.data!;
            final uniqueArea = informacoes
                .where((info) => info.tipo == tipo)
                .map((info) => info.area)
                .toSet()
                .toList();
            return ListView.builder(
              itemCount: uniqueArea.length,
              itemBuilder: (context, index) {
                final area = uniqueArea[index];
                final infoList = informacoes.where((info) => info.area == area).toList();
                return buildGridItem(area: area, infoList: infoList);
              },
            );
          }
        },
      ),
    );
  }

  Widget buildGridItem({required String area, required List<InfoModel> infoList}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: GestureDetector(
        onTap: () {
          Get.to(
            () => ThirdScreen(infoList: infoList, area: area),
            transition: Transition.fadeIn,
          );
        },
        child: Container(
          decoration: BoxDecoration(
            color: paleBlue,
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                area,
                style: GoogleFonts.montserrat(
                  color: Colors.black,
                  fontSize: 18,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
