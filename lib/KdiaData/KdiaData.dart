import 'dart:async';
import 'dart:math';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

import 'dart:typed_data';
import 'dart:ui';

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
  void _createTableV1(Batch batch) {
    batch.execute('''
create table station (id text,name text,lat real,lon real);
create table stop(id text,station_id text,seq int,name text,short_name text);
create table train(id text,name text,number text);
create table train_class(id text,name text,color text);
create table calendar(id text,name text);
create table timetable(id text,name text,calendar_id text);
create table timetable_route(id text,timetable_id text,route_id text,seq int,reversed int);
create table timetable_station_style(id text,timetable_id text,station_id text,is_main int,show_style_down int, show_style_up int);
create table timetable_train_seq(id text,timetable_id text,train_id text,direction int,seq int);
create table route(id text,name text,color text);
    ) ''');
  }
  createNewProject()async{
    print((await getApplicationDocumentsDirectory()).path);

    final String path = join((await getApplicationDocumentsDirectory()).path, "test.sql");
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        var batch = db.batch();
        _createTableV1(batch);
        await batch.commit();
      },
      onDowngrade: onDatabaseDowngradeDelete,
    );

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
  List<Trip> trips=[];
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

