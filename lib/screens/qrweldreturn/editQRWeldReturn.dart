import 'dart:convert';
import 'package:easy_rails/constants.dart';
import 'package:easy_rails/customdropdown.dart';
import 'package:easy_rails/screens/qrweldreturn/tabQRweldreturn.dart';
import 'package:easy_rails/size_config.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'dart:io' show File, Platform;
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

String device;
SharedPreferences sharedPreferences;
List<String> listUpdateQRWeldReturnUnSynced=[];

var _formKeyWeldReturn = GlobalKey<FormState>();

class EditQRWeldReturn extends StatefulWidget {
  String weldJson;
  EditQRWeldReturn({this.weldJson});
  @override
  _EditQRWeldReturnState createState() => _EditQRWeldReturnState();
}

class _EditQRWeldReturnState extends State<EditQRWeldReturn> {
  DateTime _weldDate;
  DateTime _weldKitDetailsDate;
  String _section;
  String _kilometer;
  String _road;
  String _track;
  String _rail;
  String _weldType;
  String _reasonForWeldFinal;
  String _heatingTrolley;
  String _steelAddedRemoved = 'Added';
  String _steelAddedRemovedmm;
  String _wasRailAdjusted = 'No';
  String _weldBatchNumber;
  String _railKg;
  String _railType;
  double _topPeaked=0.0;
  double _topDipped=0.0;
  double _sidePeaked=0.0;
  double _sideDipped=0.0;
  bool _groundByMe = true;
  bool _groundByManualEnterName = false;
  bool _groundByLeaveBlank = false;
  String _weldGroundByManual;
  String _weldGroundByManualLicence;
  String _weldGroundManualCount;
  String _railTempFinal;
  String _comments;
  String _extID;
  bool _waiting = false;
  String error='No Error';

  var ctrlTopPeaked = TextEditingController();
  var ctrlSidePeaked = TextEditingController();
  var ctrlTopDipped = TextEditingController();
  var ctrlSideDipped = TextEditingController();
  var ctrlGroundByManual = TextEditingController();
  var ctrlGroundByManualCount = TextEditingController();
  var ctrlGroundByManualLicence = TextEditingController();
  var ctrlweldBatchNumber = TextEditingController();
  var ctrlweldLocationTrack = TextEditingController();
  var ctrlsteelAddedRemovedmm = TextEditingController();
  var ctrlSection = TextEditingController();
  var ctrlkilometer = TextEditingController();
  var ctrlRail = TextEditingController();
  var ctrlSteelAddedRemovedmm = TextEditingController();
  var ctrlComment = TextEditingController();
  var ctrlReasonForWeld = TextEditingController();

  void CreateNewWeldReturn(String url) async{
    http.Response _response =await  http.get(url);
    try{
      print(_response.body);
      var _responseBody = _response.body;
      error = jsonDecode(_responseBody)['Error'];
    }
    catch(e){ShowFlushbar('Error','Something went wrong',Icons.close,context);}

  }

