import 'package:cinema/components/header.dart';
import 'package:flutter/material.dart';

class SearchCinema extends StatefulWidget {
  const SearchCinema({super.key});

  @override
  State<SearchCinema> createState() => _SearchCinemaState();
}

class _SearchCinemaState extends State<SearchCinema> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF111111),
      body: Column(
        children: [
          const Header(),
          const SizedBox(
            height: 22,
          ),
          TextField(
            decoration: InputDecoration(
              filled: false,
              hintText: 'Pesquisar',
              suffixIcon: const Icon(Icons.search),
              suffixIconColor: const Color.fromARGB(255, 217, 217, 217),
              hintStyle: const TextStyle(
                color: Color.fromARGB(
                    255, 217, 217, 217), // Cor desejada para o hintText
              ),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide.none,
              ),
            ),
          )
        ],
      ),
    );
  }
}
