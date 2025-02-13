import "dart:io";

import "package:matrimony_application/matrimony/user_form_page.dart";
import "package:matrimony_application/matrimony/utils_const_string.dart";

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