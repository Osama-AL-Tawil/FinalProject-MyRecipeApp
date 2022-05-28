import 'dart:math';

class UserModel{
    String email;
    String userName;
    String phone;
    String? profileImage;
    String role;
  UserModel(this.email,this.userName,this.phone,this.role,this.profileImage);
   UserModel.fromMap(Map<String,dynamic> map)
       : email = map["email"],
         userName = map["userName"],
         phone=map['phone'],
         role=map['role'],
         profileImage=map['profileImage'];

   toMap(){
     return {'email':email,'userName':userName,'phone':phone, 'role':role,'profileImage':profileImage};
   }
}



