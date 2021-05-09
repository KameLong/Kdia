
import 'package:kdia/KdiaData/KdiaTimeTable.dart';
import 'package:kdia/main.dart';
import 'dart:typed_data';
import 'dart:ui';
import 'dart:io';
import 'package:uuid/uuid.dart';
import 'package:collection/collection.dart';
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;

import 'KLlibrary.dart';


///文字列定義（日本語）
const String NEW_PROJECT="新しいプロジェクト";
const String NEW_STATION="新しい駅";





///一つの路線集団
///KdiaProjecct外との直通や運用操作は考えなくて良い
class KdiaProject{
  UUID id=UUID.fromString(Uuid().v4());
  String filepath="";
  String name=NEW_PROJECT;
  List<Station> stations=[];
  List<Train>trains=[];
  List<TrainClass>trainClasses=[];
  List<Calendar>calendars=[];
  List<TimeTable>timetables=[];
  Map<UUID,Route?> routes={};


  ///サンプルプロジェクトを生成します
  void createSampleProject() {
    id = UUID.fromString("d4647048-0f31-4f27-bc59-2c79890355a6");
    name = "サンプルプロジェクト";
    stations.add(new Station()
      ..id = UUID.fromString("81d57f71-fac2-4e55-b5f8-b3db40214628")
      ..name = "横浜");
    stations[stations.length-1].stops.add(
        new Stop(stations[stations.length-1])
        ..id = UUID.fromString("5f8ff5bc-aa23-4a19-9b63-d0422dda5d2a")
        ..name = "横浜"
        ..shortName = "1");
    stations.add(new Station()
      ..id = UUID.fromString("9313510f-e605-4d38-b42e-ae9e28fcb1b3")
      ..name = "星川");
    stations[stations.length-1].stops.add(
        new Stop(stations[stations.length-1])
        ..id = UUID.fromString("9982adf6-18d2-416b-9dcb-a0919d00b912")
        ..name = "星川"
        ..shortName = "1");
    stations.add(new Station()
      ..id = UUID.fromString("7d9a837f-e41d-4c82-84b3-a46b5cff7be2")
      ..name = "西谷");
    stations[stations.length-1].stops.add(
        new Stop(stations[stations.length-1])
        ..id = UUID.fromString("7d9a837f-e41d-4c82-84b3-a46b5cff7be2")
        ..name = "西谷"
        ..shortName = "1");
    stations.add(new Station()
      ..id = UUID.fromString("53534708-9eac-418b-8640-671acbf247c2")
      ..name = "二俣川");
    stations[stations.length-1].stops.add(
        new Stop(stations[stations.length-1])
        ..id = UUID.fromString("ce1aeb53-d754-43f6-a058-30a637fa25f3")
        ..name = "二俣川"
        ..shortName = "1");
    stations.add(new Station()
      ..id = UUID.fromString("8cd6ccb0-a139-4cd5-ae6b-d5a8f64bab29")
      ..name = "大和");
        stations[stations.length-1].stops.add(
        new Stop(stations[stations.length-1])
        ..id = UUID.fromString("36411d14-765c-41f1-95e3-7fce84558923")
        ..name = "大和"
        ..shortName = "1");
    stations.add(new Station()
      ..id = UUID.fromString("60e1e918-81ab-437a-a3cc-b60c502eae9f")
      ..name = "海老名");
        stations[stations.length-1].stops.add(
        new Stop(stations[stations.length-1])
        ..id = UUID.fromString("4c7ea40a-aa40-4c95-8d76-c53009189e7c")
        ..name = "海老名"
        ..shortName = "1");
    stations.add(new Station()
      ..id = UUID.fromString("87ed37aa-8219-4252-8b08-e71c22a1d56f")
      ..name = "新宿");
        stations[stations.length-1].stops.add(
        new Stop(stations[stations.length-1])
        ..id = UUID.fromString("e57f3ee3-8e0a-4ce2-b981-98fb966cc846")
        ..name = "新宿"
        ..shortName = "1");
    stations.add(new Station()
      ..id = UUID.fromString("dbf73ecf-8a7f-452a-9248-b5d85c919b73")
      ..name = "湘南台");
        stations[stations.length-1].stops.add(
        new Stop(stations[stations.length-1])
        ..id = UUID.fromString("4d0d6c40-b85a-4ba2-a5b7-8bba64083a25")
        ..name = "湘南台"
        ..shortName = "1");
    trains.add(new Train(this)
      ..id = UUID.fromString("0200a722-ead5-4ff1-b681-c1bf5848aa3f")
      ..name = "相鉄本線下り"
      ..number = "1"
    );
    trains.add(new Train(this)
      ..id = UUID.fromString("28f1bb92-a4f4-4dd2-b3fd-b3193ac35691")
      ..name = "相鉄本線上り"
      ..number = "2"
    );
    trains.add(new Train(this)
      ..id = UUID.fromString("b20d194d-17a0-4353-a396-870a5ecf499a")
      ..name = "相鉄いずみ野線下り"
      ..number = "3"
    );
    trains.add(new Train(this)
      ..id = UUID.fromString("effcf5aa-2446-47f6-b885-569b589e14c2")
      ..name = "相鉄いずみ野線上り"
      ..number = "4"
    );
    trains.add(new Train(this)
      ..id = UUID.fromString("8bfb2913-5c1d-4a32-ace0-2442944cac0c")
      ..name = "直通線下り"
      ..number = "5"
    );
    trains.add(new Train(this)
      ..id = UUID.fromString("df78665e-cb07-4783-8ba7-c92ff0ab02d1")
      ..name = "直通線上り"
      ..number = "6"
    );
    trainClasses.add(new TrainClass()
      ..id = UUID.fromString("511abe32-5367-46c8-a408-f3d37e211d11")
      ..name = "普通"
      ..color = Color.fromARGB(255, 0, 0, 0)
    );
    trainClasses.add(new TrainClass()
      ..id = UUID.fromString("c192e0f7-8553-46f6-8080-8d12f205e01c")
      ..name = "快速"
      ..color = Color.fromARGB(255, 0, 0, 0)
    );
    trainClasses.add(new TrainClass()
      ..id = UUID.fromString("19768584-6cfe-491c-b85c-6ff07803e180")
      ..name = "急行"
      ..color = Color.fromARGB(255, 0, 0, 0)
    );
    trainClasses.add(new TrainClass()
      ..id = UUID.fromString("b2decba7-af2f-440f-a4d8-5f3938704cce")
      ..name = "特急"
      ..color = Color.fromARGB(255, 0, 0, 0)
    );
    calendars.add(new Calendar()
      ..name = "平日"
      ..id = UUID.fromString("7292b8ae-2971-4c93-ae55-feef22a9b8c2")
    );
    routes[UUID.fromString("c444bfa2-282e-4b98-9f20-1a2806c7984c")]=new Route(this);
    routes[UUID.fromString("8263ba6d-4264-4425-829e-1beee73abbc1")]=new Route(this);
    routes[UUID.fromString("40d01d47-3754-4dbc-8e31-a981e7f89eec")]=new Route(this);
    routes[UUID.fromString("2e0c2e2c-5ec1-4bf3-8015-9f0d8571cc4e")]=new Route(this);
    routes[UUID.fromString("48e954cf-6207-4cfa-9004-bfb37e535459")]=new Route(this);
    routes.forEach((key, value) {
      if(value!=null) {
        value.id = key;
      }
    });

  }
  ///CSV形式の文字列を出力します。
  String getCsv(){
    String result="";
    result+="<Project>\n";
    result+="id,name\n";
    result+=id.toString()+","+name+"\n";
    result+="<Route>\n";
    result+="id\n";

    result+="<Station>\n";
    result+=Station.getCsvTitle();
    for(Station s in stations){
      result+=s.getCsv();
    }
    result+="<Stop>\n";
    result+=Stop.getCsvTitle();
    for(Station s in stations){
      for(Stop stop in s.stops){
        result+=stop.getCsv();
      }
    }
    result+="<Train>\n";
    result+=Train.getCsvTitle();
    for(Train t in trains){
        result+=t.getCsv();
    }

    result+="<TrainClass>\n";
    result+=TrainClass.getCsvTitle();
    for(TrainClass trainClass in trainClasses){
      result+=trainClass.getCsv();
    }
    result+="<Calendar>\n";
    result+=Calendar.getCsvTitle();
    for(Calendar calendar in calendars){
      result+=calendar.getCsv();
    }



    result+="<Timetable>\n";
    result+=TimeTable.getCsvTitle();
    for(TimeTable timeTable in timetables){
      result+=timeTable.getCsv();
    }

    result+="<TimetableRoute>\n";
    result+=TimeTableRoute.getCsvTitle();
    for(TimeTable timeTable in timetables){
      timeTable.routes.asMap().forEach((index, route) {
        result+=route.getCsv(timeTable.id,index);

      });
    }
    result+="<TimetablePathStyle>\n";
    result+=TimeTablePathStyle.getCsvTitle();
    for(TimeTable timeTable in timetables){
      timeTable.pathStyle.forEach((element) {
        result+=element.getCsv(timeTable.id);
      });
    }
    result+="<TimetableTrain>\n";
    result+=TimeTable.getTimetableTrainCsvTitle();
    for(TimeTable timeTable in timetables){
      result+=timeTable.getTimetableTrainCsv();
    }
    return result;
  }

