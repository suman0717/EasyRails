import 'dart:convert';
import 'package:easy_rails/constants.dart';
import 'package:easy_rails/customdropdown.dart';
import 'package:easy_rails/size_config.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;
import 'package:modal_progress_hud/modal_progress_hud.dart';

int aWCounter = 0;
bool _waiting = false;
String error = 'No Error';
String _temparr;
bool isReportGenerated = false;

var _artcweldReturnFormKey = GlobalKey<FormState>();
var _supervisorFormKeyARTC = GlobalKey<FormState>();

class ArtcWeldReturnForm extends StatefulWidget {
  @override
  _ArtcWeldReturnFormState createState() => _ArtcWeldReturnFormState();
}

class _ArtcWeldReturnFormState extends State<ArtcWeldReturnForm> {
  String _welder;
  String _licenseNumber;
  DateTime _weekend;
  String _welderSignature;
  DateTime _welderSignatureDate;
  String _welderHomeStation;
  String _supervisor;
  DateTime _supervisorSignatureDate;
  String _operator;
  String _ultraSonicName;
  String _ultraSonicSignature;
  bool _question1 = false;
  String _question1Signature;
  String _question1Comment;
  bool _question2 = false;
  String _question2Signature;
  String _question2Comment;
  bool _question3 = false;
  String _question3Signature;
  String _question3Comment;
  bool _question4 = false;
  String _question4Signature;
  String _question4Comment;
  bool _question5 = false;
  String _question5Signature;
  String _question5Comment;
  String _notes;

  var ctrlLicense = TextEditingController();
  var ctrlWelderSignature = TextEditingController();
  var ctrlWelderHomeStation = TextEditingController();
  var ctrlRailOperator = TextEditingController();
  var ctrl_question1 = TextEditingController();
  var ctrl_question2 = TextEditingController();
  var ctrl_question3 = TextEditingController();
  var ctrl_question4 = TextEditingController();
  var ctrl_question5 = TextEditingController();
  var ctrlMobileartc = TextEditingController();

  var _tmpArray = [];

  getCheckboxItems() {
    ARTCWeldReturnMapForForm.forEach((key, value) {
      if (value == true) {
        _tmpArray.add(key);
      }
    });

    // Printing all selected items on Terminal screen.
    print(_tmpArray);
    _temparr = _tmpArray.toString();
    _temparr = _temparr.replaceAll('[', '');
    _temparr = _temparr.replaceAll(']', '');
    _temparr = _temparr.replaceAll(' ', '');
    _temparr = _temparr.padRight(1);
    print('String value');
    print(_temparr);
    // Here you will get all your selected Checkbox items.

    // Clear array after use.
    _tmpArray.clear();
  }

  @override
  void initState() {
    setState(() {
      _waiting = true;
    });
    isReportGenerated = false;
    _weekend = DateTime.now();
    _welderSignatureDate = DateTime.now();
    _supervisorSignatureDate = DateTime.now();
    _welder = loggedinUserFName + ' ' + loggedinUserSName;

    ctrlRailOperator.text = _operator = 'ARTC Weld Returns';
    GetGenericDataForARTCWeldreturnForm().whenComplete(() {
      setState(() {
        ErUser.forEach((key, value) {
          if (jsonDecode(value)["FullName"] ==
              loggedinUserFName + ' ' + loggedinUserSName) {
            _licenseNumber =
                jsonDecode(value)["ActiveLicenseNumber"].toString();
            _welderSignature =
                jsonDecode(value)["Signature_Full_Plain"].toString();
            _welderHomeStation = jsonDecode(value)["HomeStation"].toString();
            ctrlLicense.text = _licenseNumber;
            ctrlWelderSignature.text = _welderSignature;
            ctrlWelderHomeStation.text = _welderHomeStation;
          }
        });
        _waiting = false;
      });
    }).catchError((error, stackTrace) {
      setState(() {
        _waiting = false;
      });
      print("outer: $error");
    });
    super.initState();
  }

