
class LeaveModel{
  String? uIdUser;
  String? uid;
  String? date;
  String? time;
  String? note;
  String? link;
  String? phone;
  String? name;
  String? type;

  LeaveModel({ this.uIdUser, this.uid, this.link, this.name,this.phone,this.date,this.note,this.time ,this.type});

  factory LeaveModel.formJson(json,){
    return LeaveModel(
      uIdUser: json['UIdUser'],
      uid:json['Uid'],
      time: json['Time'],
      note: json['Note'],
      phone: json['Phone'],
      name: json['Name'],
      link: json['Link'],
      date: json['Date'],
      type: json['Type'],
    );
  }

  Map<String,dynamic> toMap(){
    return {
      'UIdUser': uIdUser,
      'uid':uid,
      'Time': time,
      'Note': note,
      'Phone': phone,
      'Name': name,
      'Link': link,
      'Date': date,
      'Type': type,
    };

  }
}