  //CSV形式で保存します
  void saveAsCsv(String fileName){
    print(this);
    new Directory('./'+fileName).create(recursive: true)
        .then((Directory directory) {
      var file = File(Directory.current.path+"/"+fileName+"/"+fileName+".csv");
      var sink = file.openWrite();
      String result=getCsv();
      sink.write(result);
      sink.close();
      routes.forEach((uuid, route) {
        result+=uuid.toString()+"\n";
        if(route!=null){
          route.saveAsCsv(Directory.current.path+"/"+fileName+"/");
        }
      });
    });



  }
  void fromCsvLine(List<String>line){
    if(line.length<2){
      throw new Exception("列数が足りない");
    }
    id=UUID.fromString(line[0]);
    name=line[1];
  }

  void loadCsv(String filePath){
    new File(filePath).readAsLines()
        .then((lines) async {
          await fromCsvFile(lines);
          saveAsCsv("test2");
    });
  }
  Future<void> fromCsvFile (List<String> dataList) async {
    String status="";
    bool titleLine=false;
    for(String line in dataList){
      if(line.startsWith("<")){
        status=line.substring(1,line.length-1);
        titleLine=true;
        continue;
      }
      if(titleLine){
        titleLine=false;
        continue;
      }
      switch(status){
        case "Project":
          fromCsvLine(line.split(","));
          break;
        case "Route":
          routes[UUID.fromString(line.split(",")[0])]=null;
          break;
        case "Station":
          Station station=new Station();
          station.fromCsvLine(line.split(","));
          stations.add(station);
          break;
        case "Stop":
          Stop stop=new Stop(new Station());
          stop.fromCsvLine(line.split(","),this);
          break;
        case "Train":

          Train train=new Train(this);
          train.fromCsvLine(line.split(","));
          trains.add(train);
          break;
        case "TrainClass":
          TrainClass trainClass=new TrainClass();
          trainClass.fromCsvLine(line.split(","));
          trainClasses.add(trainClass);
          break;
        case "Calendar":
          Calendar calendar=new Calendar();
          calendar.fromCsvLine(line.split(","));
          calendars.add(calendar);
          break;
        case "Timetable":
          TimeTable timetable=new TimeTable(this,new Calendar());
          timetable.fromCsvLine(line.split(","),this);
          timetables.add(timetable);
          break;
        case "TimetableRoute":
          TimeTableRoute.fromCsvLine(line.split(","),this);
          break;
        case "TimetablePathStyle":
          TimeTablePathStyle.fromCsvLine(line.split(","),this);
          break;
        case "TimetableTrain":
          TimeTable.fromTimetableTrainCsvLine(line.split(","),this);
          break;
      }


    }

  }

