import 'dart:convert';
import 'package:easy_rails/constants.dart';
import 'package:easy_rails/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

DateTime _weldDate;
bool _workorderNA = false;
bool _workOrderEnter = true;
bool _FlocNA = false;
bool _FlocEnter = true;
bool _railTempNA = false;
bool _railTempEnter = true;
bool _datamarkBeforeNA = false;
bool _datamarkBeforeEnter = true;
bool _datamarkAftereNA = false;
bool _datamarkAfterEnter = true;
bool _weldGrinderMe = false;
bool _weldGrinderManualEnterName = true;
bool _weldGrinderLeaveBlank = false;
bool _weldGrinderManualEnterNameNA = false;
bool _addVerticalAlignmentNA = false;
bool _addVerticalAlignmentEnter = true;
bool _addHorizontalAlignmentNA = false;
bool _addHorizontalAlignmentEnter = true;

bool _reasonForWeldNew = false;
bool _reasonForWeldDefect = true;

bool _waiting = false;
String error='No Error';

var ctrlWorkOrderFinal = TextEditingController();
var ctrlSystem = TextEditingController();
var ctrlkilometrage = TextEditingController();
var ctrlRoad = TextEditingController();
var ctrlFlocFinal = TextEditingController();
var ctrlRail = TextEditingController();
var ctrlRailSize1 = TextEditingController();
var ctrlRailSize2 = TextEditingController();
var ctrlRailGrade1 = TextEditingController();
var ctrlRailGrade2 = TextEditingController();
var ctrlRailType = TextEditingController();
var ctrlNdt = TextEditingController();
var ctrlWeldType = TextEditingController();
var ctrlReasonForWeld = TextEditingController();
var ctrlrailTempFinal = TextEditingController();
var ctrlweldBatchNumber = TextEditingController();
var ctrlStressManagement = TextEditingController();
var ctrlFineWeather = TextEditingController();
var ctrlDataMarkBeforeFinal = TextEditingController();
var ctrlDataMarkAfterFinal = TextEditingController();
var ctrlWeldGrinderManual = TextEditingController();
var ctrlWeldGrinderManualCount = TextEditingController();
var ctrlWeldGrinderManualLicence = TextEditingController();
var ctrlstraightEdgeType = TextEditingController();
var ctrladdVerticalAlignmentFinal = TextEditingController();
var ctrladdHorizontalAlignmentFinal = TextEditingController();
var ctrlHorAlignFieldFace = TextEditingController();
var ctrlGageface = TextEditingController();
var ctrlStandardComment = TextEditingController();
var ctrlCommentsPlain = TextEditingController();

class ViewWeldReturn extends StatefulWidget {
  String weldJson;
  ViewWeldReturn({this.weldJson});
  @override
  _ViewWeldReturnState createState() => _ViewWeldReturnState();
}

class _ViewWeldReturnState extends State<ViewWeldReturn> {


