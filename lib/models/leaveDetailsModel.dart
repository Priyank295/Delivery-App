// ignore: file_names
class LeaveDetailsModel {
  String start;
  String end;
  String status;
  String reason;

  LeaveDetailsModel(
      {required this.start,
      required this.end,
      required this.reason,
      required this.status});

  factory LeaveDetailsModel.fromJson(Map<String, dynamic> json) {
    return LeaveDetailsModel(
        start: json['start_date'],
        end: json['end_date'],
        reason: json['reason'],
        status: json['status']);
  }

  Map<String, dynamic> toJson() {
    return {
      "start_date": start,
      "end_date": end,
      "reason": reason,
      "status": status
    };
  }
}
