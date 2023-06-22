import 'package:carousel_slider/carousel_slider.dart';
import 'package:cinema/components/header.dart';
import 'package:cinema/components/menu.dart';
import 'package:cinema/filme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class Cinema extends StatefulWidget {
  const Cinema({Key? key}) : super(key: key);

  @override
  State<Cinema> createState() => _CinemaState();
}

class _CinemaState extends State<Cinema> {
  bool isLoading = true;
  int _currentSlideIndex = 0;
  String _currentCategory = 'Em cartaz';
  List<Movie> movies = [];
  List<dynamic> filteredMovieData = [];
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadMovies();
    searchController.addListener(filterFilmes);
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void filterFilmes() {
    String searchText = searchController.text.trim().toLowerCase();
    if (searchText.isEmpty) {
      setState(() {
        filteredMovieData = [];
      });
      return; // Retorna para evitar a execução do código restante
    }

    setState(() {
      filteredMovieData = movies.where((movie) {
        String movieName = movie.title.toLowerCase();
        return movieName.contains(searchText);
      }).toList();
    });
  }

  Future<void> loadMovies() async {
    // Create an instance of CinemaData
    CinemaData cinemaData = CinemaData();

    await cinemaData.fetchMovies(context);
    cinemaData;

    setState(() {
      movies = cinemaData.movies;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Movie> slideMovies = movies.take(3).toList();

    return Scaffold(
      backgroundColor: const Color(0xFF111111),
      body: Stack(
        children: [
          if (isLoading) // Exibe o indicador de loading enquanto isLoading for verdadeiro
            Center(
              child: CircularProgressIndicator(),
            )
          else
            movies.isEmpty
                ? const Center(
                    child: Column(children: [
                      Spacer(),
                      Text('Nenhum filme encontrado',
                          style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: Color.fromARGB(120, 255, 255, 255))),
                      Spacer()
                    ]),
                  )
                : ListView(
                    children: [
                      const Header(),
                      Padding(
                        padding: const EdgeInsets.all(11.0),
                        child: Column(
                          children: [
                            TextField(
                              controller: searchController,
                              style: const TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color:
                                    Color(0xFFD9D9D9), // Cor do texto digitado
                              ),
                              decoration: InputDecoration(
                                filled: false,
                                hintText: 'Pesquisar',
                                suffixIcon: const Icon(Icons.search),
                                suffixIconColor: const Color(0x7CD9D9D9),
                                hintStyle: const TextStyle(
                                  color: Color(0x7CD9D9D9), // Cor do hintText
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 12, horizontal: 16),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: const BorderSide(
                                    color: Color(0xFFD9D9D9),
                                  ), // Cor da borda quando não está em foco
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: const BorderSide(
                                      color: Color(
                                          0xFFD9D9D9)), // Cor da borda ao focar
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            filteredMovieData.isNotEmpty
                                ? _buildFiltredMovies()
                                : Column(
                                    children: [
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
                                            items: slideMovies.map((item) {
                                              return Builder(
                                                builder:
                                                    (BuildContext context) {
                                                  return GestureDetector(
                                                    onTap: () async {
                                                      SharedPreferences prefs =
                                                          await SharedPreferences
                                                              .getInstance();
                                                      prefs.setInt(
                                                          'selectedMovieId',
                                                          item.id);
                                                      // ignore: use_build_context_synchronously
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              const Filme(),
                                                        ),
                                                      );
                                                    },
                                                    child: Container(
                                                      margin:
                                                          const EdgeInsets.all(
                                                              5.0),
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            const BorderRadius
                                                                .all(
                                                          Radius.circular(10.0),
                                                        ),
                                                        child: Stack(
                                                          children: [
                                                            Image.network(
                                                              item.imageURL,
                                                              fit: BoxFit.cover,
                                                              width: double
                                                                  .infinity,
                                                            ),
                                                            Positioned(
                                                              left: 0,
                                                              right: 0,
                                                              bottom: 35.0,
                                                              child: Container(
                                                                padding: const EdgeInsets
                                                                        .symmetric(
                                                                    vertical:
                                                                        10.0,
                                                                    horizontal:
                                                                        10.0),
                                                                color: Colors
                                                                    .black
                                                                    .withOpacity(
                                                                        0.7),
                                                                child: Text(
                                                                  item.title,
                                                                  style:
                                                                      const TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        18.0,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                  ),
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                },
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
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: List.generate(
                                                    slideMovies.length,
                                                    (index) {
                                                  return Container(
                                                    width: 10.0,
                                                    height: 10.0,
                                                    margin: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 4.0),
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color:
                                                          _currentSlideIndex ==
                                                                  index
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
                                    ],
                                  ),
                            const SizedBox(height: 20),
                            filteredMovieData.isEmpty
                                ? Row(
                                    children: [
                                      Expanded(
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                          child: _currentCategory == 'Em cartaz'
                                              ? Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0),
                                                    color:
                                                        const Color(0xFF590A0A),
                                                  ),
                                                  child: TextButton(
                                                    onPressed: () {
                                                      setState(() {
                                                        _currentCategory =
                                                            'Em cartaz';
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
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0),
                                                    border: Border.all(
                                                      color: const Color(
                                                          0xFF590A0A),
                                                    ),
                                                  ),
                                                  child: TextButton(
                                                    onPressed: () {
                                                      setState(() {
                                                        _currentCategory =
                                                            'Em cartaz';
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
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                          child: _currentCategory == 'Em breve'
                                              ? Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0),
                                                    color:
                                                        const Color(0xFF590A0A),
                                                  ),
                                                  child: TextButton(
                                                    onPressed: () {
                                                      setState(() {
                                                        _currentCategory =
                                                            'Em breve';
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
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0),
                                                    border: Border.all(
                                                      color: const Color(
                                                          0xFF590A0A),
                                                    ),
                                                  ),
                                                  child: TextButton(
                                                    onPressed: () {
                                                      setState(() {
                                                        _currentCategory =
                                                            'Em breve';
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
                                  )
                                : const SizedBox(),
                            const SizedBox(height: 20),
                            if (filteredMovieData.isEmpty &&
                                _currentCategory == 'Em cartaz')
                              _buildEmCartazCards(),
                            if (filteredMovieData.isEmpty &&
                                _currentCategory != 'Em cartaz')
                              _buildEmBreveCards(),
                            const SizedBox(height: 60),
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
    List<Movie> emCartazMovies = movies
        .skip(3)
        .toList()
        .where((movie) =>
            DateTime.parse(movie.releaseDate).isBefore(DateTime.now()))
        .toList();
    emCartazMovies;

    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: (emCartazMovies.length / 2).ceil(),
      itemBuilder: (context, sectionIndex) {
        int startIndex = sectionIndex * 2;
        int endIndex = startIndex + 2;
        if (endIndex > emCartazMovies.length) endIndex = emCartazMovies.length;

        return GridView.count(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          crossAxisCount: 2,
          childAspectRatio: 0.47,
          crossAxisSpacing: 25,
          mainAxisSpacing: 15,
          children: List.generate(endIndex - startIndex, (index) {
            int movieIndex = startIndex + index;
            Movie movie = emCartazMovies[movieIndex];

            return GestureDetector(
              onTap: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();

                prefs.setInt('selectedMovieId', emCartazMovies[movieIndex].id);
                // ignore: use_build_context_synchronously
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Filme(),
                  ),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Image.network(
                        movie.imageURL,
                        height: 300,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      movie.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        );
      },
    );
  }

  Widget _buildFiltredMovies() {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: (filteredMovieData.length / 2).ceil(),
      itemBuilder: (context, sectionIndex) {
        int startIndex = sectionIndex * 2;
        int endIndex = startIndex + 2;
        if (endIndex > filteredMovieData.length) {
          endIndex = filteredMovieData.length;
        }

        return GridView.count(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          crossAxisCount: 2,
          childAspectRatio: 0.7,
          crossAxisSpacing: 25,
          mainAxisSpacing: 15,
          children: List.generate(endIndex - startIndex, (index) {
            int movieIndex = startIndex + index;
            Movie movie = filteredMovieData[movieIndex];

            return GestureDetector(
              onTap: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                int idMovie = filteredMovieData[movieIndex].id as int;
                prefs.setInt('selectedMovieId', idMovie);
                // ignore: use_build_context_synchronously
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Filme(),
                  ),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Image.network(
                        movie.imageURL,
                        height: 200,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      movie.title,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        );
      },
    );
  }

  Widget _buildEmBreveCards() {
    filteredMovieData;
    List<Movie> emBreveMovies = movies
        .skip(3)
        .toList()
        .where((movie) =>
            DateTime.parse(movie.releaseDate).isAfter(DateTime.now()))
        .toList();

    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: (emBreveMovies.length / 2).ceil(),
      itemBuilder: (context, sectionIndex) {
        int startIndex = sectionIndex * 2;
        int endIndex = startIndex + 2;
        if (endIndex > emBreveMovies.length) endIndex = emBreveMovies.length;

        return GridView.count(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          crossAxisCount: 2,
          childAspectRatio: 0.7,
          crossAxisSpacing: 25,
          mainAxisSpacing: 15,
          children: List.generate(endIndex - startIndex, (index) {
            int movieIndex = startIndex + index;
            Movie movie = emBreveMovies[movieIndex];

            return GestureDetector(
              onTap: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.setInt('selectedMovieId', emBreveMovies[movieIndex].id);
                // ignore: use_build_context_synchronously
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Filme(),
                  ),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Image.network(
                        movie.imageURL,
                        height: 200,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      movie.title,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        );
      },
    );
  }
}

class Movie {
  final int id;
  final String title;
  final String imageURL;
  final String releaseDate;

  Movie(
      {required this.id,
      required this.title,
      required this.imageURL,
      required this.releaseDate});

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'],
      title: json['name'],
      imageURL: json['image'],
      releaseDate: json['data-estreia'],
    );
  }
}

class CinemaData {
  List<Movie> movies = [];

  Future<void> fetchMovies(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int selectedCinemaId = prefs.getInt('selectedCinemaId') ?? 0;
    // Load cinema data from db.json
    final String jsonString = await rootBundle.loadString('assets/db.json');
    final data = jsonDecode(jsonString);

    for (var cinema in data['cinemas']) {
      if (cinema['id'] == selectedCinemaId) {
        cinema['filmes'];
        List<dynamic> movieList = cinema['filmes'];
        movies = movieList.map((item) => Movie.fromJson(item)).toList();
        break;
      }
    }
  }
}