  Calendar getCalendar(UUID uuid){
    for(Calendar c in calendars){
      if(c.id==uuid){
        return c;
      }
    }
    throw new Exception("uuid:${(uuid)} is not calendar's id");
  }

  TimeTable getTimeTable(UUID uuid){
    for(TimeTable t in timetables){
      if(t.id==uuid){
        return t;
      }
    }
    throw new Exception("uuid:${(uuid)} is not timetable's id");
  }
  Train getTrain(UUID uuid){
    for(Train t in trains){
      if(t.id==uuid){
        return t;
      }
    }
    throw new Exception("uuid:${(uuid)} is not train's id");
  }
  TrainClass getTrainClass(UUID uuid){
    for(TrainClass t in trainClasses){
      if(t.id==uuid){
        return t;
      }
    }
    throw new Exception("uuid:${(uuid)} is not trainClass's id");
  }
  Station getStation(UUID uuid){
    for(Station s in stations){
      if(s.id==uuid){
        return s;
      }
    }
    throw new Exception("uuid:${(uuid)} is not station's id");
  }



  ///sampleを読み込む
Future<void>loadSample()async{
  String data=await rootBundle.loadString('sampleData/sample.csv');
  this.fromCsvFile(data.split("\n"));
  print("loadSample");
  for (var key in routes.keys) {
    routes[key]=new Route(this);
    String data2=await rootBundle.loadString('sampleData/$key.csv');
    routes[key]?.fromCsvFile(data2.split("\n"));
  }
  routes.forEach((key, value)async {
    print("$key,${value?.id},${key==value?.id}");
  });


}
Route getRoute(UUID routeID){
    if(routes[routeID]!=null){
      return routes[routeID]!;
    }
    throw new Exception("$routeID:routeが読み込まれていません。　あらかじめrouteを読み込んでください");
}

Future<Route> prepareRoute(UUID routeID)async{
    if(routes[routeID]==null){
      routes[routeID]=new Route(this);
      String data2=await rootBundle.loadString('sampleData/$routeID.csv');
      routes[routeID]?.fromCsvFile(data2.split("\n"));
    }
    return routes[routeID]!;

}




}
///一つの駅を表す
///駅はKdiaProject内で
class Station{
  UUID id=UUID.fromString(Uuid().v4());
  String name=NEW_STATION;
  //北緯 + 南緯 -
  double lat=35;
  //東経 + 西経 -
  double lon=135;

