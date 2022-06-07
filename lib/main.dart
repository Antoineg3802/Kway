import 'dart:html';

import 'package:flutter/material.dart';
import 'package:kway/models/city.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Colors.blue,
              ),
              child: Column(
                children: [
                  const Text(
                    'Mes villes',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(40.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        textStyle: const TextStyle(fontSize: 20),
                      ),
                      onPressed: () => showDialog<String>(
                        context: context,
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
                            TextFormField(
                              decoration: const InputDecoration(
                                hintText: 'Entrer votre ville',
                              ),
                              validator: (String? value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter some text';
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
                      ),
                      child: const Text('Ajouter une ville'),
                    ),
                  )
                ],
              ),
            ),
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
