import 'package:finedust/model/stat_model.dart';
import 'package:finedust/model/status_model.dart';

class StatAndStatusModel {
  // 미세먼지 / 초미세먼지
  final ItemCode itemCode;
  final StatusModel status;
  final StatModel stat;

  StatAndStatusModel({
    required this.itemCode,
    required this.status,
    required this.stat,
  });
}
