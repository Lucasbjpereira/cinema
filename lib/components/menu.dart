import 'package:cinema/cinema.dart';
import 'package:cinema/search_cinema.dart';
import 'package:flutter/material.dart';

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
              icon: Image.asset(
                  'assets/imgs/home.png'), // Caminho para o ícone no diretório de assets
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Cinema(),
                  ),
                );
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
