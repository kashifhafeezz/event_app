// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginRequestModel _$LoginRequestModelFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'LoginRequestModel',
      json,
      ($checkedConvert) {
        final val = LoginRequestModel(
          email: $checkedConvert('Email', (v) => v as String),
          password: $checkedConvert('Password', (v) => v as String),
        );
        return val;
      },
      fieldKeyMap: const {'email': 'Email', 'password': 'Password'},
    );

Map<String, dynamic> _$LoginRequestModelToJson(LoginRequestModel instance) =>
    <String, dynamic>{
      'Email': instance.email,
      'Password': instance.password,
    };
