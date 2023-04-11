import 'package:flutter/material.dart';
import 'package:simple_weahter/Home/homePage.dart';
import 'Cloud/Cloud.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Navigation Bar',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Navigation Bar'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    CloudPage(),
    HomePage(title: "1"),
    Text(
      'Favorites Page',
    ),
   Text(
      'Fs Page',
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Color.fromARGB(255, 62, 36, 105),
        shape: CircularNotchedRectangle(),
        child: Container(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.wb_sunny),
                color: _selectedIndex == 0 ? Colors.white : null,
                onPressed: () => _onItemTapped(0),
              ),
              IconButton(
                icon: Icon(Icons.cloud),
                color: _selectedIndex == 1 ? Colors.white : null,
                onPressed: () => _onItemTapped(1),
              ),
              IconButton(
                icon: Icon(Icons.favorite),
                color: _selectedIndex == 2 ? Colors.white : null,
                onPressed: () => _onItemTapped(2),
              ),
              IconButton(
                icon: Icon(Icons.settings),
                color: _selectedIndex == 3 ? Colors.white : null,
                onPressed: () => _onItemTapped(3),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
