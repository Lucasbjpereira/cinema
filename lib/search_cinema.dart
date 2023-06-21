import 'package:cinema/components/header.dart';
import 'package:cinema/components/menu.dart';
import 'package:cinema/components/pesquisa.dart';
import 'package:flutter/material.dart';

class SearchCinema extends StatefulWidget {
  const SearchCinema({super.key});

  @override
  State<SearchCinema> createState() => _SearchCinemaState();
}

class _SearchCinemaState extends State<SearchCinema> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF111111),
      body: Stack(
        children: [
          ListView(
            children: [
              const Header(),
              Padding(
                padding: const EdgeInsets.all(22.0),
                child: Column(
                  children: [
                    const Pesquisa(),
                    const SizedBox(
                      height: 10,
                    ),
                    const Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        'Filtrar por região',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFFD9D9D9),
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 105,
                              height: 105,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                    200), // Raio dos cantos
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color.fromARGB(45, 0, 0, 0)
                                        .withOpacity(
                                            0.1), // Cor e opacidade da sombra
                                    spreadRadius:
                                        2, // Raio de propagação da sombra
                                    blurRadius: 2, // Raio de desfoque da sombra
                                    offset: const Offset(
                                        2, 2), // Deslocamento da sombra (x, y)
                                  ),
                                ],
                              ),
                              child: ClipRRect(
                                borderRadius:
                                    BorderRadius.circular(6), // Raio dos cantos
                                child: Image.network(
                                  fit: BoxFit.cover,
                                  'https://www.animalucas.com/wp-content/uploads/2017/08/cineroxy.jpg', // URL da imagem desejada
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Cine Roxy 6 D+',
                                    style: TextStyle(
                                      fontFamily: 'Inter',
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      color: Color(0xFFD9D9D9),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  const Text(
                                    'Rua Frei Gaspar 365, São Vicente, SP, 11310-935',
                                    softWrap: true,
                                    maxLines: 2,
                                    style: TextStyle(
                                      fontFamily: 'Inter',
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xFFD9D9D9),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  SizedBox(
                                    width: double.infinity,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: const Color(
                                            0xFF111111), // Cor de fundo vermelho
                                        side: const BorderSide(
                                          width: 2, // Largura da borda
                                          color:
                                              Color(0xFF590A0A), // Cor da borda
                                        ),
                                      ),
                                      onPressed: () {},
                                      child: const Text('Selecionar'),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Row(
                          children: [
                            Container(
                              width: 105,
                              height: 105,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                    200), // Raio dos cantos
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color.fromARGB(45, 0, 0, 0)
                                        .withOpacity(
                                            0.1), // Cor e opacidade da sombra
                                    spreadRadius:
                                        2, // Raio de propagação da sombra
                                    blurRadius: 2, // Raio de desfoque da sombra
                                    offset: const Offset(
                                        2, 2), // Deslocamento da sombra (x, y)
                                  ),
                                ],
                              ),
                              child: ClipRRect(
                                borderRadius:
                                    BorderRadius.circular(6), // Raio dos cantos
                                child: Image.network(
                                  fit: BoxFit.cover,
                                  'https://www.animalucas.com/wp-content/uploads/2017/08/cineroxy.jpg', // URL da imagem desejada
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Cine Roxy 6 D+',
                                    style: TextStyle(
                                      fontFamily: 'Inter',
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      color: Color(0xFFD9D9D9),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  const Text(
                                    'Rua Frei Gaspar 365, São Vicente, SP, 11310-935',
                                    softWrap: true,
                                    maxLines: 2,
                                    style: TextStyle(
                                      fontFamily: 'Inter',
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xFFD9D9D9),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  SizedBox(
                                    width: double.infinity,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: const Color(
                                            0xFF111111), // Cor de fundo vermelho
                                        side: const BorderSide(
                                          width: 2, // Largura da borda
                                          color:
                                              Color(0xFF590A0A), // Cor da borda
                                        ),
                                      ),
                                      onPressed: () {},
                                      child: const Text('Selecionar'),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Row(
                          children: [
                            Container(
                              width: 105,
                              height: 105,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                    200), // Raio dos cantos
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color.fromARGB(45, 0, 0, 0)
                                        .withOpacity(
                                            0.1), // Cor e opacidade da sombra
                                    spreadRadius:
                                        2, // Raio de propagação da sombra
                                    blurRadius: 2, // Raio de desfoque da sombra
                                    offset: const Offset(
                                        2, 2), // Deslocamento da sombra (x, y)
                                  ),
                                ],
                              ),
                              child: ClipRRect(
                                borderRadius:
                                    BorderRadius.circular(6), // Raio dos cantos
                                child: Image.network(
                                  fit: BoxFit.cover,
                                  'https://www.animalucas.com/wp-content/uploads/2017/08/cineroxy.jpg', // URL da imagem desejada
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Cine Roxy 6 D+',
                                    style: TextStyle(
                                      fontFamily: 'Inter',
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      color: Color(0xFFD9D9D9),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  const Text(
                                    'Rua Frei Gaspar 365, São Vicente, SP, 11310-935',
                                    softWrap: true,
                                    maxLines: 2,
                                    style: TextStyle(
                                      fontFamily: 'Inter',
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xFFD9D9D9),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  SizedBox(
                                    width: double.infinity,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: const Color(
                                            0xFF111111), // Cor de fundo vermelho
                                        side: const BorderSide(
                                          width: 2, // Largura da borda
                                          color:
                                              Color(0xFF590A0A), // Cor da borda
                                        ),
                                      ),
                                      onPressed: () {},
                                      child: const Text('Selecionar'),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Row(
                          children: [
                            Container(
                              width: 105,
                              height: 105,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                    200), // Raio dos cantos
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color.fromARGB(45, 0, 0, 0)
                                        .withOpacity(
                                            0.1), // Cor e opacidade da sombra
                                    spreadRadius:
                                        2, // Raio de propagação da sombra
                                    blurRadius: 2, // Raio de desfoque da sombra
                                    offset: const Offset(
                                        2, 2), // Deslocamento da sombra (x, y)
                                  ),
                                ],
                              ),
                              child: ClipRRect(
                                borderRadius:
                                    BorderRadius.circular(6), // Raio dos cantos
                                child: Image.network(
                                  fit: BoxFit.cover,
                                  'https://www.animalucas.com/wp-content/uploads/2017/08/cineroxy.jpg', // URL da imagem desejada
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Cine Roxy 6 D+',
                                    style: TextStyle(
                                      fontFamily: 'Inter',
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      color: Color(0xFFD9D9D9),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  const Text(
                                    'Rua Frei Gaspar 365, São Vicente, SP, 11310-935',
                                    softWrap: true,
                                    maxLines: 2,
                                    style: TextStyle(
                                      fontFamily: 'Inter',
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xFFD9D9D9),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  SizedBox(
                                    width: double.infinity,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: const Color(
                                            0xFF111111), // Cor de fundo vermelho
                                        side: const BorderSide(
                                          width: 2, // Largura da borda
                                          color:
                                              Color(0xFF590A0A), // Cor da borda
                                        ),
                                      ),
                                      onPressed: () {},
                                      child: const Text('Selecionar'),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Row(
                          children: [
                            Container(
                              width: 105,
                              height: 105,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                    200), // Raio dos cantos
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color.fromARGB(45, 0, 0, 0)
                                        .withOpacity(
                                            0.1), // Cor e opacidade da sombra
                                    spreadRadius:
                                        2, // Raio de propagação da sombra
                                    blurRadius: 2, // Raio de desfoque da sombra
                                    offset: const Offset(
                                        2, 2), // Deslocamento da sombra (x, y)
                                  ),
                                ],
                              ),
                              child: ClipRRect(
                                borderRadius:
                                    BorderRadius.circular(6), // Raio dos cantos
                                child: Image.network(
                                  fit: BoxFit.cover,
                                  'https://www.animalucas.com/wp-content/uploads/2017/08/cineroxy.jpg', // URL da imagem desejada
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Cine Roxy 6 D+',
                                    style: TextStyle(
                                      fontFamily: 'Inter',
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      color: Color(0xFFD9D9D9),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  const Text(
                                    'Rua Frei Gaspar 365, São Vicente, SP, 11310-935',
                                    softWrap: true,
                                    maxLines: 2,
                                    style: TextStyle(
                                      fontFamily: 'Inter',
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xFFD9D9D9),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  SizedBox(
                                    width: double.infinity,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: const Color(
                                            0xFF111111), // Cor de fundo vermelho
                                        side: const BorderSide(
                                          width: 2, // Largura da borda
                                          color:
                                              Color(0xFF590A0A), // Cor da borda
                                        ),
                                      ),
                                      onPressed: () {},
                                      child: const Text('Selecionar'),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Row(
                          children: [
                            Container(
                              width: 105,
                              height: 105,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                    200), // Raio dos cantos
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color.fromARGB(45, 0, 0, 0)
                                        .withOpacity(
                                            0.1), // Cor e opacidade da sombra
                                    spreadRadius:
                                        2, // Raio de propagação da sombra
                                    blurRadius: 2, // Raio de desfoque da sombra
                                    offset: const Offset(
                                        2, 2), // Deslocamento da sombra (x, y)
                                  ),
                                ],
                              ),
                              child: ClipRRect(
                                borderRadius:
                                    BorderRadius.circular(6), // Raio dos cantos
                                child: Image.network(
                                  fit: BoxFit.cover,
                                  'https://www.animalucas.com/wp-content/uploads/2017/08/cineroxy.jpg', // URL da imagem desejada
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Cine Roxy 6 D+',
                                    style: TextStyle(
                                      fontFamily: 'Inter',
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      color: Color(0xFFD9D9D9),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  const Text(
                                    'Rua Frei Gaspar 365, São Vicente, SP, 11310-935',
                                    softWrap: true,
                                    maxLines: 2,
                                    style: TextStyle(
                                      fontFamily: 'Inter',
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xFFD9D9D9),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  SizedBox(
                                    width: double.infinity,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: const Color(
                                            0xFF111111), // Cor de fundo vermelho
                                        side: const BorderSide(
                                          width: 2, // Largura da borda
                                          color:
                                              Color(0xFF590A0A), // Cor da borda
                                        ),
                                      ),
                                      onPressed: () {},
                                      child: const Text('Selecionar'),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Row(
                          children: [
                            Container(
                              width: 105,
                              height: 105,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                    200), // Raio dos cantos
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color.fromARGB(45, 0, 0, 0)
                                        .withOpacity(
                                            0.1), // Cor e opacidade da sombra
                                    spreadRadius:
                                        2, // Raio de propagação da sombra
                                    blurRadius: 2, // Raio de desfoque da sombra
                                    offset: const Offset(
                                        2, 2), // Deslocamento da sombra (x, y)
                                  ),
                                ],
                              ),
                              child: ClipRRect(
                                borderRadius:
                                    BorderRadius.circular(6), // Raio dos cantos
                                child: Image.network(
                                  fit: BoxFit.cover,
                                  'https://www.animalucas.com/wp-content/uploads/2017/08/cineroxy.jpg', // URL da imagem desejada
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Cine Roxy 6 D+',
                                    style: TextStyle(
                                      fontFamily: 'Inter',
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      color: Color(0xFFD9D9D9),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  const Text(
                                    'Rua Frei Gaspar 365, São Vicente, SP, 11310-935',
                                    softWrap: true,
                                    maxLines: 2,
                                    style: TextStyle(
                                      fontFamily: 'Inter',
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xFFD9D9D9),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  SizedBox(
                                    width: double.infinity,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: const Color(
                                            0xFF111111), // Cor de fundo vermelho
                                        side: const BorderSide(
                                          width: 2, // Largura da borda
                                          color:
                                              Color(0xFF590A0A), // Cor da borda
                                        ),
                                      ),
                                      onPressed: () {},
                                      child: const Text('Selecionar'),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Row(
                          children: [
                            Container(
                              width: 105,
                              height: 105,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                    200), // Raio dos cantos
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color.fromARGB(45, 0, 0, 0)
                                        .withOpacity(
                                            0.1), // Cor e opacidade da sombra
                                    spreadRadius:
                                        2, // Raio de propagação da sombra
                                    blurRadius: 2, // Raio de desfoque da sombra
                                    offset: const Offset(
                                        2, 2), // Deslocamento da sombra (x, y)
                                  ),
                                ],
                              ),
                              child: ClipRRect(
                                borderRadius:
                                    BorderRadius.circular(6), // Raio dos cantos
                                child: Image.network(
                                  fit: BoxFit.cover,
                                  'https://www.animalucas.com/wp-content/uploads/2017/08/cineroxy.jpg', // URL da imagem desejada
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Cine Roxy 6 D+',
                                    style: TextStyle(
                                      fontFamily: 'Inter',
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      color: Color(0xFFD9D9D9),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  const Text(
                                    'Rua Frei Gaspar 365, São Vicente, SP, 11310-935',
                                    softWrap: true,
                                    maxLines: 2,
                                    style: TextStyle(
                                      fontFamily: 'Inter',
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xFFD9D9D9),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  SizedBox(
                                    width: double.infinity,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: const Color(
                                            0xFF111111), // Cor de fundo vermelho
                                        side: const BorderSide(
                                          width: 2, // Largura da borda
                                          color:
                                              Color(0xFF590A0A), // Cor da borda
                                        ),
                                      ),
                                      onPressed: () {},
                                      child: const Text('Selecionar'),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 60,
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          const Menu(),
        ],
      ),
    );
  }
}
