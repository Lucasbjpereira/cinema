import 'package:flutter/material.dart';

class Filme extends StatefulWidget {
  const Filme({super.key});

  @override
  State<Filme> createState() => _FilmeState();
}

class _FilmeState extends State<Filme> {
// Variáveis fictícias para simular os dados do filme
  final String _imageUrl =
      'https://example.com/filme.jpg'; // URL da imagem fictícia
  final String _titulo = 'Título do Filme';
  final String _genero = 'Ação';
  final String _duracao = '2h 30min';
  final String _classificacao = '18+';
  final String _sinopse =
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed commodo aliquam neque vitae vulputate.';
  final List<String> _datas = ['22/05', '23/05', '24/05'];
  final List<Map<String, dynamic>> _sessoes = [
    {
      'sala': 'Sala 1',
      'idioma': 'Dublado',
      'horarios': ['10:00', '12:30', '15:00']
    },
    {
      'sala': 'Sala 2',
      'idioma': 'Legendado',
      'horarios': ['11:00', '13:30', '16:00']
    },
    {
      'sala': 'Sala 3',
      'idioma': 'Dublado',
      'horarios': ['14:00', '16:30', '19:00']
    },
  ];

  int _selectedDateIndex = 0;

  @override
  Widget build(BuildContext context) {
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
                  image: NetworkImage(_imageUrl),
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
                    _titulo,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  _buildFilmInfoRow(_genero, _duracao, _classificacao),
                  const SizedBox(height: 20),
                  const Text(
                    'Sinopse',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    _sinopse,
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Programação',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                  const SizedBox(height: 10),
                  _buildDatesList(),
                  const SizedBox(height: 10),
                  _buildFilmSessions(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilmInfoRow(String genre, String time, String rating) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(genre),
        Text(time),
        Text(rating),
      ],
    );
  }

  Widget _buildDatesList() {
    return SizedBox(
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _datas.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              setState(() {
                _selectedDateIndex = index;
              });
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                border: Border.all(
                  color: _selectedDateIndex == index
                      ? Colors.blue
                      : Colors.transparent,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                child: Text(
                  _datas[index],
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: _selectedDateIndex == index
                        ? Colors.blue
                        : Colors.black,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildFilmSessions() {
    List<Widget> sessionWidgets = [];

    for (int i = 0; i < _sessoes.length; i++) {
      Map<String, dynamic> sessao = _sessoes[i];

      Widget sessionWidget = Column(
        children: [
          ListTile(
            leading: Text(sessao['sala']),
            title: Text(sessao['idioma']),
            subtitle: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: sessao['horarios']
                      .map<Widget>((horario) => Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: Text(horario),
                          ))
                      .toList(),
                ),
                const Text('Outra sessão'),
              ],
            ),
          ),
          const Divider(),
        ],
      );

      sessionWidgets.add(sessionWidget);
    }

    return Column(
      children: sessionWidgets,
    );
  }
}
