import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Trabalho de Sistemas Distribuídos',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Trabalho de Sistemas Distribuídos'),
        ),
        drawer: Theme(
          data: Theme.of(context).copyWith(
            canvasColor:
                Colors.white, //This will change the drawer background to blue.
            //other styles
          ),
          child: Drawer(
            child: ListView(children: [
              const UserAccountsDrawerHeader(
                currentAccountPicture: Icon(Icons.account_circle, size: 50),
                accountName: Text("accountName"),
                accountEmail: Text("accountEmail"),
              ),
              ListTile(
                title: const Text('Equipamentos'),
                onTap: () {
                  Navigator.of(context).pushNamed("/EquipamentoTela");
                },
              ),
              ListTile(
                title: const Text('Clima'),
                onTap: () {
                  Navigator.of(context).pushNamed("/ClimaTela");
                },
              ),
              ListTile(
                title: const Text('Página 3'),
                onTap: () {},
              ),
            ]),
          ),
        ),
        body: Center(
          child: Container(
            height: 200,
            width: 200,
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(
                      "https://upload.wikimedia.org/wikipedia/commons/thumb/2/27/Instituto_Federal_de_Santa_Catarina_-_Marca_Vertical_2015.svg/1200px-Instituto_Federal_de_Santa_Catarina_-_Marca_Vertical_2015.svg.png"),
                  fit: BoxFit.cover),
            ),
          ),
        ),
      ),
    );
  }
}
