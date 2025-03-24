import 'dart:io';
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
                TextFormField(
                  controller: controller.area,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.manage_search_sharp,
                      color: Colors.black,
                    ), 
                    labelText: 'Area do Curso'
                  ),
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
                    prefixIcon: Icon(
                      Icons.book_sharp,
                      color: Colors.black,
                    ), 
                    labelText: 'Descrição do Curso'
                  ),
                  maxLines: null, 
                  keyboardType: TextInputType.multiline,
                ),
                SizedBox(height: 15),
                TextFormField(
                  controller: controller.publicoAlvo,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.people,
                      color: Colors.black,
                    ), 
                    labelText: 'Público Alvo'
                  ),
                ),
                SizedBox(height: 15),
                TextFormField(
                  controller: controller.duracao,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.access_time,
                      color: Colors.black,
                    ), 
                    labelText: 'Duração'
                  ),
                ),
                SizedBox(height: 15),
                TextFormField(
                  controller: controller.turno,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.nightlight_round,
                      color: Colors.black,
                    ), 
                    labelText: 'Turno'
                  ),
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
