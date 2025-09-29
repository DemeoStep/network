import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import 'package:network/core/consts/api_consts.dart';
import 'package:network/abstraction/api_client/api_client.dart';
import 'package:network/core/data/dio_client/dio_client.dart';
import 'package:network/core/data/dio_client/dio_request_processor.dart';
import 'package:network/core/data/http_client/http_client.dart';
import 'package:network/core/data/http_client/http_request_processor.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import 'injectable.config.dart';

@InjectableInit(preferRelativeImports: true)
void configureDependencies(GetIt getIt) => getIt.init();

@module
abstract class RegisterModule {
  @LazySingleton()
  Dio dio() {
    final dio = Dio(
      BaseOptions(
        connectTimeout: ApiConst.connectTimeout,
        receiveTimeout: ApiConst.receiveTimeout,
        baseUrl: ApiConst.baseUrl,
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      ),
    );

    dio.interceptors.add(
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
        compact: false,
      ),
    );
    dio.transformer = BackgroundTransformer();

    return dio;
  }

  @LazySingleton()
  ApiClient<Dio> dioClient() => DioClient(dio(), DioRequestProcessor());

  @LazySingleton()
  ApiClient<http.Client> httpClient() =>
      HttpClient(http.Client(), HttpRequestProcessor());
}