  @override
  void initState() {
    setState(() {
      _waiting = true;
    });
    print('Weld Json');
    print(widget.weldJson);
    //Initialize All Data with the picked Record
    _extID = jsonDecode(widget.weldJson)['EXT_ID'].toString();
    _weldDate = jsonDecode(widget.weldJson)["WeldDate"] != null?DateFormat("yyyy-MM-dd hh:mm:ss").parse(jsonDecode(widget.weldJson)["WeldDate"]):DateTime.now();
    _weldKitDetailsDate = jsonDecode(widget.weldJson)["WeldKitDetalsDate"] != null?DateFormat("yyyy-MM-dd hh:mm:ss").parse(jsonDecode(widget.weldJson)["WeldKitDetalsDate"]):DateTime.now();
    ctrlSection.text = _section = jsonDecode(widget.weldJson)["Section"];
    ctrlweldBatchNumber.text = _weldBatchNumber = jsonDecode(widget.weldJson)["BatchNo"];
    ctrlkilometer.text = _kilometer = jsonDecode(widget.weldJson)["Kilometer"].toString();
    print('Weld Json1');
    _road = jsonDecode(widget.weldJson)["Road"];
    _track = jsonDecode(widget.weldJson)['Track'];
    ctrlRail.text = _rail = jsonDecode(widget.weldJson)["Rail"];
    _railTempFinal = jsonDecode(widget.weldJson)['RailTempFinal'];
    _weldType = jsonDecode(widget.weldJson)['Weld_Type'];
    _railKg = jsonDecode(widget.weldJson)['Rail_Kg'];
    _railType = jsonDecode(widget.weldJson)['Rail_Type'];
    print('Weld Json2');
    ctrlReasonForWeld.text = _reasonForWeldFinal = jsonDecode(widget.weldJson)["ReasonForWeldFinal"];
    _heatingTrolley = jsonDecode(widget.weldJson)['HeatingTrolley'];
    _wasRailAdjusted = jsonDecode(widget.weldJson)['WasRailAdjusted'];
    _steelAddedRemoved = jsonDecode(widget.weldJson)['SteelAddedRemoved'];
    ctrlSteelAddedRemovedmm.text = _steelAddedRemovedmm = jsonDecode(widget.weldJson)['SteelAddedRemovedNum'].toString();
    ctrlComment.text = _comments = jsonDecode(widget.weldJson)['Comments'];
    print('Weld Json3');
    _topPeaked = double.parse(jsonDecode(widget.weldJson)['TopPeaked']);
    ctrlTopPeaked.text = _topPeaked.toString();
    _sidePeaked = double.parse(jsonDecode(widget.weldJson)['SidePeaked']);
    ctrlSidePeaked.text = _sidePeaked.toString();
    _topDipped = double.parse(jsonDecode(widget.weldJson)['TopDipped']);
    ctrlTopDipped.text = _topDipped.toString();
    _sideDipped = double.parse(jsonDecode(widget.weldJson)['SideDipped']);
    ctrlSideDipped.text = _sideDipped.toString();
    print('Weld Json4');
    ctrlGroundByManual.text = _weldGroundByManual = jsonDecode(widget.weldJson)["GroundBy"];
    print(jsonDecode(widget.weldJson)["GroundBy"]);
    if(jsonDecode(widget.weldJson)["GroundBy"] == loggedinUserFName+' '+loggedinUserSName){
      print('Me');
      _weldGroundByManual='Me';
      ctrlGroundByManualCount.text='';
      ctrlGroundByManualLicence.text=jsonDecode(widget.weldJson)["License"];
      _groundByMe = true;
      _groundByManualEnterName = false;
      _groundByLeaveBlank = false;
    }
    else if(jsonDecode(widget.weldJson)["GroundBy"] == 'Leave Blank'){
      print('Leave Blank');
      ctrlGroundByManual.text = _weldGroundByManual = jsonDecode(widget.weldJson)["GroundBy"];
      ctrlGroundByManualLicence.text = _weldGroundByManualLicence = jsonDecode(widget.weldJson)["License"];
      ctrlGroundByManualCount.text = _weldGroundManualCount = jsonDecode(widget.weldJson)["QRYearlyWeldCount"].toString();
      _groundByMe = false;
      _groundByManualEnterName = false;
      _groundByLeaveBlank = true;
    }
    else if(jsonDecode(widget.weldJson)["GroundBy"] != 'Leave Blank' && jsonDecode(widget.weldJson)["GroundBy"] != loggedinUserFName+' '+loggedinUserSName){
      print('Manual');
      ctrlGroundByManual.text = _weldGroundByManual = jsonDecode(widget.weldJson)["GroundBy"];
      ctrlGroundByManualLicence.text = _weldGroundByManualLicence = jsonDecode(widget.weldJson)["License"];
      ctrlGroundByManualCount.text = _weldGroundManualCount = jsonDecode(widget.weldJson)["QRYearlyWeldCount"].toString();
      _groundByMe = false;
      _groundByManualEnterName = true;
      _groundByLeaveBlank = false;
    }

    device = Platform.isIOS==true?'IOS':'Android';
    GetGenericDataQR().whenComplete(() {
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
      if(_road == null){
        _isWeldReurnvalid=false;
        ShowFlushbar('Error','Please Provide Road',Icons.close,context);
      }
      else if(_rail == null){
        _isWeldReurnvalid=false;
        ShowFlushbar('Error','Please Provide Rail',Icons.close,context);
      }

      else if(_railType == null){
        _isWeldReurnvalid=false;
        ShowFlushbar('Error','Please Provide Rail Type',Icons.close,context);
      }

    }
    return ModalProgressHUD(
      inAsyncCall: _waiting,
      color: Color(0xff3ba838),
      opacity: 0.1,
      child: Scaffold(
        appBar: AppBar( centerTitle: true,
        title: Text('EDIT WELD RETURN',style: TextStyle(
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

        body: GestureDetector(onTap: (){
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

                            //Section
                            Padding(
                              padding: EdgeInsets.only(bottom: 1.05 * SizeConfig.heightMultiplier, top: 2.63 * SizeConfig.heightMultiplier),
                              child: Text(
                                'Section',
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
                                  if(value.isEmpty){
                                    return 'Provide Section';
                                  }
                                },
                                controller: ctrlSection,
                                textAlign: TextAlign.center,
                                onChanged: (value) {
                                  _section = value;
                                },
                                style: TextStyle(
                                    fontFamily: 'Poppins', fontSize: 1.84 * SizeConfig.heightMultiplier),
                                decoration: kTextFieldDecorationNoback.copyWith(
                                  hintText: '',contentPadding: EdgeInsets.symmetric(vertical: 1.5 * SizeConfig.heightMultiplier, horizontal: 20.0),)
                            ),

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
                              child: TextFormField(validator: (String value){
                                if(value.isEmpty)
                                {
                                  return 'Please provide kilometer';
                                }
                              },
                                  controller: ctrlkilometer,
                                  keyboardType: TextInputType.number,
                                  textAlign: TextAlign.center,
                                  onChanged: (value) {
                                    _kilometer = value;
                                  },
                                  style: TextStyle(
                                      fontFamily: 'Poppins', fontSize: 1.84 * SizeConfig.heightMultiplier),
                                  decoration: kTextFieldDecorationNoback.copyWith(
                                    hintText: '',contentPadding: EdgeInsets.symmetric(vertical: 1.5 * SizeConfig.heightMultiplier, horizontal: 20.0),)
                              ),
                              width: 68.2 * SizeConfig.widthMultiplier,
                            ),

                            //Road
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
                                hintText: 'Choose a road',
                                hintStyle: TextStyle(
                                    height: 1.0,
                                    fontFamily: 'Poppins',
                                    fontSize:
                                    1.84 * SizeConfig.heightMultiplier),
                                items: qrRoadList,
                                strict: true,
                                setter: (dynamic newValue) {
                                  print('Setter');
                                  _road = newValue;
                                }),

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
                            DropDownField(
                                onValueChanged: (dynamic s) {
                                  print(s);
                                  setState(() {
                                    _track = s;
                                  });
                                },
                                textStyle: TextStyle(
                                    height: 0.9,
                                    fontFamily: 'Poppins',
                                    fontSize:
                                    1.84 * SizeConfig.heightMultiplier),
                                value: _track,
                                required: false,
                                hintText: 'Choose a track',
                                hintStyle: TextStyle(
                                    height: 1.0,
                                    fontFamily: 'Poppins',
                                    fontSize:
                                    1.84 * SizeConfig.heightMultiplier),
                                items: qrTrackList,
                                strict: true,
                                setter: (dynamic newValue) {
                                  print('Setter');
                                  _track = newValue;
                                }),

                            //Rail
                            Padding(
                              padding: EdgeInsets.only(bottom: 8.0, top: 20),
                              child: Text(
                                'Rail (L / R)',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 1.7 * SizeConfig.heightMultiplier,
                                  color: const Color(0xffa1a1a1),
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ),
                            Container(
                              child: TextFormField(textCapitalization: TextCapitalization.sentences,
controller: ctrlRail,
                                  validator: (String value) {
                                    if (value.isEmpty) {
                                      return 'Please Provide Rail';
                                    } else if ((value != 'L' &&
                                        value != 'R' &&
                                        value != 'l' &&
                                        value != 'R') &&
                                        value.isNotEmpty) {
                                      return 'Value must be either \'L\' or \'R\'';
                                    }
                                  },
                                  maxLength: 1,
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
                            DropDownField(
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
                                items: qrWeldTypeList,
                                strict: true,
                                setter: (dynamic newValue) {
                                  print('Setter');
                                  _weldType = newValue;
                                }),

                            //KG
                            Padding(
                              padding: EdgeInsets.only(top: 20),
                              child: Text(
                                'KG',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 1.7 * SizeConfig.heightMultiplier,
                                  color: const Color(0xffa1a1a1),
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ),
                            Container(
                              child: DropDownField(
                                onValueChanged: (dynamic s) async {
                                  _railKg = s;
                                },
                                keyboardType: TextInputType.number,
                                textStyle: TextStyle(
                                    height: 0.9,
                                    fontFamily: 'Poppins',
                                    fontSize: 1.84 *
                                        SizeConfig.heightMultiplier),
                                value: _railKg,
                                required: false,
                                hintText: 'Provide Kg',
                                hintStyle: TextStyle(
                                    height: 1.0,
                                    fontFamily: 'Poppins',
                                    fontSize: 1.84 *
                                        SizeConfig.heightMultiplier),
                                items: [
                                  '47/50',
                                  '47/53',
                                  '50/60',
                                  '47/53',
                                  '53/60',
                                  '47',
                                  '53',
                                  '60',
                                  '50',
                                  '53/60',
                                  '41',
                                  '41/47',
                                ].map(
                                      (String dropdownitem) {
                                    return dropdownitem;
                                  },
                                ).toList(),
                                strict: false,
                                setter: (dynamic newValue) {
                                  print('Setter');
                                  _railKg = newValue;
                                },
                              ),
                            ),

                            //Rail Type
                            Padding(
                              padding: EdgeInsets.only(top: 20),
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
                            Container(
                              child: DropDownField(
                                onValueChanged: (dynamic s) async {
                                  _railType = s;
                                },
                                keyboardType: TextInputType.number,
                                textStyle: TextStyle(
                                    height: 0.9,
                                    fontFamily: 'Poppins',
                                    fontSize: 1.84 *
                                        SizeConfig.heightMultiplier),
                                value: _railType,
                                required: false,
                                hintText: 'Provide Rail Type',
                                hintStyle: TextStyle(
                                    height: 1.0,
                                    fontFamily: 'Poppins',
                                    fontSize: 1.84 *
                                        SizeConfig.heightMultiplier),
                                items: [
                                  'SC',
                                  'HH',
                                ].map(
                                      (String dropdownitem) {
                                    return dropdownitem;
                                  },
                                ).toList(),
                                strict: false,
                                setter: (dynamic newValue) {
                                  print('Setter');
                                  _railType = newValue;
                                },
                              ),
                            ),

                            //Weld Reason
                            Padding(
                              padding: EdgeInsets.only(top: 20),
                              child: Text(
                                'Weld Reason',
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
                                    _reasonForWeldFinal = s;
                                  });
                                },
                                textStyle: TextStyle(
                                    height: 0.9,
                                    fontFamily: 'Poppins',
                                    fontSize:
                                    1.84 * SizeConfig.heightMultiplier),
                                value: _reasonForWeldFinal,
                                required: false,
                                hintText: 'Reason For Weld',
                                hintStyle: TextStyle(
                                    height: 1.0,
                                    fontFamily: 'Poppins',
                                    fontSize:
                                    1.84 * SizeConfig.heightMultiplier),
                                items: qrWeldReasonList,
                                strict: true,
                                setter: (dynamic newValue) {
                                  print('Setter');
                                  _reasonForWeldFinal = newValue;
                                }),

                            //Heating Trolley
                            Padding(
                              padding: EdgeInsets.only(top: 20),
                              child: Text(
                                'Heating Trolley',
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
                                    _heatingTrolley = s;
                                  });
                                },
                                textStyle: TextStyle(
                                    height: 0.9,
                                    fontFamily: 'Poppins',
                                    fontSize:
                                    1.84 * SizeConfig.heightMultiplier),
                                value: _heatingTrolley,
                                required: false,
                                hintText: 'Heating Trolley',
                                hintStyle: TextStyle(
                                    height: 1.0,
                                    fontFamily: 'Poppins',
                                    fontSize:
                                    1.84 * SizeConfig.heightMultiplier),
                                items: qrHeating_TrolleyList,
                                strict: true,
                                setter: (dynamic newValue) {
                                  print('Setter');
                                  _heatingTrolley = newValue;
                                }),

                            //Was Rail Adjusted
                            Padding(
                              padding: EdgeInsets.only(top: 20),
                              child: Text(
                                'Was Rail Adjusted',
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
                                _wasRailAdjusted = s;
                              },

                              textStyle: TextStyle(
                                  height: 0.9,
                                  fontFamily: 'Poppins',
                                  fontSize: 1.84 *
                                      SizeConfig.heightMultiplier),
                              value: _wasRailAdjusted,
                              required: false,
                              hintText: 'Provide Temperature',
                              hintStyle: TextStyle(
                                  height: 1.0,
                                  fontFamily: 'Poppins',
                                  fontSize: 1.84 *
                                      SizeConfig.heightMultiplier),
                              items: [
                                'Yes',
                                'No',
                              ].map(
                                    (String dropdownitem) {
                                  return dropdownitem;
                                },
                              ).toList(),
                              strict: false,
                              setter: (dynamic newValue) {
                                print('Setter');
                                _wasRailAdjusted = newValue;
                              },
                            ),

                            //Weld Kit Details Date
                            Padding(
                              padding: EdgeInsets.only(top: 20),
                              child: Text(
                                'Weld Kit Details Date',
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
                              child: ListTile(trailing: IconButton(icon: Icon(Icons.date_range_outlined), onPressed: (){pickWeldKitDetailsDate();}),
                                title: Center(child: Text('${_weldKitDetailsDate.day}-${_weldKitDetailsDate.month}-${_weldKitDetailsDate.year}')),

                              ),
                            ),

                            //Steel Added/Removed
                            Padding(
                              padding: EdgeInsets.only(bottom: 8.0, top: 20),
                              child: Text(
                                'Steel Added/Removed',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 1.7 * SizeConfig.heightMultiplier,
                                  color: const Color(0xffa1a1a1),
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ),

                            Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    child: TextFormField(controller: ctrlSteelAddedRemovedmm,
                                        keyboardType: TextInputType.number,
                                        textAlign: TextAlign.center,
                                        maxLength: 3,
                                        onChanged: (value) {
                                          _steelAddedRemovedmm = value;
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
                                    width: 45.2 * SizeConfig.widthMultiplier,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'mm',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 1.7 * SizeConfig.heightMultiplier,
                                      color: const Color(0xffa1a1a1),
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                                Container(
//                          height: 5.13 * SizeConfig.heightMultiplier,
                                  width: 30.2 * SizeConfig.widthMultiplier,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(3.95 * SizeConfig.heightMultiplier),
                                    border: Border.all(color: Color(0xffe8e8e8),width: 1.0),
                                  ),
                                  child: Center(
                                    child: DropdownButton<String>(
                                      onTap: () {
                                        FocusManager.instance.primaryFocus.unfocus();
                                      },
                                      icon: Icon(
                                        Icons.keyboard_arrow_down,size: 2.5 * SizeConfig.heightMultiplier,
                                      ),
                                      underline: Container(
                                        height: 1.0,
                                        decoration: const BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                  color: Colors.transparent,
                                                  width: 1.0)),
                                        ),
                                      ),
                                      value: _steelAddedRemoved,
                                      items:
                                      ['Added','Removed'].map(
                                            (String dropdownitem) {
                                          return DropdownMenuItem<String>(
                                            value: dropdownitem,
                                            child: Text(dropdownitem,style: TextStyle(
                                                fontFamily: 'Manrope', fontSize: 1.84 * SizeConfig.heightMultiplier),),
                                          );
                                        },
                                      ).toList(),
                                      onChanged: (String value) {
                                        setState(
                                              () {
                                            _steelAddedRemoved = value;
                                          },
                                        );
                                      },
                                    ),
                                  ),
                                ),

                              ],
                            ),

                            // Ground By
                            Padding(
                              padding: EdgeInsets.only(bottom: 1.05 * SizeConfig.heightMultiplier, top: 2.63 * SizeConfig.heightMultiplier),
                              child: Text(
                                'Ground By',
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
                                      Checkbox(value: _groundByMe,
                                          activeColor: kShadeColor1,
                                          onChanged: (bool newvalue){
                                            if(newvalue==true){
                                              setState(() {
                                                print(newvalue);
                                                ctrlGroundByManual.text='Me';
                                                _weldGroundByManual='Me';
                                                ctrlGroundByManualLicence.text=kActiveLicenseNumber;
                                                _weldGroundByManualLicence=kActiveLicenseNumber;
                                                _groundByMe = newvalue;
                                                _groundByManualEnterName = !newvalue;
                                                _groundByLeaveBlank = !newvalue;
                                              });
                                            }
                                          }),
                                      Text('Me'),
                                      Checkbox(value: _groundByManualEnterName,
                                        activeColor: kShadeColor1,
                                        onChanged: (bool newvalue){
                                          if(newvalue==true){
                                            setState(() {
                                              print(newvalue);
                                              ctrlGroundByManual.text='';
                                              _weldGroundByManual='';
                                              _groundByManualEnterName = newvalue;
                                              ctrlGroundByManualLicence.text='';
                                              _groundByMe = !newvalue;
                                              _groundByLeaveBlank = !newvalue;
                                            });
                                          }
                                        },),
                                      Text('Manually Enter Name'),
                                    ],

                                  ),
                                  Row(
                                    children: [
                                      Checkbox(value: _groundByLeaveBlank,
                                          activeColor: kShadeColor1,
                                          onChanged: (bool newvalue){
                                            if(newvalue==true){
                                              setState(() {
                                                print(newvalue);
                                                ctrlGroundByManual.text='';
                                                _weldGroundByManual='Leave Blank';
                                                _weldGroundByManualLicence='N/A';
                                                _groundByLeaveBlank = newvalue;
                                                _groundByManualEnterName = !newvalue;
                                                _groundByMe = !newvalue;
                                              });
                                            }
                                          }),
                                      Text('Leave Blank'),

                                    ],
                                  ),
                                  Container(
                                    child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Visibility(visible: _groundByManualEnterName,
                                          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Padding(
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
                                              TextFormField(
                                                //     validator: (String value){
                                                //   if(_groundByManualEnterName==true && (_weldGrinderManual == null ||_weldGrinderManual.contains('N/A'))){
                                                //     return 'Provide Ground By';
                                                //   }
                                                // },
                                                  controller: ctrlGroundByManual,
                                                  textAlign: TextAlign.center,
                                                  onChanged: (value) {
                                                    _weldGroundByManual = value;
                                                    print(_weldGroundByManual);
                                                  },
                                                  style: TextStyle(
                                                      fontFamily: 'Poppins', fontSize: 1.84 * SizeConfig.heightMultiplier),
                                                  decoration: kTextFieldDecorationNoback.copyWith(
                                                    hintText: '',contentPadding: EdgeInsets.symmetric(vertical: 1.5 * SizeConfig.heightMultiplier, horizontal: 20.0),)
                                              ),

                                            ],
                                          ),
                                        ),
                                        Visibility(visible: !_groundByLeaveBlank,
                                            child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
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
                                                TextFormField(maxLength: 5,readOnly: _groundByMe,
                                                    validator: (String value){
                                                      if(_groundByMe == false && _weldGroundByManualLicence == null){
                                                        return 'Provide Licence Number';
                                                      }
                                                    },
                                                    controller: ctrlGroundByManualLicence,
                                                    textAlign: TextAlign.center,
                                                    onChanged: (value) {
                                                      _weldGroundByManualLicence = value;
                                                    },
                                                    style: TextStyle(
                                                        fontFamily: 'Poppins', fontSize: 1.84 * SizeConfig.heightMultiplier),
                                                    decoration: kTextFieldDecorationNoback.copyWith(
                                                      hintText: '',contentPadding: EdgeInsets.symmetric(vertical: 1.5 * SizeConfig.heightMultiplier, horizontal: 20.0),)
                                                ),
                                                Visibility(visible: _groundByManualEnterName,
                                                    child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Padding(
                                                          padding: EdgeInsets.only(bottom: 1.05 * SizeConfig.heightMultiplier, top: 2.63 * SizeConfig.heightMultiplier),
                                                          child: Text(
                                                            'Yearly Weld Count',
                                                            style: TextStyle(
                                                              fontFamily: 'Poppins',
                                                              fontSize: 1.7 * SizeConfig.heightMultiplier,
                                                              color: const Color(0xffa1a1a1),
                                                            ),
                                                            textAlign: TextAlign.left,
                                                          ),
                                                        ),
                                                        TextFormField(maxLength: 5,
                                                            // validator: (String value){
                                                            //   if(_groundByMe == false && _weldGroundByManualLicence == null){
                                                            //     return 'Provide Licence Number';
                                                            //   }
                                                            // },
                                                            controller: ctrlGroundByManualCount,
                                                            keyboardType: TextInputType.number,
                                                            textAlign: TextAlign.center,
                                                            onChanged: (value) {
                                                              _weldGroundManualCount = value;
                                                            },
                                                            style: TextStyle(
                                                                fontFamily: 'Poppins', fontSize: 1.84 * SizeConfig.heightMultiplier),
                                                            decoration: kTextFieldDecorationNoback.copyWith(
                                                              hintText: '',contentPadding: EdgeInsets.symmetric(vertical: 1.5 * SizeConfig.heightMultiplier, horizontal: 20.0),)
                                                        ),

                                                      ],
                                                    ))
                                              ],
                                            ))
                                        // SizedBox(height: 2 * SizeConfig.heightMultiplier,),


                                      ],
                                    ),

                                  ),

                                ],
                              ),
