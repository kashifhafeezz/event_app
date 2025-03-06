// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ask_question_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AskQuestionRequestModel _$AskQuestionRequestModelFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      'AskQuestionRequestModel',
      json,
      ($checkedConvert) {
        final val = AskQuestionRequestModel(
          eventId: $checkedConvert('EventId', (v) => (v as num).toInt()),
          speakerName: $checkedConvert('SpeakerName', (v) => v as String),
          askedBy: $checkedConvert('AskedBy', (v) => v as String),
          questionDetail: $checkedConvert('QuestionDetail', (v) => v as String),
        );
        return val;
      },
      fieldKeyMap: const {
        'eventId': 'EventId',
        'speakerName': 'SpeakerName',
        'askedBy': 'AskedBy',
        'questionDetail': 'QuestionDetail'
      },
    );

Map<String, dynamic> _$AskQuestionRequestModelToJson(
        AskQuestionRequestModel instance) =>
    <String, dynamic>{
      'EventId': instance.eventId,
      'SpeakerName': instance.speakerName,
      'AskedBy': instance.askedBy,
      'QuestionDetail': instance.questionDetail,
    };
