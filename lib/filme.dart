import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

class Filme extends StatefulWidget {
  const Filme({Key? key}) : super(key: key);

  @override
  State<Filme> createState() => _FilmeState();
}

class _FilmeState extends State<Filme> {
  late List<dynamic> _filmes;
  int _selectedDateIndex = 0;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _carregarDados();
  }

  Future<void> _carregarDados() async {
    final String data = await rootBundle.loadString('assets/db.json');
    final Map<String, dynamic> json = jsonDecode(data);
    setState(() {
      _filmes = json['cinemas'][0]['filmes'];
      _isLoading = false;
    });
  }

  void _updateSelectedDate(int id) {
    final int selectedIndex =
        _filmes[0]['sessoes'].indexWhere((sessao) => sessao['id'] == id);
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

    final filme = _filmes[0];
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 300,
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
                  Text(
                    titulo,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  _buildFilmInfoRow(genero, duracao, classificacao),
                  const SizedBox(height: 20),
                  const Text(
                    'Sinopse',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    sinopse,
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Datas disponíveis:',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  _buildDateSelector(sessoes),
                  const SizedBox(height: 20),
                  const Text(
                    'Sessões:',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  _buildSessionsList(sessoes),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilmInfoRow(
      String genero, String duracao, String classificacao) {
    return Row(
      children: [
        _buildInfoItem('Gênero', genero),
        const SizedBox(width: 10),
        _buildInfoItem('Duração', duracao),
        const SizedBox(width: 10),
        _buildInfoItem('Classificação', classificacao),
      ],
    );
  }

  Widget _buildInfoItem(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          value,
          style: const TextStyle(fontSize: 14),
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
                        ? Colors.blue
                        : Colors.grey[300],
                  ),
                  child: Text(
                    entry.value['data'],
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
        Text(
          sessoes[_selectedDateIndex]['data'],
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
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
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey[200],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            sala['nome'],
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            'Dublado: ${sala['dublado'] ? 'Sim' : 'Não'}',
            style: const TextStyle(fontSize: 14),
          ),
          Text(
            '3D: ${sala['3d'] ? 'Sim' : 'Não'}',
            style: const TextStyle(fontSize: 14),
          ),
          const SizedBox(height: 5),
          Wrap(
            spacing: 10,
            children: sala['horarios']
                .map<Widget>((horario) => Chip(
                      label: Text(horario['horario']),
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }
}
