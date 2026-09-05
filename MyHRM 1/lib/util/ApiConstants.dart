import 'dart:io';

import 'package:flutter/foundation.dart';

class ApiConstants {

  ApiConstants._();

  /// Base API URL — same host Angular's `environment.apiUrl` pointed to.
  /// Example given by the user: http://localhost:8085/api/
  static const String baseUrl = 'http://localhost:8085/api/';

  /// Base URL for served images (customer/agent/rider profile photos etc.)
  /// Mirrors Angular's `environment.imgUrl`.
  static const String imgUrl = 'http://10.0.2.2:8085/images/';

  // ── Auth ───────────────────────────────────────────────
  static const String login = 'auth/login';
  static const String forgotPassword = 'auth/forgot-password';
  static const String resetPassword = 'auth/reset-password';
  static const String verifyEmail = 'auth/verify-email';

  // ── Customer ───────────────────────────────────────────
  static const String employee = 'employee/';
  static String employeeByUserId(int userId) => 'employee/user/$userId';
  static String employeeById(int id) => 'employee/$id';

  // ── Address hierarchy ────────────────────────────────────
  static const String country = 'country/';
  static String divisionsByCountry(int countryId) =>
      'division/country/$countryId';
  static String districtsByDivision(int divisionId) => 'district/$divisionId';
  static String policeStationsByDistrict(int districtId) =>
      'policeStation/district/$districtId';
  static String policeStationSearch(String keyword) =>
      'policeStation/search?keyword=$keyword';

  // // ── Parcels ────────────────────────────────────────────
  // static const String parcels = 'parcels';
  // static const String bookParcel = 'parcels/book';
  // static String parcelsByCustomer(int customerId) =>
  //     'parcels/customer/$customerId';
  // static String trackParcel(String trackingCode) =>
  //     'parcels/track/$trackingCode';
  // static String cancelParcel(int id) => 'parcels/$id/cancel';
  // static const String calculateCharge = 'parcels/calculate';


}