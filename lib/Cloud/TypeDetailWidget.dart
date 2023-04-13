import 'dart:math';

import 'package:flutter/material.dart';
import 'package:simple_weahter/Cloud/Cloud.dart';
import 'package:simple_weahter/ExtensionToolClass/CustomText.dart';

class cloudDetailItem {
  String daynumber;
  String weekday;
  bool select;
  cloudDetailItem({this.daynumber, this.weekday, this.select = false});
}

class MyModalPage extends StatefulWidget {
  final cloudAllType type;

  const MyModalPage({Key key, this.type = cloudAllType.UVI}) : super(key: key);

  @override
  _MyModalPageState createState() => _MyModalPageState();
}

class _MyModalPageState extends State<MyModalPage> {
  List<dynamic> data = [];

  @override
  void initState() {
    super.initState();

    for (int i = 0; i < 10; i++) {
      if (i == 1) {
        data.add(cloudDetailItem(daynumber: '$i', weekday: '$i', select: true));
      } else {
        data.add(
            cloudDetailItem(daynumber: '$i', weekday: '$i', select: false));
      }
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
                // color: Colors.amberAccent,
                // width: double.infinity, // or use fixed width
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: data.length,
                  itemBuilder: (BuildContext context, int index) {
                    cloudDetailItem value = data[index];
                    final onetext = value.daynumber;
                    final twotext = value.weekday;
                    final select = value.select;

                    return GestureDetector(
                      onTap: () {
                        data.asMap().forEach((key, value) {
                          data[key].select = false;
                        });
                        setState(() {
                          data[index].select = true;
                        });
                      },
                      child: Container(
                        margin: EdgeInsets.all(8),
                        width: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            CustomText(
                              textContent: '$onetext',
                              textColor: Colors.white,
                            ),
                            Container(
                              width: 35,
                              height: 35,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: select
                                    ? Colors.white
                                    : Color.fromARGB(0, 255, 255, 255),
                              ),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  CustomText(
                                    textContent: '$twotext',
                                    textColor:
                                        select ? Colors.black : Colors.white,
                                  ),
                                ],
                              ),
                            ),
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
