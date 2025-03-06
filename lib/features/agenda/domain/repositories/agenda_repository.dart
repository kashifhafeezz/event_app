import 'package:dartz/dartz.dart';
import 'package:event_app/core/response_error/view/response_error.dart';
import 'package:event_app/features/agenda/data/models/agenda_model.dart';

abstract class AgendaRepository {
  Future<Either<ResponseError, List<AgendaModel>>> getAgenda();
}
