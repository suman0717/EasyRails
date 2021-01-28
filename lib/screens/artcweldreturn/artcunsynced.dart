import 'dart:convert';
import 'package:easy_rails/constants.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'editunsyncedartcWeldReturn.dart';

bool _waiting = false;

class ARTCUnsynced extends StatefulWidget {
  @override
  _ARTCUnsyncedState createState() => _ARTCUnsyncedState();
}

class _ARTCUnsyncedState extends State<ARTCUnsynced> {
  @override
  void initState() {
    setState(() {
      _waiting = true;
    });
    GetARTCWeldReturn_UnSynced().whenComplete(() {
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
    return ModalProgressHUD(
      inAsyncCall: _waiting,
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              child: ARTCUnsyncedRecord(),
            )
          ],
        ),
      ),
    );
  }
}

class ARTCUnsyncedRecord extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: ARTC_UnsyncedMap.values.map((dynamic value) {
        return Card(
          elevation: 5.0,
          child: ListTile(
            onTap: () {
              print(jsonDecode(value)["tempaRTCLocalBatch"].toString());
              print(value);
              print(jsonDecode(value)["tempweldLocationCode"].toString());
            },
            title: Text(
              jsonDecode(value)["id"].toString()+'-ARTC Weld',
            ),
            trailing: IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                print(jsonDecode(value).toString());
                print(value);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => EditUnsyncedARTCWeldReturn(
                              weldJson: value,
                            )));
              },
            ),
          ),
        );
      }).toList(),
    );
  }
}
