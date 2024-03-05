class Credential {
  String? name;
  String? address;
  String? phone;
  String? email;
  String? password;
  String?id;

  Credential(
      {this.name, this.address, this.phone, this.email, this.password,this.id});

  Credential.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    address = json['address'];
    phone = json['phoneNo'];
    email = json['email'];
    password = json['password'];
    id=json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['address'] = this.address;
    data['phoneNo'] = this.phone;
    data['email'] = this.email;
    data['password'] = this.password;
    data['id']=this.id;
    return data;
  }
}