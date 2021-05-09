import 'dart:typed_data';

import 'package:uuid/uuid.dart';

String bool2Str(bool value){
  if(value){
    return "1";
  }else{
    return "0";
  }
}

class UUID{
  Uint8List value=new Uint8List(16);
  UUID(){
    value=Uuid.parseAsByteList(Uuid().v4());
  }

  static UUID fromString(String uuidString){
    if(uuidString==""){
     return new UUID();
    }
    UUID uuid=new UUID();
    uuid.value=Uuid.parseAsByteList(uuidString);
    return uuid;
  }
  @override
  bool operator ==(Object other) {
    if(other is UUID){
      if(this.value.length==other.value.length){
        for(int i=0;i<this.value.length;i++){
          if(this.value[i]==other.value[i]){

          }else{
            return false;
          }
        }
        return true;
      }
    }
    return false;
  }
  bool isNull() {
    for (int i = 0; i < this.value.length; i++) {
      if (this.value[i] != 0) {
        return false;
      }
    }
    return true;
  }

  @override
  int get hashCode{
    int hash=0;
    for(int a in value){
      hash^=a;
    }
  return hash;
  }

  @override
  String toString() {
    return Uuid.unparse(value);
  }
}
