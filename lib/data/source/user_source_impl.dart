import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import 'package:network/core/consts/api_consts.dart';
import 'package:network/abstraction/api_client/api_client.dart';
import 'package:network/abstraction/request_params.dart';
import 'package:network/abstraction/request_processor.dart';
import 'package:network/data/model/user_model.dart';
import 'package:network/data/source/user_source.dart';

@LazySingleton(as: UserSource)
class UserSourceImpl implements UserSource {
  static const String _users = 'userssss';
  // static const String _users = 'todos';
  final ApiClient<http.Client> _apiClient;
  final RequestProcessor _requestProcessor;

  const UserSourceImpl(this._apiClient, this._requestProcessor);

  @override
  Future<UserModelList> getUsers() async {
    return _requestProcessor.processRequest(
      onRequest: () => _apiClient.get(
        '${ApiConst.baseUrl}$_users',
        // requestParams: DioRequestParams(queryParameters: {'userId': 1}),
      ),
      onParse: (response) {
        //http.Client
        final data =
            jsonDecode(response.body as String? ?? '') as List<dynamic>? ?? [];
        //Dio
        // final data = response.body as List<dynamic>? ?? [];

        return UserModelList.fromJson(data);
      },
    );
  }
}
