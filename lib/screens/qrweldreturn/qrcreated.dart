import 'dart:convert';
import 'package:easy_rails/constants.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'editQRWeldReturn.dart';

bool _waiting = false;

class QRCreated extends StatefulWidget {
  @override
  _QRCreatedState createState() => _QRCreatedState();
}

class _QRCreatedState extends State<QRCreated> {

  @override
  void initState() {
    setState(() {
      _waiting = true;
    });
    print(kQRWeldListCreatedSubmittedUrl + '$loggedinUserFName $loggedinUserSName&Status=Created');
    GetQRWeldReturn_Created(
        kQRWeldListCreatedSubmittedUrl + '$loggedinUserFName $loggedinUserSName&Status=Created')
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
              child: QRCreatedRecord(),

            )
          ],
        ),
      ),
    );
  }
}


class QRCreatedRecord extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: QR_CreatedMap.values.map((dynamic value) {
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
                    builder: (context) => EditQRWeldReturn(weldJson: value,)));
              },
            ),
          ),
        );
      }).toList(),
    );
  }
}
