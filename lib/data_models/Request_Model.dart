import 'package:test_app/data_models/User_Account_Model.dart';

class RequestModel {
  final String id;
  final String clientId;
  final String workerId;
  final Location location;
  final DateTime requestDate;
  final DateTime createDate;
  final String details;

  const RequestModel(
      {required this.id,
      required this.clientId,
      required this.workerId,
      required this.location,
      required this.requestDate,
      required this.createDate,
      required this.details});

  toJson() {
    return {
      "client_id": clientId,
      "worker_id": workerId,
      "location": location.toJson(),
      "request_date": requestDate.millisecondsSinceEpoch,
      "create_date": createDate.millisecondsSinceEpoch,
      "details": details,
    };
  }

  factory RequestModel.fromJson(Map<String, dynamic> json) {
    return RequestModel(
        id: 'id',
        clientId: json['client_id'],
        workerId: json['worker_id'],
        location: Location.fromJson(json['location']),
        requestDate:
            DateTime.fromMillisecondsSinceEpoch(json['request_date'] * 1000),
        createDate:
            DateTime.fromMillisecondsSinceEpoch(json['create_date'] * 1000),
        details: json["details"]);
  }
}
