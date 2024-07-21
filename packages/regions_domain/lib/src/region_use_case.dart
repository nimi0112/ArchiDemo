import 'package:regions_data/regions_data.dart';

class RegionUseCase {
  RegionUseCase(this.apiProvider);

  final ApiProvider apiProvider;

// Future<List<City>> getCitiesOfAState(
//   String countryCode,
//   String stateCode,
// ) async {
//   final allStates = await apiProvider.getCitiesList();
//
//   return allStates.fold((error) {
//     return [];
//   }, (success) {
//     return success
//         .where(
//           (state) =>
//               state.countryCode == countryCode &&
//               state.stateCode == stateCode,
//         )
//         .toList();
//   });
// }
}
