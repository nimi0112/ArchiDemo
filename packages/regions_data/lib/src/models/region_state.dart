import 'dart:convert';

import 'package:equatable/equatable.dart';

class RegionStatesResponse {
  final bool error;
  final String msg;
  final Data data;

  RegionStatesResponse({
    required this.error,
    required this.msg,
    required this.data,
  });

  factory RegionStatesResponse.fromRawJson(String str) =>
      RegionStatesResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RegionStatesResponse.fromJson(Map<String, dynamic> json) =>
      RegionStatesResponse(
        error: json["error"],
        msg: json["msg"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "msg": msg,
        "data": data.toJson(),
      };
}

class Data {
  final String name;
  final String iso3;
  final String iso2;
  final List<RegionState> states;

  Data({
    required this.name,
    required this.iso3,
    required this.iso2,
    required this.states,
  });

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        name: json["name"],
        iso3: json["iso3"],
        iso2: json["iso2"],
        states: List<RegionState>.from(
            json["states"].map((x) => RegionState.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "iso3": iso3,
        "iso2": iso2,
        "states": List<dynamic>.from(states.map((x) => x.toJson())),
      };
}

class RegionState extends Equatable {
  final String name;
  final String stateCode;

  RegionState({
    required this.name,
    required this.stateCode,
  });

  factory RegionState.fromRawJson(String str) =>
      RegionState.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RegionState.fromJson(Map<String, dynamic> json) => RegionState(
        name: json["name"],
        stateCode: json["state_code"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "state_code": stateCode,
      };

  @override
  List<Object> get props => [name, stateCode];
}
