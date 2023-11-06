import 'package:dio/dio.dart';
import 'package:quote_quill/networks/dio_client.dart';
import 'package:quote_quill/networks/endpoints.dart';
import 'package:quote_quill/networks/models/quotes_req_model.dart';

class QuotesRepo {
  final DioClient dioClient = DioClient(Dio());
  Future<QuotesReqModel?> quotesReq() async {
    try {
      final response = await dioClient.quoteClient(endpoint: EndPoints.quotes);
      if (response != null) {
        if (response.statusCode == 200 || response.statusCode == 201) {
          final quotesResponse = QuotesReqModel.fromJson(response.data);
          if (quotesResponse.c != null &&
              quotesResponse.a != null &&
              quotesResponse.q != null) {
            return quotesResponse;
          } else {
            return QuotesReqModel(error: "no data");
          }
        } else {
          final quotesResponse = QuotesReqModel.fromJson(response.data);
          if (response.statusCode == 400) {
            return quotesResponse;
          }
        }
      }
    } on DioException catch (e) {
      if (e.response!.data != null && e.response!.data != null) {
        final quotesResponse = QuotesReqModel.fromJson(e.response!.data);
        return quotesResponse;
      }
    }
    return QuotesReqModel(error: "An unexpected error occurred");
  }
}
