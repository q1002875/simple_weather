import 'package:flutter/material.dart';
import 'package:simple_weahter/Cloud/Cloud.dart';

class MyModalPage extends StatefulWidget {
  final cloudAllType type;

  const MyModalPage({Key key, this.type = cloudAllType.UVI}) : super(key: key);

  @override
  _MyModalPageState createState() => _MyModalPageState();
}

class _MyModalPageState extends State<MyModalPage> {
  List<String> data = [];
  @override
  void initState() {
    super.initState();
    /////用map寫點選去製造畫面
    ///map{}
    for (int i = 0; i < 50; i++) {
      data.add('$i');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 74, 57, 131),
        title: Text(widget.type.name),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/homeBackground.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            // Expanded(
            Container(
                width: double.infinity,
                height: 100,
                color: Colors.amberAccent,
                // width: double.infinity, // or use fixed width
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: data.length,
                  itemBuilder: (BuildContext context, int index) {
                    String value = data[index];
                    return GestureDetector(
                      onTap: () {
                        print('date$value');
                      },
                      child: Container(
                        margin: EdgeInsets.all(8),
                        width: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.grey[300],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(value),
                            Text(value),
                          ],
                        ),
                      ),
                    );
                  },
                )),

            Expanded(
                child: Container(
              margin: EdgeInsets.all(8),
              width: double.infinity,
              height: 300,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Color.fromARGB(174, 139, 98, 162),
              ),
            ))
          ],
        ),
      ),
    );
  }
}
