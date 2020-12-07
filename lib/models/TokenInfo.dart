// token信息
class TokenInfo {
  String token;
  int expireAt;
  int isRenew;

  TokenInfo({this.token, this.expireAt, this.isRenew});

  TokenInfo.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    expireAt = json['expire_at'];
    isRenew = json['is_renew'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    data['expire_at'] = this.expireAt;
    data['is_renew'] = this.isRenew;
    return data;
  }
}
