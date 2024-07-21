import 'package:arch_demo/regions/bloc/regions_bloc.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:regions_data/regions_data.dart';
import 'package:regions_domain/regions_domain.dart';

// Mock classes
class MockApiProvider extends Mock implements ApiProvider {}

class MockRegionUseCase extends Mock implements RegionUseCase {}

void main() {
  late RegionsBloc regionsBloc;
  late MockApiProvider mockApiProvider;
  late MockRegionUseCase mockRegionUseCase;

  setUp(() {
    mockApiProvider = MockApiProvider();
    mockRegionUseCase = MockRegionUseCase();
    regionsBloc = RegionsBloc(
      apiProvider: mockApiProvider,
      regionUseCase: mockRegionUseCase,
    );
  });

  group('RegionsBloc', () {
    blocTest<RegionsBloc, RegionsState>(
      'emits [loading, success] when GetCountriesList is added and apiProvider.getCountriesList returns success',
      build: () {
        when(() => mockApiProvider.getCountriesList())
            .thenAnswer((_) async => Right([
                  Country(
                      name: 'Country1',
                      iso2: 'Country1 ISO2',
                      iso3: 'Country1 ISO3',
                      unicodeFlag: ''),
                  Country(
                      name: 'Country2',
                      iso2: 'Country2 ISO2',
                      iso3: 'Country2 ISO3',
                      unicodeFlag: '')
                ]));
        return regionsBloc;
      },
      act: (bloc) => bloc.add(GetCountriesList()),
      expect: () => [
        RegionsState(
          isCountriesLoading: true,
          selectedCountry: '',
          selectedState: '',
        ),
        RegionsState(
            isCountriesLoading: false,
            countries: [
              Country(
                  name: 'Country1',
                  iso2: 'Country1 ISO2',
                  iso3: 'Country1 ISO3',
                  unicodeFlag: ''),
              Country(
                  name: 'Country2',
                  iso2: 'Country2 ISO2',
                  iso3: 'Country2 ISO3',
                  unicodeFlag: '')
            ],
            selectedCountry: '',
            selectedState: ''),
      ],
      verify: (_) {
        verify(() => mockApiProvider.getCountriesList()).called(1);
      },
    );

    blocTest<RegionsBloc, RegionsState>(
      'emits [loading, failure] when GetCountriesList is added and apiProvider.getCountriesList returns failure',
      build: () {
        when(() => mockApiProvider.getCountriesList())
            .thenAnswer((_) async => Left([]));
        return regionsBloc;
      },
      act: (bloc) => bloc.add(GetCountriesList()),
      expect: () => [
        RegionsState(
            isCountriesLoading: true, selectedCountry: '', selectedState: ''),
        RegionsState(
            isCountriesLoading: false, selectedCountry: '', selectedState: ''),
      ],
      verify: (_) {
        verify(() => mockApiProvider.getCountriesList()).called(1);
      },
    );

    blocTest<RegionsBloc, RegionsState>(
      'emits [loading, failure] when GetStatesList is added and apiProvider.getStatesList returns failure',
      build: () {
        when(() => mockApiProvider.getStatesList(any()))
            .thenAnswer((_) async => Left([]));
        return regionsBloc;
      },
      act: (bloc) => bloc.add(GetStatesList(countryName: 'Country1')),
      expect: () => [
        RegionsState(
          isStatesLoading: true,
          selectedCountry: 'Country1',
        ),
        RegionsState(
          isStatesLoading: false,
          selectedCountry: 'Country1',
        ),
      ],
      verify: (_) {
        verify(() => mockApiProvider.getStatesList('Country1')).called(1);
      },
    );

    blocTest<RegionsBloc, RegionsState>(
      'emits [loading, success] when GetCitiesList is added and apiProvider.getCitiesList returns success',
      build: () {
        when(() => mockApiProvider.getCitiesList(any(), any()))
            .thenAnswer((_) async => Right(['City1', 'City2']));
        return regionsBloc;
      },
      act: (bloc) => bloc.add(GetCitiesList(stateName: 'State1')),
      seed: () => RegionsState(selectedCountry: 'Country1'),
      expect: () => [
        RegionsState(isCitiesLoading: true, selectedCountry: 'Country1'),
        RegionsState(
            isCitiesLoading: false,
            cities: ['City1', 'City2'],
            selectedCountry: 'Country1',
            selectedState: 'State1'),
      ],
      verify: (_) {
        verify(() => mockApiProvider.getCitiesList('Country1', 'State1'))
            .called(1);
      },
    );

    blocTest<RegionsBloc, RegionsState>(
      'emits [loading, failure] when GetCitiesList is added and apiProvider.getCitiesList returns failure',
      build: () {
        when(() => mockApiProvider.getCitiesList(any(), any()))
            .thenAnswer((_) async => Left([]));
        return regionsBloc;
      },
      act: (bloc) => bloc.add(GetCitiesList(stateName: 'State1')),
      seed: () => RegionsState(selectedCountry: 'Country1'),
      expect: () => [
        RegionsState(isCitiesLoading: true, selectedCountry: 'Country1'),
        RegionsState(isCitiesLoading: false, selectedCountry: 'Country1'),
      ],
      verify: (_) {
        verify(() => mockApiProvider.getCitiesList('Country1', 'State1'))
            .called(1);
      },
    );
  });
}
// dart lib/helpers/mqtt_connection.dart
