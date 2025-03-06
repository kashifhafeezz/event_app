// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'speaker_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SpeakerModel _$SpeakerModelFromJson(Map<String, dynamic> json) => SpeakerModel(
      eventId: (json['Eventid'] as num).toInt(),
      id: (json['id'] as num).toInt(),
      speakerName: json['speaker_name'] as String,
      speakerDesignation: json['speaker_designation'] as String,
      speakerBio: json['speaker_bio'] as String,
      speakerImage: json['speaker_image'] as String,
      speakerType: json['speaker_type'] as String,
      order: (json['Order'] as num).toInt(),
    );

Map<String, dynamic> _$SpeakerModelToJson(SpeakerModel instance) =>
    <String, dynamic>{
      'Eventid': instance.eventId,
      'id': instance.id,
      'speaker_name': instance.speakerName,
      'speaker_designation': instance.speakerDesignation,
      'speaker_bio': instance.speakerBio,
      'speaker_image': instance.speakerImage,
      'speaker_type': instance.speakerType,
      'Order': instance.order,
    };
