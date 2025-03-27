import 'package:dio/dio.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/retrofit.dart';

part 'login_api.g.dart';

@RestApi(baseUrl: "https://hackaton-rails-api.duckdns.org:3000/")
abstract class LoginClient {
  factory LoginClient(Dio dio, {String baseUrl}) = _LoginClient;

  @GET('users/?name={name}')
  Future<LoginResponse?> getUser(@Path("name") String name);

}

@JsonSerializable()
class LoginResponse {
  @JsonKey(name: "name")
  String? name;
  @JsonKey(name: "lastname")
  String? lastname;
  @JsonKey(name: "birthdate")
  String? birthdate;
  @JsonKey(name: "password")
  String? password;
  @JsonKey(name: "description")
  String? description;
  @JsonKey(name: "image")
  String? image;

  LoginResponse({this.name, this.lastname, this.birthdate, this.password, this.description, this.image});

  factory LoginResponse.fromJson(Map<String, dynamic> json) => _$LoginResponseFromJson(json);
  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);
}