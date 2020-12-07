import '../TokenInfo.dart';

class ResponseData<T> {
  int code;
  String message;
  int timestamp;
  T data;

  ResponseData({this.code, this.message, this.timestamp, this.data});

  ResponseData.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    timestamp = json['timestamp'];
    var name = T.toString();
    if (name == "TokenInfo") {
      data = TokenInfo.fromJson(json['data']) as T;
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['message'] = this.message;
    data['timestamp'] = this.timestamp;
    data['data'] = this.data;
    return data;
  }
}