  @override
  void dispose() {
    ARTCWeldReturnMapForForm = {};
    aWCounter = 0;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool _isWeldReurnvalid = true;

    void _validate() {
      if (_welder == null) {
        _isWeldReurnvalid = false;
        ShowFlushbar('Error', 'Please Provide Welder', Icons.close, context);
      } else if (aWCounter < 1) {
        _isWeldReurnvalid = false;
        ShowFlushbar('Error', 'Please Choose Atleast One Weld Return',
            Icons.close, context);
      }
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'ARTC Aurizon Weld Return Form',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 1.9 * SizeConfig.heightMultiplier,
            color: const Color(0xffffffff),
            fontWeight: FontWeight.w500,
          ),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment(-1.21, -1.17),
              end: Alignment(1.25, 0.26),
              colors: [
                const Color(0xff5eb533),
                const Color(0xff097445),
                const Color(0xff157079),
                const Color(0xff02414d)
              ],
              stops: [0.0, 0.391, 0.712, 1.0],
            ),
          ),
        ),
      ),
      body: ModalProgressHUD(
        inAsyncCall: _waiting,
        color: Color(0xff3ba838),
        opacity: 0.1,
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Column(
            children: [
              Visibility(
                visible: !isReportGenerated,
                child: Expanded(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(
                        6.35 * SizeConfig.widthMultiplier,
                        2.63 * SizeConfig.heightMultiplier,
                        6.35 * SizeConfig.widthMultiplier,
                        0),
                    child: Form(
                      key: _artcweldReturnFormKey,
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            //Choose Welder
                            Padding(
                              padding: EdgeInsets.only(bottom: 8.0, top: 20),
                              child: Text(
                                'Choose Welder',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 1.7 * SizeConfig.heightMultiplier,
                                  color: const Color(0xffa1a1a1),
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ),
                            DropDownField(
                                onValueChanged: (dynamic s) async {
                                  print('akjsdsa');
                                  setState(() {
                                    _waiting = true;
                                  });
                                  await GetARTCWeldReturn(kARTCWeldListUrl + s);
                                  setState(() {
                                    _welder = s;
                                    ErUser.forEach((key, value) {
                                      if (jsonDecode(value)["FullName"] == s) {
                                        _licenseNumber = jsonDecode(
                                                value)["ActiveLicenseNumber"]
                                            .toString();
                                        _welderSignature = jsonDecode(
                                                value)["Signature_Full_Plain"]
                                            .toString();
                                        _welderHomeStation =
                                            jsonDecode(value)["HomeStation"]
                                                .toString();
                                        ctrlLicense.text = _licenseNumber;
                                        ctrlWelderSignature.text =
                                            _welderSignature;
                                        ctrlWelderHomeStation.text =
                                            _welderHomeStation;
                                      }
                                    });
                                    _waiting = false;
                                  });
                                },
                                textStyle: TextStyle(
                                    height: 0.9,
                                    fontFamily: 'Poppins',
                                    fontSize:
                                        1.84 * SizeConfig.heightMultiplier),
                                value: _welder,
                                required: false,
                                hintText: 'Choose a welder',
                                hintStyle: TextStyle(
                                    height: 1.0,
                                    fontFamily: 'Poppins',
                                    fontSize:
                                        1.84 * SizeConfig.heightMultiplier),
                                items: ErUser.values.map(
                                  (dynamic value) {
                                    return jsonDecode(value)["FullName"]
                                        .toString();
                                  },
                                ).toList(),
                                strict: true,
                                setter: (dynamic newValue) {
                                  print('Setter');
                                  _welder = newValue;
                                }),

                            //Welder License
                            Padding(
                              padding: EdgeInsets.only(bottom: 8.0, top: 20),
                              child: Text(
                                'License Number',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 1.7 * SizeConfig.heightMultiplier,
                                  color: const Color(0xffa1a1a1),
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ),
                            Container(
                              child: TextFormField(
                                  readOnly: true,
                                  textAlign: TextAlign.center,
                                  controller: ctrlLicense,
                                  style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize:
                                          1.84 * SizeConfig.heightMultiplier),
                                  decoration:
                                      kTextFieldDecorationNoback.copyWith(
                                    hintText: '',
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical:
                                            1.5 * SizeConfig.heightMultiplier,
                                        horizontal: 20.0),
                                  )),
                              width: 68.2 * SizeConfig.widthMultiplier,
                            ),

                            //Week Ending
                            Padding(
                              padding: EdgeInsets.only(bottom: 8.0, top: 20),
                              child: Text(
                                'Week Ending',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 1.7 * SizeConfig.heightMultiplier,
                                  color: const Color(0xffa1a1a1),
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ),
                            Container(
                              // height: 5.13 * SizeConfig.heightMultiplier,
                              width: 68.2 * SizeConfig.widthMultiplier,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                    3.95 * SizeConfig.heightMultiplier),
                                border: Border.all(
                                    color: Color(0xffe8e8e8), width: 1.0),
                              ),
                              child: ListTile(
                                trailing: IconButton(
                                    icon: Icon(Icons.date_range_outlined),
                                    onPressed: () {
                                      pickWeekendDate();
                                    }),
                                title: Center(
                                    child: Text(
                                        '${_weekend.day}-${_weekend.month}-${_weekend.year}')),
                              ),
                            ),

                            //Welders Signature
                            Padding(
                              padding: EdgeInsets.only(bottom: 8.0, top: 20),
                              child: Text(
                                'Welders Signature',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 1.7 * SizeConfig.heightMultiplier,
                                  color: const Color(0xffa1a1a1),
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ),
                            Container(
                              child: TextFormField(
                                  readOnly: true,
                                  textAlign: TextAlign.center,
                                  controller: ctrlWelderSignature,
                                  style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize:
                                          1.84 * SizeConfig.heightMultiplier),
                                  decoration:
                                      kTextFieldDecorationNoback.copyWith(
                                    hintText: '',
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical:
                                            1.5 * SizeConfig.heightMultiplier,
                                        horizontal: 20.0),
                                  )),
                              width: 68.2 * SizeConfig.widthMultiplier,
                            ),

                            //Welder Signature Date
                            Padding(
                              padding: EdgeInsets.only(bottom: 8.0, top: 20),
                              child: Text(
                                'Date',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 1.7 * SizeConfig.heightMultiplier,
                                  color: const Color(0xffa1a1a1),
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ),
                            Container(
                              width: 68.2 * SizeConfig.widthMultiplier,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                    3.95 * SizeConfig.heightMultiplier),
                                border: Border.all(
                                    color: Color(0xffe8e8e8), width: 1.0),
                              ),
                              child: ListTile(
                                trailing: IconButton(
                                    icon: Icon(Icons.date_range_outlined),
                                    onPressed: () {
                                      pickWeldSignature();
                                    }),
                                title: Center(
                                    child: Text(
                                        '${_welderSignatureDate.day}-${_welderSignatureDate.month}-${_welderSignatureDate.year}')),
                              ),
                            ),

                            //Welder Home Station
                            Padding(
                              padding: EdgeInsets.only(bottom: 8.0, top: 20),
                              child: Text(
                                'Home Station',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 1.7 * SizeConfig.heightMultiplier,
                                  color: const Color(0xffa1a1a1),
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ),
                            Container(
                              child: TextFormField(
                                  readOnly: true,
                                  textAlign: TextAlign.center,
                                  controller: ctrlWelderHomeStation,
                                  style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize:
                                          1.84 * SizeConfig.heightMultiplier),
                                  decoration:
                                      kTextFieldDecorationNoback.copyWith(
                                    hintText: '',
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical:
                                            1.5 * SizeConfig.heightMultiplier,
                                        horizontal: 20.0),
                                  )),
                              width: 68.2 * SizeConfig.widthMultiplier,
                            ),

                            //Supervisor
                            Padding(
                              padding: EdgeInsets.only(bottom: 8.0, top: 20),
                              child: Row(
                                children: [
                                  Text(
                                    'Choose Supervisor',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize:
                                          1.7 * SizeConfig.heightMultiplier,
                                      color: const Color(0xffa1a1a1),
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                  IconButton(
                                      icon: Icon(Icons.add),
                                      onPressed:
                                          AddNewSupervisorToOperatorARTC),
                                  IconButton(
                                      icon: Icon(Icons.refresh),
                                      onPressed: () async {
                                        setState(() {
                                          _waiting = true;
                                        });
                                        await GetSupervisor(kSupervisorListUrl +
                                            'ARTC Weld Returns');
                                        setState(() {
                                          _waiting = false;
                                        });
                                      }),
                                ],
                              ),
                            ),
                            DropDownField(
                                onValueChanged: (dynamic s) async {
                                  print('akjsdsa');
                                  setState(() {
                                    _supervisor = s;
                                  });
                                },
                                textStyle: TextStyle(
                                    height: 0.9,
                                    fontFamily: 'Poppins',
                                    fontSize:
                                        1.84 * SizeConfig.heightMultiplier),
                                value: _supervisor,
                                required: false,
                                hintText: 'Choose a Supervisor',
                                hintStyle: TextStyle(
                                    height: 1.0,
                                    fontFamily: 'Poppins',
                                    fontSize:
                                        1.84 * SizeConfig.heightMultiplier),
                                items: SupervisorARTC.values.map(
                                  (dynamic value) {
                                    return jsonDecode(value)["FullName"]
                                        .toString();
                                  },
                                ).toList(),
                                strict: true,
                                setter: (dynamic newValue) {
                                  print('Setter');
                                  _supervisor = newValue;
                                }),

                            //Supervisor Signature Date
                            Padding(
                              padding: EdgeInsets.only(bottom: 8.0, top: 20),
                              child: Text(
                                'Date',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 1.7 * SizeConfig.heightMultiplier,
                                  color: const Color(0xffa1a1a1),
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ),
                            Container(
                              width: 68.2 * SizeConfig.widthMultiplier,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                    3.95 * SizeConfig.heightMultiplier),
                                border: Border.all(
                                    color: Color(0xffe8e8e8), width: 1.0),
                              ),
                              child: ListTile(
                                trailing: IconButton(
                                    icon: Icon(Icons.date_range_outlined),
                                    onPressed: () {
                                      pickSuperVisorSignature();
                                    }),
                                title: Center(
                                    child: Text(
                                        '${_supervisorSignatureDate.day}-${_supervisorSignatureDate.month}-${_supervisorSignatureDate.year}')),
                              ),
                            ),

                            //UltraSonic Name
                            Padding(
                              padding: EdgeInsets.only(bottom: 8.0, top: 20),
                              child: Text(
                                'Name',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 1.7 * SizeConfig.heightMultiplier,
                                  color: const Color(0xffa1a1a1),
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ),
                            Container(
                              child: TextFormField(
                                  onChanged: (String s) {
                                    setState(() {
                                      _ultraSonicName = s;
                                    });
                                  },
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize:
                                          1.84 * SizeConfig.heightMultiplier),
                                  decoration:
                                      kTextFieldDecorationNoback.copyWith(
                                    hintText: '',
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical:
                                            1.5 * SizeConfig.heightMultiplier,
                                        horizontal: 20.0),
                                  )),
                              width: 68.2 * SizeConfig.widthMultiplier,
                            ),

                            //UltraSonic Signature
                            Padding(
                              padding: EdgeInsets.only(bottom: 8.0, top: 20),
                              child: Text(
                                'Signature',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 1.7 * SizeConfig.heightMultiplier,
                                  color: const Color(0xffa1a1a1),
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ),
                            Container(
                              child: TextFormField(
                                  onChanged: (String s) {
                                    setState(() {
                                      _ultraSonicSignature = s;
                                    });
                                  },
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize:
                                          1.84 * SizeConfig.heightMultiplier),
                                  decoration:
                                      kTextFieldDecorationNoback.copyWith(
                                    hintText: '',
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical:
                                            1.5 * SizeConfig.heightMultiplier,
                                        horizontal: 20.0),
                                  )),
                              width: 68.2 * SizeConfig.widthMultiplier,
                            ),

                            //Have Welds Been Packed (WeldPacked)
                            Padding(
                              padding: EdgeInsets.only(bottom: 8.0, top: 20),
                              child: Text(
                                'Have Welds Been Packed (WeldPacked)',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 1.7 * SizeConfig.heightMultiplier,
                                  color: const Color(0xffa1a1a1),
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ),
                            Container(
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Checkbox(
                                          value: _question1,
                                          activeColor: kShadeColor1,
                                          onChanged: (bool newvalue) {
                                            setState(() {
                                              _question1 = newvalue;
                                              if (newvalue == true) {
                                                _question1Signature =
                                                    ctrl_question1.text =
                                                        _welderSignature;
                                              } else {
                                                _question1Signature =
                                                    ctrl_question1.text = '';
                                              }
                                            });
                                          }),
                                      Text('Yes'),
                                      Checkbox(
                                          value: !_question1,
                                          activeColor: kShadeColor1,
                                          onChanged: (bool newvalue) {
                                            setState(() {
                                              _question1 = !newvalue;
                                              if (newvalue != true) {
                                                _question1Signature =
                                                    ctrl_question1.text =
                                                        _welderSignature;
                                              } else {
                                                _question1Signature =
                                                    ctrl_question1.text = '';
                                              }
                                            });
                                          }),
                                      Text('No'),
                                    ],
                                  ),
                                  Visibility(
                                      visible: _question1,
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  bottom: 8.0, top: 20),
                                              child: Text(
                                                'Signature',
                                                style: TextStyle(
                                                  fontFamily: 'Poppins',
                                                  fontSize: 1.7 *
                                                      SizeConfig
                                                          .heightMultiplier,
                                                  color:
                                                      const Color(0xffa1a1a1),
                                                ),
                                                textAlign: TextAlign.left,
                                              ),
                                            ),
                                            Container(
                                              child: TextFormField(
                                                  readOnly: true,
                                                  textAlign: TextAlign.center,
                                                  controller: ctrl_question1,
                                                  style: TextStyle(
                                                      fontFamily: 'Poppins',
                                                      fontSize: 1.84 *
                                                          SizeConfig
                                                              .heightMultiplier),
                                                  decoration:
                                                      kTextFieldDecorationNoback
                                                          .copyWith(
                                                    hintText: '',
                                                    contentPadding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 1.5 *
                                                                SizeConfig
                                                                    .heightMultiplier,
                                                            horizontal: 20.0),
                                                  )),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  bottom: 8.0, top: 20),
                                              child: Text(
                                                'Comment',
                                                style: TextStyle(
                                                  fontFamily: 'Poppins',
                                                  fontSize: 1.7 *
                                                      SizeConfig
                                                          .heightMultiplier,
                                                  color:
                                                      const Color(0xffa1a1a1),
                                                ),
                                                textAlign: TextAlign.left,
                                              ),
                                            ),
                                            Container(
                                              child: TextFormField(
                                                  textAlign: TextAlign.center,
                                                  onChanged: (value) {
                                                    _question1Comment = value;
                                                  },
                                                  style: TextStyle(
                                                      fontFamily: 'Poppins',
                                                      fontSize: 1.84 *
                                                          SizeConfig
                                                              .heightMultiplier),
                                                  decoration:
                                                      kTextFieldDecorationNoback
                                                          .copyWith(
                                                    hintText: '',
                                                    contentPadding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 1.5 *
                                                                SizeConfig
                                                                    .heightMultiplier,
                                                            horizontal: 20.0),
                                                  )),
                                            ),
                                          ]))
                                ],
                              ),
                              width: 68.2 * SizeConfig.widthMultiplier,
                            ),

                            //Are rail ends and closures crowed to correct curvature? (Where Radius <800m)
                            Padding(
                              padding: EdgeInsets.only(bottom: 8.0, top: 20),
                              child: Text(
                                'Are rail ends and closures crowed to correct curvature? (Where Radius <800m)',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 1.7 * SizeConfig.heightMultiplier,
                                  color: const Color(0xffa1a1a1),
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ),
                            Container(
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Checkbox(
                                          value: _question2,
                                          activeColor: kShadeColor1,
                                          onChanged: (bool newvalue) {
                                            setState(() {
                                              _question2 = newvalue;
                                              if (newvalue == true) {
                                                _question2Signature =
                                                    ctrl_question2.text =
                                                        _welderSignature;
                                              } else {
                                                _question2Signature =
                                                    ctrl_question2.text = '';
                                              }
                                            });
                                          }),
                                      Text('Yes'),
                                      Checkbox(
                                          value: !_question2,
                                          activeColor: kShadeColor1,
                                          onChanged: (bool newvalue) {
                                            setState(() {
                                              _question2 = !newvalue;
                                              if (newvalue != true) {
                                                _question2Signature =
                                                    ctrl_question2.text =
                                                        _welderSignature;
                                              } else {
                                                _question2Signature =
                                                    ctrl_question2.text = '';
                                              }
                                            });
                                          }),
                                      Text('No'),
                                    ],
                                  ),
                                  Visibility(
                                      visible: _question2,
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  bottom: 8.0, top: 20),
                                              child: Text(
                                                'Signature',
                                                style: TextStyle(
                                                  fontFamily: 'Poppins',
                                                  fontSize: 1.7 *
                                                      SizeConfig
                                                          .heightMultiplier,
                                                  color:
                                                      const Color(0xffa1a1a1),
                                                ),
                                                textAlign: TextAlign.left,
                                              ),
                                            ),
                                            Container(
                                              child: TextFormField(
                                                  readOnly: true,
                                                  textAlign: TextAlign.center,
                                                  controller: ctrl_question2,
                                                  style: TextStyle(
                                                      fontFamily: 'Poppins',
                                                      fontSize: 1.84 *
                                                          SizeConfig
                                                              .heightMultiplier),
                                                  decoration:
                                                      kTextFieldDecorationNoback
                                                          .copyWith(
                                                    hintText: '',
                                                    contentPadding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 1.5 *
                                                                SizeConfig
                                                                    .heightMultiplier,
                                                            horizontal: 20.0),
                                                  )),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  bottom: 8.0, top: 20),
                                              child: Text(
                                                'Comment',
                                                style: TextStyle(
                                                  fontFamily: 'Poppins',
                                                  fontSize: 1.7 *
                                                      SizeConfig
                                                          .heightMultiplier,
                                                  color:
                                                      const Color(0xffa1a1a1),
                                                ),
                                                textAlign: TextAlign.left,
                                              ),
                                            ),
                                            Container(
                                              child: TextFormField(
                                                  textAlign: TextAlign.center,
                                                  onChanged: (value) {
                                                    _question2Comment = value;
                                                  },
                                                  style: TextStyle(
                                                      fontFamily: 'Poppins',
                                                      fontSize: 1.84 *
                                                          SizeConfig
                                                              .heightMultiplier),
                                                  decoration:
                                                      kTextFieldDecorationNoback
                                                          .copyWith(
                                                    hintText: '',
                                                    contentPadding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 1.5 *
                                                                SizeConfig
                                                                    .heightMultiplier,
                                                            horizontal: 20.0),
                                                  )),
                                            ),
                                          ]))
                                ],
                              ),
                              width: 68.2 * SizeConfig.widthMultiplier,
                            ),

                            //Was track on design alignment when adjusted? If No, attach detailed alignment measurement
                            Padding(
                              padding: EdgeInsets.only(bottom: 8.0, top: 20),
                              child: Text(
                                'Was track on design alignment when adjusted? If No, attach detailed alignment measurement ',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 1.7 * SizeConfig.heightMultiplier,
                                  color: const Color(0xffa1a1a1),
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ),
                            Container(
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Checkbox(
                                          value: _question3,
                                          activeColor: kShadeColor1,
                                          onChanged: (bool newvalue) {
                                            setState(() {
                                              _question3 = newvalue;
                                              if (newvalue == true) {
                                                _question3Signature =
                                                    ctrl_question3.text =
                                                        _welderSignature;
                                              } else {
                                                _question3Signature =
                                                    ctrl_question3.text = '';
                                              }
                                            });
                                          }),
                                      Text('Yes'),
                                      Checkbox(
                                          value: !_question3,
                                          activeColor: kShadeColor1,
                                          onChanged: (bool newvalue) {
                                            setState(() {
                                              _question3 = !newvalue;
                                              if (newvalue != true) {
                                                _question3Signature =
                                                    ctrl_question3.text =
                                                        _welderSignature;
                                              } else {
                                                _question3Signature =
                                                    ctrl_question3.text = '';
                                              }
                                            });
                                          }),
                                      Text('No'),
                                    ],
                                  ),
                                  Visibility(
                                      visible: _question3,
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  bottom: 8.0, top: 20),
                                              child: Text(
                                                'Signature',
                                                style: TextStyle(
                                                  fontFamily: 'Poppins',
                                                  fontSize: 1.7 *
                                                      SizeConfig
                                                          .heightMultiplier,
                                                  color:
                                                      const Color(0xffa1a1a1),
                                                ),
                                                textAlign: TextAlign.left,
                                              ),
                                            ),
                                            Container(
                                              child: TextFormField(
                                                  readOnly: true,
                                                  textAlign: TextAlign.center,
                                                  controller: ctrl_question3,
                                                  style: TextStyle(
                                                      fontFamily: 'Poppins',
                                                      fontSize: 1.84 *
                                                          SizeConfig
                                                              .heightMultiplier),
                                                  decoration:
                                                      kTextFieldDecorationNoback
                                                          .copyWith(
                                                    hintText: '',
                                                    contentPadding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 1.5 *
                                                                SizeConfig
                                                                    .heightMultiplier,
                                                            horizontal: 20.0),
                                                  )),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  bottom: 8.0, top: 20),
                                              child: Text(
                                                'Comment',
                                                style: TextStyle(
                                                  fontFamily: 'Poppins',
                                                  fontSize: 1.7 *
                                                      SizeConfig
                                                          .heightMultiplier,
                                                  color:
                                                      const Color(0xffa1a1a1),
                                                ),
                                                textAlign: TextAlign.left,
                                              ),
                                            ),
                                            Container(
                                              child: TextFormField(
                                                  textAlign: TextAlign.center,
                                                  onChanged: (value) {
                                                    _question3Comment = value;
                                                  },
                                                  style: TextStyle(
                                                      fontFamily: 'Poppins',
                                                      fontSize: 1.84 *
                                                          SizeConfig
                                                              .heightMultiplier),
                                                  decoration:
                                                      kTextFieldDecorationNoback
                                                          .copyWith(
                                                    hintText: '',
                                                    contentPadding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 1.5 *
                                                                SizeConfig
                                                                    .heightMultiplier,
                                                            horizontal: 20.0),
                                                  )),
                                            ),
                                          ]))
                                ],
                              ),
                              width: 68.2 * SizeConfig.widthMultiplier,
                            ),

                            //Have creep marks been established or reset? If NO, attach details
                            Padding(
                              padding: EdgeInsets.only(bottom: 8.0, top: 20),
                              child: Text(
                                'Have creep marks been established or reset? If NO, attach details',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 1.7 * SizeConfig.heightMultiplier,
                                  color: const Color(0xffa1a1a1),
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ),
                            Container(
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Checkbox(
                                          value: _question4,
                                          activeColor: kShadeColor1,
                                          onChanged: (bool newvalue) {
                                            setState(() {
                                              _question4 = newvalue;
                                              if (newvalue == true) {
                                                _question4Signature =
                                                    ctrl_question4.text =
                                                        _welderSignature;
                                              } else {
                                                _question4Signature =
                                                    ctrl_question4.text = '';
                                              }
                                            });
                                          }),
                                      Text('Yes'),
                                      Checkbox(
                                          value: !_question4,
                                          activeColor: kShadeColor1,
                                          onChanged: (bool newvalue) {
                                            setState(() {
                                              _question4 = !newvalue;
                                              if (newvalue != true) {
                                                _question4Signature =
                                                    ctrl_question4.text =
                                                        _welderSignature;
                                              } else {
                                                _question4Signature =
                                                    ctrl_question4.text = '';
                                              }
                                            });
                                          }),
                                      Text('No'),
                                    ],
                                  ),
                                  Visibility(
                                      visible: _question4,
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  bottom: 8.0, top: 20),
                                              child: Text(
                                                'Signature',
                                                style: TextStyle(
                                                  fontFamily: 'Poppins',
                                                  fontSize: 1.7 *
                                                      SizeConfig
                                                          .heightMultiplier,
                                                  color:
                                                      const Color(0xffa1a1a1),
                                                ),
                                                textAlign: TextAlign.left,
                                              ),
                                            ),
                                            Container(
                                              child: TextFormField(
                                                  readOnly: true,
                                                  textAlign: TextAlign.center,
                                                  controller: ctrl_question4,
                                                  style: TextStyle(
                                                      fontFamily: 'Poppins',
                                                      fontSize: 1.84 *
                                                          SizeConfig
                                                              .heightMultiplier),
                                                  decoration:
                                                      kTextFieldDecorationNoback
                                                          .copyWith(
                                                    hintText: '',
                                                    contentPadding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 1.5 *
                                                                SizeConfig
                                                                    .heightMultiplier,
                                                            horizontal: 20.0),
                                                  )),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  bottom: 8.0, top: 20),
                                              child: Text(
                                                'Comment',
                                                style: TextStyle(
                                                  fontFamily: 'Poppins',
                                                  fontSize: 1.7 *
                                                      SizeConfig
                                                          .heightMultiplier,
                                                  color:
                                                      const Color(0xffa1a1a1),
                                                ),
                                                textAlign: TextAlign.left,
                                              ),
                                            ),
                                            Container(
                                              child: TextFormField(
                                                  textAlign: TextAlign.center,
                                                  onChanged: (value) {
                                                    _question4Comment = value;
                                                  },
                                                  style: TextStyle(
                                                      fontFamily: 'Poppins',
                                                      fontSize: 1.84 *
                                                          SizeConfig
                                                              .heightMultiplier),
                                                  decoration:
                                                      kTextFieldDecorationNoback
                                                          .copyWith(
                                                    hintText: '',
                                                    contentPadding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 1.5 *
                                                                SizeConfig
                                                                    .heightMultiplier,
                                                            horizontal: 20.0),
                                                  )),
                                            ),
                                          ]))
                                ],
                              ),
                              width: 68.2 * SizeConfig.widthMultiplier,
                            ),

                            //Have welds been final ground Y/N
                            Padding(
                              padding: EdgeInsets.only(bottom: 8.0, top: 20),
                              child: Text(
                                'Have welds been final ground Y/N',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 1.7 * SizeConfig.heightMultiplier,
                                  color: const Color(0xffa1a1a1),
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ),
                            Container(
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Checkbox(
                                          value: _question5,
                                          activeColor: kShadeColor1,
                                          onChanged: (bool newvalue) {
                                            setState(() {
                                              _question5 = newvalue;
                                              if (newvalue == true) {
                                                _question5Signature =
                                                    ctrl_question5.text =
                                                        _welderSignature;
                                              } else {
                                                _question5Signature =
                                                    ctrl_question5.text = '';
                                              }
                                            });
                                          }),
                                      Text('Yes'),
                                      Checkbox(
                                          value: !_question5,
                                          activeColor: kShadeColor1,
                                          onChanged: (bool newvalue) {
                                            setState(() {
                                              _question5 = !newvalue;
                                              if (newvalue != true) {
                                                ctrl_question5.text =
                                                    _welderSignature;
                                              } else {
                                                ctrl_question5.text = '';
                                              }
                                            });
                                          }),
                                      Text('No'),
                                    ],
                                  ),
                                  Visibility(
                                      visible: _question5,
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  bottom: 8.0, top: 20),
                                              child: Text(
                                                'Signature',
                                                style: TextStyle(
                                                  fontFamily: 'Poppins',
                                                  fontSize: 1.7 *
                                                      SizeConfig
                                                          .heightMultiplier,
                                                  color:
                                                      const Color(0xffa1a1a1),
                                                ),
                                                textAlign: TextAlign.left,
                                              ),
                                            ),
                                            Container(
                                              child: TextFormField(
                                                  readOnly: true,
                                                  textAlign: TextAlign.center,
                                                  controller: ctrl_question5,
                                                  style: TextStyle(
                                                      fontFamily: 'Poppins',
                                                      fontSize: 1.84 *
                                                          SizeConfig
                                                              .heightMultiplier),
                                                  decoration:
                                                      kTextFieldDecorationNoback
                                                          .copyWith(
                                                    hintText: '',
                                                    contentPadding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 1.5 *
                                                                SizeConfig
                                                                    .heightMultiplier,
                                                            horizontal: 20.0),
                                                  )),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  bottom: 8.0, top: 20),
                                              child: Text(
                                                'Comment',
                                                style: TextStyle(
                                                  fontFamily: 'Poppins',
                                                  fontSize: 1.7 *
                                                      SizeConfig
                                                          .heightMultiplier,
                                                  color:
                                                      const Color(0xffa1a1a1),
                                                ),
                                                textAlign: TextAlign.left,
                                              ),
                                            ),
                                            Container(
                                              child: TextFormField(
                                                  textAlign: TextAlign.center,
                                                  onChanged: (value) {
                                                    _question5Comment = value;
                                                  },
                                                  style: TextStyle(
                                                      fontFamily: 'Poppins',
                                                      fontSize: 1.84 *
                                                          SizeConfig
                                                              .heightMultiplier),
                                                  decoration:
                                                      kTextFieldDecorationNoback
                                                          .copyWith(
                                                    hintText: '',
                                                    contentPadding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 1.5 *
                                                                SizeConfig
                                                                    .heightMultiplier,
                                                            horizontal: 20.0),
                                                  )),
                                            ),
                                          ]))
                                ],
                              ),
                              width: 68.2 * SizeConfig.widthMultiplier,
                            ),

                            //Notes
                            Padding(
                              padding: EdgeInsets.only(bottom: 8.0, top: 20),
                              child: Text(
                                'Notes',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 1.7 * SizeConfig.heightMultiplier,
                                  color: const Color(0xffa1a1a1),
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ),
                            Container(
                              child: TextFormField(
                                  maxLength: 100,
                                  maxLines: 5,
                                  keyboardType: TextInputType.emailAddress,
                                  textAlign: TextAlign.center,
                                  onChanged: (value) {
                                    _notes = value;
                                  },
                                  style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize:
                                          1.84 * SizeConfig.heightMultiplier),
                                  decoration:
                                      kTextFieldDecorationNoback.copyWith(
                                    hintText: '',
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical:
                                            1.5 * SizeConfig.heightMultiplier,
                                        horizontal: 20.0),
                                  )),
                              width: 68.2 * SizeConfig.widthMultiplier,
                            ),

                            Padding(
                              padding: EdgeInsets.only(top: 20),
                              child: Text(
                                'Choose Weld Return to Include in this Form',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 1.7 * SizeConfig.heightMultiplier,
                                  color: const Color(0xffa1a1a1),
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ),
                            SizedBox(
                              child: ARTCCheckboxWidget(),
                              height: 300.0,
                            ),
                            SizedBox(
                              height: 2.6 * SizeConfig.heightMultiplier,
                            ),
                            Container(
                              width: 68.2 * SizeConfig.widthMultiplier,
                              height: 5.65 * SizeConfig.heightMultiplier,
                              child: RaisedButton(
                                color: kShadeColor1,
                                onPressed: () async {
                                  setState(() {
                                    _waiting = true;
                                  });
                                  String _stringWeek_Ending =
                                      '${_weekend.day}/${_weekend.month}/${_weekend.year}';
                                  String _stringWelderSignatureDate =
                                      '${_welderSignatureDate.day}/${_welderSignatureDate.month}/${_welderSignatureDate.year}';
                                  String _stringSupervisorSignatureDate =
                                      '${_supervisorSignatureDate.day}/${_supervisorSignatureDate.month}/${_supervisorSignatureDate.year}';
                                  getCheckboxItems();
                                  _validate();
                                  if (_isWeldReurnvalid == true) {
                                    print(
                                        'https://radreviews.online/app/REST/EasyRails/App_Create_ARTC_WeldReturn?WelderFullName=$_welder&LincenseNumber=$_licenseNumber&Week_Ending=$_stringWeek_Ending&WelderSignature=$_welderSignature&WelderSignatureDate=$_stringWelderSignatureDate&HomeStation=$_welderHomeStation&SupervisorFullName=$_supervisor&Supervisor_SignatureDate=$_stringSupervisorSignatureDate&UltraSonicOperatorName=$_ultraSonicName&UltraSonicOperatorSignature=$_ultraSonicSignature&WeldPacked=$_question1&CommentsWeldPacked=$_question1Comment&SignatureWeldPacked=$_question1Signature&RailEndCorrectCurvature=$_question2&CommentsRailEndCorrectCurvature=$_question2Comment&SignatureRailEndCorrectCurvature=$_question2Signature&TrackOnDesignAlignment=$_question3&CommentsTrackOnDesignAlignment=$_question3Comment&SignatureTrackOnDesignAlignment=$_question3Signature&CreepMarkEstablished=$_question4&CommentsCreepMarkEstablished=$_question4Comment&SignatureCreepMarkEstablished=$_question4Signature&FinalGround=$_question5&CommentsFinalGround=$_question5Comment&SignatureFinalGround=$_question5Signature&Notes=$_notes&pm_AWRID=$_temparr');
                                    http.Response _response = await http.get(
                                        'https://radreviews.online/app/REST/EasyRails/App_Create_ARTC_WeldReturn?WelderFullName=$_welder&LincenseNumber=$_licenseNumber&Week_Ending=$_stringWeek_Ending&WelderSignature=$_welderSignature&WelderSignatureDate=$_stringWelderSignatureDate&HomeStation=$_welderHomeStation&SupervisorFullName=$_supervisor&Supervisor_SignatureDate=$_stringSupervisorSignatureDate&UltraSonicOperatorName=$_ultraSonicName&UltraSonicOperatorSignature=$_ultraSonicSignature&WeldPacked=$_question1&CommentsWeldPacked=$_question1Comment&SignatureWeldPacked=$_question1Signature&RailEndCorrectCurvature=$_question2&CommentsRailEndCorrectCurvature=$_question2Comment&SignatureRailEndCorrectCurvature=$_question2Signature&TrackOnDesignAlignment=$_question3&CommentsTrackOnDesignAlignment=$_question3Comment&SignatureTrackOnDesignAlignment=$_question3Signature&CreepMarkEstablished=$_question4&CommentsCreepMarkEstablished=$_question4Comment&SignatureCreepMarkEstablished=$_question4Signature&FinalGround=$_question5&CommentsFinalGround=$_question5Comment&SignatureFinalGround=$_question5Signature&Notes=$_notes&pm_AWRID=$_temparr');
                                    var _responseBody = _response.body;
                                    print(_responseBody);
                                    kLatestARTCReportURL = jsonDecode(
                                        _responseBody)['ReportPathURL'];
                                    print(kLatestARTCReportURL);
                                    launchInBrowser(kLatestARTCReportURL);
                                    setState(() {
                                      isReportGenerated = true;
                                    });
                                    await Flushbar(
                                      titleText: Text(
                                        'Success',
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize:
                                              2.0 * SizeConfig.heightMultiplier,
                                          color: const Color(0xffffffff),
                                          fontWeight: FontWeight.w600,
                                        ),
                                        textAlign: TextAlign.left,
                                      ),
                                      messageText: Text(
                                        'You have successfully generated weld report',
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize:
                                              1.3 * SizeConfig.heightMultiplier,
                                          color: const Color(0xffffffff),
                                          fontWeight: FontWeight.w300,
                                        ),
                                        textAlign: TextAlign.left,
                                      ),
                                      padding: EdgeInsets.symmetric(
                                          vertical: 12.0,
                                          horizontal:
                                              5.1 * SizeConfig.widthMultiplier),
                                      icon: Icon(
                                        Icons.check,
                                        size:
                                            3.94 * SizeConfig.heightMultiplier,
                                        color: Colors.white,
                                      ),
                                      duration: Duration(seconds: 3),
                                      flushbarPosition: FlushbarPosition.TOP,
                                      borderColor: Colors.transparent,
                                      shouldIconPulse: false,
                                      maxWidth:
                                          91.8 * SizeConfig.widthMultiplier,
                                      boxShadows: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.3),
                                          spreadRadius:
                                              1 * SizeConfig.heightMultiplier,
                                          blurRadius:
                                              2 * SizeConfig.heightMultiplier,
                                          offset: Offset(0,
                                              10), // changes position of shadow
                                        ),
                                      ],
                                      backgroundColor: kShadeColor1,
                                    ).show(context);
                                  }

                                  setState(() {
                                    _waiting = false;
                                  });
                                },
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      2.63 * SizeConfig.heightMultiplier),
                                ),
                                padding: EdgeInsets.all(0.0),
                                child: Padding(
                                  padding:
                                      EdgeInsets.only(left: 0.0, right: 0.0),
                                  child: Text(
                                    'Submit ARTC Weld Return Form',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize:
                                          2.0 * SizeConfig.heightMultiplier,
                                      color: const Color(0xffffffff),
                                      fontWeight: FontWeight.w600,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 2.6 * SizeConfig.heightMultiplier,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Visibility(
                  visible: isReportGenerated,
                  child: Expanded(
                      child: Center(
                    child: Text(
                      'Report Generated...',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 2.36 * SizeConfig.heightMultiplier,
                        color: const Color(0xff363636),
                        fontWeight: FontWeight.w500,
                        height: 0.2 * SizeConfig.heightMultiplier,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  )))
            ],
          ),
        ),
      ),
    );
  }

  void AddNewSupervisorToOperatorARTC() async {
    String _emailAddress;
    String _password;
    String _mobile;
    String _maskednumber;
    String _firstName;
    String _surname;

    var ctrlMobile = TextEditingController();
    bool _localWaiting = false;
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return ModalProgressHUD(
              inAsyncCall: _localWaiting,
              child: AlertDialog(
                title: Text("Add Supervisor"),
                content: GestureDetector(
                  onTap: () {
                    FocusScope.of(context).unfocus();
                  },
                  child: SingleChildScrollView(
                    child: Form(
                      key: _supervisorFormKeyARTC,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            child: TextFormField(
                              validator: (String value) {
                                if (value.isEmpty) {
                                  return 'Please Provide First Name';
                                }
                              },
                              textAlign: TextAlign.center,
                              keyboardType: TextInputType.emailAddress,
                              onChanged: (value) {
                                _firstName = value;
                              },
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 2 * SizeConfig.heightMultiplier),
                              decoration: kTextFieldDecorationNoback.copyWith(
                                  hintText: 'First Name'),
                            ),
                            width: 67.8 * SizeConfig.widthMultiplier,
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          Container(
                            child: TextFormField(
                              validator: (String value) {
                                if (value.isEmpty) {
                                  return 'Please Provide Surname';
                                }
                              },
                              textAlign: TextAlign.center,
                              keyboardType: TextInputType.emailAddress,
                              onChanged: (value) {
                                _surname = value;
                              },
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 2 * SizeConfig.heightMultiplier),
                              decoration: kTextFieldDecorationNoback.copyWith(
                                  hintText: 'Surname'),
                            ),
                            width: 67.8 * SizeConfig.widthMultiplier,
                            // height: 5.65 * SizeConfig.heightMultiplier,
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          Container(
                            child: TextFormField(
                              validator: (String value) {
                                if (value.isEmpty) {
                                  return 'Email address must be provided';
                                } else if (EmailValidator.validate(value) !=
                                    true) {
                                  return 'Please enter a valid email';
                                }
                              },
                              textAlign: TextAlign.center,
                              keyboardType: TextInputType.emailAddress,
                              onChanged: (value) {
                                _emailAddress = value;
                              },
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 2 * SizeConfig.heightMultiplier),
                              decoration: kTextFieldDecorationNoback.copyWith(
                                  hintText: 'Email Address'),
                            ),
                            width: 67.8 * SizeConfig.widthMultiplier,
                            // height: 5.65 * SizeConfig.heightMultiplier,
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          Container(
                            width: 67.8 * SizeConfig.widthMultiplier,
                            // height: 5.65 * SizeConfig.heightMultiplier,
                            child: TextFormField(
                              validator: (String value) {
                                if (value.length < 8) {
                                  return 'Minimum 8 characters';
                                }
                              },
                              obscureText: true,
                              textAlign: TextAlign.center,
                              keyboardType: TextInputType.emailAddress,
                              onChanged: (value) {
                                _password = value;
                              },
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 2 * SizeConfig.heightMultiplier,
                              ),
                              decoration: kTextFieldDecorationNoback.copyWith(
                                  hintText: 'Password'),
                            ),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          Container(
                            child: TextFormField(
                                inputFormatters: [mobileMaskAustralia],
                                controller: ctrlMobile,
                                validator: (String value) {
                                  print(value);
                                  print(value.length);
                                  if (value.isEmpty) {
                                    return 'Mobile number must be provided';
                                  } else if (!(value.startsWith('0'))) {
                                    return 'Number should starts with 0';
                                  } else if (value.length != 12) {
                                    return 'Invalid Number';
                                  }
                                },
                                textAlign: TextAlign.center,
                                keyboardType: TextInputType.phone,
                                onChanged: (value) {
                                  _mobile =
                                      (mobileMaskAustralia).getUnmaskedText();
                                  _maskednumber =
                                      (mobileMaskAustralia).getMaskedText();
                                  print(_mobile);
                                  print(_maskednumber);
                                },
                                style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 2 * SizeConfig.heightMultiplier),
                                decoration: kTextFieldDecorationNoback.copyWith(
                                  hintText: 'Mobile',
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical:
                                          1.5 * SizeConfig.heightMultiplier,
                                      horizontal:
                                          5.10 * SizeConfig.widthMultiplier),
                                )),
                            width: 68.2 * SizeConfig.widthMultiplier,
//                            height: 5.65 * SizeConfig.heightMultiplier,
                          ),
                          SizedBox(
                            height: 30.0,
                          ),
                          Container(
                            width: 68.2 * SizeConfig.widthMultiplier,
                            height: 5.65 * SizeConfig.heightMultiplier,
                            child: RaisedButton(
                              onPressed: () async {
                                if (_supervisorFormKeyARTC.currentState
                                    .validate()) {
                                  setState(() {
                                    _localWaiting = true;
                                  });
                                  FocusManager.instance.primaryFocus.unfocus();
                                  print(
                                      'https://eventricity.online/app/REST/EasyRails/App_AddNewSupervisor?First_Name=$_firstName&Surname=$_surname&EmailAddress=$_emailAddress&Temp_pdw=$_password&Mobile=$_mobile&Mobile_validated=$_maskednumber&RailOperatorID=$_operator');
                                  http.Response _response = await http.get(
                                      'https://eventricity.online/app/REST/EasyRails/App_AddNewSupervisor?First_Name=$_firstName&Surname=$_surname&EmailAddress=$_emailAddress&Temp_pdw=$_password&Mobile=$_mobile&Mobile_validated=$_maskednumber&RailOperatorID=$_operator');
                                  print(_response.body);
                                  var _responseBody = _response.body;
                                  error = jsonDecode(_responseBody)['Error'];
                                  print(error);
                                  if (error != 'No Error') {
                                    ShowFlushbar(
                                        'Error', error, Icons.close, context);
                                  } else if (error == 'No Error') {
                                    // await Flushbar(
                                    //   titleText: Text(
                                    //     'Success',
                                    //     style: TextStyle(
                                    //       fontFamily: 'Poppins',
                                    //       fontSize: 2.0 * SizeConfig.heightMultiplier,
                                    //       color: const Color(0xffffffff),
                                    //       fontWeight: FontWeight.w600,
                                    //     ),
                                    //     textAlign: TextAlign.left,
                                    //   ),
                                    //   messageText: Text(
                                    //     'You have successfully add a supervisor',
                                    //     style: TextStyle(
                                    //       fontFamily: 'Poppins',
                                    //       fontSize: 1.3 * SizeConfig.heightMultiplier,
                                    //       color: const Color(0xffffffff),
                                    //       fontWeight: FontWeight.w300,
                                    //     ),
                                    //     textAlign: TextAlign.left,
                                    //   ),
                                    //   padding: EdgeInsets.symmetric(
                                    //       vertical: 12.0, horizontal: 5.1 * SizeConfig.widthMultiplier),
                                    //   icon: Icon(
                                    //     Icons.check,
                                    //     size: 3.94 * SizeConfig.heightMultiplier,
                                    //     color: Colors.white,
                                    //   ),
                                    //   duration: Duration(seconds: 3),
                                    //   flushbarPosition: FlushbarPosition.TOP,
                                    //   borderColor: Colors.transparent,
                                    //   shouldIconPulse: false,
                                    //   maxWidth: 91.8 * SizeConfig.widthMultiplier,
                                    //   boxShadows: [
                                    //     BoxShadow(
                                    //       color: Colors.black.withOpacity(0.3),
                                    //       spreadRadius: 1 * SizeConfig.heightMultiplier,
                                    //       blurRadius: 2 * SizeConfig.heightMultiplier,
                                    //       offset: Offset(0, 10), // changes position of shadow
                                    //     ),
                                    //   ],
                                    //   backgroundColor: kShadeColor1,
                                    // ).show(context);

                                    await GetSupervisor(kSupervisorListUrl +
                                        'ARTC Weld Returns');
                                    setState(() {
                                      _supervisor =
                                          jsonDecode(_responseBody)['FullName'];
                                      _localWaiting = false;
                                      ctrlMobile.text = '';
                                    });
                                    Navigator.pop(context);
                                  }
                                }
                              },
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      2.63 * SizeConfig.heightMultiplier)),
                              padding: EdgeInsets.all(0.0),
                              child: Ink(
                                decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment(-1.0, 0.0),
                                      end: Alignment(1.25, 0.0),
                                      colors: [
                                        const Color(0xff3ba838),
                                        const Color(0xff319945),
                                        const Color(0xff1a7861)
                                      ],
                                      stops: [0.0, 0.306, 1.0],
                                    ),
                                    borderRadius: BorderRadius.circular(
                                        3.94 * SizeConfig.heightMultiplier)),
                                child: Padding(
                                  padding:
                                      EdgeInsets.only(left: 0.0, right: 0.0),
                                  child: Container(
                                    constraints: BoxConstraints(
                                        maxWidth:
                                            67.85 * SizeConfig.widthMultiplier,
                                        minHeight:
                                            6.57 * SizeConfig.heightMultiplier),
                                    alignment: Alignment.center,
                                    child: Text(
                                      'Add',
                                      style: TextStyle(
                                        fontFamily: 'Manrope',
                                        fontSize:
                                            2.0 * SizeConfig.heightMultiplier,
                                        color: const Color(0xffffffff),
                                        fontWeight: FontWeight.w600,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Future<DateTime> pickWeekendDate() async {
    DateTime pickedDateTime = await showDatePicker(
        context: context,
        initialDate: _weekend,
        firstDate: DateTime(DateTime.now().year - 2),
        lastDate: DateTime.now());
    if (pickedDateTime != null) {
      setState(() {
        _weekend = pickedDateTime;
      });
    }
    return pickedDateTime;
  }

  Future<DateTime> pickWeldSignature() async {
    DateTime pickedDateTime = await showDatePicker(
        context: context,
        initialDate: _welderSignatureDate,
        firstDate: DateTime(DateTime.now().year - 2),
        lastDate: DateTime.now());
    if (pickedDateTime != null) {
      setState(() {
        _welderSignatureDate = pickedDateTime;
      });
    }
    return pickedDateTime;
  }

  Future<DateTime> pickSuperVisorSignature() async {
    DateTime pickedDateTime = await showDatePicker(
        context: context,
        initialDate: _supervisorSignatureDate,
        firstDate: DateTime(DateTime.now().year - 2),
        lastDate: DateTime.now());
    if (pickedDateTime != null) {
      setState(() {
        _supervisorSignatureDate = pickedDateTime;
      });
    }
    return pickedDateTime;
  }
}

class ARTCCheckboxWidget extends StatefulWidget {
  @override
  ARTCCheckboxWidgetState createState() => new ARTCCheckboxWidgetState();
}

class ARTCCheckboxWidgetState extends State {
  var tmpArray = [];

  getCheckboxItems() {
    ARTCWeldReturnMapForForm.forEach((key, value) {
      if (value == true) {
        tmpArray.add(key);
      }
    });

    // Printing all selected items on Terminal screen.
    print(tmpArray);
    // Here you will get all your selected Checkbox items.

    // Clear array after use.
    tmpArray.clear();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: ARTCWeldReturnMapForForm.keys.map((String key) {
        return CheckboxListTile(
          title: Text(key),
          value: ARTCWeldReturnMapForForm[key],
          activeColor: kShadeColor1,
          checkColor: Colors.white,
          onChanged: (bool value) {
            setState(() {
              print(value);
              if (value == true && aWCounter < 10) {
                aWCounter++;
                ARTCWeldReturnMapForForm[key] = value;
              } else if (value == false && aWCounter > 0) {
                aWCounter--;
                ARTCWeldReturnMapForForm[key] = value;
              }
              print(aWCounter);
            });
          },
        );
      }).toList(),
    );
  }
}
