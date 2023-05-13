import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:animated_login/models/loginResponse.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../models/customerResponseList.dart';
import '../presentation/widgets/bottom_navigation.dart';

abstract class BaseAuth {

  Future<String> currentUser();
  Future<loginResponse> signIn(String email, String password);
  Future<String> createUser(String userName,String password,String Name, String PhoneNumber,String RoleName,int RoleType,String CurrentUser,int UserType,BuildContext context);
  Future<List<CustomerResponseList>> getCustomerList(String CheckInDate);
  Future<String> insertCustomer(String name,String phoneNumber,String emailId,String foodType,String checkInDate,String checkOutDate,String noofPeople,String CurrentUser,int userType,BuildContext context);
}

class Auth implements BaseAuth  {
  FirebaseDatabase database = FirebaseDatabase.instance;
 // DatabaseReference ref1 = FirebaseDatabase.instance.ref("admin");
  DatabaseReference ref = FirebaseDatabase(databaseURL: "https://hotal-718a4-default-rtdb.asia-southeast1.firebasedatabase.app/").reference();




  @override
  Future<String> currentUser() {
    // TODO: implement currentUser
    throw UnimplementedError();
  }

  @override
  Future<loginResponse> signIn(String userName, String passWord) async {
    await Firebase.initializeApp();
    final snapshot = await ref.child('userDetails/$userName/$passWord').get();
    print(snapshot.value);
    if (snapshot.exists) {
      Map<dynamic, dynamic> values = snapshot.value as Map<dynamic, dynamic>;
      loginResponse LoginResponse = new loginResponse(
        name: values['name'],
        mobileNumber: values['mobileNumber'],
        role: values['role'],
        userType: values['userType']
      );
     // print(LoginResponse.Name);
      return LoginResponse;
    } else {
      print('No data available.');
      return loginResponse.fromJson({});
    }
  }

  @override
  Future<void> signOut() {
    // TODO: implement signOut
    throw UnimplementedError();
  }

  @override
  Future<String> insertCustomer(String name, String phone, String emailId, String foodType, String checkInDate, String checkOutDate, String noofpeople,String CurrentUser,int userType,BuildContext context) async {
    Random random = new Random();
    String randomNumber = random.nextInt(10000).toString();
    await ref.child('customerDetails/$randomNumber').set({
      "name": name,
      "noofpeople": noofpeople,
      "phone": phone,
      "emailId": emailId,
      "foodType": foodType,
      "checkInDate": checkInDate,
      "checkOutDate": checkOutDate,
      }).then((_) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => BottomNavigationBarExample(
                  CurrentUser,userType)));
    }).catchError((onError) {
       print(onError);
    });
    return 'Succesfully insert';

  }

  @override
  Future<String> createUser(String userName,String Password, String Name, String PhoneNumber,String RoleName, int RoleType ,String currentUserName,int userType,BuildContext context) async {
    await ref.child('userDetails/$userName/$Password').set({
      "name": Name,
      "phone": PhoneNumber,
      "role": RoleName,
      "userType": RoleType,
    }).then((_) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => BottomNavigationBarExample(
                  currentUserName,userType)));
    }).catchError((onError) {
      print(onError);
    });
    return 'Succesfully insert';
  }

  @override
  Future<List<CustomerResponseList>> getCustomerList(String CheckInDate) async {
    print(CheckInDate);
    await Firebase.initializeApp();
    List<CustomerResponseList> dataList = [];
    final snapshot = await ref.child('customerDetails').get();
    print(snapshot.value);
    for (final data in snapshot.children) {
      Map<dynamic, dynamic> values = data.value as Map<dynamic, dynamic>;
      if(values['checkInDate'] == CheckInDate) {
        CustomerResponseList customerResponseList = new CustomerResponseList(
          name: values['name'],
          phone: values['phone'],
          noofpeople: values['noofpeople'],
          emailId: values['emailId'],
          foodType: values['foodType'],
          checkInDate: values['checkInDate'],
          checkOutDate: values['checkOutDate'],
        );
        dataList.add(customerResponseList);
      }
    }
    return dataList;
  }


}
