class Chat {
  String? name;
  String? profileUrl;
  String? message;
  int? time;
  String? email;

  Chat(this.name, this.profileUrl, this.message, this.time, this.email);

  Chat.fromJson(dynamic json) {
    name = json["name"];
    profileUrl = json["profileUrl"];
    message = json["message"];
    time = json["time"];
    email = json["email"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["name"] = name;
    map["profileUrl"] = profileUrl;
    map["message"] = message;
    map["time"] = time;
    map["email"] = email;
    return map;
  }
}