// Dart imports:

// Flutter imports:
import 'dart:convert';

import 'package:flutter/foundation.dart';

// Package imports:
import 'package:dio/dio.dart';
import 'package:neumedira_farhan_test/app/utils/const.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class MyDio {
  BaseOptions get baseOptions => BaseOptions(
        headers: {
          // 'X-API-VERSION': EnvHelper().apiVersion,
          // 'Content-Type': 'application/json; charset=UTF-8',
          // 'Content-Type': "application/x-www-form-urlencoded",
          'Content-Type': "application/json",
          'Access-Control-Allow-Origin': '*',
          'Accept': '*/*',
        },
        responseType: ResponseType.plain,
        baseUrl: "$baseUrl:3000",
        // baseUrl: RemoteFirebase().urlApi,
        connectTimeout: const Duration(seconds: 60),
        receiveTimeout: const Duration(seconds: 3),
      );

  Dio get dio {
    final dataDio = Dio(baseOptions);
    dataDio.interceptors.add(MyInterceptor());
    dataDio.transformer = JsonTransformer();
    if (kDebugMode) {
      dataDio.interceptors.add(
        PrettyDioLogger(
          requestHeader: false,
          requestBody: true,
          responseBody: true,
        ),
      );
    }

    return dataDio;
  }

  static Map<String, dynamic> get defaultHeader {
    return {
      'Accept': 'application/json',
    };
  }
}

class MyInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    try {
      if (options.headers.containsKey("requiresToken")) {
        options.headers.remove("requiresToken");
        // final userData = getIt<UserLocalDataSource>().getUserToken();
        // if (userData != null)
        //   options.headers.addAll({"Authorization": "Bearer ${userData.token}"});
      }
    } catch (e) {
      // Handle any exceptions if needed
    }

    super.onRequest(options, handler);
  }
}

class JsonTransformer extends BackgroundTransformer {
  @override
  Future<String> transformRequest(RequestOptions options) async {
    // You can add logic to transform the request if needed
    return super.transformRequest(options);
  }

  @override
  Future transformResponse(
      RequestOptions options, ResponseBody responseBody) async {
    String jsonString = await super.transformResponse(options, responseBody);

    // Use json.decode to convert the response into a Map
    return json.decode(jsonString);
  }
}
