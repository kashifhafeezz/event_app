import 'dart:convert';
import 'dart:developer';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:event_app/core/response_error/view/response_error.dart';
import 'package:event_app/features/speakers/data/datasource/speaker_remote_data_source.dart';
import 'package:event_app/features/speakers/data/models/speaker_model.dart';
import 'package:event_app/utils/client/api_client.dart';
import 'package:event_app/utils/constants/api_routes.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SpeakerRemoteDataSourceImpl implements SpeakerRemoteDataSource {
  const SpeakerRemoteDataSourceImpl({
    required this.client,
    required this.secureStorage,
    required this.connectivity,
  });

  final ApiClient client;
  final FlutterSecureStorage secureStorage;
  final Connectivity connectivity;
  static const String _speakerCacheKey = 'speaker_cache';
  static const String _speakerLastFetchTimeKey = 'speaker_last_fetch_time';
  static const int _cacheExpirationHours = 1; //Depend On Scenario

  @override
  Future<List<SpeakerModel>> getSpeaker() async {
    try {
      final connectivityResult = await connectivity.checkConnectivity();
      final hasInternet = connectivityResult != ConnectivityResult.none;

      final cachedData = await _getCachedSpeakers();
      final lastFetchTime = await _getLastFetchTime();
      final cacheExpired = _isCacheExpired(lastFetchTime);

      /// Use cache if available
      if (cachedData != null && (!cacheExpired || !hasInternet)) {
        log('Using cached speaker data');
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
        final freshData = await _fetchSpeakersFromApi();

        /// Cache the new data
        await _cacheSpeakers(freshData);
        await _updateLastFetchTime();

        return freshData;
      }

      return cachedData ?? [];
    } on ResponseError catch (e) {
      log('Speaker Error: ${e.errorStatus}');
      rethrow;
    } catch (e) {
      log('Unexpected error while fetching SPEAKER: $e');
      throw ResponseError(errorStatus: 'Unexpected error occurred');
    }
  }

  // Fetch data from API
  Future<List<SpeakerModel>> _fetchSpeakersFromApi() async {
    final response = await client.request(
      path: ApiRoutes().speakers,
      method: HttpMethod.post,
      queryParameters: {'EventId': 1},
    );

    if (response.isSuccess) {
      if (response.data is List) {
        final resultList = response.data as List<dynamic>;
        final speakerItems = resultList
            .map((item) => SpeakerModel.fromJson(item as Map<String, dynamic>))
            .toList();

        return speakerItems;
      } else {
        throw ResponseError(errorStatus: response.message.toString());
      }
    }
    throw ResponseError(errorStatus: response.message.toString());
  }

  // Get cached speakers data
  Future<List<SpeakerModel>?> _getCachedSpeakers() async {
    try {
      final cachedJsonString = await secureStorage.read(key: _speakerCacheKey);
      if (cachedJsonString == null) return null;

      final dynamic decodedData = jsonDecode(cachedJsonString);
      if (decodedData is! List) {
        log('Cached speaker data is not a List');
        return null;
      }

      final decodedList = decodedData;
      return decodedList
          .map((item) => SpeakerModel.fromJson(item as Map<String, dynamic>))
          .toList();
    } catch (e) {
      log('Error reading cached speakers: $e');
      return null;
    }
  }

  // Cache speakers data
  Future<void> _cacheSpeakers(List<SpeakerModel> speakerItems) async {
    try {
      final jsonList = speakerItems.map((item) => item.toJson()).toList();
      await secureStorage.write(
        key: _speakerCacheKey,
        value: jsonEncode(jsonList),
      );
      log('Speaker data cached successfully');
    } catch (e) {
      log('Error caching speaker data: $e');
    }
  }

  // Get the timestamp of the last fetch
  Future<DateTime?> _getLastFetchTime() async {
    try {
      final timeString =
          await secureStorage.read(key: _speakerLastFetchTimeKey);
      if (timeString == null) return null;

      return DateTime.parse(timeString);
    } catch (e) {
      log('Error reading last fetch time for speakers: $e');
      return null;
    }
  }

  // Update the last fetch timestamp
  Future<void> _updateLastFetchTime() async {
    try {
      final now = DateTime.now().toIso8601String();
      await secureStorage.write(key: _speakerLastFetchTimeKey, value: now);
    } catch (e) {
      log('Error updating last fetch time for speakers: $e');
    }
  }

  // Check if the cache has expired
  bool _isCacheExpired(DateTime? lastFetchTime) {
    if (lastFetchTime == null) return true;

    final now = DateTime.now();
    final difference = now.difference(lastFetchTime);
    return difference.inHours > _cacheExpirationHours;
  }

  // Force refresh speaker data from API
  Future<List<SpeakerModel>> refreshSpeakers() async {
    try {
      final freshData = await _fetchSpeakersFromApi();
      await _cacheSpeakers(freshData);
      await _updateLastFetchTime();
      return freshData;
    } catch (e) {
      final cachedData = await _getCachedSpeakers();
      if (cachedData != null) {
        log('Refresh failed, using cached data: $e');
        return cachedData;
      }
      rethrow;
    }
  }
}
