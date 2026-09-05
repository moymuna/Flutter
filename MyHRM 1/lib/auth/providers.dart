import 'package:my_hrm/service/StorageService.dart';
import 'package:my_hrm/util/ApiClient.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Central place for cross-cutting singletons, mirroring how Angular's DI
/// container provided StorageService / HttpClient app-wide.

final secureStorageProvider = Provider<FlutterSecureStorage>((ref) {
  return const FlutterSecureStorage();
});


final storageServiceProvider = Provider<StorageService>((ref) {
  return StorageService(ref.watch(secureStorageProvider));
});


final apiClientProvider = Provider<ApiClient>((ref) {
  return ApiClient(ref.watch(storageServiceProvider));
});