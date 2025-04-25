import 'package:cloud_firestore/cloud_firestore.dart';

class InfoModel {
  String id;
  final String tipo;
  final String area;
  final String nomeCurso;
  final String descricaoCurso;
  final String publicoAlvo;
  final String duracao;
  final String turno;
  final String numeroVagas;
  final String breveConteudo;
  final String enderecoWeb;
  final String? telefone;
  final DateTime? dateTime;
  final bool inscricoesEncerradas;

  InfoModel({
    required this.id,
    required this.tipo,
    required this.area,
    required this.nomeCurso,
    required this.descricaoCurso,
    required this.publicoAlvo,
    required this.duracao,
    required this.turno,
    required this.numeroVagas,
    required this.breveConteudo,
    required this.enderecoWeb,
    this.inscricoesEncerradas = false,
    this.telefone,
    this.dateTime,
  });

  static InfoModel empty() => InfoModel(id: '',area: '', tipo: '',nomeCurso: '', descricaoCurso: '', publicoAlvo: '', duracao: '', turno: '', numeroVagas: '', breveConteudo: '', enderecoWeb: '', telefone: '', dateTime: null, inscricoesEncerradas: false);

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'tipo': tipo,
      'area': area,
      'nomeCurso': nomeCurso,
      'descricaoCurso': descricaoCurso,
      'publicoAlvo': publicoAlvo,
      'duracao': duracao,
      'turno': turno,
      'numeroVagas': numeroVagas,
      'breveConteudo': breveConteudo,
      'enderecoWeb': enderecoWeb,
      'telefone': telefone,
      'dateTime': dateTime != null ? Timestamp.fromDate(dateTime!) : null,
      'inscricoesEncerradas': inscricoesEncerradas,
    };
  }

  factory InfoModel.fromMap(Map<String, dynamic> data) {
    return InfoModel(
      id: data['id'] as String,
      tipo: data['tipo'] as String? ?? '',
      area: data['area'] as String? ?? '',
      nomeCurso: data['nomeCurso'] as String? ?? '',
      descricaoCurso: data['descricaoCurso'] as String? ?? '',
      publicoAlvo: data['publicoAlvo'] as String? ?? '',
      duracao: data['duracao'] as String? ?? '',
      turno: data['turno'] as String? ?? '',
      numeroVagas: data['numeroVagas'] as String? ?? '',
      breveConteudo: data['breveConteudo'] as String? ?? '',
      enderecoWeb: data['enderecoWeb'] as String? ?? '',
      telefone: data['telefone'] as String?,
      dateTime: data['dateTime'] != null ? (data['dateTime'] as Timestamp).toDate() : null,
      inscricoesEncerradas: data['inscricoesEncerradas'] as bool? ?? false,
    );
  }

  factory InfoModel.fromDocumentSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return InfoModel(
      id: snapshot.id,
      tipo: data['tipo'] ?? '',
      area: data['area'] ?? '',
      nomeCurso: data['nomeCurso'] ?? '',
      descricaoCurso: data['descricaoCurso'] ?? '',
      publicoAlvo: data['publicoAlvo'] ?? '',
      duracao: data['duracao'] ?? '',
      turno: data['turno'] ?? '',
      numeroVagas: data['numeroVagas'] ?? '',
      breveConteudo: data['breveConteudo'] ?? '',
      enderecoWeb: data['enderecoWeb'] ?? '',
      telefone: data['telefone']?.toString(),
      dateTime: data['dateTime'] != null ? (data['dateTime'] as Timestamp).toDate() : null,
      inscricoesEncerradas: data['inscricoesEncerradas'] ?? false,
    );
  }
}
