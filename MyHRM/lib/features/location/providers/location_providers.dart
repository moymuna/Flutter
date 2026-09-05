import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_hrm/shared/providers.dart';
import 'package:my_hrm/features/location/data/location_repository.dart';
import 'package:my_hrm/features/location/data/models/country.dart';
import 'package:my_hrm/features/location/data/models/division.dart';
import 'package:my_hrm/features/location/data/models/district.dart';
import 'package:my_hrm/features/location/data/models/police_station.dart';

final locationRepositoryProvider = Provider<LocationRepository>((ref) {
  return LocationRepository(ref.watch(apiClientProvider));
});

// ── Countries ──────────────────────────────────────────
final countriesProvider = FutureProvider<List<CountryResponse>>((ref) async {
  final repo = ref.watch(locationRepositoryProvider);
  return repo.getAllCountries();
});

// ── Divisions (depends on countryId) ───────────────────
final selectedCountryProvider = StateProvider<int?>((ref) => null);

final divisionsProvider =
    FutureProvider.family<List<DivisionResponse>, int>((ref, countryId) async {
  final repo = ref.watch(locationRepositoryProvider);
  return repo.getDivisionsByCountry(countryId);
});

// ── Districts (depends on divisionId) ──────────────────
final selectedDivisionProvider = StateProvider<int?>((ref) => null);

final districtsProvider =
    FutureProvider.family<List<DistrictResponse>, int>((ref, divisionId) async {
  final repo = ref.watch(locationRepositoryProvider);
  return repo.getDistrictsByDivision(divisionId);
});

// ── Police Stations (depends on districtId) ────────────
final selectedDistrictProvider = StateProvider<int?>((ref) => null);

final policeStationsProvider = FutureProvider.family<List<PoliceStationResponse>,
    int>((ref, districtId) async {
  final repo = ref.watch(locationRepositoryProvider);
  return repo.getPoliceStationsByDistrict(districtId);
});
