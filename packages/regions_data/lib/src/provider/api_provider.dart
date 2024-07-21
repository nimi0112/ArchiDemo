import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:regions_data/src/models/city.dart';

import '../api_constants.dart';
import '../models/country.dart';
import '../models/region_state.dart' as sta;
import '../models/region_state.dart';
import 'dio_provider.dart';

class ApiProvider {
  factory ApiProvider() {
    return _instance;
  }

  ApiProvider._internal();

  static final ApiProvider _instance = ApiProvider._internal();
  Dio _dio = DioProvider.getDio();

  Future<Either<dynamic, List<Country>>> getCountriesList() async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        apiCountries,
      );
      print(json.encode(response.data));
      return Right(CountryResponse.fromJson(response.data!).data);
    } catch (e) {
      return Left(e);
    }
  }

  Future<Either<dynamic, List<sta.RegionState>>> getStatesList(
      String countryName) async {
    try {
      final response = await _dio.post(
        apiStates,
        data: {
          'country': countryName,
        },
      );
      return Right(RegionStatesResponse.fromJson(response.data!).data.states);
    } catch (e) {
      return Left(e);
    }
  }

  Future<Either<dynamic, List<String>>> getCitiesList(
    String countryName,
    String stateName,
  ) async {
    try {
      final response = await _dio.post(
        apiCities,
        data: {
          'country': countryName,
          'state': stateName,
        },
      );
      return Right(CityResponse.fromJson(response.data!).data);
    } catch (e) {
      return Left(e);
    }
  }
}
