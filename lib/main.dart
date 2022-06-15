import 'package:flutter/material.dart';
import 'package:kway/models/city.dart';
import 'package:kway/models/dailyWeather.dart';
import 'package:kway/bdd/bdd.dart';
import 'package:kway/services/service_city.dart';
import 'package:kway/services/service_dailyWeather.dart';
import 'package:jiffy/jiffy.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(),
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

  final month = <String>[
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ];

  final coords = <double?>[0, 0];

  String town = 'Lyon';

  void updateTown(String city) {
    setState(() => {
          town = city,
        });
  }

  @override
  void initState() {
    getCountData();
    super.initState();
  }

  void UpdateCityCount() {
    setState(() {
      lengthCityList;
    });
  }

  addCity() async {
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
        title: Text(town),
      ),
      //contiens tout ce qu'il y a dans l'hamburger bar
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            //L'header du drawer
            DrawerHeader(
              decoration: const BoxDecoration(color: Colors.blueAccent),
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
                                            getCountData();
                                            UpdateCityCount();
                                            //print(lengthCityList);
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
            //Une row contiens une ville stocké
            FutureBuilder<List<String>>(
              future: getAllData(),
              builder: (context, snapshot) {
                //Pendant que le chargement ce fait
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: Text("Loading..."));
                  //Une fois que le chargement est fini
                } else if (snapshot.connectionState == ConnectionState.done) {
                  return ListView.builder(
                      itemCount: lengthCityList,
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
                                onPressed: () =>
                                    {updateTown(snapshot.data![index])},
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
        future: getCityData(town),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: Text('Loading...'),
            );
          } else if (snapshot.connectionState == ConnectionState.done &&
              isDetectable == true) {
            // Afficher la page normale
            coords[0] = snapshot.data!.coord!.lon;
            coords[1] = snapshot.data!.coord!.lat;
            return Column(children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: 350,
                    height: 200,
                    padding: const EdgeInsets.all(10.0),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      color: Colors.blue[300],
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 149,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      Jiffy().EEEE,
                                      style:
                                          const TextStyle(color: Colors.white),
                                      textAlign: TextAlign.left,
                                    ),
                                    Text(
                                      '${DateTime.now().day.toString()} ${month[DateTime.now().month - 1]}, ${DateTime.now().year.toString()}',
                                      style:
                                          const TextStyle(color: Colors.white),
                                      textAlign: TextAlign.left,
                                    ),
                                    Text(
                                      '${DateTime.now().toLocal().hour.toString()}:${DateTime.now().toLocal().minute.toString()}',
                                      style:
                                          const TextStyle(color: Colors.white),
                                      textAlign: TextAlign.left,
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(
                                          left: 17.0, top: 17.0),
                                      padding: const EdgeInsets.all(10.0),
                                      width: 130,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        color: Colors.blue[300],
                                        border: Border.all(
                                          color: Colors.white,
                                          width: 1,
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: <Widget>[
                                          Image.network(
                                            'https://openweathermap.org/img/wn/${snapshot.data!.weather![0].icon}@2x.png',
                                            width: 40.0,
                                            height: 40.0,
                                          ),
                                          Text(
                                            snapshot.data!.weather![0].main
                                                .toString(),
                                            style: const TextStyle(
                                                color: Colors.white),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 149,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    '${snapshot.data!.main!.temp!.round().toString()}°C',
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 25),
                                    textAlign: TextAlign.left,
                                  ),
                                  Text(
                                    'Humidity : ${snapshot.data!.main!.humidity.toString()} %',
                                    style: const TextStyle(color: Colors.white),
                                    textAlign: TextAlign.left,
                                  ),
                                  Text(
                                    'Wind : ${snapshot.data!.wind!.speed.toString()} m/s',
                                    style: const TextStyle(color: Colors.white),
                                    textAlign: TextAlign.left,
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Row(children: <Widget>[
                FutureBuilder<List<Daily>>(
                    future: getDailyWeather(coords[0], coords[1]),
                    builder: (context, snapshot) {
                      //Pendant que le chargement ce fait
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: Text("Chargement..."));
                        //Une fois que le chargement est fini
                      } else if (snapshot.connectionState ==
                          ConnectionState.done) {
                        return SizedBox(
                          width: 392,
                          height: 400,
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              var date = DateTime.fromMillisecondsSinceEpoch(
                                  snapshot.data![index].dt! * 1000);
                              return ListTile(
                                title: Text(
                                    '${Jiffy(date).EEEE}, ${date.day} ${month[date.month - 1]}, ${date.year}'),
                                subtitle: Text(
                                    '${snapshot.data![index].temp!.day!.round().toString()}°C'),
                                trailing: Image.network(
                                    'https://openweathermap.org/img/wn/${snapshot.data![index].weather![0].icon}@2x.png'),
                              );
                            },
                          ),
                        );
                      } else {
                        return const Center(
                            child: Text('Une erreur est survenue'));
                      }
                    })
              ]),
            ]);
          } else {
            return const Center(
              child: Text(
                  'Une erreur est survenue, vérifier votre nom de ville, il est aussi possible que nous ne trouvions pas la ville :/'),
            );
          }
        },
      ),
      // decoration: const BoxDecoration(
      //   image: DecorationImage(
      //     image: AssetImage("assets/img/troll-face.png"),
      //     fit: BoxFit.cover,
      //   ),
      // ),
    );
  }
}
