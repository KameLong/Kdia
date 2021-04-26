import 'package:kdia/KdiaData/KdiaTimeTable.dart';
import 'package:sqlite3/sqlite3.dart';
import 'dart:typed_data';
import 'dart:ui';
import 'dart:io';
import 'package:path/path.dart' as p;
import 'package:uuid/uuid.dart';


///文字列定義（日本語）
const String NEW_PROJECT="新しいプロジェクト";
const String NEW_STATION="新しい駅";





///一つの路線集団
///KdiaProjecct外との直通や運用操作は考えなくて良い
class KdiaProject{
  Uint8List id=Uuid.parseAsByteList(Uuid().v4());
  String name=NEW_PROJECT;
  List<Station> stations=[];
  List<Train>trains=[];
  List<TrainClass>trainClasses=[];
  List<Calendar>calendars=[];
  List<TimeTable>timetables=[];

  ///サンプルプロジェクトを生成します
  void createSampleProject() {
    id = Uuid.parseAsByteList("d4647048-0f31-4f27-bc59-2c79890355a6");
    name = "サンプルプロジェクト";
    stations.add(new Station()
      ..id = Uuid.parseAsByteList("81d57f71-fac2-4e55-b5f8-b3db40214628")
      ..name = "横浜"
      ..stops.add(new Stop()
        ..id = Uuid.parseAsByteList("5f8ff5bc-aa23-4a19-9b63-d0422dda5d2a")
        ..name = "横浜"
        ..shortName = "1"));
    stations.add(new Station()
      ..id = Uuid.parseAsByteList("9313510f-e605-4d38-b42e-ae9e28fcb1b3")
      ..name = "星川"
      ..stops.add(new Stop()
        ..id = Uuid.parseAsByteList("9982adf6-18d2-416b-9dcb-a0919d00b912")
        ..name = "星川"
        ..shortName = "1"));
    stations.add(new Station()
      ..id = Uuid.parseAsByteList("7d9a837f-e41d-4c82-84b3-a46b5cff7be2")
      ..name = "西谷"
      ..stops.add(new Stop()
        ..id = Uuid.parseAsByteList("7d9a837f-e41d-4c82-84b3-a46b5cff7be2")
        ..name = "西谷"
        ..shortName = "1"));
    stations.add(new Station()
      ..id = Uuid.parseAsByteList("53534708-9eac-418b-8640-671acbf247c2")
      ..name = "二俣川"
      ..stops.add(new Stop()
        ..id = Uuid.parseAsByteList("ce1aeb53-d754-43f6-a058-30a637fa25f3")
        ..name = "二俣川"
        ..shortName = "1"));
    stations.add(new Station()
      ..id = Uuid.parseAsByteList("8cd6ccb0-a139-4cd5-ae6b-d5a8f64bab29")
      ..name = "大和"
      ..stops.add(new Stop()
        ..id = Uuid.parseAsByteList("36411d14-765c-41f1-95e3-7fce84558923")
        ..name = "大和"
        ..shortName = "1"));
    stations.add(new Station()
      ..id = Uuid.parseAsByteList("60e1e918-81ab-437a-a3cc-b60c502eae9f")
      ..name = "海老名"
      ..stops.add(new Stop()
        ..id = Uuid.parseAsByteList("4c7ea40a-aa40-4c95-8d76-c53009189e7c")
        ..name = "海老名"
        ..shortName = "1"));
    stations.add(new Station()
      ..id = Uuid.parseAsByteList("87ed37aa-8219-4252-8b08-e71c22a1d56f")
      ..name = "新宿"
      ..stops.add(new Stop()
        ..id = Uuid.parseAsByteList("e57f3ee3-8e0a-4ce2-b981-98fb966cc846")
        ..name = "新宿"
        ..shortName = "1"));
    stations.add(new Station()
      ..id = Uuid.parseAsByteList("dbf73ecf-8a7f-452a-9248-b5d85c919b73")
      ..name = "湘南台"
      ..stops.add(new Stop()
        ..id = Uuid.parseAsByteList("4d0d6c40-b85a-4ba2-a5b7-8bba64083a25")
        ..name = "湘南台"
        ..shortName = "1"));
    trains.add(new Train()
      ..id = Uuid.parseAsByteList("0200a722-ead5-4ff1-b681-c1bf5848aa3f")
      ..name = "相鉄本線下り"
      ..number = "1"
    );
    trains.add(new Train()
      ..id = Uuid.parseAsByteList("28f1bb92-a4f4-4dd2-b3fd-b3193ac35691")
      ..name = "相鉄本線上り"
      ..number = "2"
    );
    trains.add(new Train()
      ..id = Uuid.parseAsByteList("b20d194d-17a0-4353-a396-870a5ecf499a")
      ..name = "相鉄いずみ野線下り"
      ..number = "3"
    );
    trains.add(new Train()
      ..id = Uuid.parseAsByteList("effcf5aa-2446-47f6-b885-569b589e14c2")
      ..name = "相鉄いずみ野線上り"
      ..number = "4"
    );
    trains.add(new Train()
      ..id = Uuid.parseAsByteList("8bfb2913-5c1d-4a32-ace0-2442944cac0c")
      ..name = "直通線下り"
      ..number = "5"
    );
    trains.add(new Train()
      ..id = Uuid.parseAsByteList("df78665e-cb07-4783-8ba7-c92ff0ab02d1")
      ..name = "直通線上り"
      ..number = "6"
    );
    trainClasses.add(new TrainClass()
      ..id = Uuid.parseAsByteList("511abe32-5367-46c8-a408-f3d37e211d11")
      ..name = "普通"
      ..color = Color.fromARGB(255, 0, 0, 0)
    );
    trainClasses.add(new TrainClass()
      ..id = Uuid.parseAsByteList("c192e0f7-8553-46f6-8080-8d12f205e01c")
      ..name = "快速"
      ..color = Color.fromARGB(255, 0, 0, 0)
    );
    trainClasses.add(new TrainClass()
      ..id = Uuid.parseAsByteList("19768584-6cfe-491c-b85c-6ff07803e180")
      ..name = "急行"
      ..color = Color.fromARGB(255, 0, 0, 0)
    );
    trainClasses.add(new TrainClass()
      ..id = Uuid.parseAsByteList("b2decba7-af2f-440f-a4d8-5f3938704cce")
      ..name = "特急"
      ..color = Color.fromARGB(255, 0, 0, 0)
    );
    calendars.add(new Calendar()
      ..name = "平日"
      ..id = Uuid.parseAsByteList("7292b8ae-2971-4c93-ae55-feef22a9b8c2")
    );
    timetables.add(new TimeTable(calendars[0])
      ..id=Uuid.parseAsByteList("0aee0d11-852e-4cb6-8834-71600a72774f")
      ..routes.add(Uuid.parseAsByteList("c444bfa2-282e-4b98-9f20-1a2806c7984c"))
      ..routes.add(Uuid.parseAsByteList("8263ba6d-4264-4425-829e-1beee73abbc1"))
      ..routes.add(Uuid.parseAsByteList("40d01d47-3754-4dbc-8e31-a981e7f89eec"))
      ..stationStyle[stations[0]]=(new TimeTableStationStyle()
        ..isMainStation=true
        ..showDown=1
        ..showp=2)
      ..stationStyle[stations[1]]=(new TimeTableStationStyle()
        ..isMainStation=false
        ..showDown=1
        ..showp=1)
      ..stationStyle[stations[2]]=(new TimeTableStationStyle()
        ..isMainStation=false
        ..showDown=1
        ..showp=1)
      ..stationStyle[stations[3]]=(new TimeTableStationStyle()
        ..isMainStation=true
        ..showDown=3
        ..showp=3)
      ..stationStyle[stations[4]]=(new TimeTableStationStyle()
        ..isMainStation=false
        ..showDown=1
        ..showp=1)
      ..stationStyle[stations[5]]=(new TimeTableStationStyle()
        ..isMainStation=true
        ..showDown=2
        ..showp=1)
      ..downTrain.add(trains[0])
      ..downTrain.add(trains[1])
      ..downTrain.add(trains[2])
      ..upTrain.add(trains[3])
      ..upTrain.add(trains[4])
      ..upTrain.add(trains[5])
    );
    timetables.add(new TimeTable(calendars[0])
      ..id=Uuid.parseAsByteList("d9490af9-7689-4bd3-9f62-59ce61705782")
      ..routes.add(Uuid.parseAsByteList("c444bfa2-282e-4b98-9f20-1a2806c7984c"))
      ..routes.add(Uuid.parseAsByteList("8263ba6d-4264-4425-829e-1beee73abbc1"))
      ..routes.add(Uuid.parseAsByteList("2e0c2e2c-5ec1-4bf3-8015-9f0d8571cc4e"))
      ..stationStyle[stations[0]]=(new TimeTableStationStyle()
        ..isMainStation=true
        ..showDown=1
        ..showp=2)
      ..stationStyle[stations[1]]=(new TimeTableStationStyle()
        ..isMainStation=false
        ..showDown=1
        ..showp=1)
      ..stationStyle[stations[2]]=(new TimeTableStationStyle()
        ..isMainStation=false
        ..showDown=1
        ..showp=1)
      ..stationStyle[stations[3]]=(new TimeTableStationStyle()
        ..isMainStation=true
        ..showDown=3
        ..showp=3)
      ..stationStyle[stations[7]]=(new TimeTableStationStyle()
        ..isMainStation=false
        ..showDown=2
        ..showp=1)
      ..downTrain.add(trains[1])
      ..downTrain.add(trains[2])
      ..downTrain.add(trains[0])
      ..upTrain.add(trains[4])
      ..upTrain.add(trains[5])
      ..upTrain.add(trains[3])
    );
    timetables.add(new TimeTable(calendars[0])
      ..id=Uuid.parseAsByteList("b10f5a85-893f-402f-b9df-c2a28ebd77a7")
      ..routes.add(Uuid.parseAsByteList("48e954cf-6207-4cfa-9004-bfb37e535459"))
      ..routes.add(Uuid.parseAsByteList("8263ba6d-4264-4425-829e-1beee73abbc1"))
      ..routes.add(Uuid.parseAsByteList("40d01d47-3754-4dbc-8e31-a981e7f89eec"))
      ..stationStyle[stations[6]]=(new TimeTableStationStyle()
        ..isMainStation=true
        ..showDown=1
        ..showp=2)
      ..stationStyle[stations[2]]=(new TimeTableStationStyle()
        ..isMainStation=false
        ..showDown=1
        ..showp=1)
      ..stationStyle[stations[3]]=(new TimeTableStationStyle()
        ..isMainStation=false
        ..showDown=3
        ..showp=3)
      ..stationStyle[stations[4]]=(new TimeTableStationStyle()
        ..isMainStation=false
        ..showDown=1
        ..showp=1)
      ..stationStyle[stations[5]]=(new TimeTableStationStyle()
        ..isMainStation=true
        ..showDown=2
        ..showp=1)
      ..downTrain.add(trains[2])
      ..downTrain.add(trains[0])
      ..downTrain.add(trains[1])
      ..upTrain.add(trains[5])
      ..upTrain.add(trains[3])
      ..upTrain.add(trains[4])
    );
    getCsv("test");

  }


