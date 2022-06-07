import 'dart:html';

import 'package:flutter/material.dart';
import 'package:kway/models/city.dart';
import 'package:kway/bdd/bdd.dart';
import 'package:kway/services/service_city.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _formKey = GlobalKey<FormState>();
  var cityName = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      //contiens tout ce qu'il y a dans l'hamburger bar
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            //L'header du drawer
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Colors.blue,
              ),
              child: Column(
                children: [
                  //Le titre
                  const Text(
                    'Mes villes',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(35.0),
                    //Le boutton pour ajouter une ville
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        textStyle: const TextStyle(fontSize: 20),
                      ),
                      //Quand le bouton est presser
                      onPressed: () => showDialog<String>(
                        context: context,
                        //Ouverture du bloc pour ecrire une ville et l'ajouter
                        builder: (BuildContext context) => AlertDialog(
                          title: const Text('Ajouter une ville'),
                          contentPadding:
                              const EdgeInsets.only(top: 25.0, left: 5.0),
                          buttonPadding: const EdgeInsets.all(5.0),
                          content: const Text(
                            "ville:",
                            textAlign: TextAlign.left,
                          ),
                          actions: <Widget>[
                            Form(
                                key: _formKey,
                                child: Column(
                                  children: [
                                    TextFormField(
                                      decoration: const InputDecoration(
                                        hintText: 'Entrer votre ville',
                                      ),
                                      controller: cityName,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: TextButton(
                                        child: Text("Submit"),
                                        onPressed: () {
                                          if (cityName.text != "") {
                                            insertCity(cityName.text);
                                          }
                                        },
                                      ),
                                    )
                                  ],
                                ))
                          ],
                        ),
                      ),

                      child: const Text('Ajouter une ville'),
                    ),
                  )
                ],
              ),
            ),
            //Une row contiens une ville stocker
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Expanded(
                    child: ListTile(
                  leading: Icon(Icons.location_city),
                  title: Text('Longessaigne'),
                )),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.delete),
                )
              ],
            ),
          ],
        ),
      ),
      //Tout l'interieur du body (de la page d'acceuil)
      body: FutureBuilder<City>(
        future: getCityData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: Text("Chargement..."));
          } else if (snapshot.connectionState == ConnectionState.done) {
            return ListTile(
              title: Text(snapshot.data!.name.toString()),
              subtitle: Text(snapshot.data!.base.toString()),
              // trailing:
              //     Text(snapshot.data![index].probability.toString()),
              // leading: Text(snapshot.data![index].count.toString()),
            );
          } else {
            return const Text("Une erreur est survenue, (code mieux)");
          }
        },
      ),
    );
  }
}
