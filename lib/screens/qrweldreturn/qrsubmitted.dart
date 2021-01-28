import 'dart:convert';
import 'package:easy_rails/constants.dart';
import 'package:easy_rails/screens/qrweldreturn/viewQRWeldReturn.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

bool _waiting = false;

class QRSubmitted extends StatefulWidget {
  @override
  _QRSubmittedState createState() => _QRSubmittedState();
}

class _QRSubmittedState extends State<QRSubmitted> {

  @override
  void initState() {
    setState(() {
      _waiting = true;
    });
    print(kQRWeldListCreatedSubmittedUrl + '$loggedinUserFName $loggedinUserSName&Status=Submitted');
    GetQRWeldReturn_Submitted(
        kQRWeldListCreatedSubmittedUrl + '$loggedinUserFName $loggedinUserSName&Status=Submitted')
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
              child: QRSubmittedRecord(),

            )
          ],
        ),
      ),
    );
  }
}


class QRSubmittedRecord extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: QR_SubmittedMap.values.map((dynamic value) {
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
                    builder: (context) => ViewQRWeldReturn(weldJson: value,)));
              },
            ),
          ),
        );
      }).toList(),
    );
  }
}
