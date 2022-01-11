class Register{
  String name;
  String mobileNo;
  String email;
  String date;
  String time;

  Register(this.name, this.mobileNo, this.email, this.date, this.time);

  factory Register.fromJson(dynamic json) {
    return Register("${json['name']}", "${json['mobileNo']}", "${json['email']}", "${json['date']}", "${json['time']}");
  }

  Map toJson() => {
    'name': name,
    'mobileNo': mobileNo,
    'email': email,
    'date': date,
    'time': time
  };
}