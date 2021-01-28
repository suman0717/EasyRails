import 'package:easy_rails/alert.dart';
import 'package:easy_rails/linkOpener.dart';
import 'package:easy_rails/screens/XDMyAccount.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BottomBar extends StatefulWidget {


  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int selectedIndex=0;
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(backgroundColor: Colors.white,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(
            Icons.info,
            size: 20.0,
          ),
          title: Text('Info'),

        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.drafts,
            size: 20.0,
          ),
          title: Text('Support'),
        ),
//        BottomNavigationBarItem(
//          icon: Icon(
//            Icons.account_circle,
//            size: 20.0,
//          ),
//          title: Text('Account'),
//        ),
      ],
      currentIndex: selectedIndex,
      selectedItemColor: Color(0xff37b033),
      onTap: _onItemTapped,
    );
  }
  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
      if(index==0){
        showAlert();}
      else if(index==1){
        QuickLaunchLink().hitLink('mailto:support@ethink.solutions?subject=Need%20Help&body=Hi%20Support');
      }
      else if(index==2){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>XDMyAccount(),),);
      }
    },);
  }

  void showAlert(){
    showDialog(context: context,
      barrierDismissible: false,
      builder: (BuildContext context){
        return
          CustomAlertDialog();
      },
    );
  }
}
