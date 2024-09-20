/// sender : ""
/// content : ""
/// timestamp : ""

class MessageBean {
  MessageBean({
      String? sender, 
      String? content, 
      String? from,
      String? timestamp,}){
    _sender = sender;
    _from = from;
    _content = content;
    _timestamp = timestamp;
}

  MessageBean.fromJson(dynamic json) {
    _sender = json['sender'];
    _from = json['from'];
    _content = json['content'];
    _timestamp = json['timestamp'];
  }
  String? _sender;
  String? _from;
  String? _content;
  String? _timestamp;

  String get sender => _sender ?? '';
  String get content => _content ?? '';
  String get from => _from ?? '';
  String? get timestamp => _timestamp;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['sender'] = _sender;
    map['from'] = _from;
    map['content'] = _content;
    map['timestamp'] = _timestamp;
    return map;
  }

}