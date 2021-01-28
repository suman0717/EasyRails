import 'dart:convert';
import 'package:easy_rails/constants.dart';
import 'package:easy_rails/customdropdown.dart';
import 'package:easy_rails/size_config.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;
import 'package:modal_progress_hud/modal_progress_hud.dart';

int aWCounter = 0;
bool _waiting = false;
String error = 'No Error';
String temparr;
bool isReportGenerated = false;

var _qrWeldReturnFormKey = GlobalKey<FormState>();

class QRWeldReturnForm extends StatefulWidget {
  @override
  _QRWeldReturnFormState createState() => _QRWeldReturnFormState();
}

class _QRWeldReturnFormState extends State<QRWeldReturnForm> {
  String _division;
  String _gang;
  String _project;
  String _welder;

  var tmpArray = [];
  getCheckboxItems(){

    QRWeldReturnMap.forEach((key, value) {
      if(value == true)
      {
        tmpArray.add(key);
      }
    });

    // Printing all selected items on Terminal screen.
    print(tmpArray);
    temparr = tmpArray.toString();
    temparr = temparr.replaceAll('[', '');
    temparr = temparr.replaceAll(']', '');
    temparr = temparr.replaceAll(' ', '');
    temparr = temparr.padRight(1);
    print('String value');
    print(temparr);
    // Here you will get all your selected Checkbox items.

    // Clear array after use.
    tmpArray.clear();
  }

