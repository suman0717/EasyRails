import 'dart:convert';
import 'package:easy_rails/constants.dart';
import 'package:easy_rails/customdropdown.dart';
import 'package:easy_rails/screens/XDMenu.dart';
import 'package:easy_rails/size_config.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

SharedPreferences sharedPreferences;
List<String> unSyncWeldReturn=[];

DateTime _weldDate;
bool _workorderNA = false;
bool _workOrderEnter = true;
String _workOrderFinal;
String _weldProcessGrade ='PLK CJ / X';
bool _FlocNA = false;
bool _FlocEnter = true;
String _FlocFinal;
bool _railTempNA = false;
bool _railTempEnter = true;
String _railTempFinal;
bool _datamarkBeforeNA = false;
bool _datamarkBeforeEnter = true;
String _datamarkBeforeFinal;
bool _datamarkAftereNA = false;
bool _datamarkAfterEnter = true;
String _datamarkAfterFinal;
bool _weldGrinderMe = false;
bool _weldGrinderManualEnterName = true;
bool _weldGrinderLeaveBlank = false;
bool _weldGrinderManualEnterNameNA = false;
String _weldGrinderManual;
String _weldGrinderManualCount;
String _weldGrinderManualLicence;
bool _addVerticalAlignmentNA = false;
bool _addVerticalAlignmentEnter = true;
String _addVerticalAlignmentFinal;
bool _addHorizontalAlignmentNA = false;
bool _addHorizontalAlignmentEnter = true;
String _addHorizontalAlignmentFinal;
bool _reasonForWeldNew = false;
bool _reasonForWeldDefect = true;
String _reasonForWeldFinal;
String _straightEdgeType = 'Flat';
String _horAlignFieldFace = 'Yes';
String _gageFaceAngeTrans = 'Yes';
String _comments;
String _StandardComment;
String _railGrade1;
String _railGrade2;
String _selectedAurizonSystem;
String _kilometrage;
String _road;
String _rail;
String _railSize1;
String _railSize2;
String _railType;
String _ndt='Yes';
String _weldType='New';
String _weldBatchNumber;
String _stressManagement='Free';
String _fineWeather;
String selectedCity;

bool _waiting = false;
String error='No Error';

var ctrlWorkOrderFinal = TextEditingController();
var ctrlFlocFinal = TextEditingController();
var ctrlReasonForWeld = TextEditingController();
var ctrlrailTempFinal = TextEditingController();
var ctrlweldBatchNumber = TextEditingController();
var ctrlDataMarkBeforeFinal = TextEditingController();
var ctrlDataMarkAfterFinal = TextEditingController();
var ctrlWeldGrinderManual = TextEditingController();
var ctrlWeldGrinderManualCount = TextEditingController();
var ctrlWeldGrinderManualLicence = TextEditingController();
var ctrladdVerticalAlignmentFinal = TextEditingController();
var ctrladdHorizontalAlignmentFinal = TextEditingController();

var _formKeyWeldReturn = GlobalKey<FormState>();

class NewWeldReturn extends StatefulWidget {
  @override
  _NewWeldReturnState createState() => _NewWeldReturnState();
}

class _NewWeldReturnState extends State<NewWeldReturn> {

