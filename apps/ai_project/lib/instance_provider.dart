import 'package:dio/dio.dart';
import 'package:home/data/record_repository.dart';
import 'package:home/tools/date_tools.dart';
import 'package:login/data/login_api.dart';
import 'package:login/data/login_view_model.dart';
import 'package:splash/data/splash_api.dart';

class InstanceProvider {
  static final DateTools _dateTools = DateTools();
  static final Dio _dio = Dio(BaseOptions(contentType: "application/json"));
  static final LoginClient _loginClient = LoginClient(_dio);
  static final SplashClient splashClient = SplashClient(_dio);
  static final LoginViewModel loginViewmodel = LoginViewModel(_loginClient);
  static final RecordRepository recordRepository = RecordRepository(_dateTools);
}