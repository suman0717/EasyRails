import 'dart:convert';
import 'package:easy_rails/constants.dart';
import 'package:easy_rails/customdropdown.dart';
import 'package:easy_rails/screens/XDMenu.dart';
import 'package:easy_rails/size_config.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'dart:io' show File, Platform;
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

String device;
SharedPreferences sharedPreferences;
List<String> unSyncArtcWeldReturn = [];

DateTime _weldLocationDate;
String _weldLocationCode;
String _weldLocationTrack;
String _aRTCLocalBatch;
String _kilometer;
String _rail;
String _railSize;
String _weldReasonCode;
String _weldType;
String _siteConditionWeather;
String _siteConditonWeld;
String _siteConditonTrack;
bool _railTempNA = false;
bool _railTempEnter = true;
String _railTempFinal;
bool _punchmarkBeforeNA = false;
bool _punchmarkBeforeEnter = true;
String _punchmarkBeforeFinal;
bool _punchmarkAftereNA = false;
bool _punchmarkAfterEnter = true;
String _punchmarkAfterFinal;
String _kmFrom;
String _kmTo;
bool _railTempNA1 = false;
bool _railTempEnter1 = true;
String _railTempFinal1;
DateTime _railFlawDate;
bool _ok = true;
String _okFinal = 'Yes';
bool _punchMarckCheck = true;
String _punchMarckCheckFinal = 'Yes';
bool _RailFlawCompleted = true;
String _RailFlawCompletedFinal = 'Yes';

String selectedCity;

bool _waiting = false;
String error = 'No Error';

// var ctrlweldLocationCode = TextEditingController();
// var ctrlweldLocationTrack = TextEditingController();
var ctrlPunchMarkBeforeFinal = TextEditingController();
var ctrlPunchMarkAfterFinal = TextEditingController();
var ctrlrailTempFinal = TextEditingController();
var ctrlrailTempFinal1 = TextEditingController();
var ctrlBatchnumber = TextEditingController();

var _formKeyartcWeldReturn = GlobalKey<FormState>();

class NewARTCWeldReturn extends StatefulWidget {
  @override
  _NewARTCWeldReturnState createState() => _NewARTCWeldReturnState();
}

