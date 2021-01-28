import 'dart:convert';
import 'package:easy_rails/constants.dart';
import 'file:///C:/Users/test/AndroidStudioProjects/easy_rails/lib/screens/aurizonweldreturn/viewWeldReturn.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

bool _waiting = false;

class AWRSubmitted extends StatefulWidget {
  @override
  _AWRSubmittedState createState() => _AWRSubmittedState();
}

class _AWRSubmittedState extends State<AWRSubmitted> {

  @override
  void initState() {
    setState(() {
      _waiting = true;
    });
    print(kAurizonWeldListCreatedSubmittedUrl + '$loggedinUserFName $loggedinUserSName&Status=Submitted');
    GetAurizonWeldReturn_Submitted(
        kAurizonWeldListCreatedSubmittedUrl + '$loggedinUserFName $loggedinUserSName&Status=Submitted')
        .whenComplete(() {
      setState(() {
        _waiting = false;
      });
    }).catchError((error, stackTrace) {
      setState(() {
        _waiting = false;
      });
      print(error);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(inAsyncCall: _waiting,
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              child: AWRSubmittedRecord(),

            )
          ],
        ),
      ),
    );
  }
}


class AWRSubmittedRecord extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: AWR_SubmittedMap.values.map((dynamic value) {
        return Card(elevation: 5.0,
          child: ListTile(
            onTap: () {
              print(jsonDecode(value)["WeldNumber"].toString());
            },
            title: Text(
              jsonDecode(value)["WeldNumber"].toString(),
            ),
            trailing: IconButton(
              icon: Icon(Icons.open_in_new_sharp),
              onPressed: () {
                print(jsonDecode(value).toString());
                print(value);
                Navigator.push(context, MaterialPageRoute(
                    builder: (context) => ViewWeldReturn(weldJson: value,)));
              },
            ),
          ),
        );
      }).toList(),
    );
  }
}
