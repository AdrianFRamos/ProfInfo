import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../const/colors.dart';
import '../models/informacoesModel.dart';
import '../utils/daysAgo.dart';

class FourteenScreen extends StatelessWidget {
  final InfoModel? info;
  static const routeName = "/FourteenScreen";

  const FourteenScreen({Key? key, this.info}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text(
          info?.nomeCurso ?? 'Informações',
          style: GoogleFonts.bebasNeue(
            fontSize: 35,
          ),
        ),
        backgroundColor: paleBlue,
      ),
      backgroundColor: WhiteBlue,
      body: Container(
        margin: EdgeInsets.all(10),
        child: info != null
            ? ListView(
                children: [
                  Container(
                    height: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  _buildTitle(info!.nomeCurso),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      daysAgo(info?.dateTime),
                      style: GoogleFonts.montserrat(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  Divider(),
                  SizedBox(height: 8),
                  _buildInfoRow(Icons.timer, 'Carga Horária', info!.duracao),
                  _buildInfoRow(Icons.school, 'Modalidade', info!.turno),
                  _buildInfoRow(Icons.group, 'Vagas', info!.numeroVagas),
                  _buildInfoRow(Icons.class_, 'Número de Turmas', '1 Turma'),
                  SizedBox(height: 16),
                  _buildSectionTitle('Público Alvo'),
                  _buildTextContent(info!.publicoAlvo),
                  SizedBox(height: 16),
                  _buildSectionTitle('Objetivo'),
                  _buildTextContent(info!.descricaoCurso),
                  SizedBox(height: 16),
                  _buildSectionTitle('Conteúdo'),
                  _buildTextContent(info!.breveConteudo),
                  SizedBox(height: 16),
                  _buildEnrollButton(info!.enderecoWeb),
                ],
              )
            : Center(
                child: Text('Nenhuma informação disponível.'),
              ),
      ),
    );
  }

 Widget _buildTitle(String title) {
    return Text(
      title,
      style: GoogleFonts.bebasNeue(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black87),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(icon, color: softBlue),
          SizedBox(width: 10),
          Text(
            '$label: ',
            style: GoogleFonts.montserrat(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87),
          ),
          Expanded(
            child: Text(
              value,
              style: GoogleFonts.montserrat(fontSize: 16, color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: GoogleFonts.montserrat(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: softBlue,
      ),
    );
  }

  Widget _buildTextContent(String content) {
    return Text(
      content,
      style: GoogleFonts.montserrat(fontSize: 16, color: Colors.black87),
    );
  }

  Widget _buildEnrollButton(String url) {
    return Center(
      child: info!.inscricoesEncerradas
          ? Container(
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              child: Text(
                "Inscrições Encerradas",
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              decoration: BoxDecoration(
                color: softBlue,
                borderRadius: BorderRadius.circular(8),
              ),
          )
          : ElevatedButton(
              onPressed: () => _launchWebsite(url),
              style: ElevatedButton.styleFrom(
                backgroundColor: softBlue,
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
              child: Text(
                "INSCREVA-SE",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
    );
  }

  Future<void> _launchWebsite(String url) async {
    final Uri uri = Uri.parse(url);

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Não foi possível abrir o site';
    }
  }
}
