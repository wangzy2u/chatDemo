class Patient {
  Patient({
      String? avatar, 
      String? name, 
      String? gender, 
      int? age, 
      String? adress, 
      bool? identity,
      int? step, 
      int? maxStep, 
      String? state, 
      bool? visible, 
      }){
    _avatar = avatar;
    _name = name;
    _gender = gender;
    _age = age;
    _adress = adress;
    _identity = identity;
    _step = step;
    _maxStep = maxStep;
    _state = state;
    _visible = visible;
}

  Patient.fromJson(dynamic json) {
    _avatar = json['avatar'];
    _name = json['name'];
    _gender = json['gender'];
    _age = json['age'];
    _adress = json['adress'];
    _identity = json['identity'];
    _step = json['step'];
    _maxStep = json['maxStep'];
    _state = json['state'];
    _visible = json['visible'];
  }
  String? _avatar;
  String? _name;
  String? _gender;
  int? _age;
  String? _adress;
  bool? _identity;
  int? _step;
  int? _maxStep;
  String? _state;
  bool? _visible;

  String? get avatar => _avatar;
  String get name => _name ?? '';
  String? get gender => _gender;
  int? get age => _age;
  String? get adress => _adress;
  bool get identity => _identity ?? false;
  int? get step => _step;
  int? get maxStep => _maxStep;
  String? get state => _state;
  bool? get visible => _visible;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['avatar'] = _avatar;
    map['name'] = _name;
    map['gender'] = _gender;
    map['age'] = _age;
    map['adress'] = _adress;
    map['identity'] = _identity;
    map['step'] = _step;
    map['maxStep'] = _maxStep;
    map['state'] = _state;
    map['visible'] = _visible;
    return map;
  }

}