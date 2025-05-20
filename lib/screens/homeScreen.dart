import 'package:profinfo/const/types.dart';
import 'package:profinfo/screens/secondScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:profinfo/widgets/bottomBarWidget.dart';
import '../const/colors.dart';
import '../controllers/infoController.dart';
import '../models/informacoesModel.dart';
import '../widgets/grandAreaWidget.dart';
import '../widgets/homeBarWidget.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = "/HomeScreen";

  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final InfoController infoController = Get.find<InfoController>();
  final TextEditingController searchController = TextEditingController();
  final FocusNode searchFocusNode = FocusNode();
  final List<String> ordemTipos = TypesCursos.tiposCurso;
  bool showSearchField = false;
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    searchFocusNode.addListener(() {
      if (!searchFocusNode.hasFocus) {
        setState(() {
          showSearchField = false;
        });
      }
    });
  }

  @override
  void dispose() {
    searchFocusNode.dispose();
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final InfoController infoController = InfoController.instance;

    return Scaffold(
      appBar: HomeAppBar(),
      drawer: Drawer(
        child: FutureBuilder<List<String>>(
          future: infoController.getNewTipo(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Erro ao carregar notificações'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return ListView(
                padding: EdgeInsets.zero,
                children: [
                  DrawerHeader(
                    decoration: BoxDecoration(
                      color: paleBlue,
                    ),
                    child: Text(
                      'Notificações',
                      style: GoogleFonts.montserrat(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  ListTile(
                    title: Text('Nenhuma nova informação adicionada'),
                  ),
                ],
              );
            } else {
              final newTipo = snapshot.data!;
              return ListView(
                padding: EdgeInsets.zero,
                children: [
                  DrawerHeader(
                    decoration: BoxDecoration(
                      color: paleBlue,
                    ),
                    child: Text(
                      'Notificações',
                      style: GoogleFonts.montserrat(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  ...newTipo.map((tipo) {
                    return ListTile(
                      title: Text('Nova Informação Adicionada: $tipo'),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SecondScreen(tipo: tipo),
                          ),
                        );
                        infoController.markNotificationsAsRead();
                        Navigator.pop(context); 
                      },
                    );
                  }).toList(),
                ],
              );
            }
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: WhiteBlue,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      if (showSearchField) {
                        setState(() {
                          showSearchField = false;
                        });
                      }
                    },
                    child: Container(
                      color: WhiteBlue,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 16),
                            Center(
                              child: TextButton(
                                onPressed: () {
                                  setState(() {
                                    showSearchField = true;
                                    searchFocusNode.requestFocus();
                                  });
                                },
                                child: Text(
                                  'Em que podemos ajudar?',
                                  style: GoogleFonts.montserrat(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            if (showSearchField)
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8.0),
                                child: TextField(
                                  controller: searchController,
                                  focusNode: searchFocusNode,
                                  decoration: InputDecoration(
                                    labelText: 'Pesquisar',
                                    border: OutlineInputBorder(),
                                    suffixIcon: Icon(Icons.search),
                                  ),
                                  onChanged: (value) {
                                    setState(() {
                                      searchQuery = value.toLowerCase();
                                    });
                                    debugPrint("Search Query: $searchQuery"); 
                                  },
                                ),
                              ),
                            SizedBox(height: 16),
                            Obx(() {
                              if (infoController.refreshData.value) {
                                return FutureBuilder<List<InfoModel>>(
                                future: searchQuery.isEmpty
                                    ? infoController.allInfo()
                                    : infoController.searchInfo(searchQuery).then((result) {
                                        debugPrint("Resultado da API para '$searchQuery': ${result.map((e) => e.tipo).toList()}");
                                        return result;
                                      }),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState == ConnectionState.waiting) {
                                    return Center(child: CircularProgressIndicator());
                                  } else if (snapshot.hasError) {
                                    return Center(child: Text('Erro ao carregar dados'));
                                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                                    return Center(child: Text('Nenhuma informação disponível'));
                                  } else {
                                    final informacoes = snapshot.data!;
                                    final tiposEncontrados = informacoes
                                        .map((info) => info.tipo)
                                        .where((tipo) => tipo.toLowerCase().contains(searchQuery))
                                        .toSet()
                                        .toList();

                                    // Ordena os tipos conforme a ordem desejada
                                    tiposEncontrados.sort((a, b) {
                                      int indexA = ordemTipos.indexOf(a);
                                      int indexB = ordemTipos.indexOf(b);

                                      if (indexA == -1) indexA = 999; // Itens não listados na ordem vão pro final
                                      if (indexB == -1) indexB = 999;

                                      return indexA.compareTo(indexB);
                                    });

                                    return Wrap(
                                      spacing: 8,
                                      runSpacing: 8,
                                      children: tiposEncontrados.map((tipo) => buildGridItem(tipo)).toList(),
                                    );
                                  }
                                },
                              );
                              } else if (infoController.refreshData.value == false) {
                                return Center(child: Text('Nenhuma informação disponível'));
                              } else {
                                return Center(child: CircularProgressIndicator());
                              }
                            }),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomBarWidget(),
    );
  }
}
