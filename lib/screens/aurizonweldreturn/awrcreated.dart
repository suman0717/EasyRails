import 'dart:convert';
import 'package:easy_rails/constants.dart';
import 'file:///C:/Users/test/AndroidStudioProjects/easy_rails/lib/screens/aurizonweldreturn/editWeldReturn.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

bool _waiting = false;

class AWRCreated extends StatefulWidget {
  @override
  _AWRCreatedState createState() => _AWRCreatedState();
}

class _AWRCreatedState extends State<AWRCreated> {

  @override
  void initState() {
    setState(() {
      _waiting = true;
    });
    print(kAurizonWeldListCreatedSubmittedUrl + '$loggedinUserFName $loggedinUserSName&Status=Created');
    GetAurizonWeldReturn_Created(
        kAurizonWeldListCreatedSubmittedUrl + '$loggedinUserFName $loggedinUserSName&Status=Created')
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
              child: AWRCreatedRecord(),

            )
          ],
        ),
      ),
    );
  }
}


class AWRCreatedRecord extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: AWR_CreatedMap.values.map((dynamic value) {
        return Card(elevation: 5.0,
          child: ListTile(
            onTap: () {
              print(jsonDecode(value)["WeldNumber"].toString());
            },
            title: Text(
              jsonDecode(value)["WeldNumber"].toString(),
            ),
            trailing: IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                print(jsonDecode(value).toString());
                print(value);

                Navigator.push(context, MaterialPageRoute(
                    builder: (context) => EditWeldReturn(weldJson: value,)));
              },
            ),
          ),
        );
      }).toList(),
    );
  }
}
