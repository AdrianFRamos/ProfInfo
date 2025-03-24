import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:profinfo/controllers/infoController.dart';
import 'package:profinfo/models/informacoesModel.dart';

class EditInfoScreen extends StatelessWidget {
  final InfoModel info;

  EditInfoScreen({required this.info}) {
    final InfoController infoController = Get.find();
    infoController.loadInfo(info);
  }

  final InfoController infoController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar Informação'),
      ),
      body: Form(
        key: infoController.infoFormKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextFormField(
                controller: infoController.area,
                decoration: InputDecoration(labelText: 'Area do Curso'),
              ),
              TextFormField(
                controller: infoController.nomeCurso,
                decoration: InputDecoration(labelText: 'Nome do Curso'),
              ),
              TextFormField(
                controller: infoController.descricaoCurso,
                decoration: InputDecoration(labelText: 'Descrição do Curso'),
              ),
              TextFormField(
                controller: infoController.publicoAlvo,
                decoration: InputDecoration(labelText: 'Público Alvo'),
              ),
              TextFormField(
                controller: infoController.duracao,
                decoration: InputDecoration(labelText: 'Duração'),
              ),
              TextFormField(
                controller: infoController.turno,
                decoration: InputDecoration(labelText: 'Turno'),
              ),
              TextFormField(
                controller: infoController.numeroVagas,
                decoration: InputDecoration(labelText: 'Número de Vagas'),
              ),
              TextFormField(
                controller: infoController.breveConteudo,
                decoration: InputDecoration(labelText: 'Breve Conteúdo'),
              ),
              TextFormField(
                controller: infoController.enderecoWeb,
                decoration: InputDecoration(labelText: 'Endereço Web'),
              ),
              TextFormField(
                controller: infoController.telefone,
                decoration: InputDecoration(labelText: 'Telefone'),
              ),
              ElevatedButton(
                onPressed: () {
                  infoController.updateInfo(info.id);
                },
                child: Text('Salvar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
