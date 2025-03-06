import 'package:event_app/features/agenda/data/models/agenda_model.dart';

abstract class AgendaRemoteDataSource {
  Future<List<AgendaModel>> getAgenda();
}
