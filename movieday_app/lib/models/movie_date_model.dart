import 'package:flutter/cupertino.dart';

class MovieDate {
  final String day;
  final String month;
  final String hour;

  const MovieDate({
    required this.day,
    required this.month,
    required this.hour,
  });

  factory MovieDate.fromJson(Map<String, dynamic> json) => MovieDate(
        day: json["day"] == null ? null : json["day"],
        month: json["month"] == null ? null : json["month"],
        hour: json["hour"] == null ? null : json["hour"]
    );

    Map<String, dynamic> toJson() => {
        "day": day == null ? null : day,
        "month" : month == null ? null : month,
        "hour": hour == null ? null : hour
    };
}

class Seat {
  final String seccion;
  final bool isHidden;
  final bool isOcuppied;
  bool isSelected;
  int numAsiento;

  Seat({
    required this.seccion,
    required this.isHidden,
    required this.isOcuppied,
    this.isSelected = false,
    required this.numAsiento
  });
}

class SeatType {
  final String name;
  final Color color;

  const SeatType({
    required this.name,
    required this.color,
  });
}