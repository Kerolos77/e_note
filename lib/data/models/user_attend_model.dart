class UserAttendModel {
  late String firstName;
  late String lastName;
  late String email;
  late String ID;
  late String password;
  late String gender;
  late String birthDate;
  late String teamId;
  late String userType;

  UserAttendModel(this.firstName, this.lastName, this.email, this.ID,
      this.password, this.gender, this.birthDate, this.teamId, this.userType);

  UserAttendModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    ID = json['id'];
    password = json['password'];
    gender = json['gender'];
    birthDate = json['birthDate'];
    teamId = json['teamId'];
    userType = json['userType'];
  }

  Map<String, dynamic> toMap() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'id': ID,
      "password": password,
      "gender": gender,
      "birthDate": birthDate,
      "teamId": teamId,
      "userType": userType,
    };
  }
}
