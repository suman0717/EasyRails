import 'dart:convert';
import 'package:easy_rails/constants.dart';
import 'package:easy_rails/screens/qrweldreturn/viewQRWeldReturn.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import 'editQRWeldReturn.dart';
import 'editunsyncedQRWeldReturn.dart';

bool _waiting = false;

class QRUnsynced extends StatefulWidget {
  @override
  _QRUnsyncedState createState() => _QRUnsyncedState();
}

class _QRUnsyncedState extends State<QRUnsynced> {

  @override
  void initState() {
    setState(() {
      _waiting = true;
    });
    GetQRWeldReturn_UnSynced().whenComplete(() {
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
              child: QRUnsyncedRecord(),

            )
          ],
        ),
      ),
    );
  }
}


class QRUnsyncedRecord extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: QR_UnsyncedMap.values.map((dynamic value) {
        return Card(elevation: 5.0,
          child: ListTile(
            onTap: () {
              print(jsonDecode(value)["id"].toString());
            },
            title: Text(
              jsonDecode(value)["id"].toString()+'-QR Weld',
            ),
            trailing: IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                print(jsonDecode(value).toString());
                print(value);
                Navigator.push(context, MaterialPageRoute(
                    builder: (context) => EditUnsyncedQRWeldReturn(weldJson: value,)));
              },
            ),
          ),
        );
      }).toList(),
    );
  }
}
