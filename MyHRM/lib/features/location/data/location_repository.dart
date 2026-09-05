import 'package:dio/dio.dart';
import 'package:my_hrm/core/network/api_client.dart';
import 'package:my_hrm/core/constants/api_constants.dart';
import 'package:my_hrm/features/location/data/models/country.dart';
import 'package:my_hrm/features/location/data/models/division.dart';
import 'package:my_hrm/features/location/data/models/district.dart';
import 'package:my_hrm/features/location/data/models/police_station.dart';

class LocationRepository {
  LocationRepository(this._apiClient);
  final ApiClient _apiClient;

  Dio get _dio => _apiClient.dio;

  // ── Country ────────────────────────────────────────
  Future<List<CountryResponse>> getAllCountries() async {
    final res = await _dio.get(ApiConstants.countriesAll);
    return (res.data as List)
        .map((e) => CountryResponse.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<CountryResponse> getCountryById(int id) async {
    final res = await _dio.get(ApiConstants.countryById(id));
    return CountryResponse.fromJson(res.data as Map<String, dynamic>);
  }

  // ── Division ───────────────────────────────────────
  Future<List<DivisionResponse>> getDivisionsByCountry(int countryId) async {
    final res = await _dio.get(ApiConstants.divisionsByCountry(countryId));
    return (res.data as List)
        .map((e) => DivisionResponse.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<List<DivisionResponse>> getAllDivisions() async {
    final res = await _dio.get(ApiConstants.divisions);
    return (res.data as List)
        .map((e) => DivisionResponse.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  // ── District ───────────────────────────────────────
  Future<List<DistrictResponse>> getDistrictsByDivision(int divisionId) async {
    final res = await _dio.get(ApiConstants.districtsByDivision(divisionId));
    return (res.data as List)
        .map((e) => DistrictResponse.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<List<DistrictResponse>> getAllDistricts() async {
    final res = await _dio.get(ApiConstants.districts);
    return (res.data as List)
        .map((e) => DistrictResponse.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  // ── Police Station ─────────────────────────────────
  Future<List<PoliceStationResponse>> getPoliceStationsByDistrict(
      int districtId) async {
    final res =
        await _dio.get(ApiConstants.policeStationsByDistrict(districtId));
    return (res.data as List)
        .map((e) =>
            PoliceStationResponse.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<List<PoliceStationResponse>> getAllPoliceStations() async {
    final res = await _dio.get(ApiConstants.policeStations);
    return (res.data as List)
        .map((e) =>
            PoliceStationResponse.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
