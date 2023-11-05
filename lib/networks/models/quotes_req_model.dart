class QuotesReqModel {
  String? q;
  String? a;
  String? c;
  String? h;
  String? error;

  QuotesReqModel({this.q, this.a, this.c, this.h, this.error});

  QuotesReqModel.fromJson(Map<String, dynamic> json) {
    q = json['q'];
    a = json['a'];
    c = json['c'];
    h = json['h'];
    error = json['error'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['q'] = q;
    data['a'] = a;
    data['c'] = c;
    data['h'] = h;
    return data;
  }
}
