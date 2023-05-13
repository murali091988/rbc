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

class CustomerEntry extends StatefulWidget {
  String? Name;
  int? userType;

  CustomerEntry(this.Name, this.userType);

  @override
  State<CustomerEntry> createState() => _CustomerEntryState();
}

class _CustomerEntryState extends State<CustomerEntry> {
  DateTime selectedDate = DateTime.now();
  TextEditingController checkInDateController = TextEditingController();
  TextEditingController checkOutDateController = TextEditingController();
  TextEditingController NameController = TextEditingController();
  TextEditingController PhoneNumberController = TextEditingController();
  TextEditingController EmailIdController = TextEditingController();
  TextEditingController FoodTypeController = TextEditingController();
  TextEditingController NoofPeopleController = TextEditingController();
  List<String> foodListType = <String>['Veg', 'NonVeg'];

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

  Widget checkInOutDate(String label, TextEditingController editingController) {
    return Column(
      children: [
        TextField(
          controller: editingController, //editing controller of this TextField
          decoration: InputDecoration(
            icon: Icon(Icons.calendar_today),
            //icon of text field
            labelText: label,
            contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.grey,
              ),
            ),
            border:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
          ),
          readOnly: true, //set it true, so that user will not able to edit text
          onTap: () async {
            DateTime? pickedDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime.now(),
                //DateTime.now() - not to allow to choose before today.
                lastDate: DateTime(2200));

            if (pickedDate != null) {
              print(
                  pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
              String formattedDate =
                  DateFormat('yyyy-MM-dd').format(pickedDate);
              print(
                  formattedDate); //formatted date output using intl package =>  2021-03-16
              //you can implement different kind of Date Format here according to your requirement

              setState(() {
                editingController.text =
                    formattedDate; //set output date to TextField value.
              });
            } else {
              print("Date is not selected");
            }
          },
        ),
        SizedBox(
          height: 30,
        )
      ],
    );
  }

  Widget checkInOutTime(String label, TextEditingController editingController) {
    return Column(
      children: [
        TextField(
            controller: editingController,
            //editing controller of this TextField
            decoration: InputDecoration(
              icon: Icon(Icons.timer),
              //icon of text field
              labelText: label,
              contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.grey,
                ),
              ),
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey)),
            ),
            readOnly: true,
            //set it true, so that user will not able to edit text
            onTap: () async {
              TimeOfDay? time = await showTimePicker(
                initialEntryMode: TimePickerEntryMode.dial,
                context: context,
                initialTime: TimeOfDay.now(),
                cancelText: "Cancel",
                confirmText: "Save",
                helpText: "Select time",
                builder: (context, Widget? child) {
                  return MediaQuery(
                    data: MediaQuery.of(context)
                        .copyWith(alwaysUse24HourFormat: false),
                    child: child!,
                  );
                },
              );
              setState(() {
                editingController.text =
                    time.toString(); //set output date to TextField value.
              });
            }),
        SizedBox(
          height: 30,
        )
      ],
    );
  }

  Widget foodType(String label, TextEditingController editingController) {
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
            'Select Food Type',
            style: TextStyle(fontSize: 14),
          ),
          items: foodListType
              .map((item) => DropdownMenuItem<String>(
                    value: item,
                    child: Text(
                      item,
                      style: const TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ))
              .toList(),
          validator: (value) {
            print(value);
            if (value == null) {
              return 'Select Food Type';
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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        "Customer Registration",
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
                        makeInput("Name", NameController),
                        makeInput("PhoneNumber", PhoneNumberController),
                        makeInput("No of People", NoofPeopleController),
                        makeInput("Email Id", EmailIdController),
                        foodType("Food Type", FoodTypeController),
                        checkInOutDate("Check In Date", checkInDateController),
                        checkInOutDate(
                            "Check Out Date", checkOutDateController),
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

                                  if (NameController.text.toString().isEmpty) {
                                    erroMessage('please Enter Name');
                                  } else if (NameController.text
                                      .toString()
                                      .isEmpty) {
                                    erroMessage('please Enter Phone Number');
                                  } else if (EmailIdController.text
                                      .toString()
                                      .isEmpty) {
                                    erroMessage('please Enter Email Id');
                                  } else if (NoofPeopleController.text
                                      .toString()
                                      .isEmpty) {
                                    erroMessage('please Enter Email Id');
                                  } else if (FoodTypeController.text
                                      .toString()
                                      .isEmpty) {
                                    erroMessage('please Select Food Type');
                                  } else if (checkInDateController.text
                                      .toString()
                                      .isEmpty) {
                                    erroMessage('please Select Check In Date');
                                  } else if (checkOutDateController.text
                                      .toString()
                                      .isEmpty) {
                                    erroMessage('please Select Check Out Date');
                                  } else {
                                    await Auth().insertCustomer(
                                        NameController.text,
                                        PhoneNumberController.text,
                                        EmailIdController.text,
                                        FoodTypeController.text,
                                        checkInDateController.text,
                                        checkOutDateController.text,
                                        NoofPeopleController.text,
                                        widget.Name!,
                                        widget.userType!,
                                        context,
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
      ),
    );
  }
}
