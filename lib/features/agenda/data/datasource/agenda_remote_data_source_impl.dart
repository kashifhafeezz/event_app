import 'dart:convert';
import 'dart:developer';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:event_app/core/response_error/view/response_error.dart';
import 'package:event_app/features/agenda/data/datasource/agenda_remote_data_source.dart';
import 'package:event_app/features/agenda/data/models/agenda_model.dart';
import 'package:event_app/utils/client/api_client.dart';
import 'package:event_app/utils/constants/api_routes.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AgendaRemoteDataSourceImpl implements AgendaRemoteDataSource {
  const AgendaRemoteDataSourceImpl({
    required this.client,
    required this.secureStorage,
    required this.connectivity,
  });

  final ApiClient client;
  final FlutterSecureStorage secureStorage;
  final Connectivity connectivity;
  static const String _agendaCacheKey = 'agenda_cache';
  static const String _agendaLastFetchTimeKey = 'agenda_last_fetch_time';
  static const int _cacheExpirationHours = 1; //Depend On Scenario

  @override
  Future<List<AgendaModel>> getAgenda() async {
    try {
      final connectivityResult = await connectivity.checkConnectivity();
      final hasInternet = connectivityResult != ConnectivityResult.none;

      final cachedData = await _getCachedAgenda();
      final lastFetchTime = await _getLastFetchTime();
      final cacheExpired = _isCacheExpired(lastFetchTime);

      /// Use cache if available
      if (cachedData != null && (!cacheExpired || !hasInternet)) {
        log('Using cached agenda data');
        return cachedData;
      }

      /// If no internet and no cache, throw an error
      if (!hasInternet && cachedData == null) {
        throw ResponseError(
          errorStatus: 'No internet connection and no cached data available',
        );
      }

      /// If we have internet, fetch fresh data
      if (hasInternet) {
        final freshData = await _fetchAgendaFromApi();

        /// Cache the new data
        await _cacheAgenda(freshData);
        await _updateLastFetchTime();

        return freshData;
      }

      return cachedData ?? [];
    } on ResponseError catch (e) {
      log('Agenda Error: ${e.errorStatus}');
      rethrow;
    } catch (e) {
      log('Unexpected error while fetching AGENDA: $e');
      throw ResponseError(errorStatus: 'Unexpected error occurred');
    }
  }

  /// Fetch data from API
  Future<List<AgendaModel>> _fetchAgendaFromApi() async {
    final response = await client.request(
      path: ApiRoutes().agenda,
      method: HttpMethod.post,
      queryParameters: {'EventId': 1},
    );

    if (response.isSuccess) {
      if (response.data is List) {
        final resultList = response.data as List<dynamic>;
        final agendaItems = resultList
            .map((item) => AgendaModel.fromJson(item as Map<String, dynamic>))
            .toList();

        return agendaItems;
      } else {
        throw ResponseError(errorStatus: response.message.toString());
      }
    }
    throw ResponseError(errorStatus: response.message.toString());
  }

  /// Get cached agenda data
  Future<List<AgendaModel>?> _getCachedAgenda() async {
    try {
      final cachedJsonString = await secureStorage.read(key: _agendaCacheKey);
      if (cachedJsonString == null) return null;

      final dynamic decodedData = jsonDecode(cachedJsonString);
      if (decodedData is! List) {
        log('Cached data is not a List');
        return null;
      }

      final decodedList = decodedData;
      return decodedList
          .map((item) => AgendaModel.fromJson(item as Map<String, dynamic>))
          .toList();
    } catch (e) {
      log('Error reading cached agenda: $e');
      return null;
    }
  }

  /// Cache agenda data
  Future<void> _cacheAgenda(List<AgendaModel> agendaItems) async {
    try {
      final jsonList = agendaItems.map((item) => item.toJson()).toList();
      await secureStorage.write(
        key: _agendaCacheKey,
        value: jsonEncode(jsonList),
      );
      log('Agenda data cached successfully');
    } catch (e) {
      log('Error caching agenda data: $e');
    }
  }

  /// Get the timestamp of the last fetch
  Future<DateTime?> _getLastFetchTime() async {
    try {
      final timeString = await secureStorage.read(key: _agendaLastFetchTimeKey);
      if (timeString == null) return null;

      return DateTime.parse(timeString);
    } catch (e) {
      log('Error reading last fetch time: $e');
      return null;
    }
  }

  /// Update the last fetch timestamp
  Future<void> _updateLastFetchTime() async {
    try {
      final now = DateTime.now().toIso8601String();
      await secureStorage.write(key: _agendaLastFetchTimeKey, value: now);
    } catch (e) {
      log('Error updating last fetch time: $e');
    }
  }

  /// Check if the cache has expired
  bool _isCacheExpired(DateTime? lastFetchTime) {
    if (lastFetchTime == null) return true;

    final now = DateTime.now();
    final difference = now.difference(lastFetchTime);
    return difference.inHours > _cacheExpirationHours;
  }

  /// Force refresh agenda data from API
  Future<List<AgendaModel>> refreshAgenda() async {
    try {
      final freshData = await _fetchAgendaFromApi();
      await _cacheAgenda(freshData);
      await _updateLastFetchTime();
      return freshData;
    } catch (e) {
      final cachedData = await _getCachedAgenda();
      if (cachedData != null) {
        log('Refresh failed, using cached data: $e');
        return cachedData;
      }
      rethrow;
    }
  }
}
