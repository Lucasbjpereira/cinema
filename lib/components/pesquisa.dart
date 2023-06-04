import 'package:flutter/material.dart';

class Pesquisa extends StatefulWidget {
  const Pesquisa({super.key});

  @override
  State<Pesquisa> createState() => _PesquisaState();
}

class _PesquisaState extends State<Pesquisa> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      style: const TextStyle(
        fontFamily: 'Inter',
        fontSize: 16,
        fontWeight: FontWeight.w700,
        color: Color(0xFFD9D9D9), // Cor do texto digitado
      ),
      decoration: InputDecoration(
        filled: false,
        hintText: 'Pesquisar',
        suffixIcon: const Icon(Icons.search),
        suffixIconColor: const Color(0x7CD9D9D9),
        hintStyle: const TextStyle(
          color: Color(0x7CD9D9D9), // Cor do hintText
        ),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(
            color: Color(0xFFD9D9D9),
          ), // Cor da borda quando não está em foco
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(
              color: Color(0xFFD9D9D9)), // Cor da borda ao focar
        ),
      ),
    );
  }
}
