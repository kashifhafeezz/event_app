import 'package:dartz/dartz.dart';
import 'package:event_app/core/response_error/view/response_error.dart';
import 'package:event_app/core/usecase/view/use_case.dart';
import 'package:event_app/features/agenda/data/models/agenda_model.dart';
import 'package:event_app/features/agenda/domain/repositories/agenda_repository.dart';

class AgendaUsecase extends UseCase<List<AgendaModel>, NoParams> {
  AgendaUsecase({required this.agendaRepository});
  final AgendaRepository agendaRepository;

  @override
  Future<Either<ResponseError, List<AgendaModel>>> call(NoParams params) async {
    return agendaRepository.getAgenda();
  }
}
