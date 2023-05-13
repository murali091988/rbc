import 'package:animated_login/data/auth.dart';
import 'package:animated_login/data/messages.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


import '../../models/customerResponseList.dart';
import '../customer_details.dart';
import 'NoDataFoundWidget.dart';

class MessagesList extends StatefulWidget {

  String? Name;
  int? userType;

  MessagesList(this.Name,this.userType);

  @override
  State<MessagesList> createState() => _MessagesListState();
}

class _MessagesListState extends State<MessagesList> {
  List<CustomerResponseList> dataList = [];
  TextEditingController  checkInDateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    DateTime currentDate = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd').format(currentDate);
    setState(() {
      checkInDateController.text = formattedDate;
    });
  }

  Widget checkInOutDate (String label,TextEditingController editingController) {
    return Column(
      children: [
        TextField(
          controller: editingController, //editing controller of this TextField
          decoration: InputDecoration(
            icon: Icon(Icons.calendar_today), //icon of text field
            labelText: label,
            contentPadding: EdgeInsets.symmetric(vertical: 0,horizontal: 5),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.grey,
              ),
            ),
            border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey)
            ),
          ),
          readOnly: true,  //set it true, so that user will not able to edit text
          onTap: () async {
            DateTime? pickedDate = await showDatePicker(
                context: context, initialDate: DateTime.now(),
                firstDate: DateTime.now(), //DateTime.now() - not to allow to choose before today.
                lastDate: DateTime(2200)
            );

            if(pickedDate != null ){
              print(pickedDate);  //pickedDate output format => 2021-03-10 00:00:00.000
              String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
              print(formattedDate); //formatted date output using intl package =>  2021-03-16
              //you can implement different kind of Date Format here according to your requirement

              setState(() {
                editingController.text = formattedDate; //set output date to TextField value.
              });
            }else{
              print("Date is not selected");
            }
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {

    return FutureBuilder<List<CustomerResponseList>>(
      future: Auth().getCustomerList(checkInDateController.text), // Your future method
      builder: (BuildContext context, AsyncSnapshot<List<CustomerResponseList>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator(); // While the future is loading
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}'); // If an error occurred
        } else {
          List<CustomerResponseList> customerList = snapshot.data!; // Access the result
          // Now you can use the customerList
          print(customerList.toString());
          return  Column(
            children: [
              checkInOutDate('Select Date',checkInDateController),
              SizedBox(height: 3),
              customerList.length != 0? ListView.builder(
                  shrinkWrap: true,
                  itemCount: customerList.length,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    final message = customerList[index];
                    return TweenAnimationBuilder<double>(
                      duration: Duration(
                        milliseconds: (200 + (index * 100)).toInt() < 1500
                            ? (200 + (index * 100)).toInt()
                            : 1500,
                      ),
                      tween: Tween(begin: 0, end: 1),
                      builder: (_, value, __) => TweenAnimationBuilder<double>(
                        duration: Duration(milliseconds: 500),
                        tween: Tween(begin: (80 * index).toDouble(), end: 0),
                        builder: ((_, paddingValue, __) => Container(
                          padding: EdgeInsets.only(top: paddingValue),
                          child: Opacity(
                            opacity: value,
                            child: InkWell(
                              onTap: () {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => CustomerDetails(
                                            widget.Name, widget.userType,message)));
                              },
                              child: Card(
                                elevation: 3,
                                child: Container(
                                  margin: EdgeInsets.all(15),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                          width: 40,
                                          height: 40,
                                          child: Image.asset('assets/images/avatar_1.png')),
                                      SizedBox(width: 10),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Name: ${message.name ?? ''}',
                                              style: TextStyle(
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                            SizedBox(height: 10),
                                            Text(
                                              'Food Type: ${message.foodType ?? ''}',
                                              style: TextStyle(
                                                  color: Colors.black.withOpacity(0.8),
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                            SizedBox(height: 10),
                                            Text(
                                              'Check In Date:${message.checkInDate ?? ''}',
                                              style: TextStyle(
                                                  color: Colors.black.withOpacity(0.8),
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                            SizedBox(height: 10),
                                            Text(
                                              'Check Out Date: ${message.checkOutDate ?? ''} ',
                                              style: TextStyle(
                                                  color: Colors.black.withOpacity(0.8),
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                            SizedBox(height: 10),
                                            Text(
                                              'Phone Number:${message.phone ?? ''}',
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.black.withOpacity(0.8),
                                                  fontWeight: FontWeight.w400),
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )),
                      ),
                    );
                  }) : NoDataFoundWidget(),
            ],
          );
        }
      },
    );
  }
}
