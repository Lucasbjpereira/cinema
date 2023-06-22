import 'package:cinema/cinema.dart';
import 'package:cinema/search_cinema.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Menu extends StatefulWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF0B0B0B),
          boxShadow: [
            BoxShadow(
              color: const Color.fromARGB(45, 0, 0, 0)
                  .withOpacity(0.1), // Cor e opacidade da sombra
              spreadRadius:
                  2, // Raio de propagação da sombra (quanto maior, mais "espalhada" ela fica)
              blurRadius: 2, // Raio de desfoque da sombra
              offset: const Offset(2, 2), // Deslocamento da sombra (x, y)
            ),
          ],
        ),
        height: 60, // Altura do menu fixo

        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              icon: Image.asset('assets/imgs/home.png'),
              onPressed: () async {
                SharedPreferences localStorage =
                    await SharedPreferences.getInstance();
                int? cinemaId = localStorage.getInt('selectedCinemaId');

                if (cinemaId == null) {
                  // ignore: use_build_context_synchronously
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return Dialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        child: Container(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Text(
                                'Aviso',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 16),
                              const Text('Você precisa selecionar um cinema.'),
                              const SizedBox(height: 16),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(context); // Fechar o diálogo
                                },
                                child: const Text('Fechar'),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                } else {
                  // ignore: use_build_context_synchronously
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Cinema(),
                    ),
                  );
                }
              },
            ),
            IconButton(
              icon: Image.asset(
                  'assets/imgs/search-cine.png'), // Caminho para o ícone no diretório de assets
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SearchCinema(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
