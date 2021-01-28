import 'dart:convert';
import 'package:easy_rails/constants.dart';
import 'package:easy_rails/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';


class ViewQRWeldReturn extends StatefulWidget {
  String weldJson;
  ViewQRWeldReturn({this.weldJson});
  @override
  _ViewQRWeldReturnState createState() => _ViewQRWeldReturnState();
}

class _ViewQRWeldReturnState extends State<ViewQRWeldReturn> {
  DateTime _weldDate;
  DateTime _weldKitDetailsDate;
  String _track;
  String _rail;
  String _weldType;
  String _reasonForWeldFinal;
  String _heatingTrolley;
  String _steelAddedRemoved = 'Added';
  String _steelAddedRemovedmm;
  String _wasRailAdjusted = 'No';
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
  var ctrlRoad = TextEditingController();
  var ctrlTrack = TextEditingController();
  var ctrlRail = TextEditingController();
  var ctrlRailTemp = TextEditingController();
  var ctrlWeldType = TextEditingController();
  var ctrlRailKG = TextEditingController();
  var ctrlRailType = TextEditingController();
  var ctrlHeatingTrolley = TextEditingController();

  var ctrlSteelAddedRemoved = TextEditingController();
  var ctrlComment = TextEditingController();
  var ctrlReasonForWeld = TextEditingController();
  var ctrlWasRailAdjusted = TextEditingController();

