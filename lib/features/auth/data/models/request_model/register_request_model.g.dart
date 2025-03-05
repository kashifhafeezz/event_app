// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegisterRequestModel _$RegisterRequestModelFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      'RegisterRequestModel',
      json,
      ($checkedConvert) {
        final val = RegisterRequestModel(
          username: $checkedConvert('UserName', (v) => v as String),
          email: $checkedConvert('Email', (v) => v as String),
          mobileNumber: $checkedConvert('Mobile', (v) => v as String),
          password: $checkedConvert('Password', (v) => v as String),
          speciality: $checkedConvert('Speciality', (v) => v as String),
          country: $checkedConvert('Country', (v) => v as String),
          instagramLink: $checkedConvert('InstagramLink', (v) => v as String),
          tikTokLink: $checkedConvert('TikTokLink', (v) => v as String),
          userconsent: $checkedConvert('Userconsent', (v) => v as String),
        );
        return val;
      },
      fieldKeyMap: const {
        'username': 'UserName',
        'email': 'Email',
        'mobileNumber': 'Mobile',
        'password': 'Password',
        'speciality': 'Speciality',
        'country': 'Country',
        'instagramLink': 'InstagramLink',
        'tikTokLink': 'TikTokLink',
        'userconsent': 'Userconsent'
      },
    );

Map<String, dynamic> _$RegisterRequestModelToJson(
        RegisterRequestModel instance) =>
    <String, dynamic>{
      'UserName': instance.username,
      'Email': instance.email,
      'Mobile': instance.mobileNumber,
      'Password': instance.password,
      'Speciality': instance.speciality,
      'Country': instance.country,
      'InstagramLink': instance.instagramLink,
      'TikTokLink': instance.tikTokLink,
      'Userconsent': instance.userconsent,
    };