  void getCsv(String fileName){
    print(Directory.current);
    String result="";
    result+="<Project>\n";
    result+="id,name\n";
    result+=Uuid.unparse(id)+","+name+"\n";
    result+="<Stations>\n";
    result+="id,name,lat,lon\n";
    for(Station s in stations){
      result+=s.getCsv();
    }

    var file = File('file.txt');
    var sink = file.openWrite();
    print(result);
    sink.write(result);
    sink.close();


  }






}
///一つの駅を表す
///駅はKdiaProject内で
class Station{
  Uint8List id=Uuid.parseAsByteList(Uuid().v4());
  String name=NEW_STATION;
  //北緯 + 南緯 -
  double lat=35;
  //東経 + 西経 -
  double lon=135;

  List<Stop> stops=[];
  String getCsv(){
    return "${Uuid.unparse(id)},$name,$lat,$lon\n";
  }

}
///駅の中の１つの番線を示す。
///列車が停車するポイント
class Stop{
  Uint8List id=Uuid.parseAsByteList(Uuid().v4());
  String name="";
  String shortName="";

}

///１つの路線を示します
///
///RouteはOuDiaの１ファイルに似ていますが、分岐を許しません
///Routeはループ構造や「の」の字構造を許します。
///
///
class Route{
  Uint8List id=Uuid.parseAsByteList(Uuid().v4());
  String name="";
  Color routeColor=Color.fromARGB(255, 0, 0, 0);
  List<Path> paths=[];


}