  @override
  void initState() {
    setState(() {
      _waiting = true;
    });
    print(widget.weldJson);
    //Initialize All Data with the picked Record

    _weldDate = jsonDecode(widget.weldJson)["WeldDate"] != null?DateFormat("yyyy-MM-dd hh:mm:ss").parse(jsonDecode(widget.weldJson)["WeldDate"]):DateTime.now();
    _weldKitDetailsDate = jsonDecode(widget.weldJson)["WeldKitDetalsDate"] != null?DateFormat("yyyy-MM-dd hh:mm:ss").parse(jsonDecode(widget.weldJson)["WeldKitDetalsDate"]):DateTime.now();
    ctrlSection.text = jsonDecode(widget.weldJson)["Section"];
    ctrlweldBatchNumber.text = jsonDecode(widget.weldJson)["BatchNo"];
    ctrlkilometer.text = jsonDecode(widget.weldJson)["Kilometer"].toString();
    ctrlRoad.text = jsonDecode(widget.weldJson)["Road"];
    ctrlTrack.text = jsonDecode(widget.weldJson)['Track'];
    ctrlRail.text = _rail = jsonDecode(widget.weldJson)["Rail"];
    ctrlRailTemp.text = jsonDecode(widget.weldJson)['RailTempFinal'];
    ctrlWeldType.text = jsonDecode(widget.weldJson)['Weld_Type'];
    ctrlRailKG.text = jsonDecode(widget.weldJson)['Rail_Kg'];
    ctrlRailType.text = jsonDecode(widget.weldJson)['Rail_Type'];
    ctrlReasonForWeld.text = jsonDecode(widget.weldJson)['ReasonForWeldFinal'];
    ctrlHeatingTrolley.text = jsonDecode(widget.weldJson)['HeatingTrolley'];
    ctrlWasRailAdjusted.text = jsonDecode(widget.weldJson)['WasRailAdjusted'];
    ctrlSteelAddedRemoved.text = jsonDecode(widget.weldJson)['SteelAddedRemoved'];
    ctrlsteelAddedRemovedmm.text = _steelAddedRemovedmm = jsonDecode(widget.weldJson)['SteelAddedRemovedNum'].toString();
    ctrlComment.text = _comments = jsonDecode(widget.weldJson)['Comments'];
    _topPeaked = double.parse(jsonDecode(widget.weldJson)['TopPeaked']);
    ctrlTopPeaked.text = _topPeaked.toString();
    _sidePeaked = double.parse(jsonDecode(widget.weldJson)['SidePeaked']);
    ctrlSidePeaked.text = _sidePeaked.toString();
    _topDipped = double.parse(jsonDecode(widget.weldJson)['TopDipped']);
    ctrlTopDipped.text = _topDipped.toString();
    _sideDipped = double.parse(jsonDecode(widget.weldJson)['SideDipped']);
    ctrlSideDipped.text = _sideDipped.toString();
    _extID = jsonDecode(widget.weldJson)['EXT_ID'].toString();
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
    setState(() {
      _waiting = false;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return ModalProgressHUD(
      inAsyncCall: _waiting,
      color: Color(0xff3ba838),
      opacity: 0.1,
      child: Scaffold(
        appBar: AppBar( centerTitle: true,
          title: Text('VIEW WELD RETURN',style: TextStyle(
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
                              child: ListTile(title: Center(child: Text('${_weldDate.day}-${_weldDate.month}-${_weldDate.year}')),

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
                              readOnly: true,
                                controller: ctrlSection,
                                textAlign: TextAlign.center,
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
                                  readOnly: true,
                                  controller: ctrlweldBatchNumber,
                                  textAlign: TextAlign.center,
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
                              child: TextFormField(
                                  readOnly: true,
                                  controller: ctrlkilometer,
                                  textAlign: TextAlign.center,
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
                            Container(
                              child: TextFormField(
                                  readOnly: true,
                                  controller: ctrlRoad,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontFamily: 'Poppins', fontSize: 1.84 * SizeConfig.heightMultiplier),
                                  decoration: kTextFieldDecorationNoback.copyWith(
                                    hintText: '',contentPadding: EdgeInsets.symmetric(vertical: 1.5 * SizeConfig.heightMultiplier, horizontal: 20.0),)
                              ),
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
                              child: TextFormField(
                                  readOnly: true,
                                  controller: ctrlTrack,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontFamily: 'Poppins', fontSize: 1.84 * SizeConfig.heightMultiplier),
                                  decoration: kTextFieldDecorationNoback.copyWith(
                                    hintText: '',contentPadding: EdgeInsets.symmetric(vertical: 1.5 * SizeConfig.heightMultiplier, horizontal: 20.0),)
                              ),
                              width: 68.2 * SizeConfig.widthMultiplier,
                            ),

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
                              child: TextFormField(
                                  readOnly: true,
                                  controller: ctrlRail,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontFamily: 'Poppins', fontSize: 1.84 * SizeConfig.heightMultiplier),
                                  decoration: kTextFieldDecorationNoback.copyWith(
                                    hintText: '',contentPadding: EdgeInsets.symmetric(vertical: 1.5 * SizeConfig.heightMultiplier, horizontal: 20.0),)
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
                              child: TextFormField(
                                  readOnly: true,
                                  controller: ctrlRailTemp,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontFamily: 'Poppins', fontSize: 1.84 * SizeConfig.heightMultiplier),
                                  decoration: kTextFieldDecorationNoback.copyWith(
                                    hintText: '',contentPadding: EdgeInsets.symmetric(vertical: 1.5 * SizeConfig.heightMultiplier, horizontal: 20.0),)
                              ),
                              width: 68.2 * SizeConfig.widthMultiplier,
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
                            Container(
                              child: TextFormField(
                                  readOnly: true,
                                  controller: ctrlWeldType,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontFamily: 'Poppins', fontSize: 1.84 * SizeConfig.heightMultiplier),
                                  decoration: kTextFieldDecorationNoback.copyWith(
                                    hintText: '',contentPadding: EdgeInsets.symmetric(vertical: 1.5 * SizeConfig.heightMultiplier, horizontal: 20.0),)
                              ),
                              width: 68.2 * SizeConfig.widthMultiplier,
                            ),

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
                              child: TextFormField(
                                  readOnly: true,
                                  controller: ctrlRailKG,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontFamily: 'Poppins', fontSize: 1.84 * SizeConfig.heightMultiplier),
                                  decoration: kTextFieldDecorationNoback.copyWith(
                                    hintText: '',contentPadding: EdgeInsets.symmetric(vertical: 1.5 * SizeConfig.heightMultiplier, horizontal: 20.0),)
                              ),
                              width: 68.2 * SizeConfig.widthMultiplier,
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
                              child: TextFormField(
                                  readOnly: true,
                                  controller: ctrlRailType,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontFamily: 'Poppins', fontSize: 1.84 * SizeConfig.heightMultiplier),
                                  decoration: kTextFieldDecorationNoback.copyWith(
                                    hintText: '',contentPadding: EdgeInsets.symmetric(vertical: 1.5 * SizeConfig.heightMultiplier, horizontal: 20.0),)
                              ),
                              width: 68.2 * SizeConfig.widthMultiplier,
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
                            Container(
                              child: TextFormField(
                                  readOnly: true,
                                  controller: ctrlReasonForWeld,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontFamily: 'Poppins', fontSize: 1.84 * SizeConfig.heightMultiplier),
                                  decoration: kTextFieldDecorationNoback.copyWith(
                                    hintText: '',contentPadding: EdgeInsets.symmetric(vertical: 1.5 * SizeConfig.heightMultiplier, horizontal: 20.0),)
                              ),
                              width: 68.2 * SizeConfig.widthMultiplier,
                            ),

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
                            Container(
                              child: TextFormField(
                                  readOnly: true,
                                  controller: ctrlHeatingTrolley,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontFamily: 'Poppins', fontSize: 1.84 * SizeConfig.heightMultiplier),
                                  decoration: kTextFieldDecorationNoback.copyWith(
                                    hintText: '',contentPadding: EdgeInsets.symmetric(vertical: 1.5 * SizeConfig.heightMultiplier, horizontal: 20.0),)
                              ),
                              width: 68.2 * SizeConfig.widthMultiplier,
                            ),

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
                            Container(
                              child: TextFormField(
                                  readOnly: true,
                                  controller: ctrlWasRailAdjusted,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontFamily: 'Poppins', fontSize: 1.84 * SizeConfig.heightMultiplier),
                                  decoration: kTextFieldDecorationNoback.copyWith(
                                    hintText: '',contentPadding: EdgeInsets.symmetric(vertical: 1.5 * SizeConfig.heightMultiplier, horizontal: 20.0),)
                              ),
                              width: 68.2 * SizeConfig.widthMultiplier,
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
                              child: ListTile(title: Center(child: Text('${_weldKitDetailsDate.day}-${_weldKitDetailsDate.month}-${_weldKitDetailsDate.year}')),
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
                                    child: TextFormField(
                                        readOnly: true,
                                        controller: ctrlsteelAddedRemovedmm,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontFamily: 'Poppins', fontSize: 1.84 * SizeConfig.heightMultiplier),
                                        decoration: kTextFieldDecorationNoback.copyWith(
                                          hintText: '',contentPadding: EdgeInsets.symmetric(vertical: 1.5 * SizeConfig.heightMultiplier, horizontal: 20.0),)
                                    ),
                                    width: 68.2 * SizeConfig.widthMultiplier,
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
                                  child: TextFormField(
                                      readOnly: true,
                                      controller: ctrlsteelAddedRemovedmm,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontFamily: 'Poppins', fontSize: 1.84 * SizeConfig.heightMultiplier),
                                      decoration: kTextFieldDecorationNoback.copyWith(
                                        hintText: '',contentPadding: EdgeInsets.symmetric(vertical: 1.5 * SizeConfig.heightMultiplier, horizontal: 20.0),)
                                  ),
                                  width: 30.2 * SizeConfig.widthMultiplier,
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
                                          }),
                                      Text('Me'),
                                      Checkbox(value: _groundByManualEnterName,
                                        activeColor: kShadeColor1,
                                        onChanged: (bool newvalue){},),
                                      Text('Manually Enter Name'),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Checkbox(value: _groundByLeaveBlank,
                                          activeColor: kShadeColor1,
                                          onChanged: (bool newvalue){}),
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
                                              TextFormField(readOnly: true,
                                                  controller: ctrlGroundByManual,
                                                  textAlign: TextAlign.center,
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
                                                TextFormField(readOnly: true,
                                                    controller: ctrlGroundByManualLicence,
                                                    textAlign: TextAlign.center,
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
                                                        TextFormField(readOnly: true,
                                                            controller: ctrlGroundByManualCount,
                                                            textAlign: TextAlign.center,
                                                            style: TextStyle(
                                                                fontFamily: 'Poppins', fontSize: 1.84 * SizeConfig.heightMultiplier),
                                                            decoration: kTextFieldDecorationNoback.copyWith(
                                                              hintText: '',contentPadding: EdgeInsets.symmetric(vertical: 1.5 * SizeConfig.heightMultiplier, horizontal: 20.0),)
                                                        ),

                                                      ],
                                                    ),),
                                              ],
                                            ),)
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              width: 68.2 * SizeConfig.widthMultiplier,
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
                              child: TextFormField(
                                readOnly: true,
                                  controller: ctrlComment,
                                  textAlign: TextAlign.center,
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
                            Container(
                              child: TextFormField(
                                  readOnly: true,
                                  controller: ctrlTopPeaked,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontFamily: 'Poppins', fontSize: 1.84 * SizeConfig.heightMultiplier),
                                  decoration: kTextFieldDecorationNoback.copyWith(
                                    hintText: '',contentPadding: EdgeInsets.symmetric(vertical: 1.5 * SizeConfig.heightMultiplier, horizontal: 20.0),)
                              ),
                              width: 68.2 * SizeConfig.widthMultiplier,
                            ),


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
                            Container(
                              child: TextFormField(
                                  readOnly: true,
                                  controller: ctrlTopDipped,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontFamily: 'Poppins', fontSize: 1.84 * SizeConfig.heightMultiplier),
                                  decoration: kTextFieldDecorationNoback.copyWith(
                                    hintText: '',contentPadding: EdgeInsets.symmetric(vertical: 1.5 * SizeConfig.heightMultiplier, horizontal: 20.0),)
                              ),
                              width: 68.2 * SizeConfig.widthMultiplier,
                            ),

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
                            Container(
                              child: TextFormField(
                                  readOnly: true,
                                  controller: ctrlSidePeaked,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontFamily: 'Poppins', fontSize: 1.84 * SizeConfig.heightMultiplier),
                                  decoration: kTextFieldDecorationNoback.copyWith(
                                    hintText: '',contentPadding: EdgeInsets.symmetric(vertical: 1.5 * SizeConfig.heightMultiplier, horizontal: 20.0),)
                              ),
                              width: 68.2 * SizeConfig.widthMultiplier,
                            ),

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
                            Container(
                              child: TextFormField(
                                  readOnly: true,
                                  controller: ctrlSideDipped,
                                  textAlign: TextAlign.center,
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
}