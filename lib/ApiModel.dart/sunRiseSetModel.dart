class SunData {
  SunDataRecords records;
  SunData({this.records});

  factory SunData.fromJson(Map<String, dynamic> json) {
    return SunData(
      records: SunDataRecords.fromJson(json['records']),
    );
  }
}

class SunDataRecords {
  String dataId;
  String note;
  SunDataLocations locations;

  SunDataRecords({this.dataId, this.note, this.locations});

  factory SunDataRecords.fromJson(Map<String, dynamic> json) {
    return SunDataRecords(
      dataId: json['dataid'],
      note: json['note'],
      locations: SunDataLocations.fromJson(json['locations']),
    );
  }
}

class SunDataLocations {
  List<SunDataLocation> location;

  SunDataLocations({this.location});

  factory SunDataLocations.fromJson(Map<String, dynamic> json) {
    return SunDataLocations(
      location: List<SunDataLocation>.from(json['location']
          .map((location) => SunDataLocation.fromJson(location))),
    );
  }
}

class SunDataLocation {
  List<SunDataTime> time;
  String countyName;

  SunDataLocation({this.time, this.countyName});

  factory SunDataLocation.fromJson(Map<String, dynamic> json) {
    return SunDataLocation(
      time: List<SunDataTime>.from(
          json['time'].map((time) => SunDataTime.fromJson(time))),
      countyName: json['CountyName'],
    );
  }
}

class SunDataTime {
  String date;
  String sunRiseTime;
  String sunSetTime;

  SunDataTime({this.date, this.sunRiseTime, this.sunSetTime});

  factory SunDataTime.fromJson(Map<String, dynamic> json) {
    return SunDataTime(
      date: json['Date'],
      sunRiseTime: json['SunRiseTime'],
      sunSetTime: json['SunSetTime'],
    );
  }
}
