import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() {
  runApp(const MyApp());
}

// Main Global Vars

final controller = TextEditingController();
var query = "";
final dio = Dio(BaseOptions(
  baseUrl: 'https://torr-finder-api.herokuapp.com/search',
  headers: {
    "Accept": "application/json",
  },
));

// This widget is the root of your application.
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Torr Finder',
      theme: ThemeData(
        scaffoldBackgroundColor: Color(0xFF26166b),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(title: 'Torr Finder'),
    );
  }
}

// Main Homepage Widget
class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void homeset() {
    setState(() {
      query = '';
      controller.clear();
    });
  }

  void UpdateState() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title, style: TextStyle(fontFamily: 'Pacifico')),
          elevation: 0,
          backgroundColor: Color(0xFF26166b),
          centerTitle: true,
          leading: Builder(builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.home),
              onPressed: () {
                homeset();
              },
            );
          }),
          actions: <Widget>[
            Builder(builder: (BuildContext context) {
              return IconButton(
                icon: const Icon(Icons.account_circle),
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return Dialog(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0)),
                          child: Container(
                            height: 350,
                            width: 280,
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    'Developer',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'Pacifico',
                                      fontSize: 25.0,
                                    ),
                                  ),
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(15.0),
                                    child: Image.asset(
                                      "assets/images/Giri.jpg",
                                      width: 180,
                                      height: 200,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                  Text(
                                    'Giridhar Salana',
                                    style: TextStyle(
                                      color: Colors.green,
                                      fontFamily: 'Pacifico',
                                      fontSize: 20.0,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        IconButton(
                                            icon: Icon(
                                                FontAwesomeIcons.facebook,
                                                color: Colors.red),
                                            onPressed: () async {
                                              const fburl =
                                                  'https://www.facebook.com/GiridharSalana';
                                              if (await canLaunch(fburl)) {
                                                await launch(fburl);
                                              } else {
                                                throw 'Could not launch $fburl';
                                              }
                                            }),
                                        SizedBox(width: 20),
                                        IconButton(
                                            icon: Icon(
                                                FontAwesomeIcons.linkedin,
                                                color: Colors.red),
                                            onPressed: () async {
                                              const liurl =
                                                  'https://www.linkedin.com/in/Giridhar-Salana';
                                              if (await canLaunch(liurl)) {
                                                await launch(liurl);
                                              } else {
                                                throw 'Could not launch $liurl';
                                              }
                                            }),
                                        SizedBox(width: 20),
                                        IconButton(
                                            icon: Icon(FontAwesomeIcons.github,
                                                color: Colors.red),
                                            onPressed: () async {
                                              const giurl =
                                                  'https://github.com/Giridharsalana';
                                              if (await canLaunch(giurl)) {
                                                await launch(giurl);
                                              } else {
                                                throw 'Could not launch $giurl';
                                              }
                                            }),
                                        SizedBox(width: 20),
                                        IconButton(
                                            icon: Icon(FontAwesomeIcons.twitter,
                                                color: Colors.red),
                                            onPressed: () async {
                                              const tiurl =
                                                  'https://www.twitter.com/GiridharSalana3';
                                              if (await canLaunch(tiurl)) {
                                                await launch(tiurl);
                                              } else {
                                                throw 'Could not launch $tiurl';
                                              }
                                            }),
                                      ])
                                ],
                              ),
                            ),
                          ),
                        );
                      });
                },
              );
            }),
          ],
        ),
        body: Column(children: [
          Searchbar(onClick: UpdateState),
          Resultsbar(),
        ]));
  }
}

// Searchbar Widget
class Searchbar extends StatefulWidget {
  const Searchbar({Key? key, required this.onClick}) : super(key: key);

  final Function onClick;

  @override
  State<Searchbar> createState() => _Searchbar();
}

class _Searchbar extends State<Searchbar> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(40)),
              color: Colors.white,
            ),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: controller,
                    textInputAction: TextInputAction.search,
                    autofocus: true,
                    decoration: InputDecoration(
                      hintText: "Search Your Torrents!",
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(40.0),
                          borderSide: BorderSide(color: Colors.white)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(40.0),
                          borderSide: BorderSide(color: Colors.white)),
                    ),
                    onChanged: (value) {
                      setState(() {
                        query = controller.text;
                        widget.onClick();
                      });
                    },
                    onSubmitted: (value) {
                      setState(() {
                        query = controller.text;
                        widget.onClick();
                      });
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    controller.text.isNotEmpty
                        ? IconButton(
                            padding: EdgeInsets.all(0),
                            icon: Icon(
                              Icons.clear,
                              color: Colors.red,
                            ),
                            tooltip: "Clear",
                            onPressed: () {
                              query = '';
                              controller.clear();
                              widget.onClick();
                            },
                          )
                        : SizedBox(),
                    IconButton(
                      padding: EdgeInsets.all(0),
                      icon: Icon(
                        Icons.search,
                        color: Colors.green,
                      ),
                      tooltip: "Search",
                      onPressed: () {
                        setState(() {
                          query = controller.text;
                          widget.onClick();
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Resultsbar extends StatefulWidget {
  const Resultsbar({Key? key}) : super(key: key);
  @override
  State<Resultsbar> createState() => _Resultsbar();
}

class _Resultsbar extends State<Resultsbar> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(
          '$query',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.red),
        ),
        // Container(
        //   color: Colors.yellow,
        //   margin: const EdgeInsets.all(10),
        //   padding: const EdgeInsets.all(10),
        // ),
        // Expanded(
        //   child: ListView(
        //     children: Test_List.map((tor) {
        //       return ListTile(
        //         title: Text(
        //           tor,
        //           style: TextStyle(
        //             color: Colors.white,
        //             fontWeight: FontWeight.bold,
        //           ),
        //         ),
        //         dense: true,
        //         enabled: true,
        //         selected: true,
        //       );
        //     }).toList(),
        //   ),
        // ),
      ],
    );
  }
}
