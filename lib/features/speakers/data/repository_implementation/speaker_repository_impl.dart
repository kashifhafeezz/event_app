import 'package:dartz/dartz.dart';
import 'package:event_app/core/response_error/view/response_error.dart';
import 'package:event_app/features/speakers/data/datasource/speaker_remote_data_source.dart';
import 'package:event_app/features/speakers/data/models/speaker_model.dart';
import 'package:event_app/features/speakers/domain/repositories/speaker_repository.dart';

class SpeakerRepositoryImpl implements SpeakerRepository {
  SpeakerRepositoryImpl({required this.speakerRemoteDataSource});
  final SpeakerRemoteDataSource speakerRemoteDataSource;

  @override
  Future<Either<ResponseError, List<SpeakerModel>>> getSpeaker() async {
    try {
      final response = await speakerRemoteDataSource.getSpeaker();

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
