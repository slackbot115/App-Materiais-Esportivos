import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:materiais_esportivos_app/EquipamentoComponents/EquipamentoModel.dart';
import 'package:materiais_esportivos_app/HomePage.dart';
import 'package:materiais_esportivos_app/main.dart';

import 'EquipamentoList.dart';
import 'EquipamentoUpdate.dart';

class EquipamentoTela extends StatefulWidget {
  @override
  _EquipamentoTelaState createState() => _EquipamentoTelaState();
}

class _EquipamentoTelaState extends State<EquipamentoTela> {
  late Future<List<EquipamentoModel>> futureEquipamentos;

  @override
  void initState() {
    super.initState();
    futureEquipamentos = fetchEquipamentoList();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mostrar Equipamentos',
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
          title: const Text('Lista de Pragas'),
        ),
        body: Center(
          child: FutureBuilder<List<EquipamentoModel>>(
            future: futureEquipamentos,
            builder: (context, snapshot) {
              if (snapshot.hasData &&
                  snapshot.connectionState == ConnectionState.done) {
                List<EquipamentoModel>? equipamentos = snapshot.data;
                return ListView.builder(
                    itemCount: equipamentos!.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        trailing: Wrap(
                          spacing: 12,
                          children: [
                            IconButton(
                                icon: Icon(
                                  Icons.remove,
                                  size: 30,
                                ),
                                onPressed: () async => {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                        content: Text(
                                          "Espere a página recarregar",
                                          style: TextStyle(fontSize: 18),
                                        ),
                                      )),
                                      await updateEquipamento(
                                              equipamentos[index], -1)
                                          .whenComplete(() => setState(
                                                () => {
                                                  Navigator.pushAndRemoveUntil(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            EquipamentoTela()), // this mymainpage is your page to refresh
                                                    (Route<dynamic> route) =>
                                                        false,
                                                  ),
                                                },
                                              )),
                                    }),
                            IconButton(
                                icon: Icon(
                                  Icons.add,
                                  size: 30,
                                ),
                                onPressed: () async => {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                        content: Text(
                                          "Espere a página recarregar",
                                          style: TextStyle(fontSize: 18),
                                        ),
                                      )),
                                      await updateEquipamento(
                                              equipamentos[index], 1)
                                          .whenComplete(() => setState(
                                                () => {
                                                  Navigator.pushAndRemoveUntil(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            EquipamentoTela()), // this mymainpage is your page to refresh
                                                    (Route<dynamic> route) =>
                                                        false,
                                                  ),
                                                },
                                              )),
                                    })
                          ],
                        ),
                        title: Text("${equipamentos[index].nome}"),
                        subtitle: Text(
                            "Quantidade disponível: ${equipamentos[index].quantidadeDisponivel}/${equipamentos[index].quantidadeTotal}"),
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
