import 'dart:convert';
import 'package:cinema/components/menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Filme extends StatefulWidget {
  const Filme({Key? key}) : super(key: key);

  @override
  State<Filme> createState() => _filmetate();
}

// ignore: camel_case_types
class _filmetate extends State<Filme> {
  List<dynamic> _filme = []; // Initialize as an empty list
  int _selectedDateIndex = 0;
  bool _isLoading = true;
  late int cinemaId;
  late int filmeId;

  @override
  void initState() {
    super.initState();
    _carregarDados();
  }

  Future<void> _carregarDados() async {
    final String data = await rootBundle.loadString('assets/db.json');
    final Map<String, dynamic> json = jsonDecode(data);
    SharedPreferences? localStorage;
    localStorage = await SharedPreferences.getInstance();
    cinemaId = localStorage.getInt('selectedCinemaId') ?? 0;
    filmeId = localStorage.getInt('selectedMovieId') ?? 0;

    for (var cinema in json['cinemas']) {
      if (cinema['id'] == cinemaId) {
        for (var filme in cinema['filmes']) {
          if (filme['id'] == filmeId) {
            setState(() {
              _filme = [filme];
              _isLoading = false;
            });
            break;
          }
        }
      }
    }
  }

  void _updateSelectedDate(int id) {
    final int selectedIndex =
        _filme[0]['sessoes'].indexWhere((sessao) => sessao['id'] == id);
    setState(() {
      _selectedDateIndex = selectedIndex != -1 ? selectedIndex : 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    final Map<String, dynamic> filme = _filme[0];
    _filme[0];
    final String imageUrl = filme['image'];
    final String titulo = filme['name'];
    final String genero = filme['genero'];
    final String duracao = filme['duracao'];
    final String classificacao = filme['classificacao'];
    final String sinopse = filme['sinopse'];
    final List<Map<String, dynamic>> sessoes =
        List<Map<String, dynamic>>.from(filme['sessoes']);

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: const Color(0xFF1E1E1E),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              children: [
                Container(
                  height: 450,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(imageUrl),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Text(
                              titulo,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                              child: _buildFilmInfoRow(
                                  genero, duracao, classificacao)),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Sinopse',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          const SizedBox(
                              height:
                                  10), // Espaçamento entre o texto e o underline
                          Container(
                            width: double.infinity,
                            height: 2,
                            color: const Color(0xFF6FBEFC),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Text(
                        sinopse,
                        textAlign: TextAlign.justify,
                        style:
                            const TextStyle(fontSize: 16, color: Colors.white),
                      ),
                      const SizedBox(height: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Programação:',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          const SizedBox(
                              height:
                                  10), // Espaçamento entre o texto e o underline
                          Container(
                            width: double.infinity,
                            height: 2,
                            color: const Color(0xFF6FBEFC),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      _buildDateSelector(sessoes),
                      const SizedBox(height: 20),
                      _buildSessionsList(sessoes),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: const SizedBox(
        height: 60, // Defina a altura desejada para o menu
        child: Menu(),
      ),
    );
  }

  Widget _buildFilmInfoRow(
      String genero, String duracao, String classificacao) {
    Color getClassificationColor(String classification) {
      int? classificationInt = int.tryParse(classification);
      if (classificationInt != null) {
        if (classificationInt >= 18) {
          return Colors.red;
        } else if (classificationInt >= 12) {
          return const Color(0xFFFF9600);
        }
      }
      return Colors.green;
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildInfoItem(genero),
        _buildVerticalDivider(),
        _buildInfoItem(duracao),
        _buildVerticalDivider(),
        Container(
          decoration: BoxDecoration(
            color: getClassificationColor(classificacao),
            borderRadius: BorderRadius.circular(5),
          ),
          padding: const EdgeInsets.all(5),
          child: Text(
            classificacao,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildVerticalDivider() {
    return Container(
      height: 8,
      width: 1,
      color: Colors.white,
      margin: const EdgeInsets.symmetric(horizontal: 10),
    );
  }

  Widget _buildInfoItem(String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          value,
          style: const TextStyle(fontSize: 16, color: Colors.white),
        ),
      ],
    );
  }

  Widget _buildDateSelector(List<Map<String, dynamic>> sessoes) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: sessoes
            .asMap()
            .entries
            .map(
              (entry) => GestureDetector(
                onTap: () {
                  _updateSelectedDate(entry.value['id']);
                },
                child: Container(
                  margin: const EdgeInsets.only(right: 10),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: entry.key == _selectedDateIndex
                        ? const Color(0xFF6FBEFC)
                        : Colors.grey[300],
                  ),
                  child: Text(
                    DateFormat('dd/MM')
                        .format(DateTime.parse(entry.value['data'])),
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: entry.key == _selectedDateIndex
                          ? FontWeight.bold
                          : FontWeight.normal,
                      color: entry.key == _selectedDateIndex
                          ? Colors.white
                          : Colors.black,
                    ),
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }

  Widget _buildSessionsList(List<Map<String, dynamic>> sessoes) {
    final List<dynamic> selectedSessoes = sessoes[_selectedDateIndex]['salas'];

    return Column(
      children: [
        Column(
          children: selectedSessoes
              .map<Widget>((sala) => _buildSessionItem(sala))
              .toList(),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildSessionItem(Map<String, dynamic> sala) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: const Color.fromARGB(192, 17, 17, 17),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            sala['nome'],
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            'Dublado: ${sala['dublado'] ? 'Sim' : 'Não'}',
            style: const TextStyle(fontSize: 14, color: Colors.white),
          ),
          Text(
            '3D: ${sala['3d'] ? 'Sim' : 'Não'}',
            style: const TextStyle(fontSize: 14, color: Colors.white),
          ),
          const SizedBox(height: 5),
          Wrap(
            spacing: 10,
            children: sala['horarios']
                .map<Widget>((horario) => Chip(
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(5), // Define o raio desejado
                      ),
                      backgroundColor: const Color(0xFF590A0A),
                      labelStyle: const TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                      ),
                      label: Text(horario['horario']),
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }
}
