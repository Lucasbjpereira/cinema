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
  String? selectedRegion;
  List<dynamic> regionsData = [];

  @override
  void initState() {
    super.initState();
    loadCinemasData();
    loadRegionsData();
    initializeSharedPreferences();
  }

  Future<void> loadCinemasData() async {
    final jsonString = await rootBundle.loadString('assets/db.json');
    final data = jsonDecode(jsonString);
    setState(() {
      cinemasData = data['cinemas'];
    });
  }

  Future<void> loadRegionsData() async {
    final jsonString = await rootBundle.loadString('assets/regioes.json');
    final data = jsonDecode(jsonString);
    setState(() {
      regionsData = data['regioes'];
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

  void selectRegion(String? regionName) {
    setState(() {
      selectedRegion = regionName;
    });
  }

  void openRegionModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          color: const Color(0xFF111111),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
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
              DropdownButton<String>(
                value: selectedRegion,
                hint: const Text('Selecione uma região'),
                dropdownColor: const Color(0xFF111111),
                style: const TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFFD9D9D9),
                ),
                items: regionsData.map((region) {
                  final String regionName = region['name'];
                  return DropdownMenuItem<String>(
                    value: regionName,
                    child: Text(regionName),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    //set state will update UI and State of your App
                    selectedRegion = newValue.toString();
                  });
                  selectRegion(newValue);
                  Navigator.pop(context);
                  openRegionModal(context);
                },
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Salvar Região'),
              ),
            ],
          ),
        );
      },
    );
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
                    GestureDetector(
                      onTap: () {
                        openRegionModal(context);
                      },
                      child: const Align(
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
                                                selectedCinemaId == cinemaId
                                                    ? const Color(0xFF590A0A)
                                                    : const Color(0xFF111111),
                                            side: const BorderSide(
                                              width: 2,
                                              color: Color(0xFF590A0A),
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