  List<Stop> stops=[];
  static getCsvTitle(){
    return "id,name,lat,lon\n";
  }
  String getCsv(){
    return "$id,$name,$lat,$lon\n";
  }
  void fromCsvLine(List<String>line){
    if(line.length<4){
      throw new Exception("Station CSV読み込み列数が足りない");
    }
    id=UUID.fromString(line[0]);
    name=line[1];
    lat=double.parse(line[2]);
    lon=double.parse(line[3]);

  }

  Stop getStop(UUID uuid){
    for(Stop s in stops){
      if(s.id==uuid){
        return s;
      }
    }
    throw new Exception("uuid:${(uuid)} is not stop's id");

  }




}
///駅の中の１つの番線を示す。
///列車が停車するポイント
class Stop{
  UUID id=UUID.fromString(Uuid().v4());
  String name="";
  String shortName="";
  Station station;
  Stop(this.station);
  static getCsvTitle(){
    return "id,station_id,name,shortName\n";
  }
  String getCsv(){
    return "$id,${(station.id)},$name,$shortName\n";
  }
  void fromCsvLine(List<String>line,KdiaProject project){
    if(line.length<4){
      throw new Exception("Stop CSV読み込み列数が足りない");
    }
    id=UUID.fromString(line[0]);
    station=project.getStation(UUID.fromString(line[1]));
    station.stops.add(this);
    name=line[2];
    shortName=line[3];
  }





}

///１つの路線を示します
///
///RouteはOuDiaの１ファイルに似ていますが、分岐を許しません
///Routeはループ構造や「の」の字構造を許します。
///
///
class Route{
  UUID id=UUID.fromString(Uuid().v4());
  KdiaProject project;
  String name="";
  Color routeColor=Color.fromARGB(255, 0, 0, 0);
  List<Path> paths=[];
  List<Trip> trips=[];
  Route(this.project) {
  }


