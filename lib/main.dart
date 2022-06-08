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
  final prefs = getAllData();
  @override
  void initState() {
    getCountData();
    super.initState();
  }

  void addCity() async {
    setState(() {
      if (cityName.text != "") {
        writeData(cityName.text);
        getCountData();
      }
    });
  }

  deleteCity(String name) async {
    setState(() {
      deleteData(name);
      getCountData();
    });
  }

  void _delete(BuildContext context, String name) {
    showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return AlertDialog(
            title: const Text('Please Confirm'),
            content: const Text('Are you sure to remove the city?'),
            actions: [
              // The "Yes" button
              TextButton(
                  onPressed: () {
                    deleteCity(name);
                    Navigator.of(context).pop();
                  },
                  child: const Text('Yes')),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('No'))
            ],
          );
        });
  }

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
                          actions: <Widget>[
                            //Tout le formulaire
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
                                            addCity();
                                            Navigator.pop(context);
                                          }),
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
            FutureBuilder<List<String>>(
              future: getAllData(),
              builder: (context, snapshot) {
                //Pendant que le chargement ce fait
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: Text("Chargement..."));
                  //Une fois que le chargement est fini
                } else if (snapshot.connectionState == ConnectionState.done) {
                  return ListView.builder(
                      itemCount: lenght,
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Expanded(
                                child: ListTile(
                              leading: const Icon(Icons.location_city),
                              title: TextButton(
                                child: Text(snapshot.data![index]),
                                onPressed: () => {
                                  // Quand la ville est séléctionné
                                },
                              ),
                            )),
                            IconButton(
                              onPressed: () {
                                //Quand l'icon pour suprimer la ville est cliquer, il fait une confirmation
                                _delete(context, snapshot.data![index]);
                              },
                              icon: const Icon(Icons.delete),
                            )
                          ],
                        );
                      });
                } else {
                  return const Text("Une erreur est survenue, (code mieux)");
                }
              },
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
            );
          } else {
            return const Text("Une erreur est survenue, (code mieux)");
          }
        },
      ),
    );
  }
}
