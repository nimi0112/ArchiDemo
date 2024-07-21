part of 'regions_bloc.dart';

@immutable
sealed class RegionsEvent {}

class GetCountriesList extends RegionsEvent {}

class GetStatesList extends RegionsEvent {
  GetStatesList({required this.countryName});

  final String countryName;
}

class GetCitiesList extends RegionsEvent {
  GetCitiesList({
    required this.stateName,
  });

  final String stateName;
}
