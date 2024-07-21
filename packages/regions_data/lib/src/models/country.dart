import 'dart:convert';

import 'package:equatable/equatable.dart';

class CountryResponse extends Equatable {
  final bool error;
  final String msg;
  final List<Country> data;

  CountryResponse({
    required this.error,
    required this.msg,
    required this.data,
  });

  factory CountryResponse.fromRawJson(String str) =>
      CountryResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CountryResponse.fromJson(Map<String, dynamic> json) =>
      CountryResponse(
        error: json["error"],
        msg: json["msg"],
        data: List<Country>.from(json["data"].map((x) => Country.fromJson(x))),
      );

  Map<String, dynamic> toJson() =>
      {
        "error": error,
        "msg": msg,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };

  @override
  List<Object> get props => [error, msg, data];
}

class Country extends Equatable {
  final String name;
  final String iso2;
  final String iso3;
  final String unicodeFlag;

  Country({
    required this.name,
    required this.iso2,
    required this.iso3,
    required this.unicodeFlag,
  });

  factory Country.fromRawJson(String str) => Country.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Country.fromJson(Map<String, dynamic> json) =>
      Country(
        name: json["name"],
        iso2: json["iso2"],
        iso3: json["iso3"],
        unicodeFlag: json["unicodeFlag"],
      );

  Map<String, dynamic> toJson() =>
      {
        "name": name,
        "iso2": iso2,
        "iso3": iso3,
        "unicodeFlag": unicodeFlag,
      };

  @override
  List<Object> get props => [name, iso2, iso3, unicodeFlag];
}
