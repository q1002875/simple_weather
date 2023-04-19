class WeatherReport {
  String datasetDescription;
  String startTime;
  String endTime;
  String issueTime;
  String update;
  String contentText;
  String phenomena;
  String significance;
  List<String> affectedAreas;

  WeatherReport({
     this.datasetDescription,
     this.startTime,
     this.endTime,
     this.issueTime,
     this.update,
     this.contentText,
     this.phenomena,
     this.significance,
     this.affectedAreas,
  });

  factory WeatherReport.fromJson(Map<String, dynamic> json) {
    var record = json['records']['record'][0];
    var info = record['hazardConditions']['hazards']['hazard'][0]['info'];
    return WeatherReport(
      datasetDescription: record['datasetInfo']['datasetDescription'],
      startTime: record['datasetInfo']['validTime']['startTime'],
      endTime: record['datasetInfo']['validTime']['endTime'],
      issueTime: record['datasetInfo']['issueTime'],
      update: record['datasetInfo']['update'],
      contentText: record['contents']['content']['contentText'],
      phenomena: info['phenomena'],
      significance: info['significance'],
      affectedAreas: List<String>.from(info['affectedAreas']['location']
          .map((location) => location['locationName'])),
    );
  }
}




//////////////////////////////////////////////////////
class Records {
  List<Record> record;

  Records({ this.record});

  factory Records.fromJson(Map<String, dynamic> json) {
    var recordsList = json['records']['record'] as List;
    List<Record> records =
        recordsList.map((record) => Record.fromJson(record)).toList();
    return Records(record: records);
  }
}

class Record {
  DatasetInfo datasetInfo;
  Contents contents;
  HazardConditions hazardConditions;

  Record(
      { this.datasetInfo,
       this.contents,
       this.hazardConditions});

  factory Record.fromJson(Map<String, dynamic> json) {
    return Record(
        datasetInfo: DatasetInfo.fromJson(json['datasetInfo']),
        contents: Contents.fromJson(json['contents']),
        hazardConditions: HazardConditions.fromJson(json['hazardConditions']));
  }
}

class DatasetInfo {
  String datasetDescription;
  String datasetLanguage;
  ValidTime validTime;
  String issueTime;
  String update;

  DatasetInfo(
      { this.datasetDescription,
       this.datasetLanguage,
       this.validTime,
       this.issueTime,
       this.update});

  factory DatasetInfo.fromJson(Map<String, dynamic> json) {
    return DatasetInfo(
        datasetDescription: json['datasetDescription'],
        datasetLanguage: json['datasetLanguage'],
        validTime: ValidTime.fromJson(json['validTime']),
        issueTime: json['issueTime'],
        update: json['update']);
  }
}

class ValidTime {
  String startTime;
  String endTime;

  ValidTime({ this.startTime,  this.endTime});

  factory ValidTime.fromJson(Map<String, dynamic> json) {
    return ValidTime(startTime: json['startTime'], endTime: json['endTime']);
  }
}

class Contents {
  Content content;

  Contents({ this.content});

  factory Contents.fromJson(Map<String, dynamic> json) {
    return Contents(content: Content.fromJson(json['content']));
  }
}

class Content {
  String contentLanguage;
  String contentText;

  Content({ this.contentLanguage,  this.contentText});

  factory Content.fromJson(Map<String, dynamic> json) {
    return Content(
        contentLanguage: json['contentLanguage'],
        contentText: json['contentText']);
  }
}

class HazardConditions {
  Hazards hazards;

  HazardConditions({ this.hazards});

  factory HazardConditions.fromJson(Map<String, dynamic> json) {
    return HazardConditions(hazards: Hazards.fromJson(json['hazards']));
  }
}

class Hazards {
  List<Hazard> hazard;

  Hazards({ this.hazard});

  factory Hazards.fromJson(Map<String, dynamic> json) {
    var hazardList = json['hazard']['hazard'] as List;
    List<Hazard> hazards =
        hazardList.map((hazard) => Hazard.fromJson(hazard)).toList();
    return Hazards(hazard: hazards);
  }
}

class Hazard {
  Info info;

  Hazard({ this.info});

  factory Hazard.fromJson(Map<String, dynamic> json) {
    return Hazard(info: Info.fromJson(json['info']));
  }
}

class Info {
  String language;
  String phenomena;
  String significance;
  AffectedAreas affectedAreas;

  Info(
      { this.language,
       this.phenomena,
       this.significance,
       this.affectedAreas});

  factory Info.fromJson(Map<String, dynamic> json) {
    return Info(
        language: json['language'],
        phenomena: json['phenomena'],
        significance: json['significance'],
        affectedAreas: AffectedAreas.fromJson(json['affectedAreas']));
  }
}

class AffectedAreas {
  List<Location> location;

  AffectedAreas({ this.location});

  factory AffectedAreas.fromJson(Map<String, dynamic> json) {
    var locationList = json['location'] as List;
    List<Location> locations =
        locationList.map((location) => Location.fromJson(location)).toList();
    return AffectedAreas(location: locations);
  }
}

class Location {
  String locationName;

  Location({ this.locationName});

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(locationName: json['locationName']);
  }
}
