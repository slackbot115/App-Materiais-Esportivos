import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:materiais_esportivos_app/HomePage.dart';
import 'package:materiais_esportivos_app/main.dart';

import 'ReservaList.dart';
import 'ReservaModel.dart';

class ReservaTela extends StatefulWidget {
  @override
  _ReservaTelaState createState() => _ReservaTelaState();
}

class _ReservaTelaState extends State<ReservaTela> {
  late Future<List<ReservaModel>> futureReservas;

  @override
  void initState() {
    super.initState();
    futureReservas = fetchReservaList();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mostrar Reservas',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: Scaffold(
        appBar: AppBar(
          actions: [],
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MyApp()),
            ),
          ),
          title: const Text('Lista de Reservas'),
        ),
        body: Center(
          child: FutureBuilder<List<ReservaModel>>(
            future: futureReservas,
            builder: (context, snapshot) {
              if (snapshot.hasData &&
                  snapshot.connectionState == ConnectionState.done) {
                List<ReservaModel>? reservas = snapshot.data;
                return ListView.builder(
                    itemCount: reservas!.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        trailing: Wrap(
                          spacing: 12,
                          children: [

                          ],
                        ),
                        title: Text("Reserva ${reservas[index].id}"),
                        subtitle: Text(
                            '''Data: ${reservas[index].dia} 
Hora de inicio:${reservas[index].horaInicio} 
Hora de termino:${reservas[index].horaTermino}
'''),
                      );
                    });
              } else if (snapshot.hasError) {
                return const CircularProgressIndicator();
              }
              // By default, show a loading spinner.
              return const CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}
