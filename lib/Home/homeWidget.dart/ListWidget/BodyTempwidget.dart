import 'package:flutter/material.dart';


class Thermometer extends StatelessWidget {
  final double temperature;
  final double height;
  final double width;
  final Color backgroundColor;
  final Color mercuryColor;

 const Thermometer({
     this.temperature,
    this.height = 200,
    this.width = 200,
    this.backgroundColor = Colors.grey,
    this.mercuryColor = Colors.red,
  });

  @override
  Widget build(BuildContext context) {
    return  Container(
      height: 300,
      width: 400,
      color: Colors.grey,
       child: Wrap(
        
        direction: Axis.horizontal,
        spacing: 2.0,
        runSpacing: 4.0,
        children: [
          Chip(
            backgroundColor: Colors.red,
            label: Text('紅色'),
          ),
          Chip(
            backgroundColor: Colors.green,
            label: Text('綠dddddd色'),
          ),
          Chip(
            backgroundColor: Colors.blue,
            label: Text('藍色'),
          ),
          Chip(
            backgroundColor: Colors.yellow,
            label: Text('黃ww色'),
          ),
          Chip(
            backgroundColor: Colors.orange,
            label: Text('橙w色'),
          ),
          Chip(
            backgroundColor: Colors.purple,
            label: Text('紫rrrrrrrrrrr色'),
          ),
        ],
      ),
      )
    ;
  }
}




class MyExpansionPanel extends StatefulWidget {
  const MyExpansionPanel();
  @override
  _MyExpansionPanelState createState() => _MyExpansionPanelState();
}





class _MyExpansionPanelState extends State<MyExpansionPanel> {
  List<Item> _items = [
    Item(
      headerValue: Thermometer(),
      expandedValue: Thermometer(),
    ),
    Item(
      headerValue: Thermometer(),
      expandedValue: Thermometer(),
    ),
    Item(
      headerValue: Thermometer(),
      expandedValue: Thermometer(),
    ),
  ];
  int _currentIndex = -1;

  @override
  Widget build(BuildContext context) {


    return SingleChildScrollView(
      child: Container(
        child: ExpansionPanelList(
          animationDuration: Duration(milliseconds: 500),
          expansionCallback: (int index, bool isExpanded) {
            setState(() {
              _currentIndex = isExpanded ? -1 : index;
            });
          },
          children: _items.map<ExpansionPanel>((Item item) {
            return ExpansionPanel(
              headerBuilder: (BuildContext context, bool isExpanded) {
                return  Container(child: item.expandedValue,);
              },
              body: Container(child: item.expandedValue,),
              isExpanded: _currentIndex == _items.indexOf(item),
            );
          }).toList(),
        ),
      ),
    );
  }
}

class Item {
  Thermometer headerValue;
  Thermometer expandedValue;

  Item({ this.headerValue,  this.expandedValue});
}
