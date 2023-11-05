import 'package:quote_quill/networks/dio_client.dart';

enum EndPoints {
  quotes,
}

extension EndPointsData on EndPoints {
  String path() {
    String path = "";
    switch (this) {
      case EndPoints.quotes:
        path = "api/quotes";
    }
    return path;
  }

  ReqType type() {
    ReqType type;
    switch (this) {
      case EndPoints.quotes:
        type = ReqType.GET;
    }
    return type;
  }
}
