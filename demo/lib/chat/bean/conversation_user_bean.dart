/// name : ""
/// avatar : ""

class ConversationUserBean {
  ConversationUserBean({
      String? name, 
      String? avatar,}){
    _name = name;
    _avatar = avatar;
}

  ConversationUserBean.fromJson(dynamic json) {
    _name = json['name'];
    _avatar = json['avatar'];
  }
  String? _name;
  String? _avatar;

  String get name => _name ?? '';
  String get avatar => _avatar ?? '';

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = _name;
    map['avatar'] = _avatar;
    return map;
  }

}