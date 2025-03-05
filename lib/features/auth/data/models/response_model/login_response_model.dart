import 'package:json_annotation/json_annotation.dart';
part 'login_response_model.g.dart';

@JsonSerializable(checked: true, includeIfNull: false)
class LoginResponseModel {
  LoginResponseModel({
    required this.id,
    required this.userUniqueId,
    required this.qrCode,
    required this.doctorName,
    required this.email,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseModelFromJson(json);

  @JsonKey(name: 'id')
  final int id;

  @JsonKey(name: 'Useruniqueid')
  final String userUniqueId;

  @JsonKey(name: 'QrCode')
  final String qrCode;

  @JsonKey(name: 'DoctorName')
  final String doctorName;

  @JsonKey(name: 'Email')
  final String email;

  Map<String, dynamic> toJson() => _$LoginResponseModelToJson(this);
}
