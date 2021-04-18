import 'package:flutter/cupertino.dart';

///一つの路線集団
///KdiaProjecct外との直通や運用操作は考えなくて良い
class KdiaProject{

}
///一つの駅を表す
///駅はKdiaProject内で
class Station{

}
///駅の中の１つの番線を示す。
///列車が停車するポイント
class Stop{

}

///１つの路線を示します
///
///RouteはOuDiaの１ファイルに似ていますが、分岐を許しません
///Routeはループ構造や「の」の字構造を許します。
///
///
class Route{

}

/// Pathは２つの駅をつなぎます。
/// RouteはPathの集合体として、１つの路線を形成します。
/// PathはProject直下に置かれるのではなく、Route内に置かれます
class Path{

}

///１つの列車を表します。1Trainは複数のTripで構成されます。
///１つのTrainは時刻表上でできるだけまとめて表示されます。
///TrainはKdiaProject直下に置かれます
class Train{

}
///１つの列車行程を表します。
///Trip内では、列車番号、列車種別、運用車両の変更を許しません
///これらを変更する場合は別Tripを仕立て、両者を同一Train扱いしてください。
///
/// Tripは所属Routeが決まっています。
/// RouteにはPathの配列があるので、配列を用いて時刻情報を表します。
class Trip{

}

class PathTime{

}