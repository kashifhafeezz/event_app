import 'package:json_annotation/json_annotation.dart';
part 'agenda_model.g.dart';

@JsonSerializable()
class AgendaModel {
  AgendaModel({
    required this.id,
    required this.eventId,
    required this.title,
    required this.date,
    required this.time,
    required this.topic,
    required this.speakerName,
    required this.day,
    required this.specialCell,
    required this.injection,
  });

  factory AgendaModel.fromJson(Map<String, dynamic> json) =>
      _$AgendaModelFromJson(json);

  @JsonKey(name: 'id')
  final int id;

  @JsonKey(name: 'Eventid')
  final int eventId;

  @JsonKey(name: 'Title')
  final String title;

  @JsonKey(name: 'date')
  final String date;

  @JsonKey(name: 'time')
  final String time;

  @JsonKey(name: 'topic')
  final String topic;

  @JsonKey(name: 'speaker_name')
  final String speakerName;

  @JsonKey(name: 'day')
  final String day;

  @JsonKey(name: 'specialcell')
  final String specialCell;

  @JsonKey(name: 'injection')
  final String injection;

  Map<String, dynamic> toJson() => _$AgendaModelToJson(this);
}