  @override
  void initState() {
    setState(() {
      _waiting = true;
    });
    print(widget.weldJson);
    //Initialize All Data with the picked Record

    _weldDate = jsonDecode(widget.weldJson)["WeldDate"] != null?DateFormat("yyyy-MM-dd hh:mm:ss").parse(jsonDecode(widget.weldJson)["WeldDate"]):DateTime.now();
    ctrlWorkOrderFinal.text = jsonDecode(widget.weldJson)["WorkOrderFinal"];
    _workorderNA = jsonDecode(widget.weldJson)["WorkOrderFinal"]==null?true:false;
    _workOrderEnter = jsonDecode(widget.weldJson)["WorkOrderFinal"] != null?true:false;
    ctrlSystem.text = jsonDecode(widget.weldJson)["SystemCode"];
    ctrlkilometrage.text = jsonDecode(widget.weldJson)["Kilometrage"].toString();
    ctrlRoad.text = jsonDecode(widget.weldJson)["Road"];
    ctrlFlocFinal.text = jsonDecode(widget.weldJson)["FlocFinal"];
    _FlocNA = jsonDecode(widget.weldJson)["FlocFinal"]==null?true:false;
    _FlocEnter = jsonDecode(widget.weldJson)["FlocFinal"] != null?true:false;
    ctrlRail.text = jsonDecode(widget.weldJson)["Rail"];
    ctrlReasonForWeld.text = jsonDecode(widget.weldJson)["ReasonForWeldFinal"];
    _reasonForWeldNew = jsonDecode(widget.weldJson)["ReasonForWeldFinal"]=="New"?true:false;
    _reasonForWeldDefect = jsonDecode(widget.weldJson)["ReasonForWeldFinal"] != "New"?true:false;
    ctrlrailTempFinal.text = jsonDecode(widget.weldJson)["RailTempFinal"];
    _railTempNA = jsonDecode(widget.weldJson)["RailTempFinal"]==null?true:false;
    _railTempEnter = jsonDecode(widget.weldJson)["RailTempFinal"] != null?true:false;
    ctrlRailSize1.text = jsonDecode(widget.weldJson)["RailSize1"];
    ctrlRailSize2.text = jsonDecode(widget.weldJson)["RailSize2"];
    ctrlRailGrade1.text = jsonDecode(widget.weldJson)["RailGrade1"];
    ctrlRailGrade2.text = jsonDecode(widget.weldJson)["RailGrade2"];
    ctrlRailType.text = jsonDecode(widget.weldJson)["RailType"];
    ctrlNdt.text = jsonDecode(widget.weldJson)["NDT"];
    ctrlWeldType.text = jsonDecode(widget.weldJson)["Weld_Type"];
    ctrlweldBatchNumber.text = jsonDecode(widget.weldJson)["WeldBatchNumber"];
    ctrlStressManagement.text = jsonDecode(widget.weldJson)["Stress_Management"];
    ctrlFineWeather.text = jsonDecode(widget.weldJson)["FineWeather"];
    ctrlDataMarkBeforeFinal.text = jsonDecode(widget.weldJson)["DataMarksBeforeFinal"];
    _datamarkBeforeNA = jsonDecode(widget.weldJson)["DataMarksBeforeFinal"]==null?true:false;
    _datamarkBeforeEnter = jsonDecode(widget.weldJson)["DataMarksBeforeFinal"] != null?true:false;
    ctrlDataMarkAfterFinal.text = jsonDecode(widget.weldJson)["DataMarksAfterFinal"];
    _datamarkAftereNA = jsonDecode(widget.weldJson)["DataMarksAfterFinal"]==null?true:false;
    _datamarkAfterEnter = jsonDecode(widget.weldJson)["DataMarksAfterFinal"] != null?true:false;
    ctrlstraightEdgeType.text = jsonDecode(widget.weldJson)["Straight_Edge_Type"];
    ctrladdVerticalAlignmentFinal.text = jsonDecode(widget.weldJson)["VertAlignofRunSurfFinal"];
    _addVerticalAlignmentNA = jsonDecode(widget.weldJson)["VertAlignofRunSurfFinal"]==null?true:false;
    _addVerticalAlignmentEnter = jsonDecode(widget.weldJson)["VertAlignofRunSurfFinal"] != null?true:false;
    ctrladdHorizontalAlignmentFinal.text = jsonDecode(widget.weldJson)["HorAlignofGaugeFaceFinal"];
    _addHorizontalAlignmentNA = jsonDecode(widget.weldJson)["HorAlignofGaugeFaceFinal"]==null?true:false;
    _addHorizontalAlignmentEnter = jsonDecode(widget.weldJson)["HorAlignofGaugeFaceFinal"] != null?true:false;
    ctrlHorAlignFieldFace.text = jsonDecode(widget.weldJson)["HorAlignofFieldFace"];
    ctrlGageface.text = jsonDecode(widget.weldJson)["GageFaceAngleTrans"];
    ctrlStandardComment.text = jsonDecode(widget.weldJson)["COMMENTTEMPLATE"];
    ctrlCommentsPlain.text = jsonDecode(widget.weldJson)["Comments"];
    ctrlWeldGrinderManual.text = jsonDecode(widget.weldJson)["WeldGrinderManual"];
    _weldGrinderMe = false;
    _weldGrinderManualEnterName = true;
    _weldGrinderLeaveBlank = false;
    _weldGrinderManualEnterNameNA = false;
    print(jsonDecode(widget.weldJson)["WeldGrinderManual"]);
    if(jsonDecode(widget.weldJson)["WeldGrinderManual"] == 'Me'){
      ctrlWeldGrinderManualCount.text='';
      ctrlWeldGrinderManualLicence.text='';
      _weldGrinderMe = true;
      _weldGrinderManualEnterName = false;
      _weldGrinderLeaveBlank = false;
      _weldGrinderManualEnterNameNA = false;
    }
    else if(jsonDecode(widget.weldJson)["WeldGrinderManual"] != 'Me' && jsonDecode(widget.weldJson)["WeldGrinderManual"] != 'null' && jsonDecode(widget.weldJson)["WeldGrinderManual"] != null && jsonDecode(widget.weldJson)["WeldGrinderManual"] != 'N/A'){
      print('Not Me');
      ctrlWeldGrinderManual.text = jsonDecode(widget.weldJson)["WeldGrinderManual"];
      ctrlWeldGrinderManualLicence.text = jsonDecode(widget.weldJson)["WeldLicenceManual"];
      ctrlWeldGrinderManualCount.text = jsonDecode(widget.weldJson)["WeldNumberCode"];
      _weldGrinderMe = false;
      _weldGrinderManualEnterName = true;
      _weldGrinderLeaveBlank = false;
      _weldGrinderManualEnterNameNA = false;
    }
    else if(jsonDecode(widget.weldJson)["WeldGrinderManual"] == 'null' && jsonDecode(widget.weldJson)["WeldGrinderManual"] == null){
      print('is NULL');
      ctrlWeldGrinderManualLicence.text = jsonDecode(widget.weldJson)["WeldLicenceManual"];
      ctrlWeldGrinderManualCount.text = jsonDecode(widget.weldJson)["WeldNumberCode"];
      _weldGrinderMe = false;
      _weldGrinderManualEnterName = false;
      _weldGrinderLeaveBlank = true;
      _weldGrinderManualEnterNameNA = false;
    }
    else if(jsonDecode(widget.weldJson)["WeldGrinderManual"] == 'N/A'){
      ctrlWeldGrinderManualLicence.text = jsonDecode(widget.weldJson)["WeldLicenceManual"];
      ctrlWeldGrinderManualCount.text = jsonDecode(widget.weldJson)["WeldNumberCode"];
      _weldGrinderMe = false;
      _weldGrinderManualEnterName = false;
      _weldGrinderLeaveBlank = false;
      _weldGrinderManualEnterNameNA = true;
    }

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
                // Container(
                //   height: 12.25 * SizeConfig.heightMultiplier,
                //  decoration: BoxDecoration(
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
                //         'VIEW WELD RETURN',
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
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(6.35 * SizeConfig.widthMultiplier, 2.63 * SizeConfig.heightMultiplier, 6.35 * SizeConfig.widthMultiplier, 0),
                    child: Form(

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
                              child: ListTile(trailing: IconButton(icon: Icon(Icons.date_range_outlined), onPressed: (){}),
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

                                          }),
                                      Text('Enter Work Order'),
                                      Checkbox(value: _workorderNA,
                                          activeColor: kShadeColor1,
                                          onChanged: (bool newvalue){

                                          }),
                                      Text('N/A'),
                                    ],
                                  ),
                                  Visibility(visible: _workOrderEnter,
                                    child: Container(
                                      child: TextFormField(maxLength: 10,
                                          controller: ctrlWorkOrderFinal,

                                         readOnly: true,
                                          textAlign: TextAlign.center,

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
                            Container(
                              child: TextFormField(
                                  controller: ctrlSystem,
                                  textAlign: TextAlign.center,
                                  readOnly: true,
                                  style: TextStyle(
                                      fontFamily: 'Poppins', fontSize: 1.84 * SizeConfig.heightMultiplier),
                                  decoration: kTextFieldDecorationNoback.copyWith(
                                    hintText: '',contentPadding: EdgeInsets.symmetric(vertical: 1.5 * SizeConfig.heightMultiplier, horizontal: 20.0),)
                              ),
                              width: 68.2 * SizeConfig.widthMultiplier,
                            ),
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
                              child: TextFormField(
                                  controller: ctrlkilometrage,
                                  textAlign: TextAlign.center,
                                  readOnly: true,
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
                            Container(
                              child: TextFormField(
                                  controller: ctrlRoad,
                                  textAlign: TextAlign.center,
                                  readOnly: true,
                                  style: TextStyle(
                                      fontFamily: 'Poppins', fontSize: 1.84 * SizeConfig.heightMultiplier),
                                  decoration: kTextFieldDecorationNoback.copyWith(
                                    hintText: '',contentPadding: EdgeInsets.symmetric(vertical: 1.5 * SizeConfig.heightMultiplier, horizontal: 20.0),)
                              ),
                              width: 68.2 * SizeConfig.widthMultiplier,
                            ),

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

                                          }),
                                      Text('Provide Floc'),
                                      Checkbox(value: _FlocNA,
                                          activeColor: kShadeColor1,
                                          onChanged: (bool newvalue){

                                          }),
                                      Text('N/A'),
                                    ],
                                  ),
                                  Visibility(visible: _FlocEnter,
                                    child: Container(
                                      child: TextFormField(

                                          controller: ctrlFlocFinal,
                                          maxLength: 10,
                                          textAlign: TextAlign.center,
                                         readOnly: true,
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
                            Container(
                              child: TextFormField(
                                  controller: ctrlRail,
                                  textAlign: TextAlign.center,
                                  readOnly: true,
                                  style: TextStyle(
                                      fontFamily: 'Poppins', fontSize: 1.84 * SizeConfig.heightMultiplier),
                                  decoration: kTextFieldDecorationNoback.copyWith(
                                    hintText: '',contentPadding: EdgeInsets.symmetric(vertical: 1.5 * SizeConfig.heightMultiplier, horizontal: 20.0),)
                              ),
                              width: 68.2 * SizeConfig.widthMultiplier,
                            ),

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

                                          }),
                                      Text('Defect'),
                                      Checkbox(value: _reasonForWeldNew,
                                          activeColor: kShadeColor1,
                                          onChanged: (bool newvalue){

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
                                          TextFormField(
                                              controller: ctrlReasonForWeld,
                                              textAlign: TextAlign.center,
                                              readOnly: true,
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
                              child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [

                                      Checkbox(value: _railTempEnter,
                                          activeColor: kShadeColor1,
                                          onChanged: (bool newvalue){

                                          }),
                                      Text('Temp'),
                                      Checkbox(value: _railTempNA,
                                          activeColor: kShadeColor1,
                                          onChanged: (bool newvalue){

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

                                          Container(
                                            child: TextFormField(
                                                controller: ctrlrailTempFinal,
                                                textAlign: TextAlign.center,
                                                readOnly: true,
                                                style: TextStyle(
                                                    fontFamily: 'Poppins', fontSize: 1.84 * SizeConfig.heightMultiplier),
                                                decoration: kTextFieldDecorationNoback.copyWith(
                                                  hintText: '',contentPadding: EdgeInsets.symmetric(vertical: 1.5 * SizeConfig.heightMultiplier, horizontal: 20.0),)
                                            ),

                                          ),

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
                            Container(
                              child: TextFormField(
                                  controller: ctrlRailSize1,
                                  textAlign: TextAlign.center,
                                  readOnly: true,
                                  style: TextStyle(
                                      fontFamily: 'Poppins', fontSize: 1.84 * SizeConfig.heightMultiplier),
                                  decoration: kTextFieldDecorationNoback.copyWith(
                                    hintText: '',contentPadding: EdgeInsets.symmetric(vertical: 1.5 * SizeConfig.heightMultiplier, horizontal: 20.0),)
                              ),
                              width: 68.2 * SizeConfig.widthMultiplier,
                            ),

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
                            Container(
                              child: TextFormField(
                                  controller: ctrlRailSize2,
                                  textAlign: TextAlign.center,
                                  readOnly: true,
                                  style: TextStyle(
                                      fontFamily: 'Poppins', fontSize: 1.84 * SizeConfig.heightMultiplier),
                                  decoration: kTextFieldDecorationNoback.copyWith(
                                    hintText: '',contentPadding: EdgeInsets.symmetric(vertical: 1.5 * SizeConfig.heightMultiplier, horizontal: 20.0),)
                              ),
                              width: 68.2 * SizeConfig.widthMultiplier,
                            ),

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
                            Container(
                              child: TextFormField(
                                  controller: ctrlRailGrade1,
                                  textAlign: TextAlign.center,
                                  readOnly: true,
                                  style: TextStyle(
                                      fontFamily: 'Poppins', fontSize: 1.84 * SizeConfig.heightMultiplier),
                                  decoration: kTextFieldDecorationNoback.copyWith(
                                    hintText: '',contentPadding: EdgeInsets.symmetric(vertical: 1.5 * SizeConfig.heightMultiplier, horizontal: 20.0),)
                              ),
                              width: 68.2 * SizeConfig.widthMultiplier,
                            ),

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
                            Container(
                              child: TextFormField(
                                  controller: ctrlRailGrade2,
                                  textAlign: TextAlign.center,
                                  readOnly: true,
                                  style: TextStyle(
                                      fontFamily: 'Poppins', fontSize: 1.84 * SizeConfig.heightMultiplier),
                                  decoration: kTextFieldDecorationNoback.copyWith(
                                    hintText: '',contentPadding: EdgeInsets.symmetric(vertical: 1.5 * SizeConfig.heightMultiplier, horizontal: 20.0),)
                              ),
                              width: 68.2 * SizeConfig.widthMultiplier,
                            ),

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
                            Container(
                              child: TextFormField(
                                  controller: ctrlRailType,
                                  textAlign: TextAlign.center,
                                  readOnly: true,
                                  style: TextStyle(
                                      fontFamily: 'Poppins', fontSize: 1.84 * SizeConfig.heightMultiplier),
                                  decoration: kTextFieldDecorationNoback.copyWith(
                                    hintText: '',contentPadding: EdgeInsets.symmetric(vertical: 1.5 * SizeConfig.heightMultiplier, horizontal: 20.0),)
                              ),
                              width: 68.2 * SizeConfig.widthMultiplier,
                            ),

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
                            Container(
                              child: TextFormField(
                                  controller: ctrlNdt,
                                  textAlign: TextAlign.center,
                                  readOnly: true,
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
                                  controller: ctrlWeldType,
                                  textAlign: TextAlign.center,
                                  readOnly: true,
                                  style: TextStyle(
                                      fontFamily: 'Poppins', fontSize: 1.84 * SizeConfig.heightMultiplier),
                                  decoration: kTextFieldDecorationNoback.copyWith(
                                    hintText: '',contentPadding: EdgeInsets.symmetric(vertical: 1.5 * SizeConfig.heightMultiplier, horizontal: 20.0),)
                              ),
                              width: 68.2 * SizeConfig.widthMultiplier,
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
                                  controller: ctrlweldBatchNumber,
                                  textAlign: TextAlign.center,
                                  readOnly: true,
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
                            Container(
                              child: TextFormField(
                                  controller: ctrlStressManagement,
                                  textAlign: TextAlign.center,
                                  readOnly: true,
                                  style: TextStyle(
                                      fontFamily: 'Poppins', fontSize: 1.84 * SizeConfig.heightMultiplier),
                                  decoration: kTextFieldDecorationNoback.copyWith(
                                    hintText: '',contentPadding: EdgeInsets.symmetric(vertical: 1.5 * SizeConfig.heightMultiplier, horizontal: 20.0),)
                              ),
                              width: 68.2 * SizeConfig.widthMultiplier,
                            ),

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
                            Container(
                              child: TextFormField(
                                  controller: ctrlFineWeather,
                                  textAlign: TextAlign.center,
                                  readOnly: true,
                                  style: TextStyle(
                                      fontFamily: 'Poppins', fontSize: 1.84 * SizeConfig.heightMultiplier),
                                  decoration: kTextFieldDecorationNoback.copyWith(
                                    hintText: '',contentPadding: EdgeInsets.symmetric(vertical: 1.5 * SizeConfig.heightMultiplier, horizontal: 20.0),)
                              ),
                              width: 68.2 * SizeConfig.widthMultiplier,
                            ),

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

                                          }),
                                      Text('Enter Data Mark'),
                                      Checkbox(value: _datamarkBeforeNA,
                                          activeColor: kShadeColor1,
                                          onChanged: (bool newvalue){

                                          }),
                                      Text('N/A'),
                                    ],
                                  ),
                                  Visibility(visible: _datamarkBeforeEnter,
                                    child: Container(
                                      child: TextFormField(
                                          readOnly: true,
                                          controller: ctrlDataMarkBeforeFinal,
                                          textAlign: TextAlign.center,

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

                                          }),
                                      Text('Enter Data Mark'),
                                      Checkbox(value: _datamarkAftereNA,
                                          activeColor: kShadeColor1,
                                          onChanged: (bool newvalue){

                                          }),
                                      Text('N/A'),
                                    ],
                                  ),
                                  Visibility(visible: _datamarkAfterEnter,
                                    child: Container(
                                      child: TextFormField(

                                          controller: ctrlDataMarkAfterFinal,
                                          textAlign: TextAlign.center,
                                          readOnly: true,
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

                                          }),
                                      Text('Me'),
                                      Checkbox(value: _weldGrinderManualEnterName,
                                          activeColor: kShadeColor1,
                                          onChanged: (bool newvalue){

                                          },),
                                      Text('Manually Enter Name'),
                                    ],

                                  ),
                                  Row(
                                    children: [
                                      Checkbox(value: _weldGrinderLeaveBlank,
                                          activeColor: kShadeColor1,
                                          onChanged: (bool newvalue){

                                          }),
                                      Text('Leave Blank'),
                                      Checkbox(value: _weldGrinderManualEnterNameNA,
                                          activeColor: kShadeColor1,
                                          onChanged: (bool newvalue){

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
                                                    controller: ctrlWeldGrinderManual,
                                                    textAlign: TextAlign.center,
                                                   readOnly: true,
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

                                              controller: ctrlWeldGrinderManualLicence,
                                              textAlign: TextAlign.center,
                                              readOnly: true,
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
                                          TextFormField(readOnly: true,controller: ctrlWeldGrinderManualCount,
                                              textAlign: TextAlign.center,

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
                            Container(
                              child: TextFormField(
                                  controller: ctrlstraightEdgeType,
                                  textAlign: TextAlign.center,
                                  readOnly: true,
                                  style: TextStyle(
                                      fontFamily: 'Poppins', fontSize: 1.84 * SizeConfig.heightMultiplier),
                                  decoration: kTextFieldDecorationNoback.copyWith(
                                    hintText: '',contentPadding: EdgeInsets.symmetric(vertical: 1.5 * SizeConfig.heightMultiplier, horizontal: 20.0),)
                              ),
                              width: 68.2 * SizeConfig.widthMultiplier,
                            ),

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

                                          }),
                                      Text('Add Alignment'),
                                      Checkbox(value: _addVerticalAlignmentNA,
                                          activeColor: kShadeColor1,
                                          onChanged: (bool newvalue){

                                          }),
                                      Text('N/A'),
                                    ],
                                  ),
                                  Visibility(visible: _addVerticalAlignmentEnter,
                                    child: Container(
                                      child: TextFormField(
                                        readOnly: true,
                                          controller: ctrladdVerticalAlignmentFinal,
                                          textAlign: TextAlign.center,

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

                                          }),
                                      Text('Add Alignment'),
                                      Checkbox(value: _addHorizontalAlignmentNA,
                                          activeColor: kShadeColor1,
                                          onChanged: (bool newvalue){

                                          }),
                                      Text('N/A'),
                                    ],
                                  ),
                                  Visibility(visible: _addHorizontalAlignmentEnter,
                                    child: Container(
                                      child: TextFormField(
                                          readOnly: true,
                                          controller: ctrladdHorizontalAlignmentFinal,
                                          textAlign: TextAlign.center,

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
                            Container(
                              child: TextFormField(
                                  controller: ctrlHorAlignFieldFace,
                                  textAlign: TextAlign.center,
                                  readOnly: true,
                                  style: TextStyle(
                                      fontFamily: 'Poppins', fontSize: 1.84 * SizeConfig.heightMultiplier),
                                  decoration: kTextFieldDecorationNoback.copyWith(
                                    hintText: '',contentPadding: EdgeInsets.symmetric(vertical: 1.5 * SizeConfig.heightMultiplier, horizontal: 20.0),)
                              ),
                              width: 68.2 * SizeConfig.widthMultiplier,
                            ),


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
                            Container(
                              child: TextFormField(
                                  controller: ctrlGageface,
                                  textAlign: TextAlign.center,
                                  readOnly: true,
                                  style: TextStyle(
                                      fontFamily: 'Poppins', fontSize: 1.84 * SizeConfig.heightMultiplier),
                                  decoration: kTextFieldDecorationNoback.copyWith(
                                    hintText: '',contentPadding: EdgeInsets.symmetric(vertical: 1.5 * SizeConfig.heightMultiplier, horizontal: 20.0),)
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
                            Container(
                              child: TextFormField(
                                  controller: ctrlStandardComment,
                                  textAlign: TextAlign.center,
                                  readOnly: true,
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
                              child: TextFormField(readOnly: true,
                                  controller: ctrlCommentsPlain,maxLines: 5,
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