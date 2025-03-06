import 'package:dartz/dartz.dart';
import 'package:event_app/core/response_error/view/response_error.dart';
import 'package:event_app/features/agenda/data/datasource/agenda_remote_data_source.dart';
import 'package:event_app/features/agenda/data/models/agenda_model.dart';
import 'package:event_app/features/agenda/domain/repositories/agenda_repository.dart';

class AgendaRepositoryImpl implements AgendaRepository {
  AgendaRepositoryImpl({required this.agendaRemoteDataSource});
  final AgendaRemoteDataSource agendaRemoteDataSource;

  @override
  Future<Either<ResponseError, List<AgendaModel>>> getAgenda() async {
    try {
      final response = await agendaRemoteDataSource.getAgenda();

      return response.isNotEmpty
          ? Right(response)
          : Left(ResponseError(errorStatus: 'An Error Occured, Try Again'));
    } on ResponseError catch (e) {
      return Left(e);
    } catch (e) {
      return Left(ResponseError(errorStatus: 'Unexpected Error'));
    }
  }
}
