import 'package:json_annotation/json_annotation.dart';
part 'login_request_model.g.dart';

@JsonSerializable(checked: true, includeIfNull: false)
class LoginRequestModel {
  LoginRequestModel({required this.email, required this.password});

  factory LoginRequestModel.fromJson(Map<String, dynamic> json) =>
      _$LoginRequestModelFromJson(json);

  @JsonKey(name: 'Email')
  final String email;

  @JsonKey(name: 'Password')
  final String password;

  Map<String, dynamic> toJson() => _$LoginRequestModelToJson(this);
}
