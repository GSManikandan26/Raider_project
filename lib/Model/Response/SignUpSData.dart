import 'dart:convert';

class SignupUser {
  String? id;
  String? userName;
  String? password;
  String? email;
  String? gender;
  String? name;
  String? userimage;
  String? mobile;
  String? age;
  String? location;

  SignupUser(
      {this.id,
        this.userName,
      this.password,
      this.email,
      this.gender,
      this.name,
      this.userimage,
      this.mobile,
      this.age,
      this.location});

        factory SignupUser.fromMap(map) {
    return SignupUser(
            id: map['_id'] ?? '',

      userName: map['userName'],
      email: map['email'],
      gender: map['gender'],
      name: map['name'],
      mobile: map['mobile'],
      password: map['password'],
      location:map['location'],
      userimage: map["userimage"],
            age: map["age"],


    );
  }
// sending data
  Map<String, dynamic> toMap() {
    return {
      'userName': userName,
      'email': email,
      'gender': gender,
      'name': name,
      'mobile': mobile,
      'password': password,
      'age':age,
      'location':location,
      'userimage':userimage,


    };
  }

  // Convert UserModel to Firestore document data
  Map<String, dynamic> toDocument() {
    return {
      'email': email,
      'gender': gender,
      'name': name,
      'mobile': mobile,
      'password': password,
            'age':age,
             'location':location,
      'userimage':userimage,
            'userName': userName,



    };
  }

   String toJson() => json.encode(toMap());

  factory SignupUser.fromJson(String source) => SignupUser.fromMap(json.decode(source));
}