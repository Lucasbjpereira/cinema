import 'package:cinema/components/header.dart';
import 'package:cinema/components/menu.dart';
import 'package:flutter/material.dart';

class MovieSession {
  final String movieImage;
  final String movieGenre;
  final String movieDuration;
  final String movieClassification;
  final String movieTitle;
  final List<MovieSchedule> schedules;

  MovieSession({
    required this.movieImage,
    required this.movieGenre,
    required this.movieDuration,
    required this.movieClassification,
    required this.movieTitle,
    required this.schedules,
  });
}

class MovieSchedule {
  final String room;
  final String language;
  final List<String> showTimes;

  MovieSchedule({
    required this.room,
    required this.language,
    required this.showTimes,
  });
}

class Sessions extends StatefulWidget {
  const Sessions({Key? key}) : super(key: key);

  @override
  State<Sessions> createState() => _SessionsState();
}

class _SessionsState extends State<Sessions> {
  DateTime selectedDate = DateTime.now();

  List<DateTime> availableDates = [
    DateTime.now(),
    DateTime.now().add(const Duration(days: 1)),
    DateTime.now().add(const Duration(days: 2)),
    DateTime.now().add(const Duration(days: 3)),
    DateTime.now().add(const Duration(days: 4)),
    DateTime.now().add(const Duration(days: 5)),
    DateTime.now().add(const Duration(days: 6)),
  ];

  List<MovieSession> movieSessions = [
    MovieSession(
      movieImage: 'https://placeimg.com/200/300/movie1',
      movieGenre: 'Ação',
      movieDuration: '2h 15min',
      movieClassification: '12',
      movieTitle: 'Filme 1',
      schedules: [
        MovieSchedule(
          room: 'Sala 1',
          language: 'Dublado',
          showTimes: ['10:00', '13:00', '16:00'],
        ),
        MovieSchedule(
          room: 'Sala 2',
          language: 'Legendado',
          showTimes: ['12:00', '15:00', '18:00'],
        ),
        MovieSchedule(
          room: 'Sala 3',
          language: 'Dublado',
          showTimes: ['14:00', '17:00', '20:00'],
        ),
      ],
    ),
    // Adicione mais MovieSessions conforme necessário
  ];

  Color _getClassificationColor(String classification) {
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

  Widget _buildClassificationContainer(String classification) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
      decoration: BoxDecoration(
        color: _getClassificationColor(classification),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        classification,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 14,
        ),
      ),
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
                padding: const EdgeInsets.all(11.0),
                child: SizedBox(
                  height: 40,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: availableDates.length,
                    itemBuilder: (context, index) {
                      DateTime date = availableDates[index];
                      bool isSelected = date.year == selectedDate.year &&
                          date.month == selectedDate.month &&
                          date.day == selectedDate.day;

                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedDate = date;
                          });
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: isSelected
                                  ? const Color(0xFF6FBEFC)
                                  : Colors.transparent,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            '${date.day}/${date.month}',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: isSelected
                                  ? const Color(0xFF6FBEFC)
                                  : Colors.white,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                itemCount: movieSessions.length,
                itemBuilder: (context, index) {
                  MovieSession session = movieSessions[index];
                  return Container(
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.only(bottom: 20),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(
                                  10), // Altere o valor de acordo com o raio desejado
                              child: Container(
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(
                                          0.5), // Cor e opacidade da sombra
                                      spreadRadius: 2, // Propagação da sombra
                                      blurRadius: 5, // Desfoque da sombra
                                      offset: const Offset(0,
                                          3), // Deslocamento da sombra (horizontal, vertical)
                                    ),
                                  ],
                                ),
                                child: Image.network(
                                  session.movieImage,
                                  height: 200,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const SizedBox(height: 5),
                            Row(
                              children: [
                                const Text(
                                  'Gênero: ',
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.white),
                                ),
                                Text(
                                  session.movieGenre,
                                  style: const TextStyle(
                                      fontSize: 14, color: Color(0xFFFF9600)),
                                ),
                              ],
                            ),
                            const SizedBox(height: 5),
                            Row(
                              children: [
                                const Text(
                                  'Duração: ',
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.white),
                                ),
                                Text(
                                  session.movieDuration,
                                  style: const TextStyle(
                                      fontSize: 14, color: Color(0xFFFF9600)),
                                ),
                              ],
                            ),
                            const SizedBox(height: 5),
                            Row(
                              children: [
                                const Text(
                                  'Classificação: ',
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.white),
                                ),
                                _buildClassificationContainer(
                                    session.movieClassification),
                              ],
                            )
                          ],
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                session.movieTitle,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: session.schedules.map((schedule) {
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            schedule.room,
                                            style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.orange,
                                            ),
                                          ),
                                          const SizedBox(width: 10),
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 15, vertical: 3),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(
                                                  10), // Altere o valor de acordo com o raio desejado
                                              border: Border.all(
                                                color: const Color(
                                                    0xFF6FBEFC), // Cor da borda azul
                                                width: 1, // Largura da borda
                                              ),
                                            ),
                                            child: Text(
                                              schedule.language,
                                              style: const TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 5),
                                      Wrap(
                                        spacing: 30,
                                        children:
                                            schedule.showTimes.map((showTime) {
                                          return Chip(
                                            label: Text(showTime),
                                            backgroundColor:
                                                const Color(0xFF590A0A),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                            labelStyle: const TextStyle(
                                                color: Colors.white),
                                          );
                                        }).toList(),
                                      ),
                                      const Divider(
                                        color: Color.fromARGB(71, 209, 209,
                                            209), // Cor do Divider
                                        thickness: 1.0, // Espessura do Divider
                                      ),
                                      const SizedBox(height: 10),
                                    ],
                                  );
                                }).toList(),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
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
