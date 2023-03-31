import 'package:flutter/material.dart';

class MyListView extends StatefulWidget {
  const MyListView();
  @override
  _MyListViewState createState() => _MyListViewState();
}

class _MyListViewState extends State<MyListView> {
  List<Widget> _items = [
    MyWidget(title: 'Widget 1'),
    MyWidget(title: 'Widget 2'),
    MyWidget(title: 'Widget 3'),
    MyWidget(title: 'Widget 4'),
    MyWidget(title: 'Widget 5'),
  ];

  @override
 Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _items.length,
              itemBuilder: (BuildContext context, int index) {
                return _items[index];
              },
            ),
          ),
        ],
      ),
    );
  }
}

class MyWidget extends StatefulWidget {
  final String title;

  MyWidget({this.title});

  @override
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  bool _isChecked = false;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(widget.title),
      trailing: Checkbox(
        value: _isChecked,
        onChanged: (bool value) {
          setState(() {
            _isChecked = value;
          });
        },
      ),
    );
  }
}