  @override
  void initState() {
    setState(() {
      _waiting = true;
    });
    _weldDate = DateTime.now();
    GetGenericDataForAurizon().whenComplete(() {
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
    void _validate(){
      if(_selectedAurizonSystem == null){
        _isWeldReurnvalid=false;
        ShowFlushbar('Error','Please Provide System',Icons.close,context);
      }
      else if(_road == null){
        _isWeldReurnvalid=false;
        ShowFlushbar('Error','Please Provide Road',Icons.close,context);
      }
      else if(_rail == null){
        _isWeldReurnvalid=false;
        ShowFlushbar('Error','Please Provide Rail',Icons.close,context);
      }
      else if(_railTempEnter == true && _railTempFinal == null){
        _isWeldReurnvalid=false;
        ShowFlushbar('Error','Please Provide Rail Temperature',Icons.close,context);
      }
      else if(_railSize1 == null){
        _isWeldReurnvalid=false;
        ShowFlushbar('Error','Please Provide Rail Size 1',Icons.close,context);
      }
      else if(_railSize2 == null){
        _isWeldReurnvalid=false;
        ShowFlushbar('Error','Please Provide Rail Size 2',Icons.close,context);
      }
      else if(_railGrade1 == null){
        _isWeldReurnvalid=false;
        ShowFlushbar('Error','Please Provide Rail Grade 1',Icons.close,context);
      }
      else if(_railGrade2 == null){
        _isWeldReurnvalid=false;
        ShowFlushbar('Error','Please Provide Rail Grade 2',Icons.close,context);
      }
      else if(_railType == null){
        _isWeldReurnvalid=false;
        ShowFlushbar('Error','Please Provide Rail Type',Icons.close,context);
      }
      else if(_fineWeather == null){
        _isWeldReurnvalid=false;
        ShowFlushbar('Error','Please Provide Fine Weather',Icons.close,context);
      }
    }
    return Scaffold(
      appBar: buildAppBar('NEW WELD RETURN'),
      body: ModalProgressHUD(
        inAsyncCall: _waiting,
        color: Color(0xff3ba838),
        opacity: 0.1,
        child: GestureDetector(onTap: (){
          FocusScope.of(context).unfocus();
        },
          child: Column(
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(6.35 * SizeConfig.widthMultiplier, 2.63 * SizeConfig.heightMultiplier, 6.35 * SizeConfig.widthMultiplier, 0),
                  child: Form(
                    key: _formKeyWeldReturn,
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
                            padding: EdgeInsets.only(bottom: 1.05 * SizeConfig.heightMultiplier),
                            child: Text(
                              'Weld Date',
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
                              borderRadius: BorderRadius.circular(3.95 * SizeConfig.heightMultiplier),
                              border: Border.all(color: Color(0xffe8e8e8),width: 1.0),
                            ),
                            child: ListTile(trailing: IconButton(icon: Icon(Icons.date_range_outlined), onPressed: (){pickDate();}),
                              title: Center(child: Text('${_weldDate.day}-${_weldDate.month}-${_weldDate.year}')),

                            ),
                          ),
                         
                          //Work Order
                          Padding(
                            padding: EdgeInsets.only(bottom: 1.05 * SizeConfig.heightMultiplier, top: 2.63 * SizeConfig.heightMultiplier),
                            child: Text(
                              'Work Order',
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

                                    Checkbox(value: _workOrderEnter,
                                        activeColor: kShadeColor1,
                                        onChanged: (bool newvalue){
                                          setState(() {
                                            print(newvalue);
                                            ctrlWorkOrderFinal.text='';
                                            _workOrderEnter = newvalue;
                                            _workorderNA = !newvalue;
                                          });
                                        }),
                                    Text('Enter Work Order'),
                                    Checkbox(value: _workorderNA,
                                        activeColor: kShadeColor1,
                                        onChanged: (bool newvalue){
                                          setState(() {
                                            print(newvalue);
                                            ctrlWorkOrderFinal.text='N/A';
                                            _workorderNA = newvalue;
                                            _workOrderEnter = !newvalue;
                                          });
                                        }),
                                    Text('N/A'),
                                  ],
                                ),
                                Visibility(visible: _workOrderEnter,
                                  child:
                                  Container(
                                    child: TextFormField(maxLength: 10,
                                        controller: ctrlWorkOrderFinal,
                                        validator: (String value){
                                          if(((value.isEmpty || value.contains('N/A')) && _workOrderEnter==true)){
                                            return 'Provide Work Order';
                                          }
                                        },
                                        keyboardType: TextInputType.phone,
                                        textAlign: TextAlign.center,
                                        onChanged: (value) {
                                          _workOrderFinal = value;
                                        },
                                        style: TextStyle(
                                            fontFamily: 'Poppins', fontSize: 1.84 * SizeConfig.heightMultiplier),
                                        decoration: kTextFieldDecorationNoback.copyWith(
                                          hintText: '',contentPadding: EdgeInsets.symmetric(vertical: 1.5 * SizeConfig.heightMultiplier, horizontal: 20.0),)
                                    ),

                                  ),
                                ),
                              ],
                            ),
                            width: 68.2 * SizeConfig.widthMultiplier,
                          ),

                          //System
                          Padding(
                            padding: EdgeInsets.only(bottom: 8.0, top: 20),
                            child: Text(
                              'System',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 1.7 * SizeConfig.heightMultiplier,
                                color: const Color(0xffa1a1a1),
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          DropDownField(
                              onValueChanged: (dynamic s) {
                                print(s);
                                setState(() {
                                  _selectedAurizonSystem = s;
                                });
                              },
                              textStyle: TextStyle(
                                  height: 0.9,
                                  fontFamily: 'Poppins',
                                  fontSize:
                                  1.84 * SizeConfig.heightMultiplier),
                              value: _selectedAurizonSystem,
                              required: false,
                              hintText: 'Choose a System',
                              hintStyle: TextStyle(
                                  height: 1.0,
                                  fontFamily: 'Poppins',
                                  fontSize:
                                  1.84 * SizeConfig.heightMultiplier),
                              items: Aurizon_SystemList,
                              strict: true,
                              setter: (dynamic newValue) {
                                print('Setter');
                                _selectedAurizonSystem = newValue;
                              }),

                          //Kilometrage
                          Padding(
                            padding: EdgeInsets.only(bottom: 8.0, top: 20),
                            child: Text(
                              'Kilometrage',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 1.7 * SizeConfig.heightMultiplier,
                                color: const Color(0xffa1a1a1),
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          Container(
                            child: TextFormField(validator: (String value){
                              if(value.isEmpty)
                                {
                                  return 'Please provide kilometrage';
                                }
                            },
                                keyboardType: TextInputType.number,
                                textAlign: TextAlign.center,
                                onChanged: (value) {
                                  _kilometrage = value;
                                },
                                style: TextStyle(
                                    fontFamily: 'Poppins', fontSize: 1.84 * SizeConfig.heightMultiplier),
                                decoration: kTextFieldDecorationNoback.copyWith(
                                  hintText: '',contentPadding: EdgeInsets.symmetric(vertical: 1.5 * SizeConfig.heightMultiplier, horizontal: 20.0),)
                            ),
                            width: 68.2 * SizeConfig.widthMultiplier,
                          ),

                          // Road
                          Padding(
                            padding: EdgeInsets.only(bottom: 8.0, top: 20),
                            child: Text(
                              'Road',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 1.7 * SizeConfig.heightMultiplier,
                                color: const Color(0xffa1a1a1),
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          DropDownField(
                              onValueChanged: (dynamic s) {
                                print(s);
                                setState(() {
                                  _road = s;
                                });
                              },
                              textStyle: TextStyle(
                                  height: 0.9,
                                  fontFamily: 'Poppins',
                                  fontSize:
                                  1.84 * SizeConfig.heightMultiplier),
                              value: _road,
                              required: false,
                              hintText: 'Choose a Road',
                              hintStyle: TextStyle(
                                  height: 1.0,
                                  fontFamily: 'Poppins',
                                  fontSize:
                                  1.84 * SizeConfig.heightMultiplier),
                              items: ['Up','Down'].map(
                                    (String dropdownitem) {
                                  return dropdownitem;
                                },
                              ).toList(),
                              strict: true,
                              setter: (dynamic newValue) {
                                print('Setter');
                                _road = newValue;
                              }),

                          //Floc
                          Padding(
                            padding: EdgeInsets.only(bottom: 1.05 * SizeConfig.heightMultiplier, top: 2.63 * SizeConfig.heightMultiplier),
                            child: Text(
                              'Floc',
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

                                    Checkbox(value: _FlocEnter,
                                        activeColor: kShadeColor1,
                                        onChanged: (bool newvalue){
                                          setState(() {
                                            print(newvalue);
                                            ctrlFlocFinal.text='';
                                            _FlocEnter = newvalue;
                                            _FlocNA = !newvalue;
                                          });
                                        }),
                                    Text('Provide Floc'),
                                    Checkbox(value: _FlocNA,
                                        activeColor: kShadeColor1,
                                        onChanged: (bool newvalue){
                                          setState(() {
                                            print(newvalue);
                                            ctrlFlocFinal.text='N/A';
                                            _FlocNA = newvalue;
                                            _FlocEnter = !newvalue;
                                          });
                                        }),
                                    Text('N/A'),
                                  ],
                                ),
                                Visibility(visible: _FlocEnter,
                                  child: Container(
                                    child: TextFormField(
                                        validator: (String value){
                                          if(((value.isEmpty || value.contains('N/A')) && _FlocEnter==true)){
                                            return 'Please Provide Floc';
                                          }
                                        },
                                        controller: ctrlFlocFinal,
                                        maxLength: 10,
                                        textAlign: TextAlign.center,
                                        onChanged: (value) {
                                          _FlocFinal = value;
                                        },
                                        style: TextStyle(
                                            fontFamily: 'Poppins', fontSize: 1.84 * SizeConfig.heightMultiplier),
                                        decoration: kTextFieldDecorationNoback.copyWith(
                                          hintText: '',contentPadding: EdgeInsets.symmetric(vertical: 1.5 * SizeConfig.heightMultiplier, horizontal: 20.0),)
                                    ),

                                  ),
                                ),
                              ],
                            ),
//                          height: 5.65 * SizeConfig.heightMultiplier,
                            width: 68.2 * SizeConfig.widthMultiplier,
//                          height: 5.65 * SizeConfig.heightMultiplier,
                          ),

                          //Rail
                          Padding(
                            padding: EdgeInsets.only(bottom: 8.0, top: 20),
                            child: Text(
                              'Rail',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 1.7 * SizeConfig.heightMultiplier,
                                color: const Color(0xffa1a1a1),
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          DropDownField(
                              onValueChanged: (dynamic s) {
                                print(s);
                                setState(() {
                                  _rail = s;
                                });
                              },
                              textStyle: TextStyle(
                                  height: 0.9,
                                  fontFamily: 'Poppins',
                                  fontSize:
                                  1.84 * SizeConfig.heightMultiplier),
                              value: _rail,
                              required: false,
                              hintText: 'Choose a Rail',
                              hintStyle: TextStyle(
                                  height: 1.0,
                                  fontFamily: 'Poppins',
                                  fontSize:
                                  1.84 * SizeConfig.heightMultiplier),
                              items: ['Left','Right'].map(
                                    (String dropdownitem) {
                                  return dropdownitem;
                                },
                              ).toList(),
                              strict: true,
                              setter: (dynamic newValue) {
                                print('Setter');
                                _rail = newValue;
                              }),

                          Padding(
                            padding: EdgeInsets.only(bottom: 8.0, top: 20),
                            child: Text(
                              'Rail and Weld Process Details',
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

                          //Reason for Weld
                          Padding(
                            padding: EdgeInsets.only(bottom: 8.0, top: 20),
                            child: Text(
                              'Reason For Weld',
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
                                    Checkbox(value: _reasonForWeldDefect,
                                        activeColor: kShadeColor1,
                                        onChanged: (bool newvalue){
                                          setState(() {
                                            print(newvalue);
                                            ctrlReasonForWeld.text='';
                                            _reasonForWeldFinal = '';
                                            _reasonForWeldDefect = newvalue;
                                            _reasonForWeldNew = !newvalue;
                                          });
                                        }),
                                    Text('Defect'),
                                    Checkbox(value: _reasonForWeldNew,
                                        activeColor: kShadeColor1,
                                        onChanged: (bool newvalue){
                                          setState(() {
                                            print(newvalue);
                                            ctrlReasonForWeld.text='New';
                                            _reasonForWeldFinal = 'New';
                                            _reasonForWeldNew = newvalue;
                                            _reasonForWeldDefect = !newvalue;
                                          });
                                        }),
                                    Text('New'),
                                  ],
                                ),
                                Visibility(visible: _reasonForWeldDefect,
                                  child: Container(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(bottom: 8.0, top: 20),
                                          child: Text(
                                            'Defect Number',
                                            style: TextStyle(
                                              fontFamily: 'Poppins',
                                              fontSize: 1.7 * SizeConfig.heightMultiplier,
                                              color: const Color(0xffa1a1a1),
                                            ),
                                            textAlign: TextAlign.left,
                                          ),
                                        ),
                                        TextFormField(maxLength: 10,
                                            validator: (String value){
                                          if(((value.isEmpty || value=='New') && _reasonForWeldDefect==true)){
                                            return 'Please Provide Defect Number';
                                          }
                                        },
                                            controller: ctrlReasonForWeld,
                                            textAlign: TextAlign.center,
                                            onChanged: (value) {
                                              _reasonForWeldFinal = value;
                                            },
                                            style: TextStyle(
                                                fontFamily: 'Poppins', fontSize: 1.84 * SizeConfig.heightMultiplier),
                                            decoration: kTextFieldDecorationNoback.copyWith(
                                              hintText: '',contentPadding: EdgeInsets.symmetric(vertical: 1.5 * SizeConfig.heightMultiplier, horizontal: 20.0),)
                                        ),
                                      ],
                                    ),

                                  ),
                                ),
                              ],
                            ),
//                          height: 5.65 * SizeConfig.heightMultiplier,
                            width: 68.2 * SizeConfig.widthMultiplier,
//                          height: 5.65 * SizeConfig.heightMultiplier,
                          ),

                          //Weld Process Grade
                          Padding(
                            padding: EdgeInsets.only(bottom: 8.0, top: 20),
                            child: Text(
                              'Weld Process Grade',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 1.7 * SizeConfig.heightMultiplier,
                                color: const Color(0xffa1a1a1),
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          DropDownField(
                              onValueChanged: (dynamic s) {
                                print(s);
                                setState(() {
                                  _weldProcessGrade = s;
                                });
                              },
                              textStyle: TextStyle(
                                  height: 0.9,
                                  fontFamily: 'Poppins',
                                  fontSize:
                                  1.84 * SizeConfig.heightMultiplier),
                              value: _weldProcessGrade,
                              required: false,
                              hintText: 'Choose a Weld Process',
                              hintStyle: TextStyle(
                                  height: 1.0,
                                  fontFamily: 'Poppins',
                                  fontSize:
                                  1.84 * SizeConfig.heightMultiplier),
                              items: ['SkV-Elite / Z90','SkV-Elite / Z110','SkV-Elite / Z120','PLK CJ / X','PLK CJ / HH'].map(
                                    (String dropdownitem) {
                                  return dropdownitem;
                                },
                              ).toList(),
                              strict: true,
                              setter: (dynamic newValue) {
                                print('Setter');
                                _weldProcessGrade = newValue;
                              }),

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

                                    Checkbox(value: _railTempEnter,
                                        activeColor: kShadeColor1,
                                        onChanged: (bool newvalue){
                                          setState(() {
                                            print(newvalue);
                                            ctrlrailTempFinal.text='';
                                            _railTempEnter = newvalue;
                                            _railTempNA = !newvalue;
                                          });
                                        }),
                                    Text('Temp'),
                                    Checkbox(value: _railTempNA,
                                        activeColor: kShadeColor1,
                                        onChanged: (bool newvalue){
                                          setState(() {
                                            print(newvalue);
                                            ctrlrailTempFinal.text='N/A';
                                            _railTempNA = newvalue;
                                            _railTempEnter = !newvalue;
                                          });
                                        }),
                                    Text('N/A'),
                                  ],
                                ),
                                Visibility(visible: _railTempEnter,
                                  child: Container(
                                    child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(bottom: 8.0, top: 20),
                                          child: Text(
                                            'Rail Temp Degrees',
                                            style: TextStyle(
                                              fontFamily: 'Poppins',
                                              fontSize: 1.7 * SizeConfig.heightMultiplier,
                                              color: const Color(0xffa1a1a1),
                                            ),
                                            textAlign: TextAlign.left,
                                          ),
                                        ),
                                        DropDownField(
                                            onValueChanged: (dynamic s) {
                                              print(s);
                                              setState(() {
                                                _railTempFinal = s;
                                              });
                                            },
                                            textStyle: TextStyle(
                                                height: 0.9,
                                                fontFamily: 'Poppins',
                                                fontSize:
                                                1.84 * SizeConfig.heightMultiplier),
                                            value: _railTempFinal,
                                            required: false,
                                            hintText: 'Choose a Rail Temp',
                                            hintStyle: TextStyle(
                                                height: 1.0,
                                                fontFamily: 'Poppins',
                                                fontSize:
                                                1.84 * SizeConfig.heightMultiplier),
                                            items: ['10','11','12','13','14','15','16','17','18','19','20','21','22','23','24','25','26','27','28','29','30','31','32','33','34','35','36','37','38','39','40','41','42','43','44','45','46','47','48','49','50'].map(
                                                  (String dropdownitem) {
                                                return dropdownitem;
                                              },
                                            ).toList(),
                                            strict: true,
                                            setter: (dynamic newValue) {
                                              print('Setter');
                                              _railTempFinal = newValue;
                                            }),

                                      ],
                                    ),

                                  ),
                                ),
                              ],
                            ),
                            width: 68.2 * SizeConfig.widthMultiplier,
                          ),

                          //Rail Size 1
                          Padding(
                            padding: EdgeInsets.only(bottom: 8.0, top: 20),
                            child: Text(
                              'Rail Size - Rail 1',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 1.7 * SizeConfig.heightMultiplier,
                                color: const Color(0xffa1a1a1),
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          DropDownField(
                              onValueChanged: (dynamic s) {
                                print(s);
                                setState(() {
                                  _railSize1 = s;
                                });
                              },
                              textStyle: TextStyle(
                                  height: 0.9,
                                  fontFamily: 'Poppins',
                                  fontSize:
                                  1.84 * SizeConfig.heightMultiplier),
                              value: _railSize1,
                              required: false,
                              hintText: 'Choose a Rail Size',
                              hintStyle: TextStyle(
                                  height: 1.0,
                                  fontFamily: 'Poppins',
                                  fontSize:
                                  1.84 * SizeConfig.heightMultiplier),
                              items: ['41','47','50','53','60','68'].map(
                                    (String dropdownitem) {
                                  return dropdownitem;
                                },
                              ).toList(),
                              strict: true,
                              setter: (dynamic newValue) {
                                print('Setter');
                                _railSize1 = newValue;
                              }),

                          //Rail Size 2
                          Padding(
                            padding: EdgeInsets.only(bottom: 8.0, top: 20),
                            child: Text(
                              'Rail Size - Rail 2',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 1.7 * SizeConfig.heightMultiplier,
                                color: const Color(0xffa1a1a1),
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          DropDownField(
                              onValueChanged: (dynamic s) {
                                print(s);
                                setState(() {
                                  _railSize2 = s;
                                });
                              },
                              textStyle: TextStyle(
                                  height: 0.9,
                                  fontFamily: 'Poppins',
                                  fontSize:
                                  1.84 * SizeConfig.heightMultiplier),
                              value: _railSize2,
                              required: false,
                              hintText: 'Choose a Rail Size',
                              hintStyle: TextStyle(
                                  height: 1.0,
                                  fontFamily: 'Poppins',
                                  fontSize:
                                  1.84 * SizeConfig.heightMultiplier),
                              items: ['41','47','50','53','60','68'].map(
                                    (String dropdownitem) {
                                  return dropdownitem;
                                },
                              ).toList(),
                              strict: true,
                              setter: (dynamic newValue) {
                                print('Setter');
                                _railSize2 = newValue;
                              }),

                          //Rail Grade 1
                          Padding(
                            padding: EdgeInsets.only(bottom: 8.0, top: 20),
                            child: Text(
                              'Rail Grades - Rail 1',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 1.7 * SizeConfig.heightMultiplier,
                                color: const Color(0xffa1a1a1),
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          DropDownField(
                              onValueChanged: (dynamic s) {
                                print(s);
                                setState(() {
                                  _railGrade2 = s;
                                });
                              },
                              textStyle: TextStyle(
                                  height: 0.9,
                                  fontFamily: 'Poppins',
                                  fontSize:
                                  1.84 * SizeConfig.heightMultiplier),
                              value: _railGrade2,
                              required: false,
                              hintText: 'Choose a Rail Grade',
                              hintStyle: TextStyle(
                                  height: 1.0,
                                  fontFamily: 'Poppins',
                                  fontSize:
                                  1.84 * SizeConfig.heightMultiplier),
                              items: railGradeList,
                              strict: true,
                              setter: (dynamic newValue) {
                                print('Setter');
                                _railGrade2 = newValue;
                              }),

                          //Rail Grade 2
                          Padding(
                            padding: EdgeInsets.only(bottom: 8.0, top: 20),
                            child: Text(
                              'Rail Grades - Rail 2',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 1.7 * SizeConfig.heightMultiplier,
                                color: const Color(0xffa1a1a1),
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          DropDownField(
                              onValueChanged: (dynamic s) {
                                print(s);
                                setState(() {
                                  _railGrade1 = s;
                                });
                              },
                              textStyle: TextStyle(
                                  height: 0.9,
                                  fontFamily: 'Poppins',
                                  fontSize:
                                  1.84 * SizeConfig.heightMultiplier),
                              value: _railGrade1,
                              required: false,
                              hintText: 'Choose a Rail Grade',
                              hintStyle: TextStyle(
                                  height: 1.0,
                                  fontFamily: 'Poppins',
                                  fontSize:
                                  1.84 * SizeConfig.heightMultiplier),
                              items: railGradeList,
                              strict: true,
                              setter: (dynamic newValue) {
                                print('Setter');
                                _railGrade1 = newValue;
                              }),

                          //Rail Type
                          Padding(
                            padding: EdgeInsets.only(bottom: 8.0, top: 20),
                            child: Text(
                              'Rail Type',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 1.7 * SizeConfig.heightMultiplier,
                                color: const Color(0xffa1a1a1),
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          DropDownField(
                              onValueChanged: (dynamic s) {
                                print(s);
                                setState(() {
                                  _railType = s;
                                });
                              },
                              textStyle: TextStyle(
                                  height: 0.9,
                                  fontFamily: 'Poppins',
                                  fontSize:
                                  1.84 * SizeConfig.heightMultiplier),
                              value: _railType,
                              required: false,
                              hintText: 'Choose a Rail Type',
                              hintStyle: TextStyle(
                                  height: 1.0,
                                  fontFamily: 'Poppins',
                                  fontSize:
                                  1.84 * SizeConfig.heightMultiplier),
                              items: ['Plain','Switch','Taper','JXN'].map(
                                    (String dropdownitem) {
                                  return dropdownitem;
                                },
                              ).toList(),
                              strict: true,
                              setter: (dynamic newValue) {
                                print('Setter');
                                _railType = newValue;
                              }),

                          //NDT
                          Padding(
                            padding: EdgeInsets.only(bottom: 8.0, top: 20),
                            child: Text(
                              'NDT (Part Worn Only)',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 1.7 * SizeConfig.heightMultiplier,
                                color: const Color(0xffa1a1a1),
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          DropDownField(
                              onValueChanged: (dynamic s) {
                                print(s);
                                setState(() {
                                  _ndt = s;
                                });
                              },
                              textStyle: TextStyle(
                                  height: 0.9,
                                  fontFamily: 'Poppins',
                                  fontSize:
                                  1.84 * SizeConfig.heightMultiplier),
                              value: _ndt,
                              required: false,
                              hintText: 'Choose NDT',
                              hintStyle: TextStyle(
                                  height: 1.0,
                                  fontFamily: 'Poppins',
                                  fontSize:
                                  1.84 * SizeConfig.heightMultiplier),
                              items: ['Yes','No','N/A'].map(
                                    (String dropdownitem) {
                                  return dropdownitem;
                                },
                              ).toList(),
                              strict: true,
                              setter: (dynamic newValue) {
                                print('Setter');
                                _ndt = newValue;
                              }),

                          //Weld Type
                          Padding(
                            padding: EdgeInsets.only(top: 20),
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
                              onValueChanged: (dynamic s) {
                                print(s);
                                setState(() {
                                  _weldType = s;
                                });
                              },
                              textStyle: TextStyle(
                                  height: 0.9,
                                  fontFamily: 'Poppins',
                                  fontSize:
                                  1.84 * SizeConfig.heightMultiplier),
                              value: _weldType,
                              required: false,
                              hintText: 'Choose a Weld Type',
                              hintStyle: TextStyle(
                                  height: 1.0,
                                  fontFamily: 'Poppins',
                                  fontSize:
                                  1.84 * SizeConfig.heightMultiplier),
                              items: ['New','Worn','Step','JXN'].map(
                                    (String dropdownitem) {
                                  return dropdownitem;
                                },
                              ).toList(),
                              strict: true,
                              setter: (dynamic newValue) {
                                print('Setter');
                                _weldType = newValue;
                              }),

                          //Weld Batch Number
                          Padding(
                            padding: EdgeInsets.only(bottom: 8.0, top: 20),
                            child: Text(
                              'Weld Batch Number',
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
                                    return 'Provide Batch Number';
                                  }
                                },
                                controller: ctrlweldBatchNumber,maxLength: 6,
                                textAlign: TextAlign.center,
                                onChanged: (value) {
                                  _weldBatchNumber = value;
                                },
                                style: TextStyle(
                                    fontFamily: 'Poppins', fontSize: 1.84 * SizeConfig.heightMultiplier),
                                decoration: kTextFieldDecorationNoback.copyWith(
                                  hintText: '',contentPadding: EdgeInsets.symmetric(vertical: 1.5 * SizeConfig.heightMultiplier, horizontal: 20.0),)
                            ),
                            width: 68.2 * SizeConfig.widthMultiplier,
                          ),

                          // Stress Management
                          Padding(
                            padding: EdgeInsets.only(bottom: 8.0, top: 20),
                            child: Text(
                              'Stress Management',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 1.7 * SizeConfig.heightMultiplier,
                                color: const Color(0xffa1a1a1),
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          DropDownField(
                              onValueChanged: (dynamic s) {
                                print(s);
                                setState(() {
                                  _stressManagement = s;
                                });
                              },
                              textStyle: TextStyle(
                                  height: 0.9,
                                  fontFamily: 'Poppins',
                                  fontSize:
                                  1.84 * SizeConfig.heightMultiplier),
                              value: _stressManagement,
                              required: false,
                              hintText: 'Choose Stress Management',
                              hintStyle: TextStyle(
                                  height: 1.0,
                                  fontFamily: 'Poppins',
                                  fontSize:
                                  1.84 * SizeConfig.heightMultiplier),
                              items: ['Tensors','CT','HT','Free'].map(
                                    (String dropdownitem) {
                                  return dropdownitem;
                                },
                              ).toList(),
                              strict: true,
                              setter: (dynamic newValue) {
                                print('Setter');
                                _stressManagement = newValue;
                              }),

                          //Fine Weather
                          Padding(
                            padding: EdgeInsets.only(bottom: 8.0, top: 20),
                            child: Text(
                              'Fine Weather?',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 1.7 * SizeConfig.heightMultiplier,
                                color: const Color(0xffa1a1a1),
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          DropDownField(
                              onValueChanged: (dynamic s) {
                                print(s);
                                setState(() {
                                  _fineWeather = s;
                                });
                              },
                              textStyle: TextStyle(
                                  height: 0.9,
                                  fontFamily: 'Poppins',
                                  fontSize:
                                  1.84 * SizeConfig.heightMultiplier),
                              value: _fineWeather,
                              required: false,
                              hintText: 'Choose Weather',
                              hintStyle: TextStyle(
                                  height: 1.0,
                                  fontFamily: 'Poppins',
                                  fontSize:
                                  1.84 * SizeConfig.heightMultiplier),
                              items: ['Hot','Cold','Showers','Rain','Cloudy','Fog','100% Humidity','Intermittent Showers'].map(
                                    (String dropdownitem) {
                                  return dropdownitem;
                                },
                              ).toList(),
                              strict: true,
                              setter: (dynamic newValue) {
                                print('Setter');
                                _fineWeather = newValue;
                              }),

                          //Data Marks Before
                          Padding(
                            padding: EdgeInsets.only(bottom: 1.05 * SizeConfig.heightMultiplier, top: 2.63 * SizeConfig.heightMultiplier),
                            child: Text(
                              'Data Marks - Before',
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

                                    Checkbox(value: _datamarkBeforeEnter,
                                        activeColor: kShadeColor1,
                                        onChanged: (bool newvalue){
                                          setState(() {
                                            print(newvalue);
                                            ctrlDataMarkBeforeFinal.text='';
                                            _datamarkBeforeEnter = newvalue;
                                            _datamarkBeforeNA = !newvalue;
                                          });
                                        }),
                                    Text('Enter Data Mark'),
                                    Checkbox(value: _datamarkBeforeNA,
                                        activeColor: kShadeColor1,
                                        onChanged: (bool newvalue){
                                          setState(() {
                                            print(newvalue);
                                            ctrlDataMarkBeforeFinal.text='N/A';
                                            _datamarkBeforeNA = newvalue;
                                            _datamarkBeforeEnter = !newvalue;
                                          });
                                        }),
                                    Text('N/A'),
                                  ],
                                ),
                                Visibility(visible: _datamarkBeforeEnter,
                                  child: Container(
                                    child: TextFormField(
                                        validator: (String value){
                                          if(((value.isEmpty || value.contains('N/A')) && _datamarkBeforeEnter==true)){
                                            return 'Provide Data Marks';
                                          }
                                        },
                                        maxLength: 5,
                                        keyboardType: TextInputType.number,
                                        controller: ctrlDataMarkBeforeFinal,
                                        textAlign: TextAlign.center,
                                        onChanged: (value) {
                                          _datamarkBeforeFinal = value;
                                        },
                                        style: TextStyle(
                                            fontFamily: 'Poppins', fontSize: 1.84 * SizeConfig.heightMultiplier),
                                        decoration: kTextFieldDecorationNoback.copyWith(
                                          hintText: '',contentPadding: EdgeInsets.symmetric(vertical: 1.5 * SizeConfig.heightMultiplier, horizontal: 20.0),)
                                    ),

                                  ),
                                ),
                              ],
                            ),
//                          height: 5.65 * SizeConfig.heightMultiplier,
                            width: 68.2 * SizeConfig.widthMultiplier,
//                          height: 5.65 * SizeConfig.heightMultiplier,
                          ),

                          //Data Marks After
                          Padding(
                            padding: EdgeInsets.only(bottom: 1.05 * SizeConfig.heightMultiplier, top: 2.63 * SizeConfig.heightMultiplier),
                            child: Text(
                              'Data Marks - After',
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

                                    Checkbox(value: _datamarkAfterEnter,
                                        activeColor: kShadeColor1,
                                        onChanged: (bool newvalue){
                                          setState(() {
                                            print(newvalue);
                                            ctrlDataMarkAfterFinal.text='';
                                            _datamarkAfterEnter = newvalue;
                                            _datamarkAftereNA = !newvalue;
                                          });
                                        }),
                                    Text('Enter Data Mark'),
                                    Checkbox(value: _datamarkAftereNA,
                                        activeColor: kShadeColor1,
                                        onChanged: (bool newvalue){
                                          setState(() {
                                            print(newvalue);
                                            ctrlDataMarkAfterFinal.text='N/A';
                                            _datamarkAftereNA = newvalue;
                                            _datamarkAfterEnter = !newvalue;
                                          });
                                        }),
                                    Text('N/A'),
                                  ],
                                ),
                                Visibility(visible: _datamarkAfterEnter,
                                  child: Container(
                                    child: TextFormField(
                                        validator: (String value){
                                          if(((value.isEmpty || value.contains('N/A')) && _datamarkAfterEnter==true)){
                                            return 'Provide Data Marks';
                                          }
                                        },
                                        maxLength: 5,
                                        keyboardType: TextInputType.number,
                                        controller: ctrlDataMarkAfterFinal,
                                        textAlign: TextAlign.center,
                                        onChanged: (value) {
                                          _datamarkAfterFinal = value;
                                        },
                                        style: TextStyle(
                                            fontFamily: 'Poppins', fontSize: 1.84 * SizeConfig.heightMultiplier),
                                        decoration: kTextFieldDecorationNoback.copyWith(
                                          hintText: '',contentPadding: EdgeInsets.symmetric(vertical: 1.5 * SizeConfig.heightMultiplier, horizontal: 20.0),)
                                    ),

                                  ),
                                ),
                              ],
                            ),
//                          height: 5.65 * SizeConfig.heightMultiplier,
                            width: 68.2 * SizeConfig.widthMultiplier,
//                          height: 5.65 * SizeConfig.heightMultiplier,
                          ),

                          Padding(
                            padding: EdgeInsets.only( top: 20),
                            child: Text(
                              'Finished Weld Alignments',
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

                          //Weld Grinder
                          Padding(
                            padding: EdgeInsets.only(bottom: 1.05 * SizeConfig.heightMultiplier, top: 2.63 * SizeConfig.heightMultiplier),
                            child: Text(
                              'Weld Grinder',
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
                                    Checkbox(value: _weldGrinderMe,
                                        activeColor: kShadeColor1,
                                        onChanged: (bool newvalue){
                                          if(newvalue==true){
                                            setState(() {
                                              print(newvalue);
                                              ctrlWeldGrinderManual.text='Me';
                                              _weldGrinderManual='Me';
                                              ctrlWeldGrinderManualCount.text='';
                                              ctrlWeldGrinderManualLicence.text='';
                                              _weldGrinderMe = newvalue;
                                              _weldGrinderManualEnterName = !newvalue;
                                              _weldGrinderLeaveBlank = !newvalue;
                                              _weldGrinderManualEnterNameNA = !newvalue;
                                            });
                                          }
                                        }),
                                    Text('Me'),
                                    Checkbox(value: _weldGrinderManualEnterName,
                                        activeColor: kShadeColor1,
                                        onChanged: (bool newvalue){
                                          if(newvalue==true){
                                            setState(() {
                                              print(newvalue);
                                              ctrlWeldGrinderManual.text='';
                                              _weldGrinderManual='';
                                              _weldGrinderManualEnterName = newvalue;
                                              _weldGrinderMe = !newvalue;
                                              _weldGrinderLeaveBlank = !newvalue;
                                              _weldGrinderManualEnterNameNA = !newvalue;
                                            });
                                          }
                                        },),
                                    Text('Manually Enter Name'),
                                  ],

                                ),
                                Row(
                                  children: [
                                    Checkbox(value: _weldGrinderLeaveBlank,
                                        activeColor: kShadeColor1,
                                        onChanged: (bool newvalue){
                                          if(newvalue==true){
                                            setState(() {
                                              print(newvalue);
                                              ctrlWeldGrinderManual.text='';
                                              _weldGrinderManual='';
                                              _weldGrinderLeaveBlank = newvalue;
                                              _weldGrinderManualEnterNameNA = !newvalue;
                                              _weldGrinderManualEnterName = !newvalue;
                                              _weldGrinderMe = !newvalue;
                                            });
                                          }
                                        }),
                                    Text('Leave Blank'),
                                    Checkbox(value: _weldGrinderManualEnterNameNA,
                                        activeColor: kShadeColor1,
                                        onChanged: (bool newvalue){
                                          if(newvalue==true){
                                            setState(() {
                                              print(newvalue);
                                              ctrlWeldGrinderManual.text='N/A';
                                              _weldGrinderManual='N/A';
                                              _weldGrinderManualEnterNameNA = newvalue;
                                              _weldGrinderLeaveBlank = !newvalue;
                                              _weldGrinderManualEnterName = !newvalue;
                                              _weldGrinderMe = !newvalue;
                                            });
                                          }
                                        }),
                                    Text('N/A'),
                                  ],
                                ),
                                Visibility(visible: !_weldGrinderMe,
                                  child: Container(
                                    child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Visibility(visible: _weldGrinderManualEnterName,
                                          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [Padding(
                                              padding: EdgeInsets.only(bottom: 1.05 * SizeConfig.heightMultiplier, top: 2.63 * SizeConfig.heightMultiplier),
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
                                              TextFormField(validator: (String value){
                                                if(_weldGrinderManualEnterName==true && (_weldGrinderManual == null ||_weldGrinderManual.contains('N/A'))){
                                                  return 'Provide Grinder';
                                                }
                                              },
                                                  controller: ctrlWeldGrinderManual,
                                                  textAlign: TextAlign.center,
                                                  onChanged: (value) {
                                                    _weldGrinderManual = value;
                                                    print(_weldGrinderManual);
                                                  },
                                                  style: TextStyle(
                                                      fontFamily: 'Poppins', fontSize: 1.84 * SizeConfig.heightMultiplier),
                                                  decoration: kTextFieldDecorationNoback.copyWith(
                                                    hintText: '',contentPadding: EdgeInsets.symmetric(vertical: 1.5 * SizeConfig.heightMultiplier, horizontal: 20.0),)
                                              ),
                                            ],
                                          ),
                                        ),
                                        // SizedBox(height: 2 * SizeConfig.heightMultiplier,),
                                        Padding(
                                          padding: EdgeInsets.only(bottom: 1.05 * SizeConfig.heightMultiplier, top: 2.63 * SizeConfig.heightMultiplier),
                                          child: Text(
                                            'Licence Number',
                                            style: TextStyle(
                                              fontFamily: 'Poppins',
                                              fontSize: 1.7 * SizeConfig.heightMultiplier,
                                              color: const Color(0xffa1a1a1),
                                            ),
                                            textAlign: TextAlign.left,
                                          ),
                                        ),
                                        TextFormField(
                                            validator: (String value){
                                              if(_weldGrinderMe == false && _weldGrinderManualLicence == null){
                                                return 'Provide Licence Number';
                                              }
                                            },
                                            controller: ctrlWeldGrinderManualLicence,
                                            textAlign: TextAlign.center,
                                            onChanged: (value) {
                                              _weldGrinderManualLicence = value;
                                            },
                                            style: TextStyle(
                                                fontFamily: 'Poppins', fontSize: 1.84 * SizeConfig.heightMultiplier),
                                            decoration: kTextFieldDecorationNoback.copyWith(
                                              hintText: '',contentPadding: EdgeInsets.symmetric(vertical: 1.5 * SizeConfig.heightMultiplier, horizontal: 20.0),)
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(bottom: 1.05 * SizeConfig.heightMultiplier, top: 2.63 * SizeConfig.heightMultiplier),
                                          child: Text(
                                            'Weld Count Number',
                                            style: TextStyle(
                                              fontFamily: 'Poppins',
                                              fontSize: 1.7 * SizeConfig.heightMultiplier,
                                              color: const Color(0xffa1a1a1),
                                            ),
                                            textAlign: TextAlign.left,
                                          ),
                                        ),
                                        TextFormField(keyboardType: TextInputType.number
                                        ,validator: (String value){
                                          if(_weldGrinderMe==false && _weldGrinderManualCount == null){
                                            return 'Provide Weld Count Number';
                                          }
                                        },controller: ctrlWeldGrinderManualCount,
                                            textAlign: TextAlign.center,
                                            onChanged: (value) {
                                              _weldGrinderManualCount = value;
                                            },
                                            style: TextStyle(
                                                fontFamily: 'Poppins', fontSize: 1.84 * SizeConfig.heightMultiplier),
                                            decoration: kTextFieldDecorationNoback.copyWith(
                                              hintText: '',contentPadding: EdgeInsets.symmetric(vertical: 1.5 * SizeConfig.heightMultiplier, horizontal: 20.0),)
                                        ),
                                      ],
                                    ),

                                  ),),

                              ],
                            ),
//                          height: 5.65 * SizeConfig.heightMultiplier,
                            width: 68.2 * SizeConfig.widthMultiplier,
//                          height: 5.65 * SizeConfig.heightMultiplier,
                          ),

                          //Straight Edge Type
                          Padding(
                            padding: EdgeInsets.only(bottom: 8.0, top: 20),
                            child: Text(
                              'Straight Edge Type',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 1.7 * SizeConfig.heightMultiplier,
                                color: const Color(0xffa1a1a1),
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          DropDownField(
                              onValueChanged: (dynamic s) {
                                print(s);
                                setState(() {
                                  _straightEdgeType = s;
                                });
                              },
                              textStyle: TextStyle(
                                  height: 0.9,
                                  fontFamily: 'Poppins',
                                  fontSize:
                                  1.84 * SizeConfig.heightMultiplier),
                              value: _straightEdgeType,
                              required: false,
                              hintText: 'Choose Straight Edge',
                              hintStyle: TextStyle(
                                  height: 1.0,
                                  fontFamily: 'Poppins',
                                  fontSize:
                                  1.84 * SizeConfig.heightMultiplier),
                              items: ['Flat','Nibbed','Electronic','N/A'].map(
                                    (String dropdownitem) {
                                  return dropdownitem;
                                },
                              ).toList(),
                              strict: true,
                              setter: (dynamic newValue) {
                                print('Setter');
                                _straightEdgeType = newValue;
                              }),

                          //Vertical Alignment
                          Padding(
                            padding: EdgeInsets.only(bottom: 1.05 * SizeConfig.heightMultiplier, top: 2.63 * SizeConfig.heightMultiplier),
                            child: Text(
                              'Vertical Alignment of Running Surface (mm)',
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

                                    Checkbox(value: _addVerticalAlignmentEnter,
                                        activeColor: kShadeColor1,
                                        onChanged: (bool newvalue){
                                          setState(() {
                                            print(newvalue);
                                            ctrladdVerticalAlignmentFinal.text='';
                                            _addVerticalAlignmentEnter = newvalue;
                                            _addVerticalAlignmentNA = !newvalue;
                                          });
                                        }),
                                    Text('Add Alignment'),
                                    Checkbox(value: _addVerticalAlignmentNA,
                                        activeColor: kShadeColor1,
                                        onChanged: (bool newvalue){
                                          setState(() {
                                            print(newvalue);
                                            ctrladdVerticalAlignmentFinal.text='N/A';
                                            _addVerticalAlignmentNA = newvalue;
                                            _addVerticalAlignmentEnter = !newvalue;
                                          });
                                        }),
                                    Text('N/A'),
                                  ],
                                ),
                                Visibility(visible: _addVerticalAlignmentEnter,
                                  child: Container(
                                    child: TextFormField(
                                        validator: (String value){
                                      if(((value.isEmpty || value.contains('N/A')) && _addVerticalAlignmentEnter==true)){
                                        return 'Provide Alignment';
                                      }
                                    },
                                        keyboardType: TextInputType.number,
                                        controller: ctrladdVerticalAlignmentFinal,
                                        textAlign: TextAlign.center,
                                        onChanged: (value) {
                                          _addVerticalAlignmentFinal = value;
                                        },
                                        style: TextStyle(
                                            fontFamily: 'Poppins', fontSize: 1.84 * SizeConfig.heightMultiplier),
                                        decoration: kTextFieldDecorationNoback.copyWith(
                                          hintText: '',contentPadding: EdgeInsets.symmetric(vertical: 1.5 * SizeConfig.heightMultiplier, horizontal: 20.0),)
                                    ),

                                  ),
                                ),
                              ],
                            ),
//                          height: 5.65 * SizeConfig.heightMultiplier,
                            width: 68.2 * SizeConfig.widthMultiplier,
//                          height: 5.65 * SizeConfig.heightMultiplier,
                          ),

                          //Horizontal Alignment
                          Padding(
                            padding: EdgeInsets.only(bottom: 1.05 * SizeConfig.heightMultiplier, top: 2.63 * SizeConfig.heightMultiplier),
                            child: Text(
                              'Horizontal Alignment of Gauge Face (mm)',
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

                                    Checkbox(value: _addHorizontalAlignmentEnter,
                                        activeColor: kShadeColor1,
                                        onChanged: (bool newvalue){
                                          setState(() {
                                            print(newvalue);
                                            ctrladdHorizontalAlignmentFinal.text='';
                                            _addHorizontalAlignmentEnter = newvalue;
                                            _addHorizontalAlignmentNA = !newvalue;
                                          });
                                        }),
                                    Text('Add Alignment'),
                                    Checkbox(value: _addHorizontalAlignmentNA,
                                        activeColor: kShadeColor1,
                                        onChanged: (bool newvalue){
                                          setState(() {
                                            print(newvalue);
                                            ctrladdHorizontalAlignmentFinal.text='N/A';
                                            _addHorizontalAlignmentNA = newvalue;
                                            _addHorizontalAlignmentEnter = !newvalue;
                                          });
                                        }),
                                    Text('N/A'),
                                  ],
                                ),
                                Visibility(visible: _addHorizontalAlignmentEnter,
                                  child: Container(
                                    child: TextFormField(
                                        validator: (String value){
                                          if(((value.isEmpty || value.contains('N/A')) && _addHorizontalAlignmentEnter==true)){
                                            return 'Provide Alignment';
                                          }
                                        },
                                        keyboardType: TextInputType.number,
                                        controller: ctrladdHorizontalAlignmentFinal,
                                        textAlign: TextAlign.center,
                                        onChanged: (value) {
                                          _addHorizontalAlignmentFinal = value;
                                        },
                                        style: TextStyle(
                                            fontFamily: 'Poppins', fontSize: 1.84 * SizeConfig.heightMultiplier),
                                        decoration: kTextFieldDecorationNoback.copyWith(
                                          hintText: '',contentPadding: EdgeInsets.symmetric(vertical: 1.5 * SizeConfig.heightMultiplier, horizontal: 20.0),)
                                    ),

                                  ),
                                ),
                              ],
                            ),
//                          height: 5.65 * SizeConfig.heightMultiplier,
                            width: 68.2 * SizeConfig.widthMultiplier,
//                          height: 5.65 * SizeConfig.heightMultiplier,
                          ),

                          //Horizontal Alignment Field Face
                          Padding(
                            padding: EdgeInsets.only(bottom: 8.0, top: 20),
                            child: Text(
                              'Horizontal Alignment of Field Face',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 1.7 * SizeConfig.heightMultiplier,
                                color: const Color(0xffa1a1a1),
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          DropDownField(
                              onValueChanged: (dynamic s) {
                                print(s);
                                setState(() {
                                  _horAlignFieldFace = s;
                                });
                              },
                              textStyle: TextStyle(
                                  height: 0.9,
                                  fontFamily: 'Poppins',
                                  fontSize:
                                  1.84 * SizeConfig.heightMultiplier),
                              value: _horAlignFieldFace,
                              required: false,
                              hintText: 'Choose one',
                              hintStyle: TextStyle(
                                  height: 1.0,
                                  fontFamily: 'Poppins',
                                  fontSize:
                                  1.84 * SizeConfig.heightMultiplier),
                              items: ['Yes','No Smooth Ground and Blended','N/A'].map(
                                    (String dropdownitem) {
                                  return dropdownitem;
                                },
                              ).toList(),
                              strict: true,
                              setter: (dynamic newValue) {
                                print('Setter');
                                _horAlignFieldFace = newValue;
                              }),

                          //Gauge Face
                          Padding(
                            padding: EdgeInsets.only(bottom: 8.0, top: 20),
                            child: Text(
                              'Gage Face Angle Transition',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 1.7 * SizeConfig.heightMultiplier,
                                color: const Color(0xffa1a1a1),
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          DropDownField(
                              onValueChanged: (dynamic s) {
                                print(s);
                                setState(() {
                                  _gageFaceAngeTrans = s;
                                });
                              },
                              textStyle: TextStyle(
                                  height: 0.9,
                                  fontFamily: 'Poppins',
                                  fontSize:
                                  1.84 * SizeConfig.heightMultiplier),
                              value: _gageFaceAngeTrans,
                              required: false,
                              hintText: 'Choose one',
                              hintStyle: TextStyle(
                                  height: 1.0,
                                  fontFamily: 'Poppins',
                                  fontSize:
                                  1.84 * SizeConfig.heightMultiplier),
                              items: ['Yes','No Smooth Blended','N/A'].map(
                                    (String dropdownitem) {
                                  return dropdownitem;
                                },
                              ).toList(),
                              strict: true,
                              setter: (dynamic newValue) {
                                print('Setter');
                                _gageFaceAngeTrans = newValue;
                              }),

                          //Comments
                          Padding(
                            padding: EdgeInsets.only(bottom: 8.0, top: 20),
                            child: Text(
                              'Comment',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 1.7 * SizeConfig.heightMultiplier,
                                color: const Color(0xffa1a1a1),
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(bottom: 8.0, top: 20),
                            child: Text(
                              'Choose Standard Comment',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 1.7 * SizeConfig.heightMultiplier,
                                color: const Color(0xffa1a1a1),
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          DropDownField(
                              onValueChanged: (dynamic s) {
                                print(s);
                                setState(() {
                                  _StandardComment = s;
                                });
                              },
                              textStyle: TextStyle(
                                  height: 0.9,
                                  fontFamily: 'Poppins',
                                  fontSize:
                                  1.84 * SizeConfig.heightMultiplier),
                              value: _StandardComment,
                              required: false,
                              hintText: 'Choose Comment',
                              hintStyle: TextStyle(
                                  height: 1.0,
                                  fontFamily: 'Poppins',
                                  fontSize:
                                  1.84 * SizeConfig.heightMultiplier),
                              items: standardCommentList,
                              strict: true,
                              setter: (dynamic newValue) {
                                print('Setter');
                                _StandardComment = newValue;
                              }),

                          SizedBox(
                            height: 2.6 * SizeConfig.heightMultiplier,
                          ),
                          Container(
                            child: TextFormField(maxLength: 100,maxLines: 5,
                                textAlign: TextAlign.center,
                                onChanged: (value) {
                                  _comments = value;
                                },
                                style: TextStyle(
                                    fontFamily: 'Poppins', fontSize: 1.84 * SizeConfig.heightMultiplier),
                                decoration: kTextFieldDecorationNoback.copyWith(
                                  hintText: '',contentPadding: EdgeInsets.symmetric(vertical: 1.5 * SizeConfig.heightMultiplier, horizontal: 20.0),)
                            ),
                            width: 68.2 * SizeConfig.widthMultiplier,
                          ),
                          SizedBox(
                            height: 2.6 * SizeConfig.heightMultiplier,
                          ),
                          Container(
                            width: 68.2 * SizeConfig.widthMultiplier,
                            height: 5.65 * SizeConfig.heightMultiplier,
                            child: RaisedButton(color: kShadeColor1,
                              onPressed: () async {
                                setState(() {
                                  _waiting = true;
                                });
                              print('https://radreviews.online/app/REST/EasyRails/App_Create_AW_WeldReport?WeldDate=${_weldDate.day}/${_weldDate.month}/${_weldDate.year}&WorkOrderFinal=$_workOrderFinal&AW_System=$_selectedAurizonSystem&Kilometrage=$_kilometrage&Road=$_road&FlocFinal=$_FlocFinal&RailType=$_railType&Rail=$_rail&ReasonForWeldFinal=$_reasonForWeldFinal&RailTempFinal=$_railTempFinal&RailSize1=$_railSize1&RailSize2=$_railSize2&NDT=$_ndt&Weld_Type=$_weldType&WeldBatchNumber=$_weldBatchNumber&Stress_Management=$_stressManagement&DataMarksAfterFinal=$_datamarkAfterFinal&DataMarksBeforeFinal=$_datamarkBeforeFinal&Straight_Edge_Type=$_straightEdgeType&VertAlignofRunSurfFinal=$_addVerticalAlignmentFinal&HorAlignofGaugeFaceFinal=$_addHorizontalAlignmentFinal&HorAlignofFieldFace=$_horAlignFieldFace&GageFaceAngleTrans=$_gageFaceAngeTrans&FineWeather=$_fineWeather&WelderID=$_weldGrinderManual&CommentFromTemplate=$_StandardComment&Comments=$_comments&WeldCountManual=$_weldGrinderManualCount&RailGradeText1=$_railGrade1&RailGradeText2=$_railGrade2&WeldLicenceManual=$_weldGrinderManualLicence&WeldProcessGrade=$_weldProcessGrade&SystemUserID=$loggedinUserID');
                              bool connectionValilable = await checkConnectionNoListner();

                                if (_formKeyWeldReturn.currentState.validate()) {
                                  _validate();
                                  if(_isWeldReurnvalid==true){
                                    if(connectionValilable != true){
                                      String _stringWelddate = '${_weldDate.day}/${_weldDate.month}/${_weldDate.year}';
                                      String _apiURL =  kBaseURL +'REST/EasyRails/App_Create_AW_WeldReport?WeldDate=${_weldDate.day}/${_weldDate.month}/${_weldDate.year}&WorkOrderFinal=$_workOrderFinal&AW_System=$_selectedAurizonSystem&Kilometrage=$_kilometrage&Road=$_road&FlocFinal=$_FlocFinal&RailType=$_railType&Rail=$_rail&ReasonForWeldFinal=$_reasonForWeldFinal&RailTempFinal=$_railTempFinal&RailSize1=$_railSize1&RailSize2=$_railSize2&NDT=$_ndt&Weld_Type=$_weldType&WeldBatchNumber=$_weldBatchNumber&Stress_Management=$_stressManagement&DataMarksAfterFinal=$_datamarkAfterFinal&DataMarksBeforeFinal=$_datamarkBeforeFinal&Straight_Edge_Type=$_straightEdgeType&VertAlignofRunSurfFinal=$_addVerticalAlignmentFinal&HorAlignofGaugeFaceFinal=$_addHorizontalAlignmentFinal&HorAlignofFieldFace=$_horAlignFieldFace&GageFaceAngleTrans=$_gageFaceAngeTrans&FineWeather=$_fineWeather&WelderID=$_weldGrinderManual&CommentFromTemplate=$_StandardComment&Comments=$_comments&WeldCountManual=$_weldGrinderManualCount&RailGradeText1=$_railGrade1&RailGradeText2=$_railGrade2&WeldLicenceManual=$_weldGrinderManualLicence&WeldProcessGrade=$_weldProcessGrade&SystemUserID=$loggedinUserID';
                                      print(_apiURL);
                                      sharedPreferences = await SharedPreferences.getInstance();
                                      unSyncWeldReturn= sharedPreferences.getStringList('unSyncWeldReturn');
                                      print(unSyncWeldReturn.length);
                                      int _id = sharedPreferences.getInt('ID');
                                      print('New sharedPreferences ID');
                                      print(_id);
                                      WeldReturn weldReturn = WeldReturn(tempweldDate: _stringWelddate,tempworkOrderFinal:_workOrderFinal,tempselectedAurizonSystem: _selectedAurizonSystem,tempkilometrage: _kilometrage,temproad: _road,tempFlocFinal: _FlocFinal,temprailType: _railType,temprail: _rail,tempreasonForWeldFinal: _reasonForWeldFinal,temprailTempFinal: _railTempFinal,temprailSize1: _railSize1,temprailSize2: _railSize2,tempndt: _ndt,tempweldType: _weldType,tempweldBatchNumber: _weldBatchNumber,tempstressManagement: _stressManagement,tempdatamarkAfterFinal: _datamarkAfterFinal,tempdatamarkBeforeFinal: _datamarkBeforeFinal,tempstraightEdgeType: _straightEdgeType,tempaddVerticalAlignmentFinal: _addVerticalAlignmentFinal,tempaddHorizontalAlignmentFinal: _addHorizontalAlignmentFinal,tempweldGrinderManual:_weldGrinderManual,temphorAlignFieldFace: _horAlignFieldFace,tempgageFaceAngeTrans: _gageFaceAngeTrans,tempfineWeather: _fineWeather,tempcomments: _comments,tempStandardComment: _StandardComment,temprailGrade1: _railGrade1,temprailGrade2: _railGrade2,apiURL: _apiURL,tempweldGrinderManualCount: _weldGrinderManualCount,tempweldGrinderManualLicence: _weldGrinderManualLicence,tempweldProcessGrade:_weldProcessGrade,id: _id);
                                      _id = _id+1;
                                      sharedPreferences.setInt('ID', _id);
                                      print('old sharedPreferences ID');
                                      print(_id);
                                      var tempJson = jsonEncode(weldReturn.tojson());
                                      unSyncWeldReturn.add(tempJson);
                                      sharedPreferences.setStringList('unSyncWeldReturn', unSyncWeldReturn);
                                      print('New');
                                      print(unSyncWeldReturn.length);
                                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>XDMenu()));
                                    }
                                    else{
                                      http.Response _response =await  http.get(kBaseURL +
                                          'REST/EasyRails/App_Create_AW_WeldReport?WeldDate=${_weldDate.day}/${_weldDate.month}/${_weldDate.year}&WorkOrderFinal=$_workOrderFinal&AW_System=$_selectedAurizonSystem&Kilometrage=$_kilometrage&Road=$_road&FlocFinal=$_FlocFinal&RailType=$_railType&Rail=$_rail&ReasonForWeldFinal=$_reasonForWeldFinal&RailTempFinal=$_railTempFinal&RailSize1=$_railSize1&RailSize2=$_railSize2&NDT=$_ndt&Weld_Type=$_weldType&WeldBatchNumber=$_weldBatchNumber&Stress_Management=$_stressManagement&DataMarksAfterFinal=$_datamarkAfterFinal&DataMarksBeforeFinal=$_datamarkBeforeFinal&Straight_Edge_Type=$_straightEdgeType&VertAlignofRunSurfFinal=$_addVerticalAlignmentFinal&HorAlignofGaugeFaceFinal=$_addHorizontalAlignmentFinal&HorAlignofFieldFace=$_horAlignFieldFace&GageFaceAngleTrans=$_gageFaceAngeTrans&FineWeather=$_fineWeather&WelderID=$_weldGrinderManual&CommentFromTemplate=$_StandardComment&Comments=$_comments&WeldCountManual=$_weldGrinderManualCount&RailGradeText1=$_railGrade1&RailGradeText2=$_railGrade2&WeldLicenceManual=$_weldGrinderManualLicence&WeldProcessGrade=$_weldProcessGrade&SystemUserID=$loggedinUserID');
                                      try{
                                        print(_response.body);
                                        var _responseBody = _response.body;
                                        error = jsonDecode(_responseBody)['Error'];
                                        if(error != 'No Error'){
                                          await ShowFlushbar('Error',error,Icons.close,context);
                                          setState(() {
                                            _waiting = false;
                                          });
                                        }
                                        else{
                                          setState(() {
                                            _waiting = false;
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
                                              'You have successfully create a Weld Report',
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
                                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>XDMenu()));
                                        }
                                      }
                                      catch(e){ShowFlushbar('Error','Something went wrong',Icons.close,context);}


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
                                    fontSize: 2.0 *SizeConfig.heightMultiplier,
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

  Future<DateTime> pickDate() async{
    DateTime pickedDateTime =await showDatePicker(
        context: context,
        initialDate: _weldDate,
        firstDate: DateTime(DateTime.now().year-1),
        lastDate: DateTime.now());
    if(pickedDateTime !=null){
      setState(() {
        _weldDate=pickedDateTime;
      });
    }
    return pickedDateTime;
  }
}

class WeldReturn{
  int id;
  String tempweldDate;
  bool tempworkorderNA;
  bool tempworkOrderEnter;
  String tempworkOrderFinal;
  String tempweldProcessGrade;
  bool tempFlocNA;
  bool tempFlocEnter;
  String tempFlocFinal;
  bool temprailTempNA;
  bool temprailTempEnter;
  String temprailTempFinal;
  bool tempdatamarkBeforeNA;
  bool tempdatamarkBeforeEnter;
  String tempdatamarkBeforeFinal;
  bool tempdatamarkAftereNA;
  bool tempdatamarkAfterEnter;
  String tempdatamarkAfterFinal;
  bool tempweldGrinderMe;
  bool tempweldGrinderManualEnterName;
  bool tempweldGrinderLeaveBlank;
  bool tempweldGrinderManualEnterNameNA;
  bool tempaddVerticalAlignmentNA;
  bool tempaddVerticalAlignmentEnter;
  String tempaddVerticalAlignmentFinal;
  bool tempaddHorizontalAlignmentNA;
  bool tempaddHorizontalAlignmentEnter;
  String tempaddHorizontalAlignmentFinal;
  String tempweldGrinderManual;
  String tempweldGrinderManualCount;
  String tempweldGrinderManualLicence;
  bool tempreasonForWeldNew;
  bool tempreasonForWeldDefect;
  String tempreasonForWeldFinal;
  String tempstraightEdgeType;
  String temphorAlignFieldFace;
  String tempgageFaceAngeTrans;
  String tempcomments;
  String tempStandardComment;
  String temprailGrade1;
  String temprailGrade2;
  String temploggedinUserID;
  String tempselectedAurizonSystem;
  String tempkilometrage;
  String temproad;
  String temprail;
  String temprailSize1;
  String temprailSize2;
  String temprailType;
  String tempndt;
  String tempweldType;
  String tempweldBatchNumber;
  String tempstressManagement;
  String tempfineWeather;

  String apiURL;

//  Constructor
  WeldReturn({this.tempweldDate,this.tempworkorderNA,this.tempworkOrderEnter,this.tempworkOrderFinal,this.tempFlocNA,this.tempFlocEnter,this.tempFlocFinal,this.temprailTempNA,this.temprailTempEnter,this.temprailTempFinal,this.tempdatamarkBeforeNA,this.tempdatamarkBeforeEnter,this.tempdatamarkBeforeFinal,this.tempdatamarkAftereNA,this.tempdatamarkAfterEnter,this.tempdatamarkAfterFinal,this.tempweldGrinderMe,this.tempweldGrinderManualEnterName,this.tempweldGrinderLeaveBlank,this.tempweldGrinderManualEnterNameNA,this.tempaddVerticalAlignmentNA,this.tempaddVerticalAlignmentEnter,this.tempaddVerticalAlignmentFinal,this.tempaddHorizontalAlignmentNA,this.tempaddHorizontalAlignmentEnter,this.tempaddHorizontalAlignmentFinal,this.tempweldGrinderManual,this.tempreasonForWeldNew,this.tempreasonForWeldDefect,this.tempreasonForWeldFinal,this.tempstraightEdgeType,this.temphorAlignFieldFace,this.tempgageFaceAngeTrans,this.tempcomments,this.temprailGrade1,this.temprailGrade2,this.tempselectedAurizonSystem,this.tempkilometrage,this.temproad,this.temprail,this.temprailSize1,this.temprailSize2,this.temprailType,this.tempndt,this.tempweldType,this.tempweldBatchNumber,this.tempstressManagement,this.tempfineWeather,this.tempStandardComment,this.apiURL,this.tempweldGrinderManualCount,this.tempweldGrinderManualLicence,this.tempweldProcessGrade,this.temploggedinUserID,this.id});

//  this map will convert object in json
  Map<String, dynamic> tojson() =>{
    'tempweldDate' : tempweldDate,
    'tempworkOrderFinal' : tempworkOrderFinal,
    'tempselectedAurizonSystem' : tempselectedAurizonSystem,
    'tempweldProcessGrade' : tempweldProcessGrade,
    'tempkilometrage' : tempkilometrage,
    'temproad' : temproad,
    'tempFlocFinal' : tempFlocFinal,
    'temprailType' : temprailType,
    'temprail' : temprail,
    'tempreasonForWeldFinal' : tempreasonForWeldFinal,
    'temprailTempFinal' : temprailTempFinal,
    'temprailSize1' : temprailSize1,
    'temprailSize2' : temprailSize2,
    'temprailGrade1' : temprailGrade1,
    'temprailGrade2' : temprailGrade2,
    'tempndt' : tempndt,
    'tempweldType' : tempweldType,
    'tempweldBatchNumber' : tempweldBatchNumber,
    'tempstressManagement' : tempstressManagement,
    'tempdatamarkAfterFinal' : tempdatamarkAfterFinal,
    'tempdatamarkBeforeFinal' : tempdatamarkBeforeFinal,
    'tempstraightEdgeType' : tempstraightEdgeType,
    'tempaddVerticalAlignmentFinal' : tempaddVerticalAlignmentFinal,
    'tempaddHorizontalAlignmentFinal' : tempaddHorizontalAlignmentFinal,
    'temphorAlignFieldFace' : temphorAlignFieldFace,
    'tempgageFaceAngeTrans' : tempgageFaceAngeTrans,
    'tempfineWeather' : tempfineWeather,
    'tempcomments' : tempcomments,
    'tempStandardComment' : tempStandardComment,
    'apiURL' : apiURL,
    'tempweldGrinderManual' : tempweldGrinderManual,
    'tempweldGrinderManualCount' : tempweldGrinderManualCount,
    'temploggedinUserID' : temploggedinUserID,
    'tempweldGrinderManualLicence' : tempweldGrinderManualLicence,
    'id' : id,
  };

//  this function will convert json into object
  WeldReturn.fromJson(Map<String,dynamic> json):
        tempweldDate = json['tempweldDate'],
        tempworkOrderFinal = json['tempworkOrderFinal'],
        tempselectedAurizonSystem = json['tempselectedAurizonSystem'],
        tempweldProcessGrade = json['tempweldProcessGrade'],
        tempkilometrage = json['tempkilometrage'],
        temproad = json['temproad'],
        tempFlocFinal = json['tempFlocFinal'],
        temprailType = json['temprailType'],
        temprail = json['temprail'],
        tempreasonForWeldFinal = json['tempreasonForWeldFinal'],
        temprailTempFinal = json['temprailTempFinal'],
        temprailSize1 = json['temprailSize1'],
        temprailSize2 = json['temprailSize2'],
        temprailGrade1 = json['temprailGrade1'],
        temprailGrade2 = json['temprailGrade2'],
        tempndt = json['tempndt'],
        tempweldType = json['tempweldType'],
        tempweldBatchNumber = json['tempweldBatchNumber'],
        tempstressManagement = json['tempstressManagement'],
        tempdatamarkAfterFinal = json['tempdatamarkAfterFinal'],
        tempdatamarkBeforeFinal = json['tempdatamarkBeforeFinal'],
        tempstraightEdgeType = json['tempstraightEdgeType'],
        tempaddVerticalAlignmentFinal = json['tempaddVerticalAlignmentFinal'],
        tempaddHorizontalAlignmentFinal = json['tempaddHorizontalAlignmentFinal'],
        temphorAlignFieldFace = json['temphorAlignFieldFace'],
        tempgageFaceAngeTrans = json['tempgageFaceAngeTrans'],
        tempfineWeather = json['tempfineWeather'],
        tempcomments = json['tempcomments'],
        tempStandardComment = json['tempStandardComment'],
        apiURL = json['apiURL'],
        tempweldGrinderManual = json['tempweldGrinderManual'],
        tempweldGrinderManualCount = json['tempweldGrinderManualCount'],
        tempweldGrinderManualLicence = json['tempweldGrinderManualLicence'],
        temploggedinUserID = json['temploggedinUserID'],
        id = json['id'];
}