

class SalaryModel{
  String? uIdUser;
  String? uid;
  String? date;
  double? salary;
  String? salaryType;
  String? dis;

  SalaryModel({ this.uIdUser, this.uid, this.salaryType, this.dis,this.salary,this.date });

  factory SalaryModel.formJson(json,){
    return SalaryModel(
      uIdUser: json['UIdUser'],
      uid:json['uid'],
      salaryType: json['SalaryType'],
      dis: json['Dis'],
      salary: double.tryParse(json['Salary'].toString()),
      date: json['Date'],
    );
  }

  Map<String,dynamic> toMap(){
    return {
      'UIdUser': uIdUser,
      'uid':uid,
      'Dis': dis,
      'SalaryType': salaryType,
      'Salary': salary,
      'Date': date,
    };

  }
}