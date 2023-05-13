import 'dart:ffi';
import 'dart:io';

import 'package:animated_login/data/auth.dart';
import 'package:animated_login/data/messages.dart';
import 'package:animated_login/models/account.dart';
import 'package:animated_login/presentation/widgets/bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

import 'login_screen.dart';

class UserEntry extends StatefulWidget {
  String? Name;
  int? userType;

  UserEntry(this.Name, this.userType);

  @override
  State<UserEntry> createState() => _UserEntryState();
}

class _UserEntryState extends State<UserEntry> {
  TextEditingController UserController = TextEditingController();
  TextEditingController PasswordController = TextEditingController();
  TextEditingController NameController = TextEditingController();
  TextEditingController PhoneNumberController = TextEditingController();
  TextEditingController RoleTypeController = TextEditingController();
  List<String> RoleType = <String>['admin', 'Manger', 'Others'];

  @override
  void initState() {
    super.initState();
  }

  Widget makeInput(String label, TextEditingController editingController) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
              fontSize: 15, fontWeight: FontWeight.w400, color: Colors.black87),
        ),
        SizedBox(
          height: 5,
        ),
        TextField(
          controller: editingController, //editing controller of this TextField
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.grey,
              ),
            ),
            border:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
          ),
        ),
        SizedBox(
          height: 30,
        )
      ],
    );
  }

  Widget roleType(String label, TextEditingController editingController) {
    return Column(
      children: [
        DropdownButtonFormField2(
          decoration: InputDecoration(
            //Add isDense true and zero Padding.
            //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.
            isDense: true,
            contentPadding: EdgeInsets.zero,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            //Add more decoration as you want here
            //Add label If you want but add hint outside the decoration to be aligned in the button perfectly.
          ),
          isExpanded: true,
          hint: const Text(
            'Select Your Role Type',
            style: TextStyle(fontSize: 14),
          ),
          items: RoleType.map((item) => DropdownMenuItem<String>(
                value: item,
                child: Text(
                  item,
                  style: const TextStyle(
                    fontSize: 14,
                  ),
                ),
              )).toList(),
          validator: (value) {
            print(value);
            if (value == null) {
              return 'Select Role Type';
            }
            return null;
          },
          onChanged: (value) {
            //Do something when changing the item if you want.
            setState(() {
              editingController.text =
                  value.toString(); //set output date to TextField value.
            });
          },
          onSaved: (value) {
            print(value.toString());
          },
          buttonStyleData: const ButtonStyleData(
            height: 60,
            padding: EdgeInsets.only(left: 20, right: 10),
          ),
          iconStyleData: const IconStyleData(
            icon: Icon(
              Icons.arrow_drop_down,
              color: Colors.black45,
            ),
            iconSize: 30,
          ),
          dropdownStyleData: DropdownStyleData(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
        ),
        const SizedBox(height: 30),
      ],
    );
  }

  Future erroMessage(String message) {
    print(message);
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Alert'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        brightness: Brightness.light,
        backgroundColor: Colors.white,
        leading: IconButton(
            onPressed: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => BottomNavigationBarExample(
                          widget.Name, widget.userType)));
            },
            icon: Icon(
              Icons.arrow_back_ios,
              size: 20,
              color: Colors.black,
            )),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "User Creation",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    )
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40),
                  child: Column(
                    children: [
                      makeInput("UserName", UserController),
                      makeInput("Password", PasswordController),
                      makeInput("Name", NameController),
                      makeInput("PhoneNumber", PhoneNumberController),
                      roleType("Role Type", RoleTypeController),
                    ],
                  ),
                ),
                Stack(
                  children: [
                    Positioned(
                        child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 40),
                          child: Container(
                            padding: EdgeInsets.only(top: 3, left: 3),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(40),
                                border: Border(
                                    bottom: BorderSide(color: Colors.black),
                                    top: BorderSide(color: Colors.black),
                                    right: BorderSide(color: Colors.black),
                                    left: BorderSide(color: Colors.black))),
                            child: MaterialButton(
                              minWidth: double.infinity,
                              height: 60,
                              onPressed: () async {
                                if (UserController.text.toString().isEmpty) {
                                  erroMessage('please Enter User Name');
                                } else if (PasswordController.text
                                    .toString()
                                    .isEmpty) {
                                  erroMessage('please Enter Password');
                                } else if (NameController.text
                                    .toString()
                                    .isEmpty) {
                                  erroMessage('please Enter Name');
                                } else if (PhoneNumberController.text
                                    .toString()
                                    .isEmpty) {
                                  erroMessage('please Enter Phone Number');
                                } else if (RoleTypeController.text
                                    .toString()
                                    .isEmpty) {
                                  erroMessage('please Select Role Type');
                                } else {
                                  await Auth().createUser(
                                    UserController.text,
                                    PasswordController.text,
                                    NameController.text,
                                    PhoneNumberController.text,
                                    RoleTypeController.text,
                                    RoleTypeController.text == 'admin'
                                        ? 0
                                        : RoleTypeController.text == 'Manger'
                                            ? 1
                                            : 2,
                                    widget.Name!,
                                    widget.userType!,
                                    context
                                  );
                                }
                              },
                              color: Colors.redAccent,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(40)),
                              child: Text(
                                "Save",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ))
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