  void saveAsCsv(String path){
    var file = File(path+id.toString()+".csv");
    var sink = file.openWrite();
    String result=getCsv();
    sink.write(result);
    sink.close();

  }
  static getCsvTitle(){
    return "id,name,routeColor\n";
  }
  String getCsv(){
    String result="";
    result+="<Route>\n";
    result+=getCsvTitle();
    result+="$id,$name,${routeColor.toString().substring(6,16)}\n";
    result+="<Path>\n";
    result+=Path.getCsvTitle();
    paths.asMap().forEach((index, path) {
      result+=path.getCsv(index);
    });
    result+="<Trip>\n";
    result+=Trip.getCsvTitle();
    trips.forEach((trip) {
      result+=trip.getCsv();
    });
    result+="<PathTime>\n";
    result+=PathTime.getCsvTitle();
    trips.forEach((trip) {
      trip.pathTimes.asMap().forEach((index, pathTime) {
        result+=pathTime.getCsv();
      });
    });
    return result;
  }
  void fromCsvLine(List<String>line){
    id=UUID.fromString(line[0]);
    name=line[1];
    routeColor=new Color(int.parse(line[2]));
  }


  Future<void> loadCsv(String path,UUID id)async{
    List<String> lines=await new File(path+"/"+id.toString()+".csv").readAsLines();
    fromCsvFile(lines);
  }

  void fromCsvFile(List<String> dataList){
    String status="";
    bool titleLine=false;

    status="Route";
    titleLine=true;
    for(String line in dataList){
      if(line.length==0){
        continue;
      }
      while(line.endsWith(",")){
        line=line.substring(0,line.length-1);
      }
      print(line);
      if(line.startsWith("<")){
        status=line.substring(1,line.length-1);
        titleLine=true;
        continue;
      }
      if(titleLine){
        titleLine=false;
        continue;
      }
      switch(status){
        case "Route":
          fromCsvLine(line.split(","));
          break;
        case "Path":
          Path path=new Path(new Station(),new Station());
          path.fromCsv(line.split(","), project);
          paths.add(path);
          break;
        case "Trip":
          Trip trip=new Trip(this, new Train(project));
          trip.fromCsvLine(line.split(","), project);
          trips.add(trip);
          break;
        case "PathTime":
          PathTime time=new PathTime(new Trip(this,new Train(project)),new Path(new Station(),new Station()), new Stop(new Station()));
          time.fromCsvLine(line.split(","), project, this);
      }


    }

  }


  Path getPath(UUID uuid){
    for(Path p in paths){
      if(p.id==uuid){
        return p;
      }
    }
    throw new Exception("uuid:${(uuid)} is not path's id");

  }
Trip getTrip(UUID uuid){
  for(Trip t in trips){
    if(t.id==uuid){
      return t;
    }
  }
  throw new Exception("uuid:${(uuid)} is not trip's id");

}




}

/// Pathは２つの駅をつなぎます。
/// RouteはPathの集合体として、１つの路線を形成します。
/// PathはProject直下に置かれるのではなく、Route内に置かれます
class Path{
  UUID id=UUID.fromString(Uuid().v4());
  Station start;
  Station end;
  Path(this.start,this.end);
  static getCsvTitle(){
    return "id,start_station_id,end_station_id,seq\n";
  }
  String getCsv(int seq){
    return "$id,${start.id},${end.id},$seq\n";
  }
  void fromCsv(List<String>line,KdiaProject project){
    id=UUID.fromString(line[0]);
    start=project.getStation(UUID.fromString(line[1]));
    end=project.getStation(UUID.fromString(line[2]));
  }

}

///１つの列車を表します。1Trainは複数のTripで構成されます。
///１つのTrainは時刻表上でできるだけまとめて表示されます。
///TrainはKdiaProject直下に置かれます
class Train{
  KdiaProject project;
  UUID id=UUID.fromString(Uuid().v4());
  String name="";
  String number="";
  Train(this.project);

  //uuid
  List<UUID> trips=[];

