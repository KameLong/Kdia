import 'package:flutter/cupertino.dart';
import 'package:kdia/KdiaData/KLlibrary.dart';
import 'package:kdia/KdiaData/KdiaData.dart';
import 'package:kdia/KdiaData/KdiaTimeTable.dart';

class TimeTableView extends StatefulWidget {
  TimeTable timeTable;
  Direction direction;
  TimeTableView(this.timeTable,this.direction){

  }
  @override
  _TimeTableViewState createState() => _TimeTableViewState();
}

class _TimeTableViewState extends State<TimeTableView> {
  @override
  Widget build(BuildContext context) {
    List<Widget> widgetList=[];
    widgetList.add(new TimeTableStationView(widget.timeTable, widget.direction));
    if(widget.direction==Direction.DOWN){
      for(Train train in widget.timeTable.downTrain) {
        widgetList.add(new TimeTableTrainView( widget.timeTable, train, widget.direction));
      }
    }
    return Row(children: widgetList,);
  }
}

class TimeTableTrainView extends StatefulWidget {
  TimeTable timeTable;
  Train train;
  Direction direction;
  TimeTableTrainView(this.timeTable,this.train,this.direction){

  }



  @override
  _TimeTableTrainViewState createState() => _TimeTableTrainViewState();
}

class _TimeTableTrainViewState extends State<TimeTableTrainView> {
  String timeInt2Str(int time,StopType stopType){
    switch(stopType)
    {
      case StopType.NO_SERVICE:
        return "• •";
      case StopType.NO_VIA:
        return "| |";
      case StopType.PASS:
        return "ﾚ";
      case StopType.STOP:
        if(time<0){
          return "◯";
        }
        String hh=((time/3600)%24).toString();
        String mm=((time/60)%60).toString().padLeft(2,"0");
        return hh+mm;
    }
    return "e";
  }
  @override
  Widget build(BuildContext context) {
    List<Widget>stationList=[];
    widget.timeTable.pathStyle.forEach((pathStyle) {
      Path path=widget.timeTable.getPath(pathStyle.pathID);
      if(widget.direction==Direction.DOWN){
        if(pathStyle.showDown& 0x01!=0){
          //発時刻
          // Text text=new Text(widget.train.getPathTime(path.id));
          // stationList.add(text);
        }
        if(pathStyle.showDown& 0x02!=0){
          //着時刻
          Text text=new Text(widget.timeTable.getPath(pathStyle.pathID).end.name);
          stationList.add(text);
        }
      }else{
        if(pathStyle.showDown& 0x01!=0){
          //発時刻
          Text text=new Text(widget.timeTable.getPath(pathStyle.pathID).end.name);
          stationList.add(text);
        }
        if(pathStyle.showDown& 0x02!=0){
          //着時刻
          Text text=new Text(widget.timeTable.getPath(pathStyle.pathID).start.name);
          stationList.add(text);
        }

      }
    });
    return Column(children: stationList);
  }
}

class TimeTableStationView extends StatefulWidget {
  TimeTable timeTable;
  Direction direction=Direction.DOWN;
  TimeTableStationView(this.timeTable,this.direction);
  @override
  _TimeTableStationViewState createState() => _TimeTableStationViewState();
}

class _TimeTableStationViewState extends State<TimeTableStationView> {
  @override
  Widget build(BuildContext context) {
    List<Widget>stationList=[];
    widget.timeTable.pathStyle.forEach((pathStyle) {
      if(widget.direction==Direction.DOWN){
        if(pathStyle.showDown& 0x01!=0){
          //発時刻
          Text text=new Text(widget.timeTable.getPath(pathStyle.pathID).start.name+" 発");
          stationList.add(text);
        }
        if(pathStyle.showDown& 0x02!=0){
          //着時刻
          Text text=new Text(widget.timeTable.getPath(pathStyle.pathID).end.name+" 着");
          stationList.add(text);
        }
      }else{
        if(pathStyle.showDown& 0x01!=0){
          //発時刻
          Text text=new Text(widget.timeTable.getPath(pathStyle.pathID).end.name);
          stationList.add(text);
        }
        if(pathStyle.showDown& 0x02!=0){
          //着時刻
          Text text=new Text(widget.timeTable.getPath(pathStyle.pathID).start.name);
          stationList.add(text);
        }

      }
    });
    return Column(children: stationList);
  }
}