  @override
  void initState() {
    setState(() {
      _waiting = true;
    });
    isReportGenerated = false;
    QRWeldReturnMap = {};
    _welder = loggedinUserFName +' '+loggedinUserSName;

    GetGenericDataForQRWeldreturnForm().whenComplete(() {
      setState(() {
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
    QRWeldReturnMap = {};
    aWCounter = 0;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool _isWeldReurnvalid = true;

    void _validate(){
      if(_welder == null){
        _isWeldReurnvalid = false;
        ShowFlushbar('Error','Please Provide Welder',Icons.close,context);
      }
      else if(aWCounter<1){
        _isWeldReurnvalid = false;
        ShowFlushbar('Error','Please Choose Atleast One Weld Return',Icons.close,context);
      }
    }
    return Scaffold(resizeToAvoidBottomPadding: true,
      appBar: AppBar( centerTitle: true,
        title: Text('QR Weld Return Form',style: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 1.9 * SizeConfig.heightMultiplier,
          color: const Color(0xffffffff),
          fontWeight: FontWeight.w500,
        ),),
        flexibleSpace: Container( decoration: BoxDecoration( gradient: LinearGradient(
          begin: Alignment(-1.21, -1.17),
          end: Alignment(1.25, 0.26),
          colors: [
            const Color(0xff5eb533),
            const Color(0xff097445),
            const Color(0xff157079),
            const Color(0xff02414d)
          ],
          stops: [0.0, 0.391, 0.712, 1.0],
        ), ), ),
      ),

      body: ModalProgressHUD(
        inAsyncCall: _waiting,
        color: Color(0xff3ba838),
        opacity: 0.1,
        child: GestureDetector(onTap: (){
          FocusScope.of(context).unfocus();
        },
          child: Column(
            children: [
              Visibility(visible: !isReportGenerated,
                child: Expanded(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(
                        6.35 * SizeConfig.widthMultiplier,
                        2.63 * SizeConfig.heightMultiplier,
                        6.35 * SizeConfig.widthMultiplier,
                        0),
                    child: Form(
                      key: _qrWeldReturnFormKey,
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            //Division
                            Padding(
                              padding: EdgeInsets.only(bottom: 8.0, top: 20),
                              child: Text(
                                'Division',
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
                                  validator: (String value) {
                                    if (value.isEmpty) {
                                      return 'Please Provide Division';
                                    }
                                  },
                                  maxLength: 20,
                                  textAlign: TextAlign.center,
                                  onChanged: (value) {
                                    _division = value;
                                  },
                                  style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize:
                                      1.84 * SizeConfig.heightMultiplier),
                                  decoration: kTextFieldDecorationNoback.copyWith(
                                    hintText: '',
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical:
                                        1.5 * SizeConfig.heightMultiplier,
                                        horizontal: 20.0),
                                  )),
                              width: 68.2 * SizeConfig.widthMultiplier,
                            ),

                            //Gang
                            Padding(
                              padding: EdgeInsets.only(bottom: 8.0, top: 20),
                              child: Text(
                                'Gang',
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
                                  validator: (String value) {
                                    if (value.isEmpty) {
                                      return 'Please Provide Gang';
                                    }
                                  },
                                  maxLength: 20,
                                  textAlign: TextAlign.center,
                                  onChanged: (value) {
                                    _gang = value;
                                  },
                                  style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize:
                                      1.84 * SizeConfig.heightMultiplier),
                                  decoration: kTextFieldDecorationNoback.copyWith(
                                    hintText: '',
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical:
                                        1.5 * SizeConfig.heightMultiplier,
                                        horizontal: 20.0),
                                  )),
                              width: 68.2 * SizeConfig.widthMultiplier,
                            ),

                            //Project
                            Padding(
                              padding: EdgeInsets.only(bottom: 8.0, top: 20),
                              child: Text(
                                'Project',
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
                                  maxLength: 20,
                                  textAlign: TextAlign.center,
                                  onChanged: (value) {
                                    _project = value;
                                  },
                                  style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize:
                                      1.84 * SizeConfig.heightMultiplier),
                                  decoration: kTextFieldDecorationNoback.copyWith(
                                    hintText: '',
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical:
                                        1.5 * SizeConfig.heightMultiplier,
                                        horizontal: 20.0),
                                  )),
                              width: 68.2 * SizeConfig.widthMultiplier,
                            ),

                            //Welder
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
                            DropDownField(onValueChanged: (dynamic s) async {
                              print('akjsdsa');
                              print(s);
                              setState(() {
                                _waiting=true;
                              });
                              tmpArray.clear();
                              await GetGenericDataQRWeldReturn(kQRWeldListUrl +s);
                              setState(()  {
                                _welder = s;
                                _waiting=false;
                              },
                              );
                            },textStyle: TextStyle(height: 0.9,
                                fontFamily: 'Poppins', fontSize: 1.84 * SizeConfig.heightMultiplier),
                                value: _welder,
                                required: false,
                                hintText: 'Choose a welder',
                                hintStyle: TextStyle(height: 1.0,
                                    fontFamily: 'Poppins', fontSize: 1.84 * SizeConfig.heightMultiplier),
                                items: welderList,
                                strict: true,
                                setter: (dynamic newValue) {
                                  print('Setter');
                                  _welder = newValue;
                                }),

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
                              child: CheckboxWidget(),
                              height: 300.0,),
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
                                  if(_qrWeldReturnFormKey.currentState.validate()){
                                    getCheckboxItems();
                                  _validate();
                                  if(_isWeldReurnvalid){
                                    print('https://eventricity.online/app/REST/EasyRails/App_Create_QRWeldReturnForm?WelderID=$_welder&pm_AWRID=$temparr');
                                    http.Response _response = await http.get('https://eventricity.online/app/REST/EasyRails/App_Create_QRWeldReturnForm?WelderID=$_welder&pm_AWRID=$temparr');
                                    var _responseBody = _response.body;
                                    kLatestReportURL = jsonDecode(_responseBody)['ReportPathURL'];
                                    print(kLatestReportURL);
                                    setState(() {
                                      isReportGenerated = true;
                                    });
                                    await Flushbar(
                                      titleText: Text(
                                        'Success',
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 2.0 * SizeConfig.heightMultiplier,
                                          color: const Color(0xffffffff),
                                          fontWeight: FontWeight.w600,
                                        ),
                                        textAlign: TextAlign.left,
                                      ),
                                      messageText: Text(
                                        'You have successfully generated weld report',
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 1.3 * SizeConfig.heightMultiplier,
                                          color: const Color(0xffffffff),
                                          fontWeight: FontWeight.w300,
                                        ),
                                        textAlign: TextAlign.left,
                                      ),
                                      padding: EdgeInsets.symmetric(
                                          vertical: 12.0, horizontal: 5.1 * SizeConfig.widthMultiplier),
                                      icon: Icon(
                                        Icons.check,
                                        size: 3.94 * SizeConfig.heightMultiplier,
                                        color: Colors.white,
                                      ),
                                      duration: Duration(seconds: 3),
                                      flushbarPosition: FlushbarPosition.TOP,
                                      borderColor: Colors.transparent,
                                      shouldIconPulse: false,
                                      maxWidth: 91.8 * SizeConfig.widthMultiplier,
                                      boxShadows: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.3),
                                          spreadRadius: 1 * SizeConfig.heightMultiplier,
                                          blurRadius: 2 * SizeConfig.heightMultiplier,
                                          offset: Offset(0, 10), // changes position of shadow
                                        ),
                                      ],
                                      backgroundColor: kShadeColor1,
                                    ).show(context);

                                    launchInBrowser(kLatestReportURL);
                                  }

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
                                  padding: EdgeInsets.only(left: 0.0, right: 0.0),
                                  child: Text(
                                    'Submit Weld Return Form',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 2.0 * SizeConfig.heightMultiplier,
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
              Visibility(visible: isReportGenerated,child: Expanded(child: Center(child: Text(
                'Report Generated...',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 2.36 * SizeConfig.heightMultiplier,
                  color: const Color(0xff363636),
                  fontWeight: FontWeight.w500,
                  height: 0.2 * SizeConfig.heightMultiplier,
                ),
                textAlign: TextAlign.left,
              ),)))

            ],
          ),
        ),
      ),
    );
  }
}

class CheckboxWidget extends StatefulWidget {
  @override
  CheckboxWidgetState createState() => new CheckboxWidgetState();
}

class CheckboxWidgetState extends State {
  var tmpArray = [];

  getCheckboxItems(){

    QRWeldReturnMap.forEach((key, value) {
      if(value == true)
      {
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
      children: QRWeldReturnMap.keys.map((String key) {

        return CheckboxListTile(
          title: Text(key),
          value: QRWeldReturnMap[key],
          activeColor: kShadeColor1,
          checkColor: Colors.white,
          onChanged: (bool value) {
            setState(() {
              print(value);
              if(value == true && aWCounter < 7){
                aWCounter++;
                QRWeldReturnMap[key] = value;
              }
              else if(value == false && aWCounter > 0){
                aWCounter--;
                QRWeldReturnMap[key] = value;
              }
              print(aWCounter);
            });
          },
        );
      }).toList(),
    );
  }
}
