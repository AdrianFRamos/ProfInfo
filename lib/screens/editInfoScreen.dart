import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:profinfo/const/colors.dart';
import 'package:profinfo/const/types.dart';
import 'package:profinfo/controllers/infoController.dart';
import 'package:profinfo/models/informacoesModel.dart';

class EditInfoScreen extends StatefulWidget {
  final InfoModel info;

  EditInfoScreen({required this.info});

  @override
  State<EditInfoScreen> createState() => _EditInfoScreenState();
}

class _EditInfoScreenState extends State<EditInfoScreen> {
  String? tipoSelecionado;
  String? areaSelecionada;
  String? publicoAlvoSelecionado;
  String? turnoSelecionado;
  String? duracaoSelecionada;

  final TextEditingController duracaoNumerica = TextEditingController();

  final InfoController infoController = Get.find();

  @override
  void initState() {
    super.initState();
    infoController.loadInfo(widget.info);

    tipoSelecionado = widget.info.tipo;
    areaSelecionada = widget.info.area;
    publicoAlvoSelecionado = widget.info.publicoAlvo;
    turnoSelecionado = widget.info.turno;
    final duracaoTexto = InfoController.instance.duracao.text;

    if (duracaoTexto.isNotEmpty) {
      final partes = duracaoTexto.split(" ");

      if (partes.length == 2) {
        final numero = partes[0];
        final tipo = partes[1][0].toUpperCase() + partes[1].substring(1).toLowerCase();

        if (TypesDuracao.duracao.contains(tipo)) {
          infoController.tipoDuracaoSelecionado = tipo;
          InfoController.instance.duracao.text = numero;
        }
      }
    }
  }

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
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: DropdownButtonFormField<String>(
                  value: TypesCursos.tiposCurso.contains(tipoSelecionado) ? tipoSelecionado : null,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey[100],
                    prefixIcon: Icon(Icons.class_, color: Colors.black),
                    labelText: 'Tipo do Curso',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
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
                      infoController.tipo.text = value;
                    });
                  },
                ),
              ),
              SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: DropdownButtonFormField<String>(
                  value: TypesAreas.areaCurso.contains(areaSelecionada) ? areaSelecionada : null,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey[100],
                    prefixIcon: Icon(Icons.manage_search_sharp, color: Colors.black),
                    labelText: 'Área do Curso',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
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
                      infoController.area.text = value;
                    });
                  },
                ),
              ),
              SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: TextFormField(
                  controller: infoController.nomeCurso,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey[100],
                    prefixIcon: Icon(
                      Icons.text_snippet,
                      color: Colors.black,
                    ), 
                    labelText: 'Nome do Curso',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: TextFormField(
                  controller: infoController.descricaoCurso,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey[100],
                    prefixIcon: Icon(Icons.book_sharp, color: Colors.black),
                    labelText: 'Descrição do Curso',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  keyboardType: TextInputType.multiline,
                  maxLines: null, 
                ),
              ),
              SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: DropdownButtonFormField<String>(
                  value: TypesPublicoAlvo.publicoAlvo.contains(publicoAlvoSelecionado) ? publicoAlvoSelecionado : null,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey[100],
                    prefixIcon: Icon(Icons.people, color: Colors.black),
                    labelText: 'Público Alvo',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
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
                      infoController.publicoAlvo.text = value;
                    });
                  },
                ),
              ),
              SizedBox(height: 15),
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: TextFormField(
                        controller: duracaoNumerica,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.grey[100],
                          prefixIcon: Icon(Icons.access_time, color: Colors.black),
                          labelText: 'Duração',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        keyboardType: TextInputType.number,
                        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                        onChanged: (value) {
                          infoController.duracao.text =
                              "$value ${infoController.tipoDuracaoSelecionado}";
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 16.0),
                      child: DropdownButtonFormField<String>(
                        value: TypesDuracao.duracao.contains(infoController.tipoDuracaoSelecionado) ? infoController.tipoDuracaoSelecionado : null,
                        decoration: InputDecoration(
                          labelText: 'Unidade',
                          filled: true,
                          fillColor: Colors.grey[100],
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        items: TypesDuracao.duracao.map((tipo) {
                          return DropdownMenuItem<String>(
                            value: tipo,
                            child: Text(tipo),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            infoController.tipoDuracaoSelecionado = value!;
                            final numero = infoController.duracao.text.replaceAll(RegExp(r'\D'), '');
                            infoController.duracao.text = "$numero ${infoController.tipoDuracaoSelecionado}";
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: DropdownButtonFormField<String>(
                  value: TypesTurno.turno.contains(turnoSelecionado) ? turnoSelecionado : null,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey[100],
                    prefixIcon: Icon(Icons.nightlight_round, color: Colors.black),
                    labelText: 'Turno',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
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
                      infoController.turno.text = value;
                    });
                  },
                ),
              ),
              SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: TextFormField(
                  controller: infoController.numeroVagas,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey[100],
                    prefixIcon: Icon(
                      Icons.event_seat,
                      color: Colors.black,
                    ), 
                    labelText: 'Número de Vagas',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                ),
              ),
              SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: TextFormField(
                  controller: infoController.breveConteudo,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey[100],
                    prefixIcon: Icon(
                      Icons.list,
                      color: Colors.black,
                    ), 
                    labelText: 'Breve Conteúdo',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  keyboardType: TextInputType.multiline,
                  maxLines: null, 
                ),
              ),
              SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: TextFormField(
                  controller: infoController.enderecoWeb,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey[100],
                    prefixIcon: Icon(
                      Icons.link,
                      color: Colors.black,
                    ), 
                    labelText: 'Endereço Web',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: TextFormField(
                  controller: infoController.telefone,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey[100],
                    prefixIcon: Icon(
                      Icons.phone,
                      color: Colors.black,
                    ), 
                    labelText: 'Telefone',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 24),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: SwitchListTile(
                  title: Text("Encerrar inscrições"),
                  value: infoController.inscricoesEncerradas,
                  onChanged: (value) {
                    setState(() {
                      infoController.inscricoesEncerradas = value;
                    });
                  },
                ),
                ),
                SizedBox(height: 24),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      infoController.updateInfo(widget.info.id);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Informação atualizada com sucesso!')),
                      );
                    },
                    icon: Icon(Icons.save_alt),
                    label: Text(
                      'Salvar',
                      style: TextStyle(fontSize: 16, letterSpacing: 1),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: softBlue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
