part of 'regions_bloc.dart';

@immutable
class RegionsState extends Equatable {
  const RegionsState({
    this.countries = const [],
    this.states = const [],
    this.cities = const [],
    this.isCountriesLoading = true,
    this.isStatesLoading = false,
    this.isCitiesLoading = false,
    this.selectedCountry,
    this.selectedState,
  });

  final List<Country> countries;
  final List<RegionState> states;
  final List<String> cities;
  final bool isCountriesLoading;
  final bool isStatesLoading;
  final bool isCitiesLoading;
  final String? selectedCountry;
  final String? selectedState;

  RegionsState copyWith({
    List<Country>? countries,
    List<RegionState>? states,
    List<String>? cities,
    bool? isCountriesLoading,
    bool? isStatesLoading,
    bool? isCitiesLoading,
    String? selectedCountry,
    String? selectedState,
  }) {
    return RegionsState(
      countries: countries ?? this.countries,
      states: states ?? this.states,
      cities: cities ?? this.cities,
      isCountriesLoading: isCountriesLoading ?? this.isCountriesLoading,
      isStatesLoading: isStatesLoading ?? this.isStatesLoading,
      isCitiesLoading: isCitiesLoading ?? this.isCitiesLoading,
      selectedCountry: selectedCountry ?? this.selectedCountry,
      selectedState: selectedState ?? this.selectedState,
    );
  }

  @override
  List<Object?> get props => [
        countries,
        states,
        cities,
        isCountriesLoading,
        isStatesLoading,
        isCitiesLoading,
        selectedCountry,
        selectedState,
      ];
}
