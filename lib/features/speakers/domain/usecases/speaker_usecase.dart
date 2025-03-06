import 'package:dartz/dartz.dart';
import 'package:event_app/core/response_error/view/response_error.dart';
import 'package:event_app/core/usecase/view/use_case.dart';
import 'package:event_app/features/speakers/data/models/speaker_model.dart';
import 'package:event_app/features/speakers/domain/repositories/speaker_repository.dart';

class SpeakerUsecase extends UseCase<List<SpeakerModel>, NoParams> {
  SpeakerUsecase({required this.speakerRepository});
  final SpeakerRepository speakerRepository;

  @override
  Future<Either<ResponseError, List<SpeakerModel>>> call(
    NoParams params,
  ) async {
    return speakerRepository.getSpeaker();
  }
}
