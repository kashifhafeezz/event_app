import 'package:json_annotation/json_annotation.dart';
part 'speaker_model.g.dart';

@JsonSerializable()
class SpeakerModel {
  SpeakerModel({
    required this.eventId,
    required this.id,
    required this.speakerName,
    required this.speakerDesignation,
    required this.speakerBio,
    required this.speakerImage,
    required this.speakerType,
    required this.order,
  });

  factory SpeakerModel.fromJson(Map<String, dynamic> json) =>
      _$SpeakerModelFromJson(json);

  @JsonKey(name: 'Eventid')
  final int eventId;

  @JsonKey(name: 'id')
  final int id;

  @JsonKey(name: 'speaker_name')
  final String speakerName;

  @JsonKey(name: 'speaker_designation')
  final String speakerDesignation;

  @JsonKey(name: 'speaker_bio')
  final String speakerBio;

  @JsonKey(name: 'speaker_image')
  final String speakerImage;

  @JsonKey(name: 'speaker_type')
  final String speakerType;

  @JsonKey(name: 'Order')
  final int order;

  Map<String, dynamic> toJson() => _$SpeakerModelToJson(this);
}
