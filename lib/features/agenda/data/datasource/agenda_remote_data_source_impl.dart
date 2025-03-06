import 'dart:developer';
import 'package:event_app/core/response_error/view/response_error.dart';
import 'package:event_app/features/agenda/data/datasource/agenda_remote_data_source.dart';
import 'package:event_app/features/agenda/data/models/agenda_model.dart';
import 'package:event_app/utils/client/api_client.dart';
import 'package:event_app/utils/constants/api_routes.dart';

class AgendaRemoteDataSourceImpl implements AgendaRemoteDataSource {
  const AgendaRemoteDataSourceImpl({required this.client});
  final ApiClient client;

  @override
  Future<List<AgendaModel>> getAgenda() async {
    try {
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
    } on ResponseError catch (e) {
      log('Agenda Error: ${e.errorStatus}');
      rethrow;
    } catch (e) {
      log('Unexpected error during while fetching AGENDA: $e');
      throw ResponseError(errorStatus: 'Unexpected error occurred');
    }
  }
}