/// Pathは２つの駅をつなぎます。
/// RouteはPathの集合体として、１つの路線を形成します。
/// PathはProject直下に置かれるのではなく、Route内に置かれます
class Path{
  Uint8List id=Uuid.parseAsByteList(Uuid().v4());
  Station start;
  Station end;
  Path(this.start,this.end);

}

///１つの列車を表します。1Trainは複数のTripで構成されます。
///１つのTrainは時刻表上でできるだけまとめて表示されます。
///TrainはKdiaProject直下に置かれます
class Train{
  Uint8List id=Uuid.parseAsByteList(Uuid().v4());
  String name="";
  String number="";

  //uuid
  List<Uint8List> trips=[];
}
///１つの列車行程を表します。
///Trip内では、列車番号、列車種別、運用車両の変更を許しません
///これらを変更する場合は別Tripを仕立て、両者を同一Train扱いしてください。
///
/// Tripは所属Routeが決まっています。
/// RouteにはTimePathの配列があるので、配列を用いて時刻情報を表します。
class Trip{
  Uint8List id=Uuid.parseAsByteList(Uuid().v4());
  Direction direction=Direction.DOWN;
  TrainClass trainClass=TrainClass.DEFAULT();
}


///　駅間の時間を示します。
///
///
class PathTime {
  Uint8List id=Uuid.parseAsByteList(Uuid().v4());
  Direction direction=Direction.DOWN;
  Path path;
  int depTime = 0;
  int ariTime = 0;
  int stopPos = -1;
  StopType stopType=StopType.NO_SERVICE;

  PathTime(this.path);
}

///列車の種別を示します。
class TrainClass{
  Uint8List id=Uuid.parseAsByteList(Uuid().v4());
  String name="";
  Color color=Color.fromARGB(255, 0, 0, 0);
  TrainClass();
  TrainClass.DEFAULT(){
  }

}
class Calendar{
  Uint8List id=Uuid.parseAsByteList(Uuid().v4());
  String name="";

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

