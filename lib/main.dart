import 'package:flutter/material.dart';

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
      body: Container(
        margin: const EdgeInsets.fromLTRB(0, 70, 0, 0),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const <Widget>[
                Text(
                  'Town',
                  style: TextStyle(fontSize: 25),
                )
              ],
            ),
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
                                crossAxisAlignment : CrossAxisAlignment.start,
                                children: <Widget>[
                                  const Text(
                                    'Day', 
                                    style:TextStyle(color: Colors.white),
                                    textAlign: TextAlign.left,
                                  ),
                                  const Text(
                                    'Date', 
                                    style:TextStyle(color: Colors.white),
                                    textAlign: TextAlign.left,
                                  ),
                                  const Text(
                                    'Hour', 
                                    style:TextStyle(color: Colors.white),
                                    textAlign: TextAlign.left,
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(left: 17.0, top: 17.0),
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
                                    child : Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: <Widget>[
                                        Image.network(
                                          'https://cdn-icons-png.flaticon.com/512/1163/1163661.png',
                                          width: 40.0,
                                          height: 40.0,
                                        ),
                                        const Text(
                                          'Weather',
                                          style:TextStyle(color: Colors.white),
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
                              crossAxisAlignment : CrossAxisAlignment.center,
                              mainAxisAlignment : MainAxisAlignment.center,
                              children: const <Widget>[
                                Text(
                                  'XX.XX°', 
                                  style:TextStyle(color: Colors.white,fontSize: 25),
                                  textAlign: TextAlign.left,
                                ),
                                Text(
                                  'Humidity : XX %', 
                                  style:TextStyle(color: Colors.white),
                                  textAlign: TextAlign.left,
                                ),
                                Text(
                                  'Wind : XX.XX km/h', 
                                  style:TextStyle(color: Colors.white),
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
            Row(
              children: <Widget>[
                // Expanded(
                //   child: ListView(
                //   scrollDirection: Axis.horizontal,
                //   shrinkWrap: true,
                //   children: const <Widget>[
                //     Card(
                //       child : Text('Hour'),  
                //     ),
                //     Card(
                //       child : Text('Hour'),  
                //     ),
                //     Card(
                //       child : Text('Hour'),  
                //     ),
                //     Card(
                //       child : Text('Hour'),  
                //     ),
                //     Card(
                //       child : Text('Hour'),  
                //     ),
                //     Card(
                //       child : Text('Hour'),  
                //     ),
                //     Card(
                //       child : Text('Hour'),  
                //     ),
                //     Card(
                //       child : Text('Hour'),  
                //     ),
                //     Card(
                //       child : Text('Hour'),  
                //     ),
                //     Card(
                //       child : Text('Hour'),  
                //     ),
                //     Card(
                //       child : Text('Hour'),  
                //     ),
                //     Card(
                //       child : Text('Hour'),  
                //     ),
                //     Card(
                //       child : Text('Hour'),  
                //     ),
                //     Card(
                //       child : Text('Hour'),  
                //     ),
                //   ],
                // ),
                // ),
              ],
            ),
            Row(
              children : <Widget>[
                ListView(
                  scrollDirection: Axis.horizontal,
                  children : const <Widget>[
                    // Card(
                    //   child : Text('Hour'),  
                    // ),
                    // Card(
                    //   child : Text('Hour'),  
                    // ),
                    // Card(
                    //   child : Text('Hour'),  
                    // ),
                    // Card(
                    //   child : Text('Hour'),  
                    // ),
                    // Card(
                    //   child : Text('Hour'),  
                    // ),
                    // Card(
                    //   child : Text('Hour'),  
                    // ),
                    // Card(
                    //   child : Text('Hour'),  
                    // ),
                    // Card(
                    //   child : Text('Hour'),  
                    // ),
                    // Card(
                    //   child : Text('Hour'),  
                    // ),
                    // Card(
                    //   child : Text('Hour'),  
                    // ),
                    // Card(
                    //   child : Text('Hour'),  
                    // ),
                    // Card(
                    //   child : Text('Hour'),  
                    // ),
                    // Card(
                    //   child : Text('Hour'),  
                    // ),
                    // Card(
                    //   child : Text('Hour'),  
                    // ),
                  ],
                ),
              ]
            ),
          ],
        ),
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
