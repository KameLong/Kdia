import 'package:kdia/KdiaData/KLlibrary.dart';
import 'package:kdia/KdiaData/KdiaData.dart';
import 'package:kdia/KdiaData/KdiaTimeTable.dart';

/// １枚の路線時刻表描画に用いるデータを保存します
///

class TimeTableData{
  KdiaProject project;
  TimeTableData(this.project);

  void setTimeTableID(UUID){

  }

}

class TimeTableTrainData {
  KdiaProject project;
  UUID timetableID;
  UUID trainID;
  int direction;

  TimeTableTrainData(this.project, this.timetableID, this.trainID,
      this.direction) {

  }
}
///データクラス
class TimeTableOneStation{
  Station station;
  int ypos=0;
  int style=0;
  TimeTableOneStation(this.station);
}
class TimeTableStationData {
  KdiaProject project;
  UUID timetableID;
  int direction;
  List<TimeTableOneStation>stations=[];

  TimeTableStationData(this.project, this.timetableID, this.direction) {
    TimeTable timeTable=project.getTimeTable(timetableID);
    makeStationList(timeTable);
    //駅開始ypos
    //駅名
    //駅表示スタイル
  }
  Future<void>makeStationList(TimeTable timeTable)async {
    timeTable.routes.forEach((routeID) {
      project.prepareRoute(routeID.routeID).then((route){
        List<Path>paths=route.paths;
        if(!(routeID.reversed^(this.direction==1))){
          paths=paths.reversed.toList();
        }
        paths.forEach((path) {
            TimeTableOneStation oneStation=new TimeTableOneStation(path.start);

          });
      });
    });

  }
}