class _NewARTCWeldReturnState extends State<NewARTCWeldReturn> {
  @override
  void initState() {
    setState(() {
      _waiting = true;
    });
    _weldLocationDate = DateTime.now();
    _railFlawDate = DateTime.now();
    ctrlBatchnumber.text = _aRTCLocalBatch = aRTCLatestBatch;
    ctrlPunchMarkBeforeFinal.text = '';
    ctrlPunchMarkBeforeFinal.text = '';
    ctrlrailTempFinal.text = '';
    ctrlrailTempFinal1.text = '';
    device = Platform.isIOS == true ? 'IOS' : 'Android';
    GetGenericDataForARTCWeldreturn().whenComplete(() {
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
  Widget build(BuildContext context) {
    bool _isWeldReurnvalid = true;
    void _validate() {
      if (_rail == null) {
        _isWeldReurnvalid = false;
        ShowFlushbar('Error', 'Please Provide Rail', Icons.close, context);
      } else if (_railTempEnter == true && _railTempFinal == null) {
        _isWeldReurnvalid = false;
        ShowFlushbar(
            'Error', 'Please Provide Rail Temperature', Icons.close, context);
      } else if (_railSize == null) {
        _isWeldReurnvalid = false;
        ShowFlushbar('Error', 'Please Provide Rail Size', Icons.close, context);
      }
    }

    return Scaffold(
      appBar: buildAppBar('NEW ARTC WELD RETURN'),
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
              Expanded(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(
                      6.35 * SizeConfig.widthMultiplier,
                      2.63 * SizeConfig.heightMultiplier,
                      6.35 * SizeConfig.widthMultiplier,
                      0),
                  child: Form(
                    key: _formKeyartcWeldReturn,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          //Weld Location
                          Text(
                            'Weld Location',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 2.36 * SizeConfig.heightMultiplier,
                              color: const Color(0xff363636),
                              fontWeight: FontWeight.w500,
                              height: 0.2 * SizeConfig.heightMultiplier,
                            ),
                            textAlign: TextAlign.left,
                          ),
                          SizedBox(
                            height: 1.3 * SizeConfig.heightMultiplier,
                          ),

                          //Weld Date
                          Padding(
                            padding: EdgeInsets.only(
                                bottom: 1.05 * SizeConfig.heightMultiplier),
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
                                    pickWeldLocationDate();
                                  }),
                              title: Center(
                                  child: Text(
                                      '${_weldLocationDate.day}-${_weldLocationDate.month}-${_weldLocationDate.year}')),
                            ),
                          ),

                          //Code
                          Padding(
                            padding: EdgeInsets.only(bottom: 8.0, top: 20),
                            child: Text(
                              'Code',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 1.7 * SizeConfig.heightMultiplier,
                                color: const Color(0xffa1a1a1),
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          Container(
                            child: TextFormField(maxLength: 10,
                                keyboardType: TextInputType.emailAddress,
                                textAlign: TextAlign.center,
                                onChanged: (value) {
                                    _weldLocationCode = value;
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

                          //Track
                          Padding(
                            padding: EdgeInsets.only(bottom: 8.0, top: 20),
                            child: Text(
                              'Track',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 1.7 * SizeConfig.heightMultiplier,
                                color: const Color(0xffa1a1a1),
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          Container(
                            child: TextFormField(maxLength: 10,
                                keyboardType: TextInputType.emailAddress,
                                validator: (String value) {
                                  if (value.isEmpty) {
                                    return 'Please Provide Track';
                                  }
                                },
                                textAlign: TextAlign.center,
                                onChanged: (value) {
                                    _weldLocationTrack = value;
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

                          //Kilometer
                          Padding(
                            padding: EdgeInsets.only(bottom: 8.0, top: 20),
                            child: Text(
                              'Kilometer',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 1.7 * SizeConfig.heightMultiplier,
                                color: const Color(0xffa1a1a1),
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          Container(
                            child: TextFormField(maxLength: 8,
                                keyboardType: TextInputType.number,
                                textAlign: TextAlign.center,
                                onChanged: (value) {
                                  _kilometer = value;
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

                          //Weld Details
                          Padding(
                            padding: EdgeInsets.only(bottom: 8.0, top: 20),
                            child: Text(
                              'Weld Detail',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 2.36 * SizeConfig.heightMultiplier,
                                color: const Color(0xff363636),
                                fontWeight: FontWeight.w500,
                                height: 0.2 * SizeConfig.heightMultiplier,
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),

                          //Rail
                          Padding(
                            padding: EdgeInsets.only(bottom: 8.0, top: 20),
                            child: Text(
                              'Rail (U / D)',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 1.7 * SizeConfig.heightMultiplier,
                                color: const Color(0xffa1a1a1),
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          Container(
                            child: TextFormField(maxLength: 1,textCapitalization: TextCapitalization.sentences,
                                validator: (String value) {
                                  if (value.isEmpty) {
                                    return 'Please Provide Rail';
                                  } else if ((value != 'U' &&
                                          value != 'D' &&
                                          value != 'u' &&
                                          value != 'd') &&
                                      value.isNotEmpty) {
                                    return 'Value must be either \'U\' or \'D\'';
                                  }
                                },

                                textAlign: TextAlign.center,
                                onChanged: (value) {
                                  _rail = value;
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

                          //Rail Size
                          Padding(
                            padding: EdgeInsets.only(bottom: 8.0, top: 20),
                            child: Text(
                              'Rail Size',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 1.7 * SizeConfig.heightMultiplier,
                                color: const Color(0xffa1a1a1),
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          DropDownField(
                            onValueChanged: (dynamic value) async {
                              _railSize = value;
                            },
                            keyboardType: TextInputType.number,
                            textStyle: TextStyle(
                                height: 0.9,
                                fontFamily: 'Poppins',
                                fontSize: 1.84 * SizeConfig.heightMultiplier),
                            value: _railSize,
                            required: false,
                            hintText: 'Choose Rail Size',
                            hintStyle: TextStyle(
                                height: 1.0,
                                fontFamily: 'Poppins',
                                fontSize: 1.84 * SizeConfig.heightMultiplier),
                            items: ['41', '47', '50', '53', '60', '68'].map(
                              (String dropdownitem) {
                                return dropdownitem;
                              },
                            ).toList(),
                            strict: true,
                            setter: (dynamic newValue) {
                              print('Setter');
                              _railSize = newValue;
                            },
                          ),

                          //Weld Reason
                          Padding(
                            padding: EdgeInsets.only(bottom: 8.0, top: 20),
                            child: Text(
                              'Weld Reasons',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 1.7 * SizeConfig.heightMultiplier,
                                color: const Color(0xffa1a1a1),
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          DropDownField(
                            onValueChanged: (dynamic value) async {
                              _weldReasonCode = value;
                            },
                            textStyle: TextStyle(
                                height: 0.9,
                                fontFamily: 'Poppins',
                                fontSize: 1.84 * SizeConfig.heightMultiplier),
                            value: _weldReasonCode,
                            required: false,
                            hintText: 'Choose Weld Reason',
                            hintStyle: TextStyle(
                                height: 1.0,
                                fontFamily: 'Poppins',
                                fontSize: 1.84 * SizeConfig.heightMultiplier),
                            items: artcWeldReasonList,
                            strict: true,
                            setter: (dynamic newValue) {
                              print('Setter');
                              _weldReasonCode = newValue;
                            },
                          ),

                          // Batch Number
                          Padding(
                            padding: EdgeInsets.only(bottom: 8.0, top: 20),
                            child: Text(
                              'Batch No.',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 1.7 * SizeConfig.heightMultiplier,
                                color: const Color(0xffa1a1a1),
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          Container(
                            child: TextFormField(maxLength: 6,
                                controller: ctrlBatchnumber,
                                keyboardType: TextInputType.emailAddress,
                                validator: (String value) {
                                  if (value.isEmpty) {
                                    return 'Please Provide Batch No';
                                  }
                                },
                                textAlign: TextAlign.center,
                                onChanged: (value) {
                                  _aRTCLocalBatch = value;
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

                          //Weld Type
                          Padding(
                            padding: EdgeInsets.only(bottom: 8.0, top: 20),
                            child: Text(
                              'Weld Type',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 1.7 * SizeConfig.heightMultiplier,
                                color: const Color(0xffa1a1a1),
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          DropDownField(
                            onValueChanged: (dynamic value) async {
                              _weldType = value;
                            },
                            textStyle: TextStyle(
                                height: 0.9,
                                fontFamily: 'Poppins',
                                fontSize: 1.84 * SizeConfig.heightMultiplier),
                            value: _weldType,
                            required: false,
                            hintText: 'Choose Weld Type',
                            hintStyle: TextStyle(
                                height: 1.0,
                                fontFamily: 'Poppins',
                                fontSize: 1.84 * SizeConfig.heightMultiplier),
                            items: artcWeldTypeList,
                            strict: true,
                            setter: (dynamic newValue) {
                              print('Setter');
                              _weldType = newValue;
                            },
                          ),

                          //Site Condition Weather
                          Padding(
                            padding: EdgeInsets.only(bottom: 8.0, top: 20),
                            child: Text(
                              'Site Condition Weather',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 1.7 * SizeConfig.heightMultiplier,
                                color: const Color(0xffa1a1a1),
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          DropDownField(
                            onValueChanged: (dynamic value) async {
                              _siteConditionWeather = value;
                            },
                            textStyle: TextStyle(
                                height: 0.9,
                                fontFamily: 'Poppins',
                                fontSize: 1.84 * SizeConfig.heightMultiplier),
                            value: _siteConditionWeather,
                            required: false,
                            hintText: 'Choose Weather',
                            hintStyle: TextStyle(
                                height: 1.0,
                                fontFamily: 'Poppins',
                                fontSize: 1.84 * SizeConfig.heightMultiplier),
                            items: siteWeatherList,
                            strict: true,
                            setter: (dynamic newValue) {
                              print('Setter');
                              _siteConditionWeather = newValue;
                            },
                          ),

                          //Site Condition Weld
                          Padding(
                            padding: EdgeInsets.only(bottom: 8.0, top: 20),
                            child: Text(
                              'Site Condition Weld',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 1.7 * SizeConfig.heightMultiplier,
                                color: const Color(0xffa1a1a1),
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          DropDownField(
                            onValueChanged: (dynamic value) async {
                              _siteConditonWeld = value;
                            },
                            textStyle: TextStyle(
                                height: 0.9,
                                fontFamily: 'Poppins',
                                fontSize: 1.84 * SizeConfig.heightMultiplier),
                            value: _siteConditonWeld,
                            required: false,
                            hintText: 'Choose Weld',
                            hintStyle: TextStyle(
                                height: 1.0,
                                fontFamily: 'Poppins',
                                fontSize: 1.84 * SizeConfig.heightMultiplier),
                            items: siteWeldList,
                            strict: true,
                            setter: (dynamic newValue) {
                              print('Setter');
                              _siteConditonWeld = newValue;
                            },
                          ),

                          //Site Condition Track
                          Padding(
                            padding: EdgeInsets.only(bottom: 8.0, top: 20),
                            child: Text(
                              'Site Condition Track',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 1.7 * SizeConfig.heightMultiplier,
                                color: const Color(0xffa1a1a1),
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          DropDownField(
                            onValueChanged: (dynamic value) async {
                              _siteConditonTrack = value;
                            },
                            textStyle: TextStyle(
                                height: 0.9,
                                fontFamily: 'Poppins',
                                fontSize: 1.84 * SizeConfig.heightMultiplier),
                            value: _siteConditonTrack,
                            required: false,
                            hintText: 'Choose Track',
                            hintStyle: TextStyle(
                                height: 1.0,
                                fontFamily: 'Poppins',
                                fontSize: 1.84 * SizeConfig.heightMultiplier),
                            items: siteTrackList,
                            strict: true,
                            setter: (dynamic newValue) {
                              print('Setter');
                              _siteConditonTrack = newValue;
                            },
                          ),

                          //Punch Marks Before
                          Padding(
                            padding: EdgeInsets.only(
                                bottom: 1.05 * SizeConfig.heightMultiplier,
                                top: 2.63 * SizeConfig.heightMultiplier),
                            child: Text(
                              'Punch Marks - Before',
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
                                        value: _punchmarkBeforeEnter,
                                        activeColor: kShadeColor1,
                                        onChanged: (bool newvalue) {
                                          setState(() {
                                            print(newvalue);
                                            ctrlPunchMarkBeforeFinal.text = '';
                                            _punchmarkBeforeEnter = newvalue;
                                            _punchmarkBeforeNA = !newvalue;
                                          });
                                        }),
                                    Text('Enter Punch Mark'),
                                    Checkbox(
                                        value: _punchmarkBeforeNA,
                                        activeColor: kShadeColor1,
                                        onChanged: (bool newvalue) {
                                          setState(() {
                                            print(newvalue);
                                            ctrlPunchMarkBeforeFinal.text =
                                                'N/A';
                                            _punchmarkBeforeNA = newvalue;
                                            _punchmarkBeforeEnter = !newvalue;
                                          });
                                        }),
                                    Text('N/A'),
                                  ],
                                ),
                                Visibility(
                                  visible: _punchmarkBeforeEnter,
                                  child: Container(
                                    child: TextFormField(
                                        validator: (String value) {
                                          if (((value.isEmpty ||
                                                  value.contains('N/A')) &&
                                              _punchmarkBeforeEnter == true)) {
                                            return 'Provide Punch Marks';
                                          }
                                        },
                                        maxLength: 5,
                                        keyboardType: TextInputType.number,
                                        controller: ctrlPunchMarkBeforeFinal,
                                        textAlign: TextAlign.center,
                                        onChanged: (value) {
                                          _punchmarkBeforeFinal = value;
                                        },
                                        style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize: 1.84 *
                                                SizeConfig.heightMultiplier),
                                        decoration:
                                            kTextFieldDecorationNoback.copyWith(
                                          hintText: '',
                                          contentPadding: EdgeInsets.symmetric(
                                              vertical: 1.5 *
                                                  SizeConfig.heightMultiplier,
                                              horizontal: 20.0),
                                        )),
                                  ),
                                ),
                              ],
                            ),
                            width: 68.2 * SizeConfig.widthMultiplier,
                          ),

                          //Punch Marks After
                          Padding(
                            padding: EdgeInsets.only(
                                bottom: 1.05 * SizeConfig.heightMultiplier,
                                top: 2.63 * SizeConfig.heightMultiplier),
                            child: Text(
                              'Punch Marks - After',
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
                                        value: _punchmarkAfterEnter,
                                        activeColor: kShadeColor1,
                                        onChanged: (bool newvalue) {
                                          setState(() {
                                            print(newvalue);
                                            ctrlPunchMarkAfterFinal.text = '';
                                            _punchmarkAfterEnter = newvalue;
                                            _punchmarkAftereNA = !newvalue;
                                          });
                                        }),
                                    Text('Enter Punch Mark'),
                                    Checkbox(
                                        value: _punchmarkAftereNA,
                                        activeColor: kShadeColor1,
                                        onChanged: (bool newvalue) {
                                          setState(() {
                                            print(newvalue);
                                            ctrlPunchMarkAfterFinal.text =
                                                'N/A';
                                            _punchmarkAftereNA = newvalue;
                                            _punchmarkAfterEnter = !newvalue;
                                          });
                                        }),
                                    Text('N/A'),
                                  ],
                                ),
                                Visibility(
                                  visible: _punchmarkAfterEnter,
                                  child: Container(
                                    child: TextFormField(
                                        validator: (String value) {
                                          if (((value.isEmpty ||
                                                  value.contains('N/A')) &&
                                              _punchmarkAfterEnter == true)) {
                                            return 'Provide Punch Marks';
                                          }
                                        },
                                        maxLength: 5,
                                        keyboardType: TextInputType.number,
                                        controller: ctrlPunchMarkAfterFinal,
                                        textAlign: TextAlign.center,
                                        onChanged: (value) {
                                          _punchmarkAfterFinal = value;
                                        },
                                        style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize: 1.84 *
                                                SizeConfig.heightMultiplier),
                                        decoration:
                                            kTextFieldDecorationNoback.copyWith(
                                          hintText: '',
                                          contentPadding: EdgeInsets.symmetric(
                                              vertical: 1.5 *
                                                  SizeConfig.heightMultiplier,
                                              horizontal: 20.0),
                                        )),
                                  ),
                                ),
                              ],
                            ),
                            width: 68.2 * SizeConfig.widthMultiplier,
                          ),

                          //Rail Temp
                          Padding(
                            padding: EdgeInsets.only(bottom: 8.0, top: 20),
                            child: Text(
                              'Rail Temp',
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
                                        value: _railTempEnter,
                                        activeColor: kShadeColor1,
                                        onChanged: (bool newvalue) {
                                          setState(() {
                                            print(newvalue);
                                            ctrlrailTempFinal.text = '';
                                            _railTempFinal = '';
                                            _railTempEnter = newvalue;
                                            _railTempNA = !newvalue;
                                          });
                                        }),
                                    Text('Temp'),
                                    Checkbox(
                                        value: _railTempNA,
                                        activeColor: kShadeColor1,
                                        onChanged: (bool newvalue) {
                                          setState(() {
                                            print(newvalue);
                                            ctrlrailTempFinal.text = 'N/A';
                                            _railTempFinal = 'N/A';
                                            _railTempNA = newvalue;
                                            _railTempEnter = !newvalue;
                                          });
                                        }),
                                    Text('N/A'),
                                  ],
                                ),
                                Visibility(
                                  visible: _railTempEnter,
                                  child: Container(
                                    child: DropDownField(
                                      onValueChanged: (dynamic s) async {
                                        _railTempFinal = s;
                                      },
                                      keyboardType: TextInputType.number,
                                      textStyle: TextStyle(
                                          height: 0.9,
                                          fontFamily: 'Poppins',
                                          fontSize: 1.84 *
                                              SizeConfig.heightMultiplier),
                                      value: _railTempFinal,
                                      required: false,
                                      hintText: 'Provide Temperature',
                                      hintStyle: TextStyle(
                                          height: 1.0,
                                          fontFamily: 'Poppins',
                                          fontSize: 1.84 *
                                              SizeConfig.heightMultiplier),
                                      items: [
                                        '10',
                                        '11',
                                        '12',
                                        '13',
                                        '14',
                                        '15',
                                        '16',
                                        '17',
                                        '18',
                                        '19',
                                        '20',
                                        '21',
                                        '22',
                                        '23',
                                        '24',
                                        '25',
                                        '26',
                                        '27',
                                        '28',
                                        '29',
                                        '30',
                                        '31',
                                        '32',
                                        '33',
                                        '34',
                                        '35',
                                        '36',
                                        '37',
                                        '38',
                                        '39',
                                        '40',
                                        '41',
                                        '42',
                                        '43',
                                        '44',
                                        '45',
                                        '46',
                                        '47',
                                        '48',
                                        '49',
                                        '50'
                                      ].map(
                                        (String dropdownitem) {
                                          return dropdownitem;
                                        },
                                      ).toList(),
                                      strict: false,
                                      setter: (dynamic newValue) {
                                        print('Setter');
                                        _railTempFinal = newValue;
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            width: 68.2 * SizeConfig.widthMultiplier,
                          ),

                          //Adjustment Details
                          Padding(
                            padding: EdgeInsets.only(bottom: 8.0, top: 20),
                            child: Text(
                              'Adjustment Details',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 2.36 * SizeConfig.heightMultiplier,
                                color: const Color(0xff363636),
                                fontWeight: FontWeight.w500,
                                height: 0.2 * SizeConfig.heightMultiplier,
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),

                          //KM From
                          Padding(
                            padding: EdgeInsets.only(bottom: 8.0, top: 20),
                            child: Text(
                              'KM From',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 1.7 * SizeConfig.heightMultiplier,
                                color: const Color(0xffa1a1a1),
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          Container(
                            child: TextFormField(maxLength: 8,
                                keyboardType: TextInputType.number,
                                textAlign: TextAlign.center,
                                onChanged: (value) {
                                  _kmFrom = value;
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

                          //KM To
                          Padding(
                            padding: EdgeInsets.only(bottom: 8.0, top: 20),
                            child: Text(
                              'KM To',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 1.7 * SizeConfig.heightMultiplier,
                                color: const Color(0xffa1a1a1),
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          Container(
                            child: TextFormField(maxLength: 8,
                                keyboardType: TextInputType.number,
                                textAlign: TextAlign.center,
                                onChanged: (value) {
                                  _kmTo = value;
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

                          //Rail Temp1
                          Padding(
                            padding: EdgeInsets.only(bottom: 8.0, top: 20),
                            child: Text(
                              'Rail Temp',
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
                                        value: _railTempEnter1,
                                        activeColor: kShadeColor1,
                                        onChanged: (bool newvalue) {
                                          setState(() {
                                            print(newvalue);
                                            ctrlrailTempFinal1.text = '';
                                            _railTempFinal1 = '';
                                            _railTempEnter1 = newvalue;
                                            _railTempNA1 = !newvalue;
                                          });
                                        }),
                                    Text('Temp'),
                                    Checkbox(
                                        value: _railTempNA1,
                                        activeColor: kShadeColor1,
                                        onChanged: (bool newvalue) {
                                          setState(() {
                                            print(newvalue);
                                            ctrlrailTempFinal1.text = 'N/A';
                                            _railTempFinal1 = 'N/A';
                                            _railTempNA1 = newvalue;
                                            _railTempEnter1 = !newvalue;
                                          });
                                        }),
                                    Text('N/A'),
                                  ],
                                ),
                                Visibility(
                                  visible: _railTempEnter1,
                                  child: Container(
                                    child: DropDownField(
                                      onValueChanged: (dynamic s) async {
                                        _railTempFinal1 = s;
                                      },
                                      keyboardType: TextInputType.number,
                                      textStyle: TextStyle(
                                          height: 0.9,
                                          fontFamily: 'Poppins',
                                          fontSize: 1.84 *
                                              SizeConfig.heightMultiplier),
                                      value: _railTempFinal1,
                                      required: false,
                                      hintText: 'Provide Temperature',
                                      hintStyle: TextStyle(
                                          height: 1.0,
                                          fontFamily: 'Poppins',
                                          fontSize: 1.84 *
                                              SizeConfig.heightMultiplier),
                                      items: [
                                        '10',
                                        '11',
                                        '12',
                                        '13',
                                        '14',
                                        '15',
                                        '16',
                                        '17',
                                        '18',
                                        '19',
                                        '20',
                                        '21',
                                        '22',
                                        '23',
                                        '24',
                                        '25',
                                        '26',
                                        '27',
                                        '28',
                                        '29',
                                        '30',
                                        '31',
                                        '32',
                                        '33',
                                        '34',
                                        '35',
                                        '36',
                                        '37',
                                        '38',
                                        '39',
                                        '40',
                                        '41',
                                        '42',
                                        '43',
                                        '44',
                                        '45',
                                        '46',
                                        '47',
                                        '48',
                                        '49',
                                        '50'
                                      ].map(
                                        (String dropdownitem) {
                                          return dropdownitem;
                                        },
                                      ).toList(),
                                      strict: false,
                                      setter: (dynamic newValue) {
                                        print('Setter');
                                        _railTempFinal1 = newValue;
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            width: 68.2 * SizeConfig.widthMultiplier,
                          ),

                          Padding(
                            padding: EdgeInsets.only(bottom: 8.0, top: 20),
                            child: Text(
                              'Ultrasonic',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 2.36 * SizeConfig.heightMultiplier,
                                color: const Color(0xff363636),
                                fontWeight: FontWeight.w500,
                                height: 0.2 * SizeConfig.heightMultiplier,
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),

                          //Rail Flaw Date
                          Padding(
                            padding: EdgeInsets.only(
                                bottom: 1.05 * SizeConfig.heightMultiplier),
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
                                    pickRailFlawDate();
                                  }),
                              title: Center(
                                  child: Text(
                                      '${_railFlawDate.day}-${_railFlawDate.month}-${_railFlawDate.year}')),
                            ),
                          ),

                          //OK
                          Padding(
                            padding: EdgeInsets.only(bottom: 8.0, top: 20),
                            child: Text(
                              'OK',
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
                                        value: _ok,
                                        activeColor: kShadeColor1,
                                        onChanged: (bool newvalue) {
                                          setState(() {
                                            if (newvalue == true) {
                                              _okFinal = 'Yes';
                                              print(_okFinal);
                                              _ok = newvalue;
                                            }
                                          });
                                        }),
                                    Text('Yes'),
                                    Checkbox(
                                        value: !_ok,
                                        activeColor: kShadeColor1,
                                        onChanged: (bool newvalue) {
                                          setState(() {
                                            if (newvalue == true) {
                                              _okFinal = 'No';
                                              print(_okFinal);
                                              _ok = !newvalue;
                                            }
                                          });
                                        }),
                                    Text('No'),
                                  ],
                                ),
                              ],
                            ),
                            width: 68.2 * SizeConfig.widthMultiplier,
                          ),

                          //Rail Flaw Completed
                          Padding(
                            padding: EdgeInsets.only(bottom: 8.0, top: 20),
                            child: Text(
                              'Rail Flaw Completed',
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
                                        value: _RailFlawCompleted,
                                        activeColor: kShadeColor1,
                                        onChanged: (bool newvalue) {
                                          setState(() {
                                            if (newvalue == true) {
                                              _RailFlawCompletedFinal = 'Yes';
                                              print(_RailFlawCompletedFinal);
                                              _RailFlawCompleted = newvalue;
                                            }
                                          });
                                        }),
                                    Text('Yes'),
                                    Checkbox(
                                        value: !_RailFlawCompleted,
                                        activeColor: kShadeColor1,
                                        onChanged: (bool newvalue) {
                                          setState(() {
                                            if (newvalue == true) {
                                              _RailFlawCompletedFinal = 'No';
                                              print(_RailFlawCompletedFinal);
                                              _RailFlawCompleted = !newvalue;
                                            }
                                          });
                                        }),
                                    Text('No'),
                                  ],
                                ),
                              ],
                            ),
                            width: 68.2 * SizeConfig.widthMultiplier,
                          ),

                          //Punch Mark Check
                          Padding(
                            padding: EdgeInsets.only(bottom: 8.0, top: 20),
                            child: Text(
                              'Punch Mark Check',
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
                                        value: _punchMarckCheck,
                                        activeColor: kShadeColor1,
                                        onChanged: (bool newvalue) {
                                          setState(() {
                                            if (newvalue == true) {
                                              _punchMarckCheckFinal = 'Yes';
                                              print(_punchMarckCheckFinal);
                                              _punchMarckCheck = newvalue;
                                            }
                                          });
                                        }),
                                    Text('Yes'),
                                    Checkbox(
                                        value: !_punchMarckCheck,
                                        activeColor: kShadeColor1,
                                        onChanged: (bool newvalue) {
                                          setState(() {
                                            if (newvalue == true) {
                                              _punchMarckCheckFinal = 'No';
                                              print(_punchMarckCheckFinal);
                                              _punchMarckCheck = !newvalue;
                                            }
                                          });
                                        }),
                                    Text('No'),
                                  ],
                                ),
                              ],
                            ),
                            width: 68.2 * SizeConfig.widthMultiplier,
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
                                if (_formKeyartcWeldReturn.currentState
                                    .validate()) {
                                  _validate();
                                  if (_isWeldReurnvalid == true) {
                                    bool connectionValilable =
                                        await checkConnectionNoListner();
                                    if (connectionValilable != true) {
                                      print('No Connection');
                                      String _stringWeldLocationDate =
                                          '${_weldLocationDate.day}/${_weldLocationDate.month}/${_weldLocationDate.year}';
                                      String _stringRailFlawDate =
                                          '${_railFlawDate.day}/${_railFlawDate.month}/${_railFlawDate.year}';
                                      String _apiURL = kBaseURL +
                                          'REST/EasyRails/App_Create_ARTC_WeldReturn?Date_Welders=${_weldLocationDate.day}/${_weldLocationDate.month}/${_weldLocationDate.year}&Code=$_weldLocationCode&Track=$_weldLocationTrack&Kilometer=$_kilometer&Rail=$_rail&RailSize=$_railSize&WeldReasonCode=$_weldReasonCode&Weld_Type_Code=$_weldType&BatchNo=$_aRTCLocalBatch&Weather_SiteCondition=$_siteConditionWeather&Weld_SiteCondition=$_siteConditonWeld&Track_SiteCondition=$_siteConditonTrack&PunchMarksBeforeFinal=$_punchmarkBeforeFinal&PunchMarksAfterFinal=$_punchmarkAfterFinal&RailTempFinal=$_railTempFinal&FromPoint=$_kmFrom&ToPoint=$_kmTo&Date_RailFlaw=${_railFlawDate.day}/${_railFlawDate.month}/${_railFlawDate.year}&RailTempFinal_InCharge=$_railTempFinal1&OK=$_ok&RailFlawReportCompleted=$_RailFlawCompletedFinal&Punch_Mark_Check=$_punchMarckCheckFinal&SystemUserID=$loggedinUserID';

                                      sharedPreferences =
                                          await SharedPreferences.getInstance();
                                      unSyncArtcWeldReturn =
                                          sharedPreferences.getStringList(
                                              'unSyncArtcWeldReturn');
                                      int _id = sharedPreferences.getInt('ID');
                                      print('New sharedPreferences ID');
                                      print(_id);
                                      ARTCWeldReturn artcweldReturn =
                                          ARTCWeldReturn(
                                        tempweldLocationDate: _stringWeldLocationDate,
                                        tempweldLocationCode: _weldLocationCode,
                                        tempweldLocationTrack: _weldLocationTrack,
                                        tempkilometer: _kilometer,
                                        temprail: _rail,
                                        temprailSize: _railSize,
                                        tempweldReasonCode: _weldReasonCode,
                                        tempweldType: _weldType,
                                        tempsiteConditionWeather: _siteConditionWeather,
                                        tempsiteConditonWeld: _siteConditonWeld,
                                        tempsiteConditonTrack: _siteConditonTrack,
                                        temprailTempNA: _railTempNA,
                                        temprailTempNA1: _railTempNA1,
                                        temprailTempFinal: _railTempFinal,
                                        temppunchmarkBeforeNA: _punchmarkBeforeNA,
                                        temppunchmarkBeforeEnter: _punchmarkBeforeEnter,
                                        temppunchmarkBeforeFinal: _punchmarkBeforeFinal,
                                        temppunchmarkAftereNA: _punchmarkAftereNA,
                                        temppunchmarkAfterEnter: _punchmarkAfterEnter,
                                        temppunchmarkAfterFinal: _punchmarkAfterFinal,
                                        tempkmFrom: _kmFrom,
                                        tempkmTo: _kmTo,
                                        temprailTempEnter1: _railTempEnter1,
                                        temprailTempFinal1: _railTempFinal1,
                                        temprailFlawDate: _stringRailFlawDate,
                                        tempok: _ok,
                                        tempokFinal: _okFinal,
                                        temppunchMarckCheck: _punchMarckCheck,
                                        temppunchMarckCheckFinal: _punchMarckCheckFinal,
                                        tempRailFlawCompleted: _RailFlawCompleted,
                                        tempRailFlawCompletedFinal: _RailFlawCompletedFinal,
                                        temprailTempEnter: _railTempEnter,
                                        temploggedinUserID: loggedinUserID,
                                        tempaRTCLocalBatch: _aRTCLocalBatch,
                                        apiURL: _apiURL,
                                        id: _id,
                                      );
                                      _id = _id + 1;
                                      sharedPreferences.setInt('ID', _id);
                                      print('old sharedPreferences ID');
                                      print(_id);
                                      var tempJson =
                                          jsonEncode(artcweldReturn.tojson());
                                      unSyncArtcWeldReturn.add(tempJson);
                                      sharedPreferences.setStringList(
                                          'unSyncArtcWeldReturn',
                                          unSyncArtcWeldReturn);
                                      aRTCLatestBatch = _aRTCLocalBatch;
                                      sharedPreferences.setString('aRTCLatestBatch', _aRTCLocalBatch);
                                      await Flushbar(
                                        titleText: Text(
                                          'Success',
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize: 2.0 *
                                                SizeConfig.heightMultiplier,
                                            color: const Color(0xffffffff),
                                            fontWeight: FontWeight.w600,
                                          ),
                                          textAlign: TextAlign.left,
                                        ),
                                        messageText: Text(
                                          'You have successfully create a Weld Report locally, record will be synced once you are connected to internet',
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize: 1.3 *
                                                SizeConfig.heightMultiplier,
                                            color: const Color(0xffffffff),
                                            fontWeight: FontWeight.w300,
                                          ),
                                          textAlign: TextAlign.left,
                                        ),
                                        padding: EdgeInsets.symmetric(
                                            vertical: 12.0,
                                            horizontal: 5.1 *
                                                SizeConfig.widthMultiplier),
                                        icon: Icon(
                                          Icons.check,
                                          size: 3.94 *
                                              SizeConfig.heightMultiplier,
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
                                            color:
                                                Colors.black.withOpacity(0.3),
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
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => XDMenu()));
                                    } else {
                                      print('Connected');
                                      print(kBaseURL +
                                          'REST/EasyRails/App_Create_ARTC_WeldReturn?Date_Welders=${_weldLocationDate.day}/${_weldLocationDate.month}/${_weldLocationDate.year}&Code=$_weldLocationCode&Track=$_weldLocationTrack&Kilometer=$_kilometer&Rail=$_rail&RailSize=$_railSize&WeldReasonCode=$_weldReasonCode&BatchNo=$_aRTCLocalBatch&Weld_Type_Code=$_weldType&Weather_SiteCondition=$_siteConditionWeather&Weld_SiteCondition=$_siteConditonWeld&Track_SiteCondition=$_siteConditonTrack&PunchMarksBeforeFinal=$_punchmarkBeforeFinal&PunchMarksAfterFinal=$_punchmarkAfterFinal&RailTempFinal=$_railTempFinal&FromPoint=$_kmFrom&ToPoint=$_kmTo&Date_RailFlaw=${_railFlawDate.day}/${_railFlawDate.month}/${_railFlawDate.year}&RailTempFinal_InCharge=$_railTempFinal1&OK=$_ok&RailFlawReportCompleted=$_RailFlawCompletedFinal&Punch_Mark_Check=$_punchMarckCheckFinal&SystemUserID=$loggedinUserID');
                                      http.Response _response = await http.get(
                                          kBaseURL +
                                              'REST/EasyRails/App_Create_ARTC_WeldReturn?Date_Welders=${_weldLocationDate.day}/${_weldLocationDate.month}/${_weldLocationDate.year}&Code=$_weldLocationCode&Track=$_weldLocationTrack&Kilometer=$_kilometer&Rail=$_rail&RailSize=$_railSize&WeldReasonCode=$_weldReasonCode&BatchNo=$_aRTCLocalBatch&Weld_Type_Code=$_weldType&Weather_SiteCondition=$_siteConditionWeather&Weld_SiteCondition=$_siteConditonWeld&Track_SiteCondition=$_siteConditonTrack&PunchMarksBeforeFinal=$_punchmarkBeforeFinal&PunchMarksAfterFinal=$_punchmarkAfterFinal&RailTempFinal=$_railTempFinal&FromPoint=$_kmFrom&ToPoint=$_kmTo&Date_RailFlaw=${_railFlawDate.day}/${_railFlawDate.month}/${_railFlawDate.year}&RailTempFinal_InCharge=$_railTempFinal1&OK=$_ok&RailFlawReportCompleted=$_RailFlawCompletedFinal&Punch_Mark_Check=$_punchMarckCheckFinal&SystemUserID=$loggedinUserID');
                                      try {
                                        print(_response.body);
                                        var _responseBody = _response.body;
                                        error =
                                            jsonDecode(_responseBody)['Error'];
                                        if (error != 'No Error') {
                                          await ShowFlushbar('Error', error,
                                              Icons.close, context);
                                          setState(() {
                                            _waiting = false;
                                          });
                                        } else {
                                          setState(() {
                                            _waiting = false;
                                          });
                                          sharedPreferences = await SharedPreferences.getInstance();
                                          aRTCLatestBatch = _aRTCLocalBatch;
                                          sharedPreferences.setString('aRTCLatestBatch', _aRTCLocalBatch);
                                          await Flushbar(
                                            titleText: Text(
                                              'Success',
                                              style: TextStyle(
                                                fontFamily: 'Poppins',
                                                fontSize: 2.0 *
                                                    SizeConfig.heightMultiplier,
                                                color: const Color(0xffffffff),
                                                fontWeight: FontWeight.w600,
                                              ),
                                              textAlign: TextAlign.left,
                                            ),
                                            messageText: Text(
                                              'You have successfully create a Weld Report',
                                              style: TextStyle(
                                                fontFamily: 'Poppins',
                                                fontSize: 1.3 *
                                                    SizeConfig.heightMultiplier,
                                                color: const Color(0xffffffff),
                                                fontWeight: FontWeight.w300,
                                              ),
                                              textAlign: TextAlign.left,
                                            ),
                                            padding: EdgeInsets.symmetric(
                                                vertical: 12.0,
                                                horizontal: 5.1 *
                                                    SizeConfig.widthMultiplier),
                                            icon: Icon(
                                              Icons.check,
                                              size: 3.94 *
                                                  SizeConfig.heightMultiplier,
                                              color: Colors.white,
                                            ),
                                            duration: Duration(seconds: 3),
                                            flushbarPosition:
                                                FlushbarPosition.TOP,
                                            borderColor: Colors.transparent,
                                            shouldIconPulse: false,
                                            maxWidth: 91.8 *
                                                SizeConfig.widthMultiplier,
                                            boxShadows: [
                                              BoxShadow(
                                                color: Colors.black
                                                    .withOpacity(0.3),
                                                spreadRadius: 1 *
                                                    SizeConfig.heightMultiplier,
                                                blurRadius: 2 *
                                                    SizeConfig.heightMultiplier,
                                                offset: Offset(0,
                                                    10), // changes position of shadow
                                              ),
                                            ],
                                            backgroundColor: kShadeColor1,
                                          ).show(context);
                                          Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      XDMenu()));
                                        }
                                      } catch (e) {
                                        ShowFlushbar(
                                            'Error',
                                            'Something went wrong',
                                            Icons.close,
                                            context);
                                      }
                                    }
                                  }
                                }
                                setState(() {
                                  _waiting = false;
                                });
                              },
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      2.63 * SizeConfig.heightMultiplier)),
                              padding: EdgeInsets.all(0.0),
                              child: Padding(
                                padding: EdgeInsets.only(left: 0.0, right: 0.0),
                                child: Text(
                                  'CREATE',
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
            ],
          ),
        ),
      ),
    );
  }

  Future<DateTime> pickWeldLocationDate() async {
    DateTime pickedDateTime = await showDatePicker(
        context: context,
        initialDate: _weldLocationDate,
        firstDate: DateTime(DateTime.now().year - 2),
        lastDate: DateTime.now());
    if (pickedDateTime != null) {
      setState(() {
        _weldLocationDate = pickedDateTime;
      });
    }
    return pickedDateTime;
  }

  Future<DateTime> pickRailFlawDate() async {
    DateTime pickedDateTime = await showDatePicker(
        context: context,
        initialDate: _railFlawDate,
        firstDate: DateTime(DateTime.now().year - 2),
        lastDate: DateTime.now());
    if (pickedDateTime != null) {
      setState(() {
        _railFlawDate = pickedDateTime;
      });
    }
    return pickedDateTime;
  }
}

class ARTCWeldReturn {
  int id;
  String tempweldLocationDate;
  String tempweldLocationCode;
  String tempweldLocationTrack;
  String tempkilometer;
  String temprail;
  String temprailSize;
  String tempweldReasonCode;
  String tempweldType;
  String tempsiteConditionWeather;
  String tempsiteConditonWeld;
  String tempsiteConditonTrack;
  bool temprailTempNA = false;
  bool temprailTempNA1 = false;
  String temprailTempFinal;
  bool temppunchmarkBeforeNA = false;
  bool temppunchmarkBeforeEnter = true;
  String temppunchmarkBeforeFinal;
  bool temppunchmarkAftereNA = false;
  bool temppunchmarkAfterEnter = true;
  String temppunchmarkAfterFinal;
  String tempkmFrom;
  String tempkmTo;
  bool temprailTempEnter1 = true;
  String temprailTempFinal1;
  String temprailFlawDate;
  bool tempok = true;
  String tempokFinal = 'Yes';
  bool temppunchMarckCheck = true;
  String temppunchMarckCheckFinal = 'Yes';
  bool tempRailFlawCompleted = true;
  String tempRailFlawCompletedFinal = 'Yes';
  bool temprailTempEnter = true;
  String apiURL;
  String temploggedinUserID;
  String tempaRTCLocalBatch;

//  Constructor
  ARTCWeldReturn(
      {this.tempweldLocationDate,
      this.tempweldLocationCode,
      this.tempweldLocationTrack,
      this.tempkilometer,
      this.temprail,
      this.temprailSize,
      this.tempweldReasonCode,
      this.tempweldType,
      this.tempsiteConditionWeather,
      this.tempsiteConditonWeld,
      this.tempsiteConditonTrack,
      this.temprailTempNA,
      this.temprailTempNA1,
      this.temprailTempFinal,
      this.temppunchmarkBeforeNA,
      this.temppunchmarkBeforeEnter,
      this.temppunchmarkBeforeFinal,
      this.temppunchmarkAftereNA,
      this.temppunchmarkAfterEnter,
      this.temppunchmarkAfterFinal,
      this.tempkmFrom,
      this.tempkmTo,
      this.temprailTempEnter1,
      this.temprailTempFinal1,
      this.temprailFlawDate,
      this.tempok,
      this.tempokFinal,
      this.temppunchMarckCheck,
      this.temppunchMarckCheckFinal,
      this.tempRailFlawCompleted,
      this.tempRailFlawCompletedFinal,
      this.temprailTempEnter,
      this.apiURL,
      this.temploggedinUserID,
        this.tempaRTCLocalBatch,
      this.id});

//  this map will convert object in json
  Map<String, dynamic> tojson() => {
        'tempweldLocationDate': tempweldLocationDate,
        'tempweldLocationCode': tempweldLocationCode,
        'tempweldLocationTrack': tempweldLocationTrack,
        'tempkilometer': tempkilometer,
        'temprail': temprail,
        'temprailSize': temprailSize,
        'tempweldReasonCode': tempweldReasonCode,
        'tempweldType': tempweldType,
        'tempsiteConditionWeather': tempsiteConditionWeather,
        'tempsiteConditonWeld': tempsiteConditonWeld,
        'tempsiteConditonTrack': tempsiteConditonTrack,
        'temprailTempNA': temprailTempNA,
        'temprailTempNA1': temprailTempNA1,
        'temprailTempFinal': temprailTempFinal,
        'temppunchmarkBeforeNA': temppunchmarkBeforeNA,
        'temppunchmarkBeforeEnter': temppunchmarkBeforeEnter,
        'temppunchmarkBeforeFinal': temppunchmarkBeforeFinal,
        'temppunchmarkAftereNA': temppunchmarkAftereNA,
        'temppunchmarkAfterEnter': temppunchmarkAfterEnter,
        'temppunchmarkAfterFinal': temppunchmarkAfterFinal,
        'tempkmFrom': tempkmFrom,
        'tempkmTo': tempkmTo,
        'temprailTempEnter1': temprailTempEnter1,
        'temprailTempFinal1': temprailTempFinal1,
        'temprailFlawDate': temprailFlawDate,
        'tempok': tempok,
        'tempokFinal': tempokFinal,
        'temppunchMarckCheck': temppunchMarckCheck,
        'temppunchMarckCheckFinal': temppunchMarckCheckFinal,
        'tempRailFlawCompleted': tempRailFlawCompleted,
        'tempRailFlawCompletedFinal': tempRailFlawCompletedFinal,
        'temprailTempEnter': temprailTempEnter,
        'apiURL': apiURL,
        'temploggedinUserID': temploggedinUserID,
      'tempaRTCLocalBatch' : tempaRTCLocalBatch,
        'id': id,
      };

//  this function will convert json into object
  ARTCWeldReturn.fromJson(Map<String, dynamic> json)
      : tempweldLocationDate = json['tempweldLocationDate'],
        tempweldLocationCode = json['tempweldLocationCode'],
        tempweldLocationTrack = json['tempweldLocationTrack'],
        tempkilometer = json['tempkilometer'],
        temprail = json['temprail'],
        temprailSize = json['temprailSize'],
        tempweldReasonCode = json['tempweldReasonCode'],
        tempweldType = json['tempweldType'],
        tempsiteConditionWeather = json['tempsiteConditionWeather'],
        tempsiteConditonWeld = json['tempsiteConditonWeld'],
        tempsiteConditonTrack = json['tempsiteConditonTrack'],
        temprailTempNA = json['temprailTempNA'],
        temprailTempNA1 = json['temprailTempNA1'],
        temprailTempFinal = json['temprailTempFinal'],
        temppunchmarkBeforeNA = json['temppunchmarkBeforeNA'],
        temppunchmarkBeforeEnter = json['temppunchmarkBeforeEnter'],
        temppunchmarkBeforeFinal = json['temppunchmarkBeforeFinal'],
        temppunchmarkAftereNA = json['temppunchmarkAftereNA'],
        temppunchmarkAfterEnter = json['temppunchmarkAfterEnter'],
        temppunchmarkAfterFinal = json['temppunchmarkAfterFinal'],
        tempkmFrom = json['tempkmFrom'],
        tempkmTo = json['tempkmTo'],
        temprailTempEnter1 = json['temprailTempEnter1'],
        temprailTempFinal1 = json['temprailTempFinal1'],
        temprailFlawDate = json['temprailFlawDate'],
        tempok = json['tempok'],
        tempokFinal = json['tempokFinal'],
        temppunchMarckCheck = json['temppunchMarckCheck'],
        temppunchMarckCheckFinal = json['temppunchMarckCheckFinal'],
        tempRailFlawCompleted = json['tempRailFlawCompleted'],
        tempRailFlawCompletedFinal = json['tempRailFlawCompletedFinal'],
        temprailTempEnter = json['temprailTempEnter'],
        apiURL = json['apiURL'],
        temploggedinUserID = json['temploggedinUserID'],
        tempaRTCLocalBatch = json['tempaRTCLocalBatch'],
        id = json['id'];
}
