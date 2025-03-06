import 'package:json_annotation/json_annotation.dart';
part 'ask_question_request_model.g.dart';

@JsonSerializable(checked: true, includeIfNull: false)
class AskQuestionRequestModel {
  AskQuestionRequestModel({
    required this.eventId,
    required this.speakerName,
    required this.askedBy,
    required this.questionDetail,
  });

  factory AskQuestionRequestModel.fromJson(Map<String, dynamic> json) =>
      _$AskQuestionRequestModelFromJson(json);

  @JsonKey(name: 'EventId')
  final int eventId;

  @JsonKey(name: 'SpeakerName')
  final String speakerName;

  @JsonKey(name: 'AskedBy')
  final String askedBy;

  @JsonKey(name: 'QuestionDetail')
  final String questionDetail;

  Map<String, dynamic> toJson() => _$AskQuestionRequestModelToJson(this);
}
