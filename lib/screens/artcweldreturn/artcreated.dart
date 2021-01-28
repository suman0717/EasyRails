import 'dart:convert';
import 'package:easy_rails/constants.dart';
import 'editartcWeldReturn.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

bool _waiting = false;

class ARTCCreated extends StatefulWidget {
  @override
  _ARTCCreatedState createState() => _ARTCCreatedState();
}

class _ARTCCreatedState extends State<ARTCCreated> {
  @override
  void initState() {
    setState(() {
      _waiting = true;
    });
    print(kARTCWeldListCreatedSubmittedUrl +
        '$loggedinUserFName $loggedinUserSName&Status=Created');
    GetARTCWeldReturn_Created(kARTCWeldListCreatedSubmittedUrl +
            '$loggedinUserFName $loggedinUserSName&Status=Created')
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
    return ModalProgressHUD(
      inAsyncCall: _waiting,
      child: Scaffold(
        // appBar: AppBar( centerTitle: true, title: Text('asd'), flexibleSpace: Container( decoration: BoxDecoration( gradient: LinearGradient( begin: Alignment.topLeft, end: Alignment.bottomRight, colors: <Color>[ Colors.red, Colors.blue ]) ), ), ),
        // extendBodyBehindAppBar: true,
        body: Column(
          children: [
            Expanded(
              child: ARTCCreatedRecord(),
            )
          ],
        ),
      ),
    );
  }
}

class ARTCCreatedRecord extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: ARTC_CreatedMap.values.map((dynamic value) {
        return Card(
          elevation: 5.0,
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
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => EditARTCWeldReturn(
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
