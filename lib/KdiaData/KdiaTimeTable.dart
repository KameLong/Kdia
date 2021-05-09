import 'dart:math';
import 'dart:typed_data';
import 'dart:ui';

import 'package:uuid/uuid.dart';

import 'KLlibrary.dart';
import 'KdiaData.dart';


///１枚の時刻表を示します。
///時刻データはKdiaDataに任せるので、
///このクラスでは時刻表で用いるRoute,時刻表スタイルなどを保持します。
class TimeTable{
  UUID id=UUID.fromString(Uuid().v4());
  KdiaProject project;
  List<TimeTableRoute> routes=[];

  List<TimeTablePathStyle>pathStyle=[];

  Calendar calendar;
  List<Train>downTrain=[];
  List<Train>upTrain=[];
  String name="";


  TimeTable(this.project,this.calendar);


  ///この時刻表に含まれるrouteの中からPathを検索します
  Path getPath(UUID pathID){
    for(TimeTableRoute element in routes){
      try {

        return project.getRoute(element.routeID).getPath(pathID);
      }catch(e){
      }
    }
    throw new Exception(pathID);
  }



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

class TimeTableRoute{
  UUID id=new UUID();
  UUID routeID=new UUID();
  bool reversed=false;

  static getCsvTitle(){
    return "id,timetable_id,route_id,seq,reversed\n";
  }
  getCsv(UUID timetableID,int seq){
    return "$id,$timetableID,$routeID,$seq,${bool2Str(reversed)}\n";
  }
  static void fromCsvLine(List<String>line,KdiaProject project){
    if(line.length<4){
      throw new Exception("CSV読み込み列数が足りない");
    }
    TimeTableRoute timeTableRoute=new TimeTableRoute();
    timeTableRoute.id=UUID.fromString(line[0]);
    timeTableRoute.routeID=UUID.fromString(line[2]);
    timeTableRoute.reversed=(line[4]=="1");

    TimeTable table=project.getTimeTable(UUID.fromString(line[1]));
    table.routes.add(timeTableRoute);

  }
}

//時刻表駅スタイル
class TimeTablePathStyle{
  UUID id=UUID.fromString(Uuid().v4());
  UUID pathID=UUID();
  bool isMainStation=false;
  int showDown=1;
  int showUp=1;

  static getCsvTitle(){
    return "id,timetable_id,path_id,is_main,show_style_down,show_style_up\n";
  }
  getCsv(UUID timetableID){
    return "$id,${timetableID},${pathID},${bool2Str(isMainStation)},${showDown},${showUp}\n";

  }
  static void fromCsvLine(List<String>line,KdiaProject project){
    if(line.length<6){
      throw new Exception("CSV読み込み列数が足りない");
    }
    TimeTable table=project.getTimeTable(UUID.fromString(line[1]));
    TimeTablePathStyle style=new TimeTablePathStyle();
    style.pathID=UUID.fromString(line[2]);
    style.isMainStation=(line[3]=="1");
    style.showDown=int.parse(line[4]);
    style.showUp=int.parse(line[5]);
    table.pathStyle.add(style);
  }


}

