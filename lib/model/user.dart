class User {
  int? id;
  String imagePath;
  String fullName;
  String phoneNumber;
  String country;
  String address;
  String password;

  User(this.id,
      {required this.imagePath,
      required this.fullName,
      required this.phoneNumber,
      required this.country,
      required this.address,
      required this.password});

  User.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        imagePath = json['image'],
        fullName = json['full_name'],
        phoneNumber = json['number'],
        country = json['country'],
        address = json['address'],
        password = json['password'];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'full_name': fullName,
      'image': imagePath,
      'number': phoneNumber,
      'country': country,
      'address': address,
      'password': password
    };
  }
}
