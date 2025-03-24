import 'package:profinfo/models/informacoesModel.dart';
import 'package:profinfo/repository/infoRepository.dart';
import 'package:profinfo/utils/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InfoController extends GetxController {
  static InfoController get instance => Get.find();
  final TextEditingController area = TextEditingController();
  final TextEditingController nomeCurso = TextEditingController();
  final TextEditingController descricaoCurso = TextEditingController();
  final TextEditingController publicoAlvo = TextEditingController();
  final TextEditingController duracao = TextEditingController();
  final TextEditingController turno = TextEditingController();
  final TextEditingController numeroVagas = TextEditingController();
  final TextEditingController breveConteudo = TextEditingController();
  final TextEditingController enderecoWeb = TextEditingController();
  final TextEditingController telefone = TextEditingController();
  final TextEditingController _cleanController = TextEditingController();
  GlobalKey<FormState> infoFormKey = GlobalKey<FormState>();

  RxBool refreshData = true.obs;
  final Rx<InfoModel> selecionarInfo = InfoModel.empty().obs;
  final infoRepository = Get.put(InfoRepository());

  DateTime lastNotificationTimestamp = DateTime.now().subtract(Duration(days: 1));
  RxList<String> newarea = <String>[].obs;

  Future<List<InfoModel>> allInfo() async {
    try {
      final informacoes = await infoRepository.fetchInfo();
      return informacoes;
    } catch (e) {
      snackBar.errorSnackBar(title: 'Um erro ocorreu. Tente novamente', message: e.toString());
      return [];
    }
  }

  Future<List<InfoModel>> searchInfo(String query) async {
    try {
      final informacoes = await infoRepository.searchInfo(query);
      return informacoes;
    } catch (e) {
      snackBar.errorSnackBar(title: 'Um erro ocorreu. Tente novamente', message: e.toString());
      return [];
    }
  }

  Future addNewInfo() async {
    try {
      if (!infoFormKey.currentState!.validate()) {
        return;
      }

      final informacoes = InfoModel(
        id: '',
        area: area.text.trim(),
        nomeCurso: nomeCurso.text.trim(),
        descricaoCurso: descricaoCurso.text.trim(),
        publicoAlvo: publicoAlvo.text.trim(),
        duracao: duracao.text.trim(),
        turno: turno.text.trim(),
        numeroVagas: numeroVagas.text.trim(),
        breveConteudo: breveConteudo.text.trim(),
        enderecoWeb: enderecoWeb.text.trim(),
        telefone: telefone.text.trim(),
        dateTime: DateTime.now(),
      );

      final id = await infoRepository.addInfo(informacoes);
      informacoes.id = id;

      newarea.add(informacoes.area);

      snackBar.sucessSnackBar(title: 'Parabéns', message: 'Informação adicionada com sucesso.');

      refreshData.toggle();
      resetFormField();

      Navigator.of(Get.context!).pop();
    } catch (e) {
      snackBar.errorSnackBar(title: 'Erro', message: 'Informação não adicionada.');
    }
  }

  void loadInfo(InfoModel info) {
    area.text = info.area;
    nomeCurso.text = info.nomeCurso;
    descricaoCurso.text = info.descricaoCurso;
    publicoAlvo.text = info.publicoAlvo;
    duracao.text = info.duracao;
    turno.text = info.turno;
    numeroVagas.text = info.numeroVagas;
    breveConteudo.text = info.breveConteudo;
    enderecoWeb.text = info.enderecoWeb;
    telefone.text = info.telefone ?? '';
  }

  Future updateInfo(String id) async {
    try {
      if (!infoFormKey.currentState!.validate()) {
        return;
      }

      final informacoes = InfoModel(
        id: id,
        area: area.text.trim(),
        nomeCurso: nomeCurso.text.trim(),
        descricaoCurso: descricaoCurso.text.trim(),
        publicoAlvo: publicoAlvo.text.trim(),
        duracao: duracao.text.trim(),
        turno: turno.text.trim(),
        numeroVagas: numeroVagas.text.trim(),
        breveConteudo: breveConteudo.text.trim(),
        enderecoWeb: enderecoWeb.text.trim(),
        telefone: telefone.text.trim(),
        dateTime: DateTime.now(), // Adiciona a data/hora atual
      );

      await infoRepository.updateInfo(informacoes);

      snackBar.sucessSnackBar(title: 'Parabéns', message: 'Informação atualizada com sucesso.');

      refreshData.toggle();
      resetFormField();

      Navigator.of(Get.context!).pop();
    } catch (e) {
      snackBar.errorSnackBar(title: 'Erro', message: 'Informação não atualizada.');
    }
  }

  Future deleteInfo(String id) async {
    try {
      await infoRepository.deleteInfo(id);

      snackBar.sucessSnackBar(title: 'Parabéns', message: 'Informação excluída com sucesso.');

      refreshData.toggle();
    } catch (e) {
      snackBar.errorSnackBar(title: 'Erro', message: 'Informação não excluída.');
    }
  }

  void resetFormField() {
    area.clear();
    nomeCurso.clear();
    descricaoCurso.clear();
    publicoAlvo.clear();
    duracao.clear();
    turno.clear();
    numeroVagas.clear();
    breveConteudo.clear();
    enderecoWeb.clear();
    telefone.clear();
    infoFormKey.currentState?.reset();
    _cleanController.clear();
  }

  Future<List<String>> getNewArea() async {
    try {
      final informacoes = await allInfo();
      final newGrandAreas = informacoes
          .where((info) => info.dateTime!.isAfter(lastNotificationTimestamp))
          .map((info) => info.area)
          .toSet()
          .toList();
      return newGrandAreas;
    } catch (e) {
      return [];
    }
  }

  void markNotificationsAsRead() {
    lastNotificationTimestamp = DateTime.now();
  }
}


