// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'signup_api.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignupResponse _$SignupResponseFromJson(Map<String, dynamic> json) =>
    SignupResponse(
          name: json['name'] as String?,
          lastname: json['lastname'] as String?,
          birthdate: json['birthdate'] as String?,
          password: json['password'] as String?,
          description: json['description'] as String?,
          image: json['image'] as String?,
    );

Map<String, dynamic> _$SignupResponseToJson(SignupResponse instance) =>
    <String, dynamic>{
          'name': instance.name,
          'lastname': instance.lastname,
          'birthdate': instance.birthdate,
          'password': instance.password,
          'description': instance.description,
          'image': instance.image,
    };

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers

class _SignupClient implements SignupClient {
      _SignupClient(
          this._dio, {
                this.baseUrl,
          }) {
            baseUrl ??= 'https://hackaton-rails-api.duckdns.org:3000/';
      }

      final Dio _dio;

      String? baseUrl;

      @override
      Future<SignupResponse?> getUser(name) async {
            const _extra = <String, dynamic>{};
            final queryParameters = <String, dynamic>{};
            final _headers = <String, dynamic>{};
            final Map<String, dynamic>? _data = null;
            final _result = await _dio
                .fetch<Map<String, dynamic>?>(_setStreamType<SignupResponse>(Options(
                  method: 'GET',
                  headers: _headers,
                  extra: _extra,
            )
                .compose(
                  _dio.options,
                  'users/?name=${name}',
                  queryParameters: queryParameters,
                  data: _data,
            )
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
            final value =
            _result.data == null ? null : SignupResponse.fromJson(_result.data!);
            return value;
      }

      @override
      Future<void> createUser(user) async {
            const _extra = <String, dynamic>{};
            final queryParameters = <String, dynamic>{};
            final _headers = <String, dynamic>{};
            final _data = user.toJson();
            await _dio.fetch<void>(_setStreamType<void>(Options(
                  method: 'POST',
                  headers: _headers,
                  extra: _extra,
            )
                .compose(
                  _dio.options,
                  'users',
                  queryParameters: queryParameters,
                  data: _data,
            )
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
      }

      RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
            if (T != dynamic &&
                !(requestOptions.responseType == ResponseType.bytes ||
                    requestOptions.responseType == ResponseType.stream)) {
                  if (T == String) {
                        requestOptions.responseType = ResponseType.plain;
                  } else {
                        requestOptions.responseType = ResponseType.json;
                  }
            }
            return requestOptions;
      }
}
