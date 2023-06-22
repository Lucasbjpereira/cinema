import 'dart:convert';
import 'package:cinema/sessions.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Header extends StatefulWidget {
  const Header({super.key});

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  String _image = '';
  late int cinemaId;

  @override
  void initState() {
    super.initState();
    loadCinemasData();
  }

  Future<void> loadCinemasData() async {
    SharedPreferences? localStorage;
    localStorage = await SharedPreferences.getInstance();
    int? cinemaId = localStorage.getInt('selectedCinemaId');

    final jsonString = await rootBundle.loadString('assets/db.json');
    final data = jsonDecode(jsonString);

    for (var cinema in data['cinemas']) {
      if (cinema['id'] == cinemaId) {
        setState(() {
          _image = cinema['image'];
        });
        break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 11),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 42,
                  width: 42,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(200), // Raio dos cantos
                    boxShadow: [
                      BoxShadow(
                        color: const Color.fromARGB(255, 19, 19, 19)
                            .withOpacity(0.5), // Cor e opacidade da sombra
                        spreadRadius: 2, // Raio de propagação da sombra
                        blurRadius: 4, // Raio de desfoque da sombra
                        offset:
                            const Offset(0, 2), // Deslocamento da sombra (x, y)
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(6), // Raio dos cantos
                    child: Image.network(
                      fit: BoxFit.cover,
                      _image,
                    ),
                  ),
                ),
                const Spacer(),
                IconButton(
                  icon: Image.asset(
                      'assets/imgs/sessions.png'), // Caminho para o ícone no diretório de assets
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Sessions(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
        const Divider(
          color: Color(0xFFD1D1D1), // Cor da linha (opcional)
          thickness: 2, // Espessura da linha (opcional)
        )
      ],
    );
  }
}
