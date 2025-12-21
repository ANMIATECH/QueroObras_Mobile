

import 'dart:convert';

Availability availabilityFromJson(String str) => Availability.fromJson(json.decode(str));

String availabilityToJson(Availability data) => json.encode(data.toJson());

class Availability {
  final String? status;
  final List<Datum>? data;

  Availability({
    this.status,
    this.data,
  });

  Availability copyWith({
    String? status,
    List<Datum>? data,
  }) =>
      Availability(
        status: status ?? this.status,
        data: data ?? this.data,
      );

  factory Availability.fromJson(Map<String, dynamic> json) => Availability(
    status: json["status"],
    data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Datum {
  final int? id;
  final String? userId;
  final String? day;
  final String? dayPt;
  final String? startTime;
  final String? endTime;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Datum({
    this.id,
    this.userId,
    this.day,
    this.dayPt,
    this.startTime,
    this.endTime,
    this.createdAt,
    this.updatedAt,
  });

  Datum copyWith({
    int? id,
    String? userId,
    String? day,
    String? dayPt,
    String? startTime,
    String? endTime,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      Datum(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        day: day ?? this.day,
        dayPt: dayPt ?? this.dayPt,
        startTime: startTime ?? this.startTime,
        endTime: endTime ?? this.endTime,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    userId: json["user_id"],
    day: json["day"],
    dayPt: json["day_pt"],
    startTime: json["start_time"],
    endTime: json["end_time"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "day": day,
    "day_pt": dayPt,
    "start_time": startTime,
    "end_time": endTime,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}
