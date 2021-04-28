import 'dart:math';
import 'dart:typed_data';
import 'dart:ui';

import 'package:uuid/uuid.dart';

import 'KdiaData.dart';


///１枚の時刻表を示します。
///時刻データはKdiaDataに任せるので、
///このクラスでは時刻表で用いるRoute,時刻表スタイルなどを保持します。
class TimeTable{
  UUID id=UUID.fromString(Uuid().v4());
  List<UUID> routes=[];

  Map<Station,TimeTableStationStyle>stationStyle={};

  Calendar calendar;
  List<Train>downTrain=[];
  List<Train>upTrain=[];
  String name="";


  TimeTable(this.calendar);

  static getCsvTitle(){
    return "id,name,calendar_id\n";
  }
  String getCsv(){
    return "$id,$name,${calendar.id}\n";
  }
  void fromCsvLine(List<String>line,KdiaProject project){
    if(line.length<3){
      throw new Exception("Train CSV読み込み列数が足りない");
    }
    id=UUID.fromString(line[0]);
    name=line[1];
    calendar=project.getCalendar(UUID.fromString(line[2]));
  }



  static getTimetableRouteCsvTitle(){
    return "timetable_id,route_id,seq,reversed\n";
  }
  getTimetableRouteCsv(){
    String result="";
    routes.asMap().forEach((index, routeID) {
      result+="$id,${routeID},$index,0\n";
    });
    return result;
  }
  static void fromTimetableRouteCsvLine(List<String>line,KdiaProject project){
    if(line.length<4){
      throw new Exception("CSV読み込み列数が足りない");
    }
    TimeTable table=project.getTimeTable(UUID.fromString(line[0]));
    table.routes.add(UUID.fromString(line[1]));

  }
  static getTimetableStationCsvTitle(){
    return "timetable_id,station_id,is_main,show_style_down,show_style_up\n";
  }
  getTimetableStationCsv(){
    String result="";
    stationStyle.forEach((station, style) {
      result+="$id,${station.id},${style.isMainStation},${style.showDown},${style.showUp}\n";
    });
    return result;
  }
  static void fromTimetableStationCsvLine(List<String>line,KdiaProject project){
    if(line.length<5){
      throw new Exception("CSV読み込み列数が足りない");
    }
    TimeTable table=project.getTimeTable(UUID.fromString(line[0]));
    Station station=project.getStation(UUID.fromString(line[1]));
    TimeTableStationStyle style=new TimeTableStationStyle();
    style.isMainStation=(line[2]=="1");
    style.showDown=int.parse(line[3]);
    style.showUp=int.parse(line[4]);
    table.stationStyle[station]=style;
  }

  static getTimetableTrainCsvTitle(){
    return "timetable_id,train_id,direction,seq\n";
  }
  getTimetableTrainCsv(){
    String result="";
    downTrain.asMap().forEach((index, train) {
      result+="$id,${train.id},0,$index\n";
    });
    upTrain.asMap().forEach((index, train) {
      result+="$id,${train.id},1,$index\n";
    });
    return result;
  }
  static void fromTimetableTrainCsvLine(List<String>line,KdiaProject project){
    if(line.length<4){
      throw new Exception("CSV読み込み列数が足りない");
    }
    TimeTable table=project.getTimeTable(UUID.fromString(line[0]));
    if(line[2]=="0"){
      table.downTrain.add(project.getTrain(UUID.fromString(line[1])));
    }else{
      table.upTrain.add(project.getTrain(UUID.fromString(line[1])));
    }

  }


}

//時刻表駅スタイル
class TimeTableStationStyle{
  UUID id=UUID.fromString(Uuid().v4());
  bool isMainStation=false;
  int showDown=1;
  int showUp=1;
}