//                          height: 5.65 * SizeConfig.heightMultiplier,
                              width: 68.2 * SizeConfig.widthMultiplier,
//                          height: 5.65 * SizeConfig.heightMultiplier,
                            ),

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
                            Container(
                              child: TextFormField(controller: ctrlComment,
                                  maxLength: 100,maxLines: 5,
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

                            //Top Peaked
                            Padding(
                              padding: EdgeInsets.only(bottom: 8.0, top: 20),
                              child: Text(
                                'Top Peaked',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 1.7 * SizeConfig.heightMultiplier,
                                  color: const Color(0xffa1a1a1),
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ),
                            Row(children: [
                              Expanded(
                                child: TextFormField(
                                    keyboardType: TextInputType.number,
                                    textAlign: TextAlign.center,
                                    controller: ctrlTopPeaked,
                                    style: TextStyle(color: _topPeaked>0.4?Colors.red:Colors.black,
                                        fontFamily: 'Poppins', fontSize: 1.84 * SizeConfig.heightMultiplier),
                                    decoration: kTextFieldDecorationNoback.copyWith(
                                      hintText: '',contentPadding: EdgeInsets.symmetric(vertical: 2.0 * SizeConfig.heightMultiplier, horizontal: 20.0),)
                                ),
                              ),
                              SizedBox(height: 70.0,
                                child: Column(mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: IconButton(icon: Icon(Icons.arrow_drop_up),onPressed: (){
                                        print('Increase');

                                        setState(() {
                                          if(_topPeaked<2.0){
                                            _topPeaked=_topPeaked+0.1;
                                            ctrlTopPeaked.text=_topPeaked.toStringAsFixed(1);
                                            _topPeaked = double.parse(ctrlTopPeaked.text);
                                          }
                                        });

                                      },),
                                    ),
                                    IconButton(icon: Icon(Icons.arrow_drop_down),onPressed: (){
                                      print('Decrease');
                                      setState(() {
                                        if(_topPeaked>0.0){
                                          _topPeaked=_topPeaked-0.1;
                                          ctrlTopPeaked.text=_topPeaked.toStringAsFixed(1);
                                          _topPeaked = double.parse(ctrlTopPeaked.text);
                                        }
                                      });
                                    },),
                                  ],
                                ),
                              ),
                            ],),

                            //Top Dipped
                            Padding(
                              padding: EdgeInsets.only(bottom: 8.0, top: 20),
                              child: Text(
                                'Top Dipped',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 1.7 * SizeConfig.heightMultiplier,
                                  color: const Color(0xffa1a1a1),
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ),
                            Row(children: [
                              Expanded(
                                child: TextFormField(
                                    keyboardType: TextInputType.number,
                                    textAlign: TextAlign.center,
                                    controller: ctrlTopDipped,
                                    style: TextStyle(color: _topDipped != 0?Colors.red:Colors.black,
                                        fontFamily: 'Poppins', fontSize: 1.84 * SizeConfig.heightMultiplier),
                                    decoration: kTextFieldDecorationNoback.copyWith(
                                      hintText: '',contentPadding: EdgeInsets.symmetric(vertical: 2.0 * SizeConfig.heightMultiplier, horizontal: 20.0),)
                                ),
                              ),
                              SizedBox(height: 70.0,
                                child: Column(mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: IconButton(icon: Icon(Icons.arrow_drop_up),onPressed: (){
                                        print('Increase');

                                        setState(() {
                                          if(_topDipped<0){
                                            _topDipped=_topDipped+0.1;
                                            ctrlTopDipped.text=_topDipped.toStringAsFixed(1);
                                            _topDipped = double.parse(ctrlTopDipped.text);
                                            print(_topDipped);
                                          }
                                        });

                                      },),
                                    ),
                                    IconButton(icon: Icon(Icons.arrow_drop_down),onPressed: (){
                                      print('Decrease');
                                      setState(() {
                                        if(_topDipped>-2.0){
                                          _topDipped=_topDipped-0.1;
                                          ctrlTopDipped.text=_topDipped.toStringAsFixed(1);
                                          _topDipped = double.parse(ctrlTopDipped.text);
                                          print(_topDipped);
                                        }
                                      });
                                    },),
                                  ],
                                ),
                              ),
                            ],),

                            //Side Peaked
                            Padding(
                              padding: EdgeInsets.only(bottom: 8.0, top: 20),
                              child: Text(
                                'Side Peaked',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 1.7 * SizeConfig.heightMultiplier,
                                  color: const Color(0xffa1a1a1),
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ),
                            Row(children: [
                              Expanded(
                                child: TextFormField(
                                    keyboardType: TextInputType.number,
                                    textAlign: TextAlign.center,
                                    controller: ctrlSidePeaked,
                                    style: TextStyle(color: _sidePeaked != 0?Colors.red:Colors.black,
                                        fontFamily: 'Poppins', fontSize: 1.84 * SizeConfig.heightMultiplier),
                                    decoration: kTextFieldDecorationNoback.copyWith(
                                      hintText: '',contentPadding: EdgeInsets.symmetric(vertical: 2.0 * SizeConfig.heightMultiplier, horizontal: 20.0),)
                                ),
                              ),
                              SizedBox(height: 70.0,
                                child: Column(mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: IconButton(icon: Icon(Icons.arrow_drop_up),onPressed: (){
                                        print('Increase');

                                        setState(() {
                                          if(_sidePeaked<2){
                                            _sidePeaked=_sidePeaked+0.1;
                                            ctrlSidePeaked.text=_sidePeaked.toStringAsFixed(1);
                                            _sidePeaked=double.parse(ctrlSidePeaked.text);
                                            print(_sidePeaked);
                                          }
                                        });

                                      },),
                                    ),
                                    IconButton(icon: Icon(Icons.arrow_drop_down),onPressed: (){
                                      print('Decrease');
                                      setState(() {
                                        if(_sidePeaked>0){
                                          _sidePeaked=_sidePeaked-0.1;
                                          ctrlSidePeaked.text=_sidePeaked.toStringAsFixed(1);
                                          _sidePeaked=double.parse(ctrlSidePeaked.text);
                                          print(_sidePeaked);
                                        }
                                      });
                                    },),
                                  ],
                                ),
                              ),
                            ],),

                            //Side Dipped
                            Padding(
                              padding: EdgeInsets.only(bottom: 8.0, top: 20),
                              child: Text(
                                'Side Dipped',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 1.7 * SizeConfig.heightMultiplier,
                                  color: const Color(0xffa1a1a1),
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ),
                            Row(children: [
                              Expanded(
                                child: TextFormField(
                                    keyboardType: TextInputType.number,
                                    textAlign: TextAlign.center,
                                    controller: ctrlSideDipped,
                                    style: TextStyle(color: _sideDipped != 0?Colors.red:Colors.black,
                                        fontFamily: 'Poppins', fontSize: 1.84 * SizeConfig.heightMultiplier),
                                    decoration: kTextFieldDecorationNoback.copyWith(
                                      hintText: '',contentPadding: EdgeInsets.symmetric(vertical: 2.0 * SizeConfig.heightMultiplier, horizontal: 20.0),)
                                ),
                              ),
                              SizedBox(height: 70.0,
                                child: Column(mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: IconButton(icon: Icon(Icons.arrow_drop_up),onPressed: (){
                                        print('Increase');

                                        setState(() {
                                          if(_sideDipped<0){
                                            _sideDipped=_sideDipped+0.1;
                                            ctrlSideDipped.text=_sideDipped.toStringAsFixed(1);
                                            _sideDipped=double.parse(ctrlSideDipped.text);
                                            print(_sideDipped);
                                          }
                                        });

                                      },),
                                    ),
                                    IconButton(icon: Icon(Icons.arrow_drop_down),onPressed: (){
                                      print('Decrease');
                                      setState(() {
                                        if(_sideDipped>-2.0){
                                          _sideDipped=_sideDipped-0.1;
                                          ctrlSideDipped.text=_sideDipped.toStringAsFixed(1);
                                          _sideDipped=double.parse(ctrlSideDipped.text);
                                          print(_sideDipped);
                                        }
                                      });
                                    },),
                                  ],
                                ),
                              ),
                            ],),

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

                                  print('https://radreviews.online/app/REST/EasyRails/App_Edit_QRWeldReturn?WeldDate=${_weldDate.day}/${_weldDate.month}/${_weldDate.year}&Section=$_section&Kilometer=$_kilometer&Road=$_road&Track=$_track&Rail=$_rail&Weld_Type=$_weldType&ReasonForWeldFinal=$_reasonForWeldFinal&HeatingTrolley=$_heatingTrolley&RailTempFinal=$_railTempFinal&SteelAddedRemoved=$_steelAddedRemoved&SteelAddedRemovedNum=$_steelAddedRemovedmm&WasRailAdjusted=$_wasRailAdjusted&WeldKitDetalsDate=${_weldKitDetailsDate.day}/${_weldKitDetailsDate.month}/${_weldKitDetailsDate.year}&BatchNo=$_weldBatchNumber&Rail_Kg=$_railKg&RailType=$_railType&TopPeaked=$_topPeaked&TopDipped=$_topDipped&SidePeaked=$_sidePeaked&SideDipped=$_sideDipped&Comments=$_comments&WeldCountManual=$_weldGroundManualCount&WeldGrinderFinal=$_weldGroundByManual&WeldLicenceManual=$_weldGroundByManualLicence&SystemUserID=$loggedinUserID&&EXT_ID=$_extID');
                                bool connectionValilable = await checkConnectionNoListner();
                                if(connectionValilable != true && 1==0){
                                  // if (_formKeyWeldReturn.currentState.validate()) {
                                  //   _validate();
                                  //   if(_isWeldReurnvalid==true){
                                  //     String _stringWelddate = '${_weldDate.day}/${_weldDate.month}/${_weldDate.year}';
                                  //     String _stringWeldKitDetailsDate = '${_weldKitDetailsDate.day}/${_weldKitDetailsDate.month}/${_weldKitDetailsDate.year}';
                                  //     String _apiURL =  kBaseURL +'App_Edit_QRWeldReturn?WeldDate=${_weldDate.day}/${_weldDate.month}/${_weldDate.year}&Section=$_section&Kilometer=$_kilometer&Road=$_road&Track=$_track&Rail=$_rail&Weld_Type=$_weldType&ReasonForWeldFinal=$_reasonForWeldFinal&HeatingTrolley=$_heatingTrolley&RailTempFinal=$_railTempFinal&SteelAddedRemoved=$_steelAddedRemoved&SteelAddedRemovedNum=$_steelAddedRemovedmm&WasRailAdjusted=$_wasRailAdjusted&WeldKitDetalsDate=${_weldKitDetailsDate.day}/${_weldKitDetailsDate.month}/${_weldKitDetailsDate.year}&BatchNo=$_weldBatchNumber&Rail_Kg=$_railKg&RailType=$_railType&TopPeaked=$_topPeaked&TopDipped=$_topDipped&SidePeaked=$_sidePeaked&SideDipped=$_sideDipped&Comments=$_comments&WeldCountManual=$_weldGroundManualCount&WeldGrinderFinal=$_weldGroundByManual&WeldLicenceManual=$_weldGroundByManualLicence&SystemUserID=$loggedinUserID';
                                  //     print(_apiURL);
                                  //     sharedPreferences = await SharedPreferences.getInstance();
                                  //     listUpdateQRWeldReturnUnSynced= sharedPreferences.getStringList('listUpdateWeldReturnUnSynced');
                                  //     print('First');
                                  //     print(listUpdateQRWeldReturnUnSynced.length);
                                  //     UpdateQRWeldReturnUnSynced updateQRWeldReturnUnSynced = UpdateQRWeldReturnUnSynced(tempweldDate : _stringWelddate,tempweldKitDetailsDate : _stringWeldKitDetailsDate,tempsection : _section,tempkilometer : _kilometer,temproad : _road,temptrack : _track,temprail : _rail,tempweldType : _weldType,tempreasonForWeldFinal : _reasonForWeldFinal,tempheatingTrolley : _heatingTrolley,tempsteelAddedRemoved : _steelAddedRemoved,tempsteelAddedRemovedmm : _steelAddedRemovedmm,tempwasRailAdjusted : _wasRailAdjusted,tempweldBatchNumber : _weldBatchNumber,temprailKg : _railKg,temprailType : _railType,temptopPeaked : _topPeaked,temptopDipped : _topDipped,tempsidePeaked : _sidePeaked,tempsideDipped : _sideDipped,tempgroundByMe : _groundByMe,tempgroundByManualEnterName : _groundByManualEnterName,tempgroundByLeaveBlank : _groundByLeaveBlank,tempweldGroundByManual : _weldGroundByManual,tempweldGroundByManualLicence : _weldGroundByManualLicence,tempweldGroundManualCount : _weldGroundManualCount,temprailTempFinal : _railTempFinal,tempcomments : _comments,apiURL : _apiURL,id: int.parse(_extID));
                                  //     var tempJson = jsonEncode(updateQRWeldReturnUnSynced.tojson());
                                  //     bool _recordExists = false;
                                  //     int _replaceAt;
                                  //     print('Before Iterate');
                                  //     print(listUpdateQRWeldReturnUnSynced.length);
                                  //     listUpdateQRWeldReturnUnSynced.forEach((element) {
                                  //       print(listUpdateQRWeldReturnUnSynced.indexOf(element));
                                  //       if(jsonDecode(element)['tempweldReturnID']==_weldReturnID){
                                  //         _recordExists = true;
                                  //         print('old Record');
                                  //         _replaceAt = listUpdateQRWeldReturnUnSynced.indexOf(element);
                                  //         print(_replaceAt);
                                  //       }
                                  //     }
                                  //     );
                                  //     print('After Iterate');
                                  //     print(_recordExists);
                                  //     print(listUpdateQRWeldReturnUnSynced.length);
                                  //     if(_recordExists == false){
                                  //       listUpdateQRWeldReturnUnSynced.add(tempJson);
                                  //       print('Inside');
                                  //       sharedPreferences.setStringList('listUpdateWeldReturnUnSynced', listUpdateQRWeldReturnUnSynced);
                                  //     }
                                  //     else{
                                  //       listUpdateQRWeldReturnUnSynced.removeAt(_replaceAt);
                                  //       listUpdateQRWeldReturnUnSynced.add(tempJson);
                                  //       sharedPreferences.setStringList('listUpdateWeldReturnUnSynced', listUpdateQRWeldReturnUnSynced);
                                  //     }
                                  //     print('New');
                                  //     print(listUpdateQRWeldReturnUnSynced.length);
                                  //     Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>QRWeldReturnTab()));
                                  //   }
                                  // }
                                }
                                else{
                                  if (_formKeyWeldReturn.currentState.validate()) {
                                    _validate();
                                    if(_isWeldReurnvalid==true){
                                      http.Response _response =await  http.get(kBaseURL +
                                          'REST/EasyRails/App_Edit_QRWeldReturn?WeldDate=${_weldDate.day}/${_weldDate.month}/${_weldDate.year}&Section=$_section&Kilometer=$_kilometer&Road=$_road&Track=$_track&Rail=$_rail&Weld_Type=$_weldType&ReasonForWeldFinal=$_reasonForWeldFinal&HeatingTrolley=$_heatingTrolley&RailTempFinal=$_railTempFinal&SteelAddedRemoved=$_steelAddedRemoved&SteelAddedRemovedNum=$_steelAddedRemovedmm&WasRailAdjusted=$_wasRailAdjusted&WeldKitDetalsDate=${_weldKitDetailsDate.day}/${_weldKitDetailsDate.month}/${_weldKitDetailsDate.year}&BatchNo=$_weldBatchNumber&Rail_Kg=$_railKg&RailType=$_railType&TopPeaked=$_topPeaked&TopDipped=$_topDipped&SidePeaked=$_sidePeaked&SideDipped=$_sideDipped&Comments=$_comments&WeldCountManual=$_weldGroundManualCount&WeldGrinderFinal=$_weldGroundByManual&WeldLicenceManual=$_weldGroundByManualLicence&SystemUserID=$loggedinUserID&&EXT_ID=$_extID');
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
                                          });print('inside COnnection');
                                          await Flushbar(
                                            titleText: Text(
                                              'Updated',
                                              style: TextStyle(
                                                fontFamily: 'Poppins',
                                                fontSize: 2.0 * SizeConfig.heightMultiplier,
                                                color: const Color(0xffffffff),
                                                fontWeight: FontWeight.w600,
                                              ),
                                              textAlign: TextAlign.left,
                                            ),
                                            messageText: Text(
                                              'You have successfully updated the Weld Report',
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
                                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>QRWeldReturnTab()));
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
                                    'UPDATE',
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
  Future<DateTime> pickWeldKitDetailsDate() async{
    DateTime pickedDateTime = await showDatePicker(
        context: context,
        initialDate: _weldKitDetailsDate,
        firstDate: DateTime(DateTime.now().year-1),
        lastDate: DateTime.now());
    if(pickedDateTime !=null){
      setState(() {
        _weldKitDetailsDate=pickedDateTime;
      });
    }
    return pickedDateTime;
  }
}

