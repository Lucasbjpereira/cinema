import 'package:carousel_slider/carousel_slider.dart';
import 'package:cinema/components/header.dart';
import 'package:cinema/components/menu.dart';
import 'package:cinema/components/pesquisa.dart';
import 'package:flutter/material.dart';

class Cinema extends StatefulWidget {
  const Cinema({super.key});

  @override
  State<Cinema> createState() => _CinemaState();
}

class _CinemaState extends State<Cinema> {
  int _currentSlideIndex = 0;
  String _currentCategory = 'Em cartaz';

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
                padding: const EdgeInsets.all(11.0),
                child: Column(
                  children: [
                    const Pesquisa(),
                    const SizedBox(
                      height: 10,
                    ),
                    Stack(
                      children: [
                        CarouselSlider(
                          options: CarouselOptions(
                            height: 250,
                            viewportFraction: 1.0,
                            enableInfiniteScroll: true,
                            autoPlay: true,
                            onPageChanged: (index, reason) {
                              setState(() {
                                _currentSlideIndex = index;
                              });
                            },
                          ),
                          items: [
                            'https://placeimg.com/640/480/nature',
                            'https://placeimg.com/640/480/arch',
                            'https://placeimg.com/640/480/animals',
                            'https://placeimg.com/640/480/people',
                          ].map((item) {
                            return Container(
                              margin: const EdgeInsets.all(5.0),
                              child: ClipRRect(
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(10.0)),
                                child: Image.network(
                                  item,
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                        Positioned(
                          left: 0,
                          right: 0,
                          bottom: 16.0,
                          child: Container(
                            alignment: Alignment.center,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: List.generate(4, (index) {
                                return Container(
                                  width: 10.0,
                                  height: 10.0,
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 4.0),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: _currentSlideIndex == index
                                        ? Colors.red
                                        : Colors.grey,
                                  ),
                                );
                              }),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: _currentCategory == 'Em cartaz'
                                ? Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      color: const Color(0xFF590A0A),
                                    ),
                                    child: TextButton(
                                      onPressed: () {
                                        setState(() {
                                          _currentCategory = 'Em cartaz';
                                        });
                                      },
                                      child: const Text(
                                        'Em cartaz',
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  )
                                : Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      border: Border.all(
                                        color: const Color(0xFF590A0A),
                                      ),
                                    ),
                                    child: TextButton(
                                      onPressed: () {
                                        setState(() {
                                          _currentCategory = 'Em cartaz';
                                        });
                                      },
                                      child: const Text(
                                        'Em cartaz',
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: _currentCategory == 'Em breve'
                                ? Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      color: const Color(0xFF590A0A),
                                    ),
                                    child: TextButton(
                                      onPressed: () {
                                        setState(() {
                                          _currentCategory = 'Em breve';
                                        });
                                      },
                                      child: const Text(
                                        'Em breve',
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  )
                                : Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      border: Border.all(
                                        color: const Color(0xFF590A0A),
                                      ),
                                    ),
                                    child: TextButton(
                                      onPressed: () {
                                        setState(() {
                                          _currentCategory = 'Em breve';
                                        });
                                      },
                                      child: const Text(
                                        'Em breve',
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    _currentCategory == 'Em cartaz'
                        ? _buildEmCartazCards()
                        : _buildEmBreveCards(),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ],
          ),
          const Menu(),
        ],
      ),
    );
  }

  Widget _buildEmCartazCards() {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: 2, // Defina o número de seções aqui
      itemBuilder: (context, sectionIndex) {
        return GridView.count(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          crossAxisCount: 2,
          childAspectRatio: 0.7, // Defina a proporção dos cards aqui
          crossAxisSpacing: 25, // Espaçamento horizontal entre os itens
          mainAxisSpacing: 15, // Espaçamento vertical entre os itens
          children: List.generate(2, (index) {
            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image.network(
                      'https://placeimg.com/640/480/nature',
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Título do Filme',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color.fromARGB(255, 255, 255, 255),
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            );
          }),
        );
      },
    );
  }

  Widget _buildEmBreveCards() {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: 2, // Defina o número de seções aqui
      itemBuilder: (context, sectionIndex) {
        return GridView.count(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          crossAxisCount: 2,
          childAspectRatio: 0.7, // Defina a proporção dos cards aqui
          crossAxisSpacing:
              25, // Espaçamento horizontal entre os itens Espaçamento vertical
          children: List.generate(2, (index) {
            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image.network(
                      'https://placeimg.com/640/480/nature',
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Em breve',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color.fromARGB(255, 255, 255, 255),
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            );
          }),
        );
      },
    );
  }
}
