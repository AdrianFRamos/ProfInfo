// ignore_for_file: file_names
import 'package:profinfo/screens/HomeScreen.dart';
import 'package:flutter/material.dart';

class IntroScreen extends StatelessWidget {
  static const routeName = "/introScreen";

  const IntroScreen({super.key});

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/maefilho.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left:30, top: 70),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                const Text(
                  'Bem vindo ao',
                  
                  style: TextStyle(
                    
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'E-mpodera',
                  style: TextStyle(
                    color: Colors.orange.shade900,
                    fontSize: 60,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(
                  'Um aplicativo mobile que oferece recursos, informações e suporte para empoderar mulheres.',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  softWrap: true,
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 770, 
              left: 190
            ),
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange.shade900,
              ),
              child: const Text(
                'Vamos Começar!',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              )
            ),
          )
        ],
      ),
    );
  }
}
