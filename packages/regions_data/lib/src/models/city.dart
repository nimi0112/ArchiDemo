import 'dart:convert';

import 'package:equatable/equatable.dart';

class CityResponse extends Equatable {
  final bool error;
  final String msg;
  final List<String> data;

  CityResponse({
    required this.error,
    required this.msg,
    required this.data,
  });

  factory CityResponse.fromRawJson(String str) =>
      CityResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CityResponse.fromJson(Map<String, dynamic> json) =>
      CityResponse(
        error: json["error"],
        msg: json["msg"],
        data: List<String>.from(json["data"].map((x) => x)),
      );

  Map<String, dynamic> toJson() =>
      {
        "error": error,
        "msg": msg,
        "data": List<dynamic>.from(data.map((x) => x)),
      };

  @override
  List<Object> get props => [error, msg, data];
}
