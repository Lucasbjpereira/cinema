import 'package:carousel_slider/carousel_slider.dart';
import 'package:cinema/components/header.dart';
import 'package:cinema/components/pesquisa.dart';
import 'package:flutter/material.dart';

class Cinema extends StatefulWidget {
  const Cinema({super.key});

  @override
  State<Cinema> createState() => _CinemaState();
}

class _CinemaState extends State<Cinema> {
  final List<String> imageUrls = [
    'https://example.com/image1.jpg',
    'https://example.com/image2.jpg',
    'https://example.com/image3.jpg',
  ];

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
                    CarouselSlider(
                      options: CarouselOptions(
                        height: 300.0,
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
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10.0)),
                              child: Image.network(
                                item,
                                fit: BoxFit.cover,
                                width: 1000.0,
                              ),
                            ));
                      }).toList(),
                    )
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
