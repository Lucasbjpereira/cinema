import 'package:flutter/material.dart';

class Header extends StatefulWidget {
  const Header({super.key});

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
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
                      borderRadius:
                          BorderRadius.circular(200), // Raio dos cantos
                      boxShadow: [
                        BoxShadow(
                          color: const Color.fromARGB(255, 19, 19, 19)
                              .withOpacity(0.5), // Cor e opacidade da sombra
                          spreadRadius: 2, // Raio de propagação da sombra
                          blurRadius: 4, // Raio de desfoque da sombra
                          offset: const Offset(
                              0, 2), // Deslocamento da sombra (x, y)
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(6), // Raio dos cantos
                      child: Image.network(
                        fit: BoxFit.cover,
                        'https://www.animalucas.com/wp-content/uploads/2017/08/cineroxy.jpg', // URL da imagem desejada
                      ),
                    ),
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
      ),
    );
  }
}
