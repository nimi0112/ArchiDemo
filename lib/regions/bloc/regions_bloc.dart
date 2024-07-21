import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:regions_data/regions_data.dart';
import 'package:regions_domain/regions_domain.dart';

part 'regions_event.dart';
part 'regions_state.dart';

class RegionsBloc extends Bloc<RegionsEvent, RegionsState> {
  RegionsBloc({
    required this.apiProvider,
    required this.regionUseCase,
  }) : super(const RegionsState()) {
    on<GetCountriesList>(_getGetCountriesList);
    on<GetStatesList>(_getStatesList);
    on<GetCitiesList>(_getCitiesList);
  }

  final ApiProvider apiProvider;
  final RegionUseCase regionUseCase;

  FutureOr<void> _getGetCountriesList(
    GetCountriesList event,
    Emitter<RegionsState> emit,
  ) async {
    emit(
      state.copyWith(
        isCountriesLoading: true,
        cities: const [],
        states: const [],
      ),
    );
    final result = await apiProvider.getCountriesList();
    emit(
      result.fold(
        (error) {
          return state.copyWith(isCountriesLoading: false);
        },
        (success) {
          success.sort((a, b) => a.name.compareTo(b.name));
          return state.copyWith(
            isCountriesLoading: false,
            countries: success,
            cities: const [],
            states: const [],
          );
        },
      ),
    );
  }

  FutureOr<void> _getStatesList(
      GetStatesList event, Emitter<RegionsState> emit) async {
    emit(state.copyWith(isStatesLoading: true));
    final result = await apiProvider.getStatesList(event.countryName);
    emit(
      result.fold(
        (error) {
          return state.copyWith(
            isStatesLoading: false,
            cities: const [],
          );
        },
        (success) {
          success.sort((a, b) => a.name.compareTo(b.name));
          return state.copyWith(
            isStatesLoading: false,
            states: success,
            selectedCountry: event.countryName,
            cities: [],
          );
        },
      ),
    );
  }

  FutureOr<void> _getCitiesList(
    GetCitiesList event,
    Emitter<RegionsState> emit,
  ) async {
    emit(state.copyWith(isCitiesLoading: true));
    final result = await apiProvider.getCitiesList(
      state.selectedCountry!,
      event.stateName,
    );
    emit(
      result.fold(
        (error) {
          return state.copyWith(isCitiesLoading: false);
        },
        (success) {
          return state.copyWith(
            isCitiesLoading: false,
            cities: success,
            selectedState: event.stateName,
          );
        },
      ),
    );
  }
}
