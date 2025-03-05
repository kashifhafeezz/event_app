import 'package:json_annotation/json_annotation.dart';
part 'register_request_model.g.dart';

@JsonSerializable(checked: true, includeIfNull: false)
class RegisterRequestModel {
  RegisterRequestModel({
    required this.username,
    required this.email,
    required this.mobileNumber,
    required this.password,
    required this.speciality,
    required this.country,
    required this.instagramLink,
    required this.tikTokLink,
    required this.userconsent,
  });
  factory RegisterRequestModel.fromJson(Map<String, dynamic> json) =>
      _$RegisterRequestModelFromJson(json);

  @JsonKey(name: 'UserName')
  final String username;

  @JsonKey(name: 'Email')
  final String email;

  @JsonKey(name: 'Mobile')
  final String mobileNumber;

  @JsonKey(name: 'Password')
  final String password;

  @JsonKey(name: 'Speciality')
  final String speciality;

  @JsonKey(name: 'Country')
  final String country;

  @JsonKey(name: 'InstagramLink')
  final String instagramLink;

  @JsonKey(name: 'TikTokLink')
  final String tikTokLink;

  @JsonKey(name: 'Userconsent')
  final String userconsent;

  Map<String, dynamic> toJson() => _$RegisterRequestModelToJson(this);
}
