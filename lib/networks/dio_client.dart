import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:quote_quill/constants/constants.dart';
import 'package:quote_quill/networks/endpoints.dart';

class DioClient {
  final Dio _dio;
  DioClient(this._dio) {
    _dio.interceptors.add(
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        compact: false,
      ),
    );
  }
  Future<dynamic> quoteClient({
    required EndPoints endpoint,
    Map<String, dynamic>? headers,
  }) async {
    Response response;
    if (headers != null) {
      _dio.options.headers.addAll(headers);
    }
    try {
      switch (endpoint.type()) {
        case ReqType.GET:
          response = await _dio.get("$baseUrl/${endpoint.path()}");
      }
    } on DioException catch (e) {
      if (e.response != null) {
        response = e.response!;
      } else {
        switch (e.type) {
          case DioException.receiveTimeout:
            response = Response(
              requestOptions: e.requestOptions,
              statusMessage: "Received time out",
              statusCode: 700,
            );
            break;
          default:
            response = Response(
              requestOptions: e.requestOptions,
              statusMessage: "Some error happened",
              statusCode: 800,
            );
        }
      }
      return response;
    }
  }
}

enum ReqType {
  GET,
}