class UpdateQRWeldReturnUnSynced{
  int id;
  String tempweldDate;
  String tempweldKitDetailsDate;
  String tempsection;
  String tempkilometer;
  String temproad;
  String temptrack;
  String temprail;
  String tempweldType;
  String tempreasonForWeldFinal;
  String tempheatingTrolley;
  String tempsteelAddedRemoved;
  String tempsteelAddedRemovedmm;
  String tempwasRailAdjusted;
  String tempweldBatchNumber;
  String temprailKg;
  String temprailType;
  double temptopPeaked;
  double temptopDipped;
  double tempsidePeaked;
  double tempsideDipped;
  bool tempgroundByMe;
  bool tempgroundByManualEnterName;
  bool tempgroundByLeaveBlank;
  String tempweldGroundByManual;
  String tempweldGroundByManualLicence;
  String tempweldGroundManualCount;
  String temprailTempFinal;
  String tempcomments;
  String apiURL;
  String temploggedinUserID;

//  Constructor
  UpdateQRWeldReturnUnSynced({this.tempweldDate,
    this.tempweldKitDetailsDate,
    this.tempsection,
    this.tempkilometer,
    this.temproad,
    this.temptrack,
    this.temprail,
    this.tempweldType,
    this.tempreasonForWeldFinal,
    this.tempheatingTrolley,
    this.tempsteelAddedRemoved,
    this.tempsteelAddedRemovedmm,
    this.tempwasRailAdjusted,
    this.tempweldBatchNumber,
    this.temprailKg,
    this.temprailType,
    this.temptopPeaked,
    this.temptopDipped,
    this.tempsidePeaked,
    this. tempsideDipped,
    this.tempgroundByMe,
    this.tempgroundByManualEnterName,
    this.tempgroundByLeaveBlank,
    this.tempweldGroundByManual,
    this.tempweldGroundByManualLicence,
    this.tempweldGroundManualCount,
    this.temprailTempFinal,
    this.tempcomments,
    this.apiURL,
    this.temploggedinUserID,
    this.id});

//  this map will convert object in json
  Map<String, dynamic> tojson() =>{
    'tempweldDate' : tempweldDate,
    'tempweldKitDetailsDate' : tempweldKitDetailsDate,
    'tempsection' : tempsection,
    'tempkilometer' : tempkilometer,
    'temproad' : temproad,
    'temptrack' : temptrack,
    'temprail' : temprail,
    'tempweldType' : tempweldType,
    'tempreasonForWeldFinal' : tempreasonForWeldFinal,
    'tempheatingTrolley' : tempheatingTrolley,
    'tempsteelAddedRemoved' : tempsteelAddedRemoved,
    'tempsteelAddedRemovedmm' : tempsteelAddedRemovedmm,
    'tempwasRailAdjusted' : tempwasRailAdjusted,
    'tempweldBatchNumber' : tempweldBatchNumber,
    'temprailKg' : temprailKg,
    'temprailType' : temprailType,
    'temptopPeaked' : temptopPeaked,
    'temptopDipped' : temptopDipped,
    'tempsidePeaked' : tempsidePeaked,
    'tempsideDipped' : tempsideDipped,
    'tempgroundByMe' : tempgroundByMe,
    'tempgroundByManualEnterName' : tempgroundByManualEnterName,
    'tempgroundByLeaveBlank' : tempgroundByLeaveBlank,
    'tempweldGroundByManual' : tempweldGroundByManual,
    'tempweldGroundByManualLicence' : tempweldGroundByManualLicence,
    'tempweldGroundManualCount' : tempweldGroundManualCount,
    'temprailTempFinal' : temprailTempFinal,
    'tempcomments' : tempcomments,
    'apiURL' : apiURL,
    'temploggedinUserID' : temploggedinUserID,
    'id' : id,
  };

//  this function will convert json into object
  UpdateQRWeldReturnUnSynced.fromJson(Map<String,dynamic> json):
        tempweldDate = json['tempweldDate'],
        tempweldKitDetailsDate = json['tempweldKitDetailsDate'],
        tempsection = json['tempsection'],
        tempkilometer = json['tempkilometer'],
        temproad = json['temproad'],
        temptrack = json['temptrack'],
        temprail = json['temprail'],
        tempweldType = json['tempweldType'],
        tempreasonForWeldFinal = json['tempreasonForWeldFinal'],
        tempheatingTrolley = json['tempheatingTrolley'],
        tempsteelAddedRemoved = json['tempsteelAddedRemoved'],
        tempsteelAddedRemovedmm = json['tempsteelAddedRemovedmm'],
        tempwasRailAdjusted = json['tempwasRailAdjusted'],
        tempweldBatchNumber = json['tempweldBatchNumber'],
        temprailKg = json['temprailKg'],
        temprailType = json['temprailType'],
        temptopPeaked = json['temptopPeaked'],
        temptopDipped = json['temptopDipped'],
        tempsidePeaked = json['tempsidePeaked'],
        tempsideDipped = json['tempsideDipped'],
        tempgroundByMe = json['tempgroundByMe'],
        tempgroundByManualEnterName = json['tempgroundByManualEnterName'],
        tempgroundByLeaveBlank = json['tempgroundByLeaveBlank'],
        tempweldGroundByManual = json['tempweldGroundByManual'],
        tempweldGroundByManualLicence = json['tempweldGroundByManualLicence'],
        tempweldGroundManualCount = json['tempweldGroundManualCount'],
        temprailTempFinal = json['temprailTempFinal'],
        tempcomments = json['tempcomments'],
        apiURL = json['apiURL'],
        temploggedinUserID = json['temploggedinUserID'],
        id = json['id'];
}