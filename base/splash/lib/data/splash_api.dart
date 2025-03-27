import 'package:dio/dio.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/retrofit.dart';

part 'splash_api.g.dart';

@RestApi(baseUrl: "https://hackaton-rails-api.duckdns.org:3000/")
abstract class SplashClient {
  factory SplashClient(Dio dio, {String baseUrl}) = _SplashClient;

  @GET('assets?logo_type={type}')
  Future<SplashResponse?> getSplash(@Path("type") String type);

}

@JsonSerializable()
class SplashResponse {
  @JsonKey(name: "image")
  String? image;
  @JsonKey(name: "random_sentence")
  String? randomSentence;

  SplashResponse({this.image, this.randomSentence});

  factory SplashResponse.fromJson(Map<String, dynamic> json) => _$SplashResponseFromJson(json);
  Map<String, dynamic> toJson() => _$SplashResponseToJson(this);
}