  static getCsvTitle(){
    return "id,name,number\n";
  }
  String getCsv(){
    return "$id,$name,$number\n";
  }
  void fromCsvLine(List<String>line){
    if(line.length<3){
      throw new Exception("Train CSV読み込み列数が足りない");
    }
    id=UUID.fromString(line[0]);
    name=line[1];
    number=line[2];
  }


}
///１つの列車行程を表します。
///Trip内では、列車番号、列車種別、運用車両の変更を許しません
///これらを変更する場合は別Tripを仕立て、両者を同一Train扱いしてください。
///
/// Tripは所属Routeが決まっています。
/// RouteにはTimePathの配列があるので、配列を用いて時刻情報を表します。
class Trip{
  UUID id=UUID.fromString(Uuid().v4());
  Direction direction=Direction.DOWN;
  TrainClass trainClass=TrainClass.DEFAULT();
  Route route;
  Train train;
  List<PathTime> pathTimes=[];
  Trip(this.route,this.train);

  static getCsvTitle(){
    return "id,direction,trainClass_id,train_id\n";
  }
  String getCsv(){
    return "$id,$direction,${trainClass.id},${(train.id)},\n";
  }
  void fromCsvLine(List<String>line,KdiaProject project){
    if(line.length<4){
      throw new Exception("Trip CSV読み込み列数が足りない");
    }
    id=UUID.fromString(line[0]);
//    direction=
    trainClass=project.getTrainClass(UUID.fromString(line[2]));
    train=project.getTrain(UUID.fromString(line[3]));
  }


}


///　駅間の時間を示します。
///
///
class PathTime {
  UUID id=UUID.fromString(Uuid().v4());
  Direction direction=Direction.DOWN;
  Trip trip;
  Path? path=null;
  Stop stop;
  int depTime = -1;
  int ariTime = -1;
  int stopPos = -1;
  StopType stopType=StopType.NO_SERVICE;
  PathTime(this.trip,this.path,this.stop);
  static getCsvTitle(){
    return "id,trip_id,direction,path_id,dep_time,ari_time,stop_id,stop_type\n";
  }
  String getCsv(){
    return "$id,${trip.id},$direction,${(path?.id)},$depTime,$ariTime,${(stop.id)},$stopType\n";
  }
  void fromCsvLine(List<String>line,KdiaProject project,Route route){
    if(line.length<8){
      throw new Exception("PathTime CSV読み込み列数が足りない");
    }
    id=UUID.fromString(line[0]);
    trip=route.getTrip(UUID.fromString(line[1]));
//    direction=
    if(line[3]!=""){
      path=route.getPath(UUID.fromString(line[3]));
    }
  if(line[4].length!=0){
    depTime=int.parse(line[4]);
    }
if(line[5].length!=0){
  ariTime=int.parse(line[5]);

}

//    stopType=int.parse(line[6]);
  trip.pathTimes.add(this);
  }


}

///列車の種別を示します。
class TrainClass{
  UUID id=UUID.fromString(Uuid().v4());
  String name="";
  Color color=Color.fromARGB(255, 0, 0, 0);
  TrainClass();
  TrainClass.DEFAULT(){
  }

  static getCsvTitle(){
    return "id,name,color\n";
  }
  String getCsv(){
    return "$id,$name,${color.toString().substring(6,16)}\n";
  }
  void fromCsvLine(List<String>line){
    if(line.length<3){
      throw new Exception("TrainClass CSV読み込み列数が足りない");
    }
    id=UUID.fromString(line[0]);
    name=line[1];
    color=new Color(int.parse(line[2]));
  }


}
class Calendar{
  UUID id=UUID.fromString(Uuid().v4());
  String name="";
  static getCsvTitle(){
    return "id,name\n";
  }
  String getCsv(){
    return "$id,$name\n";
  }
  void fromCsvLine(List<String>line){
    if(line.length<2){
      throw new Exception("Train CSV読み込み列数が足りない");
    }
    id=UUID.fromString(line[0]);
    name=line[1];
  }


}

enum Direction{
  DOWN,
  UP
}
enum StopType{
  NO_SERVICE,
  STOP,
  PASS,
  NO_VIA
}


