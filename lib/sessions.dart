import 'dart:convert';
import 'package:cinema/components/header.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const CinemaApp());
}

class CinemaApp extends StatelessWidget {
  const CinemaApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cinema App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Sessions(),
    );
  }
}

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
  final int id;
  final String date;
  final List<Room> rooms;

  MovieSchedule({
    required this.id,
    required this.date,
    required this.rooms,
  });
}

class Room {
  final int id;
  final String name;
  final bool isDubbed;
  final bool is3D;
  final List<Time> times;

  Room({
    required this.id,
    required this.name,
    required this.isDubbed,
    required this.is3D,
    required this.times,
  });
}

class Time {
  final int id;
  final String time;

  Time({
    required this.id,
    required this.time,
  });
}

class Sessions extends StatefulWidget {
  const Sessions({Key? key}) : super(key: key);

  @override
  State<Sessions> createState() => _SessionsState();
}

class _SessionsState extends State<Sessions> {
  DateTime selectedDate = DateTime.now();
  List<MovieSession> movies = [];

  List<DateTime> availableDates = [
    DateTime.now(),
    DateTime.now().add(const Duration(days: 1)),
    DateTime.now().add(const Duration(days: 2)),
    DateTime.now().add(const Duration(days: 3)),
    DateTime.now().add(const Duration(days: 4)),
    DateTime.now().add(const Duration(days: 5)),
    DateTime.now().add(const Duration(days: 6)),
  ];

  List<MovieSession> movieSessions = [];

  Future<void> _loadCinemaData() async {
    final String jsonString = await rootBundle.loadString('assets/db.json');
    final data = jsonDecode(jsonString);
    List<dynamic> cinemas = data['cinemas'];

    setState(() {
      movieSessions = List<MovieSession>.from(cinemas[0]['filmes'].map(
        (session) => MovieSession(
          movieImage: session['image'],
          movieGenre: session['genero'],
          movieDuration: session['duracao'],
          movieClassification: session['classificacao'],
          movieTitle: session['name'],
          schedules: List<MovieSchedule>.from(session['sessoes'].map(
            (schedule) => MovieSchedule(
              id: schedule['id'],
              date: schedule['data'],
              rooms: List<Room>.from(schedule['salas'].map(
                (room) => Room(
                  id: room['id'],
                  name: room['nome'],
                  isDubbed: room['dublado'],
                  is3D: room['3d'],
                  times: List<Time>.from(room['horarios'].map(
                    (time) => Time(
                      id: time['id'],
                      time: time['horario'],
                    ),
                  )),
                ),
              )),
            ),
          )),
        ),
      ));
    });
  }

  @override
  void initState() {
    super.initState();
    _loadCinemaData();
  }

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
            physics:
                const AlwaysScrollableScrollPhysics(), // Definir physics como AlwaysScrollableScrollPhysics
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
              Column(
                children: movieSessions.map((session) {
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
                            ),
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
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 5),
                              const Text(
                                'Sessões:',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: session.schedules.map((schedule) {
                                  final roomSchedule = schedule
                                      .rooms[0]; // Get the first room schedule
                                  return Padding(
                                    padding: const EdgeInsets.only(top: 5),
                                    child: RichText(
                                      text: TextSpan(
                                        style: const TextStyle(
                                          fontSize: 14,
                                          color: Colors.white,
                                        ),
                                        children: [
                                          const TextSpan(
                                            text: 'Sala: ',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          TextSpan(
                                            text: roomSchedule.name,
                                          ),
                                          const TextSpan(
                                            text: '\nHorários:',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          for (var time
                                              in roomSchedule.times) ...[
                                            TextSpan(text: '\n${time.time}'),
                                          ],
                                        ],
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
