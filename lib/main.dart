import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tor Finder',
      home: HomePage(),
      theme: ThemeData(
        scaffoldBackgroundColor: Color(0xFF26166b),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);
  final String title;
  final dio = Dio(BaseOptions(
    baseUrl: 'https://api.sumanjay.cf/torrent',
    headers: {
      //'Accept': 'application/json',
    },
  ));

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  bool _ishome;
  bool _issearch = false;
  void initState() {
    _ishome = true;
    _tors = null;
  }

  List _tors;

  void searchTorrents(String query) async {
    setState(() {
      _issearch = true;
    });
    final response = await widget.dio.get('', queryParameters: {
      'query': query,
    });
    setState(() {
      if (response.statusCode != 200 || response.data == 'Error') {
        _tors = null;
      } else {
        _tors = response.data;
      }
      _ishome = false;
      setState(() {
        _issearch = false;
      });
    });
  }

  void homeset() {
    setState(() {
      _tors = null;
      _ishome = true;
      _issearch = false;
    });
  }

  void _showToast() {
    Fluttertoast.showToast(
      msg: "Magnet Copied!",
      toastLength: Toast.LENGTH_SHORT,
      //gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.black,
      textColor: Colors.red,
      fontSize: 16.0,
    );
  }

  // This function is triggered when the copy icon is pressed
  void _copyToClipboard(textcp) async {
    await Clipboard.setData(ClipboardData(text: textcp));
    _showToast();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            'Tor Finder',
            style: TextStyle(fontFamily: 'Pacifico'),
          ),
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
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)), //this right here
                          child: Container(
                            height: 350,
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
                                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                                    Icon(FontAwesomeIcons.facebook, color: Colors.red),
                                    SizedBox(width: 20),
                                    Icon(Icons.linkedin, color: Colors.red),
                                    SizedBox(width: 20),
                                    Icon(FontAwesomeIcons.twitter, color: Colors.red),
                                    SizedBox(width: 20),
                                    Icon(FontAwesomeIcons.github, color: Colors.red),
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
          elevation: 0,
          backgroundColor: Color(0xFF26166b),
          centerTitle: true),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SearchForm(onSearch: searchTorrents),
            _issearch == true
                ? Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.search,
                          color: Colors.white,
                          size: 110,
                        ),
                        Text(
                          'Searching...',
                          style: TextStyle(color: Colors.white),
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        CircularProgressIndicator()
                      ],
                    ),
                  )
                : _ishome == false && _tors == null && _issearch == false
                    ? Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.search,
                              color: Colors.white,
                              size: 110,
                            ),
                            Text(
                              'Found None!',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ],
                        ),
                      )
                    : _tors == null && _ishome == true && _issearch == false
                        ? Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.search,
                                  color: Colors.white,
                                  size: 110,
                                ),
                                Text(
                                  'Search Your Torrents Here!',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                )
                                /*Text(
                                  'Made With Love By Giridhar Salana',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),*/
                              ],
                            ),
                          )
                        : Expanded(
                            child: ListView(
                              children: _tors.map((tor) {
                                return ListTile(
                                    title: Text(
                                      tor['name'],
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    subtitle: Text(
                                      '${tor['seeder']} seeders ' ' ${tor['leecher']} leechers ' ' ${tor['site']} ' ' ${tor['age']} ',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    trailing: Text(
                                      tor['size'],
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                    dense: true,
                                    enabled: true,
                                    selected: true,
                                    onTap: () => _copyToClipboard(tor['magnet']));
                              }).toList(),
                            ),
                          ),
          ],
        ),
      ),
    );
  }
}

class SearchForm extends StatefulWidget {
  SearchForm({this.onSearch});
  final void Function(String search) onSearch;
  @override
  _SearchFormState createState() => _SearchFormState();
}

class _SearchFormState extends State<SearchForm> {
  final _formKey = GlobalKey<FormState>();

  var _autoValidate = false;
  var _search;

  void clearsearch() {
    _formKey.currentState.reset();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Form(
        key: _formKey,
        autovalidate: _autoValidate,
        child: Stack(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                //border: Border.all(color: Colors.blue),
                borderRadius: BorderRadius.all(Radius.circular(40)),
                color: Colors.white,
              ),
              child: Row(
                children: <Widget>[
                  Expanded(
                      child: TextFormField(
                    textInputAction: TextInputAction.search,
                    decoration: InputDecoration(
                      //prefixIcon: Icon(Icons.search),
                      hintText: 'Enter search query',
                      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(40.0), borderSide: BorderSide(color: Colors.white)),
                      //filled: true,
                      //errorStyle: TextStyle(fontSize: 15),
                      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(40.0), borderSide: BorderSide(color: Colors.white)),
                    ),
                    onFieldSubmitted: (value) {
                      final isValid = _formKey.currentState.validate();
                      if (isValid) {
                        widget.onSearch(_search);
                      } else {
                        setState(() {
                          _autoValidate = true;
                        });
                      }
                    },
                    onChanged: (value) {
                      _search = value;
                    },
                    validator: (value) {
                      if (value.isEmpty) {
                        return null; // Validator empty return 'Please enter a search term' replaced with null
                      }
                      return null;
                    },
                  )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      MaterialButton(
                        shape: CircleBorder(),
                        //fillColor: Colors.red,
                        padding: const EdgeInsets.only(right: 20.0),
                        minWidth: 0,
                        child: Icon(
                          Icons.clear,
                        ),
                        onPressed: () {
                          _formKey.currentState.reset();
                        },
                      ),
                      MaterialButton(
                        shape: CircleBorder(),
                        padding: const EdgeInsets.only(right: 25.0),
                        //fillColor: Colors.red,
                        minWidth: 0,
                        child: Icon(
                          Icons.search,
                        ),
                        onPressed: () {
                          final isValid = _formKey.currentState.validate();
                          if (isValid) {
                            widget.onSearch(_search);
                          } else {
                            setState(() {
                              _autoValidate = true;
                            });
                          }
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
