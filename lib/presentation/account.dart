import 'dart:ffi';
import 'dart:io';

import 'package:animated_login/data/messages.dart';
import 'package:animated_login/models/account.dart';
import 'package:animated_login/presentation/user_creation.dart';
import 'package:flutter/material.dart';

import 'customer_entry.dart';
import 'login_screen.dart';

class AccountList extends StatefulWidget {
  int? userType;
  String? Name;
  AccountList(this.Name, this.userType);

  @override
  State<AccountList> createState() => _AccountListState();
}

class _AccountListState extends State<AccountList> {
  @override
  void initState() {
    super.initState();
  }


  List<Account> menuList () {
    List<Account> account = <Account>[];
    print(widget.userType);
    if(widget.userType == 0) {
      account.add(Account(
          'Custom Registration', 'Custom Create Option Avaliable in Admin',
          Icon(Icons.account_box_outlined),0));
      account.add(Account(
          'User Creation', 'User Create Option Avaliable in Admin',
          Icon(Icons.account_circle_outlined),1));
      account.add(Account('Logout', 'User Create Option Avaliable in Admin',
          Icon(Icons.logout),4));
    }else if(widget.userType == 1){
      account.add(Account('Logout', 'User Create Option Avaliable in Admin',
          Icon(Icons.logout),4));
    }else{
      account.add(Account('Logout', 'User Create Option Avaliable in Admin',
          Icon(Icons.logout),4));
    }
    return account;
  }


  @override
  Widget build(BuildContext context) {


    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15.0),
        child: ListView.builder(
            shrinkWrap: true,
            itemCount: menuList().length,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              final message = menuList()[index];
              return TweenAnimationBuilder<double>(
                duration: Duration(
                  milliseconds: (200 + (index * 100)).toInt() < 1500
                      ? (200 + (index * 100)).toInt()
                      : 1500,
                ),
                tween: Tween(begin: 0, end: 1),
                builder: (_, value, __) =>
                    TweenAnimationBuilder<double>(
                      duration: Duration(milliseconds: 500),
                      tween: Tween(begin: (80 * index).toDouble(), end: 0),
                      builder: ((_, paddingValue, __) =>
                          GestureDetector(
                            onTap: (){
                              if(message.menuType == 4){
                                Navigator.pushReplacement(
                                    context, MaterialPageRoute(builder: (context) => LoginScreen()));
                              }else if(message.menuType == 0){
                                Navigator.pushReplacement(
                                    context, MaterialPageRoute(builder: (context) => CustomerEntry(widget.Name,widget.userType)));
                              }else if(message.menuType == 1){
                                Navigator.pushReplacement(
                                    context, MaterialPageRoute(builder: (context) => UserEntry(widget.Name,widget.userType)));
                              }
                            },
                            child: Card(
                              elevation: 4,
                              margin: EdgeInsets.only(bottom: 30),
                              child: Container(
                                padding: EdgeInsets.only(top: paddingValue),
                                child: Opacity(
                                  opacity: value,
                                  child: Container(
                                    padding: EdgeInsets.all(10),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment
                                          .start,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(right: 5),
                                          child: Center(
                                            child: message.menuIcons,
                                          ),
                                        ),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment
                                                .start,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    bottom: 5),
                                                child: Text(
                                                  message.title,
                                                  style: TextStyle(
                                                      fontSize: 17,
                                                      fontWeight: FontWeight
                                                          .w600),
                                                ),
                                              ),
                                              Text(
                                                message.subTitle,
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.grey,
                                                    fontWeight: FontWeight.w700),
                                              ),
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
            }),
      ),
    );
  }
}