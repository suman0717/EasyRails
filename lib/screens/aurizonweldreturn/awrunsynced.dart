import 'dart:convert';
import 'package:easy_rails/constants.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'editunsyncedWeldReturn.dart';

bool _waiting = false;

class AWRUnsynced extends StatefulWidget {
  @override
  _AWRUnsyncedState createState() => _AWRUnsyncedState();
}

class _AWRUnsyncedState extends State<AWRUnsynced> {

  @override
  void initState() {
    setState(() {
      _waiting = true;
    });
    GetAurizonWeldReturn_UnSynced().whenComplete(() {
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
              child: AWRUnsyncedRecord(),

            )
          ],
        ),
      ),
    );
  }
}


class AWRUnsyncedRecord extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: AWR_UnsyncedMap.values.map((dynamic value) {
        return Card(elevation: 5.0,
          child: ListTile(
            onTap: () {
              print(jsonDecode(value)["id"].toString());
            },
            title: Text(
              jsonDecode(value)["id"].toString()+'-Aurizon Weld',
            ),
            trailing: IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                print(jsonDecode(value).toString());
                print(value);
                Navigator.push(context, MaterialPageRoute(
                    builder: (context) => EditUnsyncedWeldReturn(weldJson: value,)));
              },
            ),
          ),
        );
      }).toList(),
    );
  }
}
