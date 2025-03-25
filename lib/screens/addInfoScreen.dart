import 'dart:io';
import 'package:flutter/services.dart';
import 'package:profinfo/const/types.dart';
import 'package:profinfo/controllers/infoController.dart';
import 'package:profinfo/widgets/appBarWidget.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddInfoScreen extends StatefulWidget {
  AddInfoScreen({super.key});
  static const routeName = "/addInfoScreen";

  @override
  State<AddInfoScreen> createState() => _AddInfoScreenState();
}

class _AddInfoScreenState extends State<AddInfoScreen> {
  final FirebaseStorage storage = FirebaseStorage.instance;
  bool uploading = false;
  double total = 0;
  String? tipoSelecionado;
  String? areaSelecionada;
  String? publicoAlvoSelecionado;
  String? turnoSelecionado;

  final tipos = TypesCursos();
  final areas = TypesAreas();
  final publicoAlvo = TypesPublicoAlvo();
  final turno = TypesTurno();

  Future<XFile?> getImage() async {
    final ImagePicker _picker = ImagePicker();
    XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    return image;
  }

  Future<UploadTask> uploadImage(String path) async {
    File file = File(path);
    try {
      String ref = 'images/img-${DateTime.now().toString()}.jpg';
      var imageUrl = storage.ref(ref).putFile(file);
      return Future.value(imageUrl);
    } on FirebaseException catch (e) {
      throw Exception('Erro no upload: ${e.code}');
    }
  }

  selectUploadImage() async {
    XFile? file = await getImage();
    if (file != null) {
      UploadTask task = await uploadImage(file.path);

      task.snapshotEvents.listen((TaskSnapshot snapshot) async {
        if (snapshot.state == TaskState.running) {
          setState(() {
            uploading = true;
            total = (snapshot.bytesTransferred / snapshot.totalBytes) * 100;
          });
        } else if (snapshot.state == TaskState.success) {
          setState(() => uploading = false);
        }
      });
    }
  }

  void _submitForm() {
    final controller = InfoController.instance;
    if (controller.infoFormKey.currentState!.validate()) {
      controller.addNewInfo();
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = InfoController.instance;

    return Scaffold(
      appBar: AppBarWidget(showBackArrow: true, title: Text('Adicione uma nova informação')),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Form(
            key: controller.infoFormKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                DropdownButtonFormField<String>(
                  value: tipoSelecionado,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.class_, color: Colors.black),
                    labelText: 'Tipo do Curso',
                    border: OutlineInputBorder(),
                  ),
                  items: TypesCursos.tiposCurso.map((tipo) {
                    return DropdownMenuItem(
                      value: tipo,
                      child: Text(tipo),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      tipoSelecionado = value!;
                      controller.tipo.text = value;
                    });
                  },
                ),
                SizedBox(height: 15),
                DropdownButtonFormField<String>(
                  value: areaSelecionada,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.manage_search_sharp, color: Colors.black),
                    labelText: 'Área do Curso',
                    border: OutlineInputBorder(),
                  ),
                  items: TypesAreas.areaCurso.map((area) {
                    return DropdownMenuItem(
                      value: area,
                      child: Text(area),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      areaSelecionada = value!;
                      controller.area.text = value;
                    });
                  },
                ),
                SizedBox(height: 15),
                TextFormField(
                  controller: controller.nomeCurso,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.text_snippet,
                      color: Colors.black,
                    ), 
                    labelText: 'Nome do Curso'
                  ),
                ),
                SizedBox(height: 15),
                TextFormField(
                  controller: controller.descricaoCurso,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.book_sharp, color: Colors.black),
                    labelText: 'Descrição do Curso',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.multiline,
                  maxLines: null, 
                ),
                SizedBox(height: 15),
                DropdownButtonFormField<String>(
                  value: publicoAlvoSelecionado,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.people, color: Colors.black),
                    labelText: 'Público Alvo',
                    border: OutlineInputBorder(),
                  ),
                  items: TypesPublicoAlvo.publicoAlvo.map((publicoAlvo) {
                    return DropdownMenuItem(
                      value: publicoAlvo,
                      child: Text(publicoAlvo),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      publicoAlvoSelecionado = value!;
                      controller.publicoAlvo.text = value;
                    });
                  },
                ),
                SizedBox(height: 15),
                TextFormField(
                  controller: controller.duracao,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.access_time, color: Colors.black),
                    labelText: 'Duração',
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly, // só números
                  ],
                  onChanged: (value) {
                    if (value.isEmpty) return;

                    // Remove " Horas" se já tiver
                    final onlyNumbers = value.replaceAll(RegExp(r'\D'), '');

                    // Atualiza com " Horas"
                    controller.duracao.value = TextEditingValue(
                      text: "$onlyNumbers Horas",
                      selection: TextSelection.collapsed(offset: "$onlyNumbers Horas".length),
                    );
                  },
                ),
                SizedBox(height: 15),
                DropdownButtonFormField<String>(
                  value: turnoSelecionado,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.nightlight_round, color: Colors.black),
                    labelText: 'Turno',
                    border: OutlineInputBorder(),
                  ),
                  items: TypesTurno.turno.map((turno) {
                    return DropdownMenuItem(
                      value: turno,
                      child: Text(turno),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      turnoSelecionado = value!;
                      controller.turno.text = value;
                    });
                  },
                ),
                SizedBox(height: 15),
                TextFormField(
                  controller: controller.numeroVagas,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.event_seat,
                      color: Colors.black,
                    ), 
                    labelText: 'Número de Vagas'
                  ),
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 15),
                TextFormField(
                  controller: controller.breveConteudo,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.list,
                      color: Colors.black,
                    ), 
                    labelText: 'Breve Conteúdo'
                  ),
                  keyboardType: TextInputType.multiline,
                  maxLines: null, 
                ),
                SizedBox(height: 15),
                TextFormField(
                  controller: controller.enderecoWeb,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.link,
                      color: Colors.black,
                    ), 
                    labelText: 'Endereço Web',
                  ),
                ),
                SizedBox(height: 15),
                TextFormField(
                  controller: controller.telefone,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.phone,
                      color: Colors.black,
                    ), 
                    labelText: 'Telefone'
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(10),
                  child: Row(
                    children: [
                      uploading
                      ? const Padding(
                        padding: EdgeInsets.only(right: 12),
                        child: Center(
                          child: SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 3,
                              color: Colors.amber,
                            ),
                          ),
                        ),
                      ) 
                      : IconButton(
                        onPressed: selectUploadImage,
                        icon: const Icon(Icons.upload),
                      ),
                      SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: _submitForm,
                        child: Text("Salvar"),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
