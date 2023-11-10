import 'package:dio/dio.dart';
import 'package:quote_quill/networks/dio_client.dart';
import 'package:quote_quill/networks/endpoints.dart';
import 'package:quote_quill/networks/models/quotes_req_model.dart';

class QuotesRepo {
  final DioClient dioClient = DioClient(Dio());
  Future<QuotesRespWrapper?> quotesReq() async {
    try {
      List<QuotesReqModel>? listModel = [];
      final response = await dioClient.quoteClient(endpoint: EndPoints.quotes);

      if (response != null) {
        if (response.statusCode == 200 || response.statusCode == 201) {
          final respList = response.data as List<dynamic>;
          for (var element in respList) {
            if (element is Map<String, dynamic>) {
              final item = QuotesReqModel.fromJson(element);
              listModel.add(item);
            }
          }
          return QuotesRespWrapper(quotesList: listModel);
          // final quotesResponse = QuotesReqModel.fromJson(response.data);
          // if (quotesResponse.c != null &&
          //     quotesResponse.a != null &&
          //     quotesResponse.q != null) {
          //   return quotesResponse;
          // } else {
          //   return QuotesReqModel(error: "no data");
          // }
        } else {
          // final quotesResponse = QuotesReqModel.fromJson(response.data);
          // if (response.statusCode == 400) {
          //   return quotesResponse;
          // }
          return null;
        }
      }
    } on DioException catch (e) {
      // if (e.response!.data != null && e.response!.data != null) {
      //   final quotesResponse = QuotesReqModel.fromJson(e.response!.data);
      //   return quotesResponse;
      // }
      return QuotesRespWrapper(quotesList: [], error: e.message);
    }
    return QuotesRespWrapper(quotesList: [], error: "unknown error");
    ;
  }
}
