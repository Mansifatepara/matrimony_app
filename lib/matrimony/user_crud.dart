import "dart:io";

class User{
  List<Map<String,dynamic>> userList=[];


  void adduserlist({required fullname ,required address , required email,required mobilenumber,required dob,required city,required gender}){
    Map<String,dynamic> map = {} ;
    map[FULLNAME] =fullname;
    map[ADDRESS] = address;
    map[EMAIL]=email;
    map[MOBILENUMBER]=mobilenumber;
    map[DOB]=dob;
    map[CITY]=city;
    map[GENDER]=gender;
    userList.add(map);

  }

  List<Map<String, dynamic>> getUserList() {
    return userList;
  }

  void updateUser({required fullname ,required address , required email,required mobilenumber,required dob,required city,required gender}) {
    Map<String, dynamic> map = {};
    map[FULLNAME] =fullname;
    map[ADDRESS] = address;
    map[EMAIL]=email;
    map[MOBILENUMBER]=mobilenumber;
    map[DOB]=dob;
    map[CITY]=city;
    map[GENDER]=gender;
  }

  void deleteUser(id) {
    userList.removeAt(id);
  }

}