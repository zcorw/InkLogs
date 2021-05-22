import 'package:scoped_model/scoped_model.dart';

import './scheduleModel.dart';

class MainModel extends Model with ScheduleModel {
  MainModel() {
    getSchedule();
  }
}
