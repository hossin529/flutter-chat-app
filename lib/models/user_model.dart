class UserModel {
  int id;
  String name;
  String email;
  String password;
  String imageUrl;

  UserModel({this.id, this.name, this.email, this.imageUrl, this.password});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    imageUrl = json['image_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['image_url'] = this.imageUrl;
    return data;
  }
}
