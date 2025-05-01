
class UserModel{
  String? name;
  String? email;
  String? phone;
  String? uId;
  String? password;
  String? jopTitle;
  double? salary;
  bool ? isActive;
  String ? typeAccount;
  double ? countHour;


  UserModel({ this.name, this.email, this.phone, this.uId, this.isActive, this.password, this.jopTitle,this.salary,this.typeAccount , this.countHour});

  factory UserModel.formJson(json,){
    return UserModel(
      name: json['Name'],
      email:json['Email'],
      phone: json['Phone'],
      uId: json['Id'],
      salary: double.tryParse(json['salary'].toString()),
      jopTitle: json['JopTitle'],
      password: json['Password'],
      isActive: json['IsActive'],
      typeAccount: json['TypeAccount'],
      countHour: double.tryParse(json['CountHour'].toString()),
    );
  }

  Map<String,dynamic> toMap(){
    return {
      'Name': name,
      'Email':email,
      'Phone': phone,
      'Id': uId,
      'salary': salary,
      'JopTitle': jopTitle,
      'Password': password,
      'IsActive': isActive,
      'TypeAccount': typeAccount,
      'CountHour':countHour
    };

  }
}