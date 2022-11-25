import 'dart:async';

import 'package:flutter/material.dart';
import 'package:materiais_esportivos_app/EquipamentoComponents/Telas/EquipamentoTelaAdicionar.dart';
import 'package:materiais_esportivos_app/EquipamentoComponents/Telas/EquipamentoTelaEditar.dart';
import 'package:materiais_esportivos_app/main.dart';

import '../Operacoes/EquipamentoList.dart';
import '../Operacoes/EquipamentoModel.dart';
import '../Operacoes/EquipamentoUpdate.dart';

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
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const MyApp()),
            ),
          ),
          title: const Text('Lista de Equipamentos Esportivos'),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => EquipamentoTelaAdicionar()),
          ),
          backgroundColor: Colors.green,
          child: const Icon(Icons.add),
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
                                icon: const Icon(
                                  Icons.remove,
                                  size: 30,
                                ),
                                onPressed: () async => {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                        content: Text(
                                          "Espere a página recarregar",
                                          style: TextStyle(fontSize: 18),
                                        ),
                                      )),
                                      await updateQuantidadeEquipamento(
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
                                icon: const Icon(
                                  Icons.add,
                                  size: 30,
                                ),
                                onPressed: () async => {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                        content: Text(
                                          "Espere a página recarregar",
                                          style: TextStyle(fontSize: 18),
                                        ),
                                      )),
                                      await updateQuantidadeEquipamento(
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
                                    }),
                            IconButton(
                              icon: const Icon(
                                Icons.edit,
                                size: 30,
                              ),
                              onPressed: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => EquipamentoTelaEditar(
                                        equipamentos[index])),
                              ),
                            ),
                          ],
                        ),
                        title: Text(
                            "${equipamentos[index].nome} - ${equipamentos[index].tipo}"),
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
