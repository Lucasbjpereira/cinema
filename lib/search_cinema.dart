import 'dart:convert';
import 'package:cinema/components/header.dart';
import 'package:cinema/components/menu.dart';
import 'package:cinema/components/pesquisa.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SearchCinema extends StatefulWidget {
  const SearchCinema({Key? key}) : super(key: key);

  @override
  State<SearchCinema> createState() => _SearchCinemaState();
}

class _SearchCinemaState extends State<SearchCinema> {
  List<dynamic> cinemasData = [];
  int? selectedCinemaId;
  SharedPreferences? localStorage;

  @override
  void initState() {
    super.initState();
    loadCinemasData();
    initializeSharedPreferences();
  }

  Future<void> loadCinemasData() async {
    final jsonString = await rootBundle.loadString('assets/db.json');
    final data = jsonDecode(jsonString);
    setState(() {
      cinemasData = data['cinemas'];
    });
  }

  void initializeSharedPreferences() async {
    localStorage = await SharedPreferences.getInstance();
    setState(() {
      selectedCinemaId = localStorage!.getInt('selectedCinemaId');
    });
  }

  void selectCinema(int cinemaId) {
    setState(() {
      selectedCinemaId = cinemaId;
      localStorage!.setInt('selectedCinemaId', cinemaId);
    });
  }

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
                      children: cinemasData.map((cinema) {
                        final int cinemaId = cinema['id'];
                        final String name = cinema['name'];
                        final String address = cinema['endereco'];
                        final String imageUrl = cinema['image'];

                        return Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 105,
                                  height: 105,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(200),
                                    boxShadow: [
                                      BoxShadow(
                                        color: const Color.fromARGB(45, 0, 0, 0)
                                            .withOpacity(0.1),
                                        spreadRadius: 2,
                                        blurRadius: 2,
                                        offset: const Offset(2, 2),
                                      ),
                                    ],
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(6),
                                    child: Image.network(
                                      imageUrl,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        name,
                                        style: const TextStyle(
                                          fontFamily: 'Inter',
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700,
                                          color: Color(0xFFD9D9D9),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        address,
                                        softWrap: true,
                                        maxLines: 2,
                                        style: const TextStyle(
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
                                            backgroundColor:
                                                const Color(0xFF111111),
                                            side: BorderSide(
                                              width: 2,
                                              color:
                                                  selectedCinemaId == cinemaId
                                                      ? const Color(0xFF590A0A)
                                                      : Colors.transparent,
                                            ),
                                          ),
                                          onPressed: () {
                                            selectCinema(cinemaId);
                                          },
                                          child: Text(
                                            selectedCinemaId == cinemaId
                                                ? 'Selecionado'
                                                : 'Selecionar',
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                          ],
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
            ],
          ),
          const Menu(),
        ],
      ),
    );
  }
}
