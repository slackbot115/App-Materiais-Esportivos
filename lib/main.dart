import 'package:flutter/material.dart';

import 'EquipamentoComponents/Telas/EquipamentosTela.dart';
import 'HomePage.dart';
import 'WeatherComponents/Clima.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tela Adicionar Produtor',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      initialRoute: "/",
      routes: {
        "/": (context) => const HomePage(),
        "/EquipamentoTela": (context) => EquipamentoTela(),
        "/ClimaTela": (context) => const ClimaTela(),
      },
    );
  }
}
