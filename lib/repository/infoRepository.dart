import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:profinfo/models/informacoesModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InfoRepository extends GetxController {
  static InfoRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  Future<List<InfoModel>> fetchInfo() async {
    try {
      final result = await _db.collection('Cursos').get();
      return result.docs.map((documentSnapshot) => InfoModel.fromDocumentSnapshot(documentSnapshot)).toList();
    } catch (e) {
      throw 'Ocorreu algo de errado ao buscar as informações. Tente novamente';
    }
  }

  Future<String> addInfo(InfoModel informacoes) async {
    try {
      final currentInfo = await _db.collection('Cursos').add(informacoes.toJson());
      return currentInfo.id;
    } catch (e) {
      throw 'Ocorreu algo de errado ao adicionar as informações. Tente novamente';
    }
  }

  Future<void> updateInfo(InfoModel info) async {
    try {
      await _db.collection('Cursos').doc(info.id).update(info.toJson());
    } catch (e) {
      throw 'Ocorreu algo de errado ao atualizar as informações. Tente novamente';
    }
  }

  Future<void> deleteInfo(String id) async {
    try {
      await _db.collection('Cursos').doc(id).delete();
    } catch (e) {
      throw 'Ocorreu algo de errado ao deletar as informações. Tente novamente';
    }
  }

  Future<List<InfoModel>> searchInfo(String query) async {
    try {
      final normalizedQuery = query.trim().toLowerCase();
      
      // Buscar todos os cursos do Firestore
      final result = await _db.collection('Cursos').get();
      final allInfo = result.docs.map((doc) => InfoModel.fromDocumentSnapshot(doc)).toList();

      // 🔍 Passo 1: Buscar por Área
      List<InfoModel> filteredList = allInfo.where((info) {
        return info.area.toLowerCase().contains(normalizedQuery);
      }).toList();

      if (filteredList.isEmpty) {
        // 🔍 Passo 2: Buscar por Público-Alvo
        filteredList = allInfo.where((info) {
          return info.publicoAlvo.toLowerCase().contains(normalizedQuery);
        }).toList();
      }

      if (filteredList.isEmpty) {
        // 🔍 Passo 3: Buscar por Nome do Curso
        filteredList = allInfo.where((info) {
          return info.nomeCurso.toLowerCase().contains(normalizedQuery);
        }).toList();
      }

      // Logs para debug
      debugPrint("🔍 Query: $normalizedQuery");
      debugPrint("📄 Dados carregados: ${allInfo.map((e) => e.nomeCurso).toList()}");
      debugPrint("✅ Resultado filtrado: ${filteredList.map((e) => e.nomeCurso).toList()}");

      return filteredList;
    } catch (e) {
      debugPrint("❌ Erro na pesquisa: $e");
      return [];
    }
  }

}
