// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'agenda_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AgendaModel _$AgendaModelFromJson(Map<String, dynamic> json) => AgendaModel(
      id: (json['id'] as num).toInt(),
      eventId: (json['Eventid'] as num).toInt(),
      title: json['Title'] as String,
      date: json['date'] as String,
      time: json['time'] as String,
      topic: json['topic'] as String,
      speakerName: json['speaker_name'] as String,
      day: json['day'] as String,
      specialCell: json['specialcell'] as String,
      injection: json['injection'] as String,
    );

Map<String, dynamic> _$AgendaModelToJson(AgendaModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'Eventid': instance.eventId,
      'Title': instance.title,
      'date': instance.date,
      'time': instance.time,
      'topic': instance.topic,
      'speaker_name': instance.speakerName,
      'day': instance.day,
      'specialcell': instance.specialCell,
      'injection': instance.injection,
    };
