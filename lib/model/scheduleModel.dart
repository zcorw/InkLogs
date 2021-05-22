import 'package:flutter/cupertino.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:flustars/flustars.dart';

import '../common/http.dart';

class ScheduleModel extends Model {
  List<ScheldulePeriod> list;
  bool loading = false;

  void getSchedule() async {
    loading = true;
    notifyListeners();

    final res = await appApiDio.get('/schedules');

    List league = res.data['league'];
    List regular = res.data['regular'];
    List gachi = res.data['gachi'];

    list = [];
    for (var i = 0; i < league.length; i++) {
      list.add(ScheldulePeriod(
          time: league[i]['start_time'],
          regular: SchelduleData.fromJSON(regular[i]),
          league: SchelduleData.fromJSON(league[i]),
          gachi: SchelduleData.fromJSON(gachi[i])));
    }
    loading = false;
    notifyListeners();
  }

  static ScheduleModel of(BuildContext context) =>
      ScopedModel.of<ScheduleModel>(context, rebuildOnChange: true);
}

/// 单场对战信息
class SchelduleData {
  String gameMode;
  String stage1Id;
  String stage2Id;
  String stage1Name;
  String stage2Name;
  SchelduleData.fromJSON(jsonRes) {
    gameMode = jsonRes['rule']['name'];
    stage1Id = jsonRes['stage_a']['id'];
    stage1Name = jsonRes['stage_a']['name'];
    stage2Id = jsonRes['stage_b']['id'];
    stage2Name = jsonRes['stage_b']['name'];
  }
}

/// 时间段对战信息
class ScheldulePeriod {
  int timestamp;
  String timeFormat;
  SchelduleData regularBattle;
  SchelduleData gachiBattle;
  SchelduleData leagueBattle;

  ScheldulePeriod(
      {int time,
      SchelduleData regular,
      SchelduleData gachi,
      SchelduleData league}) {
    regularBattle = regular;
    gachiBattle = gachi;
    leagueBattle = league;
    timestamp = time;

    final _timeFormat =
        DateUtil.formatDateMs(time * 1000, format: DateFormats.h_m);
    if (DateUtil.isToday(time * 1000)) {
      timeFormat = _timeFormat;
    } else {
      timeFormat = '明日 $_timeFormat';
    }
  }
}
