import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:materiais_esportivos_app/EquipamentoComponents/Operacoes/EquipamentoCreate.dart';
import 'package:materiais_esportivos_app/EquipamentoComponents/Operacoes/EquipamentoUpdate.dart';

import '../Operacoes/EquipamentoModel.dart';
import 'EquipamentosTela.dart';

class EquipamentoTelaEditar extends StatefulWidget {
  EquipamentoModel equipamentoSelecionado;

  EquipamentoTelaEditar(this.equipamentoSelecionado, {super.key});

  @override
  _EquipamentoTelaEditarState createState() => _EquipamentoTelaEditarState();
}

class _EquipamentoTelaEditarState extends State<EquipamentoTelaEditar> {
  var nomeEquipamentoController = TextEditingController();
  var tipoEquipamentoController = TextEditingController();
  var quantidadeTotalEquipamentoController = TextEditingController();

  @override
  void initState() {
    super.initState();
    nomeEquipamentoController.text = widget.equipamentoSelecionado.nome!;
    tipoEquipamentoController.text = widget.equipamentoSelecionado.tipo!;
    quantidadeTotalEquipamentoController.text =
        widget.equipamentoSelecionado.quantidadeTotal!.toString();
  }

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    nomeEquipamentoController.dispose();
    tipoEquipamentoController.dispose();
    quantidadeTotalEquipamentoController.dispose();
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
              MaterialPageRoute(builder: (context) => EquipamentoTela()),
            ),
          ),
          title: const Text('Adição de Equipamento Esportivo'),
        ),
        body: Center(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: nomeEquipamentoController,
                  decoration: const InputDecoration(
                      labelText: "Digite o nome do equipamento: "),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Não pode inserir um equipamento sem nome';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: tipoEquipamentoController,
                  decoration: const InputDecoration(
                      labelText: "Digite o tipo do equipamento: "),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Não pode inserir um equipamento sem tipo';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: quantidadeTotalEquipamentoController,
                  decoration: const InputDecoration(
                      labelText:
                          "Digite a quantidade total deste equipamento: "),
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Não pode inserir um equipamento sem sua quantidade total';
                    }
                    return null;
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: ElevatedButton(
                    onPressed: () {
                      // Validate returns true if the form is valid, or false otherwise.
                      if (_formKey.currentState!.validate()) {
                        widget.equipamentoSelecionado.nome =
                            nomeEquipamentoController.text;
                        widget.equipamentoSelecionado.tipo =
                            tipoEquipamentoController.text;
                        widget.equipamentoSelecionado.quantidadeTotal =
                            int.parse(
                                quantidadeTotalEquipamentoController.text);

                        updateEquipamento(widget.equipamentoSelecionado);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EquipamentoTela()),
                        );
                      }
                    },
                    child: const Text('Criar'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
