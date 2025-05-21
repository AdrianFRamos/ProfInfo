import 'package:profinfo/const/types.dart';
import 'package:profinfo/models/informacoesModel.dart';
import 'package:profinfo/repository/infoRepository.dart';
import 'package:profinfo/utils/extractOnlyNumber.dart';
import 'package:profinfo/utils/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InfoController extends GetxController {
  static InfoController get instance => Get.find();
  final TextEditingController tipo = TextEditingController();
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
  bool inscricoesEncerradas = false;
  GlobalKey<FormState> infoFormKey = GlobalKey<FormState>();

  String tipoDuracaoSelecionado = TypesDuracao.duracao.first;

  RxBool refreshData = true.obs;
  final Rx<InfoModel> selecionarInfo = InfoModel.empty().obs;
  final infoRepository = Get.put(InfoRepository());

  DateTime lastNotificationTimestamp = DateTime.now().subtract(Duration(days: 1));
  RxList<String> newTipo = <String>[].obs;

  Future<List<InfoModel>> allInfo() async {
  try {
    final informacoes = await infoRepository.fetchInfo();
    return informacoes;
  } catch (e) {
    snackBar.errorSnackBar(
      title: 'Um erro ocorreu. Tente novamente',
      message: 'Ocorreu algo de errado ao buscar as informações. Tente novamente',
    );
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
        tipo: tipo.text.trim(),
        area: area.text.trim(),
        nomeCurso: nomeCurso.text.trim(),
        descricaoCurso: descricaoCurso.text.trim(),
        publicoAlvo: publicoAlvo.text.trim(),
        duracao: ("${extractOnlyNumber(duracao.text)} ${tipoDuracaoSelecionado}").trim(),
        turno: turno.text.trim(),
        numeroVagas: numeroVagas.text.trim(),
        breveConteudo: breveConteudo.text.trim(),
        enderecoWeb: enderecoWeb.text.trim(),
        telefone: telefone.text.trim(),
        dateTime: DateTime.now(),
        inscricoesEncerradas: inscricoesEncerradas,
      );

      final id = await infoRepository.addInfo(informacoes);
      informacoes.id = id;

      newTipo.add(informacoes.tipo);

      snackBar.sucessSnackBar(title: 'Parabéns', message: 'Informação adicionada com sucesso.');

      refreshData.toggle();
      resetFormField();

      Navigator.of(Get.context!).pop();
    } catch (e) {
      snackBar.errorSnackBar(title: 'Erro', message: 'Informação não adicionada.');
    }
  }

  void loadInfo(InfoModel info) {
    tipo.text = info.tipo;
    area.text = info.area;
    nomeCurso.text = info.nomeCurso;
    descricaoCurso.text = info.descricaoCurso;
    publicoAlvo.text = info.publicoAlvo;
    final partes = info.duracao.trim().split(' ');
    if (partes.isNotEmpty) {
      duracao.text = partes[0];
      tipoDuracaoSelecionado = (partes.length > 1) ? partes[1] : TypesDuracao.duracao.first;
    } else {
      duracao.text = '';
      tipoDuracaoSelecionado = TypesDuracao.duracao.first;
    }
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
        tipo: tipo.text.trim(),
        area: area.text.trim(),
        nomeCurso: nomeCurso.text.trim(),
        descricaoCurso: descricaoCurso.text.trim(),
        publicoAlvo: publicoAlvo.text.trim(),
        duracao: ("${extractOnlyNumber(duracao.text)} ${tipoDuracaoSelecionado}").trim(),
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
    tipo.clear();
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

  Future<List<String>> getNewTipo() async {
    try {
      final informacoes = await allInfo();
      final newTipo = informacoes
          .where((info) => info.dateTime!.isAfter(lastNotificationTimestamp))
          .map((info) => info.tipo)
          .toSet()
          .toList();
      return newTipo;
    } catch (e) {
      return [];
    }
  }

  void markNotificationsAsRead() {
    lastNotificationTimestamp = DateTime.now();
  }
}


