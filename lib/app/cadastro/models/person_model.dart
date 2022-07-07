class PersonModel {
  int? id;
  String name;
  String? img;
  String cpf;
  String phone;
  int themeIsDark;
  String nascimento;

  PersonModel(
      {this.id,
      required this.cpf,
      this.img,
      required this.name,
      required this.phone,
      required this.themeIsDark,
      required this.nascimento});

  PersonModel copyWith({
    String? name,
    String? email,
    String? img,
    String? cpf,
    String? phone,
    int? themeIsDark,
    String? nascimento,
  }) {
    return PersonModel(
        cpf: cpf ?? this.cpf,
        img: img ?? this.img,
        name: name ?? this.name,
        nascimento: nascimento ?? this.nascimento,
        phone: phone ?? this.phone,
        themeIsDark: themeIsDark ?? this.themeIsDark);
  }

  PersonModel clear() {
    return PersonModel(
        cpf: '', name: '', phone: '', themeIsDark: 0, nascimento: '');
  }

  factory PersonModel.fromMap(Map<String, dynamic> map) => PersonModel(
      id: map['idColumn'],
      img: map['imgColumn'],
      cpf: map['cpfColumn'],
      name: map['nameColumn'],
      phone: map['phoneColumn'],
      themeIsDark: map['themeIsDarkColumn'],
      nascimento: map['nascColumn']);

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'nameColumn': name,
      'phoneColumn': phone,
      'imgColumn': img,
      'themeIsDarkColumn': themeIsDark,
      'nascColumn': nascimento,
      'cpfColumn': cpf
    };
    if (id != null) {
      map['idColumn'] = id;
    }
    return map;
  }
}
