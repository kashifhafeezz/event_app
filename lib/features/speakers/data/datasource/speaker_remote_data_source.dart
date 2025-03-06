import 'package:event_app/features/speakers/data/models/speaker_model.dart';

abstract class SpeakerRemoteDataSource {
  Future<List<SpeakerModel>> getSpeaker();
}
