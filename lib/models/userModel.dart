class UserModel {
  UserModel({
    required this.userId,
    required this.imgUrl,
    required this.name,
    required this.uKey,
  });
  late final int userId;
  late final String imgUrl;
  late final String name;
  late final String uKey;

  UserModel.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    imgUrl = json['imgUrl'];
    name = json['name'];
    uKey = json['uKey'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['userId'] = userId;
    _data['imgUrl'] = imgUrl;
    _data['name'] = name;
    _data['uKey'] = uKey;
    return _data;
  }
}
