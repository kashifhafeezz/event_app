import 'package:dartz/dartz.dart';
import 'package:event_app/core/response_error/view/response_error.dart';
import 'package:event_app/features/speakers/data/models/speaker_model.dart';

abstract class SpeakerRepository {
  Future<Either<ResponseError, List<SpeakerModel>>> getSpeaker();
}
