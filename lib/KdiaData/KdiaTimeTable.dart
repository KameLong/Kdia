import 'dart:math';
import 'dart:typed_data';
import 'dart:ui';

import 'package:uuid/uuid.dart';

import 'KdiaData.dart';


///１枚の時刻表を示します。
///時刻データはKdiaDataに任せるので、
///このクラスでは時刻表で用いるRoute,時刻表スタイルなどを保持します。
class TimeTable{
  Uint8List id=Uuid.parseAsByteList(Uuid().v4());
  List<Route> routes=[];

  Map<Station,TimeTableStationStyle>stationStyle={};

  Calendar calendar;
  List<Train>downTrain=[];
  List<Train>upTrain=[];


  TimeTable(this.calendar);

}
class TimeTableStyle{
  //今後作る
}

//時刻表駅スタイル
class TimeTableStationStyle{
  Uint8List id=Uuid.parseAsByteList(Uuid().v4());
  bool isMainStation=false;
  bool showDep=true;
  bool showAri=false;
  bool showStop=false;
}

