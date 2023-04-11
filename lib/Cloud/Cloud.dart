import 'package:flutter/material.dart';
import 'package:simple_weahter/ExtensionToolClass/CustomText.dart';
import 'package:simple_weahter/Home/homeWidget.dart/ListWidget/weatherHourItem.dart';

import '../ApiCommand.dart/apiService.dart';
import '../Home/homeWidget.dart/ListWidget/UVIwidget.dart';

class WeatherData {
  String _datasetDescription;
  List<Location> _locations;

  String get datasetDescription => _datasetDescription;
  List<Location> get locations => _locations;

  WeatherData.fromJson(Map<String, dynamic> json) {
    _datasetDescription = json['records']['datasetDescription'];
    _locations = List<Location>.from(json['records']['location']
        .map((location) => Location.fromJson(location)));
  }
}

class Location {
  String _locationName;
  List<Weather> _weatherElements;

  String get locationName => _locationName;
  List<Weather> get weatherElements => _weatherElements;

  Location.fromJson(Map<String, dynamic> json) {
    _locationName = json['locationName'];
    _weatherElements = List<Weather>.from(
        json['weatherElement'].map((element) => Weather.fromJson(element)));
  }
}

class Weather {
  String _elementName;
  List<Time> _times;

  String get elementName => _elementName;
  List<Time> get times => _times;

  Weather.fromJson(Map<String, dynamic> json) {
    _elementName = json['elementName'];
    _times = List<Time>.from(json['time'].map((time) => Time.fromJson(time)));
  }
}

class Time {
  DateTime _startTime;
  DateTime _endTime;
  String _parameterName;
  String _parameterValue;
  String _parameterUnit;

  DateTime get startTime => _startTime;
  DateTime get endTime => _endTime;
  String get parameterName => _parameterName;
  String get parameterValue => _parameterValue;
  String get parameterUnit => _parameterUnit;

  Time.fromJson(Map<String, dynamic> json) {
    _startTime = DateTime.parse(json['startTime']);
    _endTime = DateTime.parse(json['endTime']);
    _parameterName = json['parameter']['parameterName'];
    _parameterValue = json['parameter']['parameterValue'];
    _parameterUnit = json['parameter']['parameterUnit'] ?? '';
  }
}

///////////////week data

class WeatherWeekData {
  String _datasetDescription;
  List<Locationweek> _locations;

  String get datasetDescription => _datasetDescription;
  List<Locationweek> get locations => _locations;

  WeatherWeekData.fromJson(Map<String, dynamic> json) {
    _datasetDescription = json['records']['datasetDescription'];
    _locations = List<Locationweek>.from(json['records']['locations'][0]
            ['location']
        .map((location) => Locationweek.fromJson(location)));
  }
  @override
  String toString() {
    return 'WeatherWeekData(datasetDescription: $datasetDescription, locations: $locations)';
  }
}

class Locationweek {
  String _locationName;
  List<Weatherweek> _weatherElements;

  String get locationName => _locationName;
  List<Weatherweek> get weatherElements => _weatherElements;

  Locationweek.fromJson(Map<String, dynamic> json) {
    _locationName = json['locationName'];
    _weatherElements = List<Weatherweek>.from(
        json['weatherElement'].map((element) => Weatherweek.fromJson(element)));
  }
  @override
  String toString() {
    return 'Locationweek(locationName: $locationName, weatherElements: $weatherElements)';
  }
}

class Weatherweek {
  String _elementName;
  List<Timeweek> _times;

  String get elementName => _elementName;
  List<Timeweek> get times => _times;

  Weatherweek.fromJson(Map<String, dynamic> json) {
    _elementName = json['elementName'];
    _times = List<Timeweek>.from(
        json['time'].map((time) => Timeweek.fromJson(time)));
  }
  @override
  String toString() {
    return 'Weatherweek(elementName: $elementName, times: $times)';
  }
}

class Timeweek {
  DateTime _startTime;
  DateTime _endTime;
  String _parameterValue;
  String _imageValue;
  DateTime get startTime => _startTime;
  DateTime get endTime => _endTime;
  String get parameterValue => _parameterValue;
  String get imageValue => _imageValue;
  Timeweek.fromJson(Map<String, dynamic> json) {
    _startTime = DateTime.parse(json['startTime']);
    _endTime = DateTime.parse(json['endTime']);
    _parameterValue = json['elementValue'][0]['value'];
    _imageValue = json['elementValue'][1]['value'];
  }
  @override
  String toString() {
    return 'Timeweek(startTime: $startTime, endTime: $endTime,parameterValue:$parameterValue,imageValue:$imageValue)';
  }
}
///////////////////////result week get

class CloudPage extends StatefulWidget {
  const CloudPage();
  @override
  _CloudPageState createState() => _CloudPageState();
}

final api = apiService();
// ignore: missing_return
Future<List<Widget>> getData(String country) async {
  final countrydata = await api.getCloudData(country);
  print(countrydata.toString());
  return countrydata;
}

class _CloudPageState extends State<CloudPage> {
  @override
  initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('新竹縣')),
      body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/homeBackground.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: FutureBuilder<List<Widget>>(
            future: getData('新竹縣'),
            builder: (context, snapshot) {
              if (snapshot.hasData) {


                return ListView(
                  scrollDirection: Axis.vertical,
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      child: ImageTextWidget(
                        text: '23123123123',
                        textcolor: Colors.black12,
                      ),
                    ),
                    Row(
                      children: [
                        MyItem(
                          text: '紫外線UVI',
                          view: 
                          snapshot.data[0]
                          // UVIWidget(textfirst:snapshot.data[0],textsecond: snapshot.data[1],uviLevel: snapshot.data[2]),
                        ),
                        MyItem(
                          text: '日出',
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        MyItem(
                          text: '風向風速WD,WS',
                        ),
                        MyItem(
                          text: '露點Td',
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        MyItem(
                          text: '體感溫度AT',
                        ),
                        MyItem(
                          text: '濕度RH',
                        ),
                      ],
                    ),
                  ],
                );
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          )),
    );
  }
}

class MyItem extends StatelessWidget {
  final String text;
  final Icon icon;
  final Widget view;
  const MyItem({Key key, this.text, this.icon, this.view}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;

    return Expanded(
      child: Container(
        width: screenWidth / 3,
        height: screenHeight / 4,
        margin: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: Color.fromARGB(120, 74, 57, 131),
        ),
        child: Column(
          children: [
            Container(
              // color: Colors.blueGrey,
              height: 30,
              child: Row(
                children: [
                  SizedBox(
                    width: 5,
                  ),
                  Icon(icon != null ? icon : Icons.volume_up),
                  SizedBox(
                    width: 5,
                  ),
                  CustomText(textContent: text, textColor: Colors.white)
                ],
              ),
            ),
            Expanded(
                child: Container(
                    // color: Colors.blue,
                    width: screenWidth,
                    // height: (screenHeight / 4) - 30,
                    child: view
                    //  UVIWidget(textfirst: '曝曬級數:中量級',textsecond: '紫外線指數:6',uviLevel: int.parse('5'),),
                    ))
          ],
        ),

        //  Center(child: CustomText(textContent: text,textColor: Colors.white,fontSize: 20,)),
      ),
    );
  }
}
