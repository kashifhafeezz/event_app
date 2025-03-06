import 'dart:developer';
import 'package:event_app/core/response_error/view/response_error.dart';
import 'package:event_app/features/speakers/data/datasource/speaker_remote_data_source.dart';
import 'package:event_app/features/speakers/data/models/speaker_model.dart';
import 'package:event_app/utils/client/api_client.dart';
import 'package:event_app/utils/constants/api_routes.dart';

class SpeakerRemoteDataSourceImpl implements SpeakerRemoteDataSource {
  const SpeakerRemoteDataSourceImpl({required this.client});
  final ApiClient client;

  @override
  Future<List<SpeakerModel>> getSpeaker() async {
    try {
      final response = await client.request(
        path: ApiRoutes().speakers,
        method: HttpMethod.post,
        queryParameters: {'EventId': 1},
      );
      if (response.isSuccess) {
        if (response.data is List) {
          final resultList = response.data as List<dynamic>;
          final speakerItems = resultList
              .map(
                  (item) => SpeakerModel.fromJson(item as Map<String, dynamic>))
              .toList();

          return speakerItems;
        } else {
          throw ResponseError(errorStatus: response.message.toString());
        }
      }
      throw ResponseError(errorStatus: response.message.toString());
    } on ResponseError catch (e) {
      log('Speaker Error: ${e.errorStatus}');
      rethrow;
    } catch (e) {
      log('Unexpected error during while fetching SPEAKER: $e');
      throw ResponseError(errorStatus: 'Unexpected error occurred');
    }
  }
}
