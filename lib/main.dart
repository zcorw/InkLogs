import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ink_logs/model/main.dart';
import 'package:ink_logs/model/models.dart';
import 'package:scoped_model/scoped_model.dart';

import './widget/schedule.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    MainModel mainModel = MainModel();
    return ScopedModel<MainModel>(
        model: mainModel,
        child: MaterialApp(
          title: 'InkLogs',
          theme: ThemeData(
            // This is the theme of your application.
            //
            // Try running your application with "flutter run". You'll see the
            // application has a blue toolbar. Then, without quitting the app, try
            // changing the primarySwatch below to Colors.green and then invoke
            // "hot reload" (press "r" in the console where you ran "flutter run",
            // or simply save your changes to "hot reload" in a Flutter IDE).
            // Notice that the counter didn't reset back to zero; the application
            // is not restarted.
            primarySwatch: Colors.lightGreen,
          ),
          home: MyHomePage(title: '日程'),
        ));
  }
}

class MyHomePage extends StatelessWidget {
  final String title;
  const MyHomePage({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(this.title),
          // actions: [RefreshIcon()],
        ),
        body: Container(
            decoration: BoxDecoration(color: Color(0x5DD1D1D1)),
            child: ScheduleList()));
  }
}

// class RefreshIcon extends StatelessWidget {
//   const RefreshIcon({Key key}) : super(key: key);

//   void _handleRefresh(Function getData) {
//     getData();
//   }

//   @override
//   Widget build(BuildContext context) {
//     var model = ScheduleModel.of(context);
//     return IconButton(
//       icon: model.loading ? CupertinoActivityIndicator() : Icon(Icons.refresh),
//       tooltip: '刷新',
//       onPressed: () {
//         _handleRefresh(model.getSchedule);
//       },
//     );
//   }
// }
