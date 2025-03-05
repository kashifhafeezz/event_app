// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginResponseModel _$LoginResponseModelFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'LoginResponseModel',
      json,
      ($checkedConvert) {
        final val = LoginResponseModel(
          id: $checkedConvert('id', (v) => (v as num).toInt()),
          userUniqueId: $checkedConvert('Useruniqueid', (v) => v as String),
          qrCode: $checkedConvert('QrCode', (v) => v as String),
          doctorName: $checkedConvert('DoctorName', (v) => v as String),
          email: $checkedConvert('Email', (v) => v as String),
        );
        return val;
      },
      fieldKeyMap: const {
        'userUniqueId': 'Useruniqueid',
        'qrCode': 'QrCode',
        'doctorName': 'DoctorName',
        'email': 'Email'
      },
    );

Map<String, dynamic> _$LoginResponseModelToJson(LoginResponseModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'Useruniqueid': instance.userUniqueId,
      'QrCode': instance.qrCode,
      'DoctorName': instance.doctorName,
      'Email': instance.email,
    };
