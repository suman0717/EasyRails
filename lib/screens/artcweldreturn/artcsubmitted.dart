import 'dart:convert';
import 'package:easy_rails/constants.dart';
import 'package:easy_rails/screens/artcweldreturn/viewartcWeldReturn.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

bool _waiting = false;

class ARTCSubmitted extends StatefulWidget {
  @override
  _ARTCSubmittedState createState() => _ARTCSubmittedState();
}

class _ARTCSubmittedState extends State<ARTCSubmitted> {
  @override
  void initState() {
    setState(() {
      _waiting = true;
    });
    print(kARTCWeldListCreatedSubmittedUrl +
        '$loggedinUserFName $loggedinUserSName&Status=Submitted');
    GetARTCWeldReturn_Submitted(kARTCWeldListCreatedSubmittedUrl +
            '$loggedinUserFName $loggedinUserSName&Status=Submitted')
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
        // appBar: AppBar(
        //   backgroundColor: Colors.transparent,
        //   elevation: 0,
        // ),
        // extendBodyBehindAppBar: true,
        body: Column(
          children: [
            // Container(
            //   height: 12.25 * SizeConfig.heightMultiplier,
            //   decoration: BoxDecoration(
            //     gradient: LinearGradient(
            //       begin: Alignment(-1.21, -1.17),
            //       end: Alignment(1.25, 0.26),
            //       colors: [
            //         const Color(0xff5eb533),
            //         const Color(0xff097445),
            //         const Color(0xff157079),
            //         const Color(0xff02414d)
            //       ],
            //       stops: [0.0, 0.391, 0.712, 1.0],
            //     ),
            //   ),
            //   child: Column(
            //     crossAxisAlignment: CrossAxisAlignment.stretch,
            //     mainAxisAlignment: MainAxisAlignment.end,
            //     children: [
            //       Text(
            //         'SUBMITTED WELD RETURN',
            //         style: TextStyle(
            //           fontFamily: 'Poppins',
            //           fontSize: 1.9 * SizeConfig.heightMultiplier,
            //           color: const Color(0xffffffff),
            //           fontWeight: FontWeight.w500,
            //         ),
            //         textAlign: TextAlign.center,
            //       ),
            //       SizedBox(
            //         height: 3.3 * SizeConfig.heightMultiplier,
            //       ),
            //     ],
            //   ),
            // ),
            Expanded(
              child: ARTCSubmittedRecord(),
            )
          ],
        ),
      ),
    );
  }
}

class ARTCSubmittedRecord extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: ARTC_SubmittedMap.values.map((dynamic value) {
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
              icon: Icon(Icons.open_in_new_sharp),
              onPressed: () {
                print(jsonDecode(value).toString());
                print(value);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ViewARTCWeldReturn(
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
