import 'package:dio/dio.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/retrofit.dart';

part 'signup_api.g.dart';

@RestApi(baseUrl: "https://hackaton-rails-api.duckdns.org:3000/")
abstract class SignupClient {
  factory SignupClient(Dio dio, {String baseUrl}) = _SignupClient;

  @GET("users/?name={name}")
  Future<SignupResponse?> getUser(@Path("name") String name);

  @POST("users")
  Future<void> createUser(@Body() SignupResponse user);
}

@JsonSerializable()
class SignupResponse {
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

  SignupResponse({
    this.name,
    this.lastname,
    this.birthdate,
    this.password,
    this.description,
    this.image,
  });

  factory SignupResponse.fromJson(Map<String, dynamic> json) =>
      _$SignupResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SignupResponseToJson(this);
}
