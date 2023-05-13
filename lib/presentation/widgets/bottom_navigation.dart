
import 'package:flutter/material.dart';

import '../../models/loginResponse.dart';
import '../account.dart';
import 'messages_screen.dart';

class BottomNavigationBarExample extends StatefulWidget {
  String? Name;
  int? userType;

  BottomNavigationBarExample(this.Name,this.userType);

  @override
  State<BottomNavigationBarExample> createState() => _BottomNavigationBarExampleState();
}

class _BottomNavigationBarExampleState extends State<BottomNavigationBarExample> {
  int _selectedIndex = 0;

  late int? userTypeValue = widget.userType;

  Widget widgetFilter (int selectIndex){
    print(widget.userType);
    List<Widget> _widgetOptions = <Widget>[];
    _widgetOptions.add(MessagesScreen(widget.Name,widget.userType));
    _widgetOptions.add(AccountList(widget.Name,widget.userType));
    return _widgetOptions.elementAt(selectIndex);
  }



  List<BottomNavigationBarItem> bottomOption (){
    List<BottomNavigationBarItem> _bottomOption = <BottomNavigationBarItem>[];
    _bottomOption.add(BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: 'Home',
    ));
    _bottomOption.add(BottomNavigationBarItem(
      icon: Icon(Icons.account_box),
      label: 'Account',
    ));
    return _bottomOption;
  }






  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: widgetFilter(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items:bottomOption(),
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
