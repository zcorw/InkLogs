import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ink_logs/model/models.dart';
import 'package:scoped_model/scoped_model.dart';

import '../common/util.dart';

/// 对战列表
class ScheduleList extends StatelessWidget {
  const ScheduleList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(builder: (context, child, model) {
      print(model.list);
      return getListW(model.list);
    });
  }
}

Widget getListW(List<ScheldulePeriod> list) {
  if (list == null) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: dp(3), horizontal: dp(20)),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(dp(6.0)),
          border: Border.all(
              color: Color.fromRGBO(250, 250, 250, 250), width: dp(1))),
      child: Center(
        child: CupertinoActivityIndicator(),
      ),
    );
  } else {
    return Container(
        child: ListView.builder(
            itemCount: list.length,
            itemBuilder: (context, idx) {
              SchelduleData league = list[idx].leagueBattle;
              SchelduleData gachi = list[idx].gachiBattle;
              SchelduleData regular = list[idx].regularBattle;
              return Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: dp(3), horizontal: dp(20)),
                  child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(dp(6.0)),
                          border: Border.all(
                              color: Color.fromRGBO(250, 250, 250, 250),
                              width: dp(1))),
                      child: Column(
                        children: [
                          TimeTag(time: list[idx].timeFormat),
                          Row(
                            children: [
                              Schedule(
                                  type: 1,
                                  mode: regular.gameMode,
                                  stage1: StageInfo.from(regular, 1),
                                  stage2: StageInfo.from(regular, 2)),
                              Schedule(
                                  type: 2,
                                  mode: gachi.gameMode,
                                  stage1: StageInfo.from(gachi, 1),
                                  stage2: StageInfo.from(gachi, 2)),
                              Schedule(
                                  type: 3,
                                  mode: league.gameMode,
                                  stage1: StageInfo.from(league, 1),
                                  stage2: StageInfo.from(league, 2)),
                            ],
                          )
                        ],
                      )));
            }));
  }
}

/// 对战时间
class TimeTag extends StatelessWidget {
  final String time;
  const TimeTag({Key key, @required this.time}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: DecoratedBox(
          decoration: BoxDecoration(
            //背景渐变
            borderRadius: BorderRadius.circular(3.0),
            color: Colors.grey,
          ), //3像素圆角
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
            child: Text(
              this.time,
              style: TextStyle(color: Colors.white),
            ),
          )),
    );
  }
}

/// 单次对战信息
class Schedule extends StatelessWidget {
  final int type;
  final String mode;
  final StageInfo stage1;
  final StageInfo stage2;
  const Schedule(
      {Key key,
      @required this.type,
      @required this.mode,
      @required this.stage1,
      @required this.stage2})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: 1,
        child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 3.0),
            child: Column(
              children: [
                ScheduleTitle(
                  text: this.mode,
                  type: this.type,
                ),
                Stage(
                  info: stage1,
                ),
                Stage(
                  info: stage2,
                ),
              ],
            )));
  }
}

/// 场地信息
class StageInfo {
  String name;
  String id;

  StageInfo.from(SchelduleData data, int idx) {
    if (idx == 1) {
      id = data.stage1Id;
      name = data.stage1Name;
    } else if (idx == 2) {
      id = data.stage2Id;
      name = data.stage2Name;
    } else {
      throw '地图信息序号只有1和2';
    }
  }
}

/// 场地
class Stage extends StatelessWidget {
  final StageInfo info;

  const Stage({
    Key key,
    @required this.info,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final id = info.id;
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.symmetric(vertical: dp(5.0)),
          child: Text(
            info.name,
            style: TextStyle(
              fontFamily: 'Splatfont2',
            ),
          ),
        ),
        DecoratedBox(
          position: DecorationPosition.foreground,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(dp(6.0)),
              border: Border.all(
                  color: Color.fromRGBO(250, 250, 250, 1), width: dp(3))),
          child: ClipRRect(
              child: Image.asset('images/stage/stage-$id.png'),
              borderRadius: BorderRadius.circular(dp(6.0))),
        )
      ],
    );
  }
}

/// 对战内容标题
class ScheduleTitle extends StatelessWidget {
  final String text;
  final int type;

  const ScheduleTitle({Key key, @required this.text, @required this.type})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: dp(30),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: dp(25),
              height: dp(25),
              margin: EdgeInsets.only(right: dp(5)),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: getIcon(),
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
            Text(
              text,
              style: TextStyle(
                  color: Color(0xff333333),
                  fontSize: dp(12),
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Splatfont1',
                  shadows: [
                    Shadow(
                        color: Color.fromRGBO(0, 0, 0, 0.8),
                        offset: Offset(1, 0))
                  ]),
            ),
          ],
        ));
  }

  AssetImage getIcon() {
    switch (this.type) {
      case 1:
        return AssetImage('images/icon/RegularBattle_page-0001.jpg');
      case 2:
        return AssetImage('images/icon/RankedBattle_page-0001.jpg');
      case 3:
        return AssetImage('images/icon/LeagueBattle_page-0001.jpg');
      default:
        return AssetImage('images/icon/RegularBattle_page-0001.jpg');
    }
  }
}
