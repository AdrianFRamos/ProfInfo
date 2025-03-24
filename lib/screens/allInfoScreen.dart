import 'package:profinfo/screens/addInfoScreen.dart';
import 'package:profinfo/widgets/appBarWidget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/infoController.dart';
import '../models/informacoesModel.dart';
import '../widgets/infoWidget.dart';

class AllInfoScreen extends StatelessWidget {
  const AllInfoScreen({super.key});
  static const routeName = "/allInfoScreen";

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(InfoController());

    return Scaffold(
      appBar: AppBarWidget(showBackArrow: true, title: Text('Todas as Informações')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Obx(
            () => FutureBuilder(
              key: Key(controller.refreshData.value.toString()),
              future: controller.allInfo(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Text('Erro ao buscar dados: ${snapshot.error}');
                } else if (!snapshot.hasData || (snapshot.data as List).isEmpty) {
                  return Text('Nenhum dado encontrado');
                } else {
                  final informacoes = snapshot.data as List<InfoModel>;
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: informacoes.length,
                    itemBuilder: (context, index) => InfoWidget(
                      informacoes: informacoes[index],
                    ),
                  );
                }
              },
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueAccent,
        onPressed: () => Get.to(() => AddInfoScreen()),
        child: Icon(Icons.add),
      ),
    );
  }
}
