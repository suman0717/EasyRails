import 'dart:convert';
import 'package:easy_rails/constants.dart';
import 'package:easy_rails/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'dart:io' show File, Platform;

class ViewARTCWeldReturn extends StatefulWidget {
  String weldJson;

  ViewARTCWeldReturn({this.weldJson});

  @override
  _ViewARTCWeldReturnState createState() => _ViewARTCWeldReturnState();
}

class _ViewARTCWeldReturnState extends State<ViewARTCWeldReturn> {
  DateTime _weldLocationDate;
  bool _railTempNA = false;
  bool _railTempEnter = true;
  bool _punchmarkBeforeNA = false;
  bool _punchmarkBeforeEnter = true;
  bool _punchmarkAftereNA = false;
  bool _punchmarkAfterEnter = true;
  bool _railTempNA1 = false;
  bool _railTempEnter1 = true;
  DateTime _railFlawDate;
  bool _ok = true;
  bool _punchMarckCheck = true;
  bool _RailFlawCompleted = true;

  var ctrlweldLocationCode = TextEditingController();
  var ctrlweldLocationTrack = TextEditingController();
  var ctrlkilometer = TextEditingController();
  var ctrlaRTCLocalBatch = TextEditingController();
  var ctrlRail = TextEditingController();
  var ctrlRailSize = TextEditingController();
  var ctrlWeldReason = TextEditingController();
  var ctrlWeldType = TextEditingController();
  var ctrlSiteConditionWeather = TextEditingController();
  var ctrlSiteConditionTrack = TextEditingController();
  var ctrlSiteConditionWeld = TextEditingController();
  var ctrlPunchMarkBeforeFinal = TextEditingController();
  var ctrlPunchMarkAfterFinal = TextEditingController();
  var ctrlrailTempFinal = TextEditingController();
  var ctrlrailTempFinal1 = TextEditingController();
  var ctrlkmFrom = TextEditingController();
  var ctrlkmTo = TextEditingController();

  @override
  void initState() {
    //Initialize fields Start
    _weldLocationDate = jsonDecode(widget.weldJson)["Date_Welders"] != null
        ? DateFormat("yyyy-MM-dd hh:mm:ss")
            .parse(jsonDecode(widget.weldJson)["Date_Welders"])
        : DateTime.now();
    _railFlawDate = jsonDecode(widget.weldJson)["Date_RailFlaw"] != null
        ? DateFormat("yyyy-MM-dd hh:mm:ss")
            .parse(jsonDecode(widget.weldJson)["Date_RailFlaw"])
        : DateTime.now();
    ctrlweldLocationCode.text = jsonDecode(widget.weldJson)["Code"];
    ctrlweldLocationTrack.text = jsonDecode(widget.weldJson)["Track"];
    ctrlkilometer.text = jsonDecode(widget.weldJson)["Kilometer"];
    ctrlRail.text = jsonDecode(widget.weldJson)["Rail"];
    ctrlRailSize.text = jsonDecode(widget.weldJson)["RailSize"];
    ctrlWeldReason.text = jsonDecode(widget.weldJson)["WeldReason"];
    ctrlaRTCLocalBatch.text = jsonDecode(widget.weldJson)["BatchNo"];
    ctrlWeldType.text = jsonDecode(widget.weldJson)["Weld_Type"];
    ctrlSiteConditionWeather.text =
        jsonDecode(widget.weldJson)["Weather_SiteCondition"];
    ctrlSiteConditionWeld.text =
        jsonDecode(widget.weldJson)["Weld_SiteCondition"];
    ctrlSiteConditionTrack.text =
        jsonDecode(widget.weldJson)["Track_SiteCondition"];
    ctrlrailTempFinal.text = jsonDecode(widget.weldJson)["RailTempFinal"];
    _railTempNA = jsonDecode(widget.weldJson)["RailTempFinal"] == null ||
            jsonDecode(widget.weldJson)["RailTempFinal"] == 'N/A'
        ? true
        : false;
    _railTempEnter = jsonDecode(widget.weldJson)["RailTempFinal"] != null &&
            jsonDecode(widget.weldJson)["RailTempFinal"] != 'N/A'
        ? true
        : false;
    ctrlPunchMarkBeforeFinal.text =
        jsonDecode(widget.weldJson)["PunchMarksBeforeFinal"];
    _punchmarkBeforeNA =
        jsonDecode(widget.weldJson)["PunchMarksBeforeFinal"] == null ||
                jsonDecode(widget.weldJson)["PunchMarksBeforeFinal"] == 'N/A'
            ? true
            : false;
    _punchmarkBeforeEnter =
        jsonDecode(widget.weldJson)["PunchMarksBeforeFinal"] != null &&
                jsonDecode(widget.weldJson)["PunchMarksBeforeFinal"] != 'N/A'
            ? true
            : false;
    ctrlPunchMarkAfterFinal.text =
        jsonDecode(widget.weldJson)["PunchMarksAfterFinal"];
    _punchmarkAftereNA =
        jsonDecode(widget.weldJson)["PunchMarksAfterFinal"] == null ||
                jsonDecode(widget.weldJson)["PunchMarksAfterFinal"] == 'N/A'
            ? true
            : false;
    _punchmarkAfterEnter =
        jsonDecode(widget.weldJson)["PunchMarksAfterFinal"] != null &&
                jsonDecode(widget.weldJson)["PunchMarksAfterFinal"] != 'N/A'
            ? true
            : false;
    ctrlkmFrom.text = jsonDecode(widget.weldJson)["FromPoint"];
    ctrlkmTo.text = jsonDecode(widget.weldJson)["ToPoint"];
    ctrlrailTempFinal1.text =
        jsonDecode(widget.weldJson)["RailTempFinal_InCharge"];
    _railTempNA1 =
        jsonDecode(widget.weldJson)["RailTempFinal_InCharge"] == null ||
                jsonDecode(widget.weldJson)["RailTempFinal_InCharge"] == 'N/A'
            ? true
            : false;
    _railTempEnter1 =
        jsonDecode(widget.weldJson)["RailTempFinal_InCharge"] != null &&
                jsonDecode(widget.weldJson)["RailTempFinal_InCharge"] != 'N/A'
            ? true
            : false;
    _ok = jsonDecode(widget.weldJson)["OK"] == 'Yes' ? true : false;
    _punchMarckCheck =
        jsonDecode(widget.weldJson)["Punch_Mark_Check"] == 'Yes' ? true : false;
    _RailFlawCompleted =
        jsonDecode(widget.weldJson)["RailFlawReportCompleted"] == 'Yes'
            ? true
            : false;

    //Initialize fields End

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Edit Weld Return',
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
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                  6.35 * SizeConfig.widthMultiplier,
                  2.63 * SizeConfig.heightMultiplier,
                  6.35 * SizeConfig.widthMultiplier,
                  0),
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
                          border:
                              Border.all(color: Color(0xffe8e8e8), width: 1.0),
                        ),
                        child: ListTile(
                          trailing: IconButton(
                              icon: Icon(Icons.date_range_outlined),
                              onPressed: () {}),
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
                        child: TextFormField(
                            controller: ctrlweldLocationCode,
                            readOnly: true,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 1.84 * SizeConfig.heightMultiplier),
                            decoration: kTextFieldDecorationNoback.copyWith(
                              hintText: '',
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 1.5 * SizeConfig.heightMultiplier,
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
                        child: TextFormField(
                            controller: ctrlweldLocationTrack,
                            readOnly: true,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 1.84 * SizeConfig.heightMultiplier),
                            decoration: kTextFieldDecorationNoback.copyWith(
                              hintText: '',
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 1.5 * SizeConfig.heightMultiplier,
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
                        child: TextFormField(
                            controller: ctrlkilometer,
                            textAlign: TextAlign.center,
                            readOnly: true,
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 1.84 * SizeConfig.heightMultiplier),
                            decoration: kTextFieldDecorationNoback.copyWith(
                              hintText: '',
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 1.5 * SizeConfig.heightMultiplier,
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
                        child: TextFormField(
                            controller: ctrlRail,
                            readOnly: true,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 1.84 * SizeConfig.heightMultiplier),
                            decoration: kTextFieldDecorationNoback.copyWith(
                              hintText: '',
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 1.5 * SizeConfig.heightMultiplier,
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
                      Container(
                        child: TextFormField(
                            controller: ctrlRailSize,
                            readOnly: true,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 1.84 * SizeConfig.heightMultiplier),
                            decoration: kTextFieldDecorationNoback.copyWith(
                              hintText: '',
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 1.5 * SizeConfig.heightMultiplier,
                                  horizontal: 20.0),
                            )),
                        width: 68.2 * SizeConfig.widthMultiplier,
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
                      Container(
                        child: TextFormField(
                            controller: ctrlWeldReason,
                            readOnly: true,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 1.84 * SizeConfig.heightMultiplier),
                            decoration: kTextFieldDecorationNoback.copyWith(
                              hintText: '',
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 1.5 * SizeConfig.heightMultiplier,
                                  horizontal: 20.0),
                            )),
                        width: 68.2 * SizeConfig.widthMultiplier,
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
                        child: TextFormField(
                            controller: ctrlaRTCLocalBatch,
                            textAlign: TextAlign.center,
                            readOnly: true,
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 1.84 * SizeConfig.heightMultiplier),
                            decoration: kTextFieldDecorationNoback.copyWith(
                              hintText: '',
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 1.5 * SizeConfig.heightMultiplier,
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
                      Container(
                        child: TextFormField(
                            controller: ctrlWeldType,
                            textAlign: TextAlign.center,
                            readOnly: true,
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 1.84 * SizeConfig.heightMultiplier),
                            decoration: kTextFieldDecorationNoback.copyWith(
                              hintText: '',
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 1.5 * SizeConfig.heightMultiplier,
                                  horizontal: 20.0),
                            )),
                        width: 68.2 * SizeConfig.widthMultiplier,
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
                      Container(
                        child: TextFormField(
                            controller: ctrlSiteConditionWeather,
                            textAlign: TextAlign.center,
                            readOnly: true,
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 1.84 * SizeConfig.heightMultiplier),
                            decoration: kTextFieldDecorationNoback.copyWith(
                              hintText: '',
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 1.5 * SizeConfig.heightMultiplier,
                                  horizontal: 20.0),
                            )),
                        width: 68.2 * SizeConfig.widthMultiplier,
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
                      Container(
                        child: TextFormField(
                            controller: ctrlSiteConditionWeld,
                            textAlign: TextAlign.center,
                            readOnly: true,
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 1.84 * SizeConfig.heightMultiplier),
                            decoration: kTextFieldDecorationNoback.copyWith(
                              hintText: '',
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 1.5 * SizeConfig.heightMultiplier,
                                  horizontal: 20.0),
                            )),
                        width: 68.2 * SizeConfig.widthMultiplier,
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
                      Container(
                        child: TextFormField(
                            controller: ctrlSiteConditionTrack,
                            textAlign: TextAlign.center,
                            readOnly: true,
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 1.84 * SizeConfig.heightMultiplier),
                            decoration: kTextFieldDecorationNoback.copyWith(
                              hintText: '',
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 1.5 * SizeConfig.heightMultiplier,
                                  horizontal: 20.0),
                            )),
                        width: 68.2 * SizeConfig.widthMultiplier,
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
                                    onChanged: (bool newvalue) {}),
                                Text('Enter Punch Mark'),
                                Checkbox(
                                    value: _punchmarkBeforeNA,
                                    activeColor: kShadeColor1,
                                    onChanged: (bool newvalue) {}),
                                Text('N/A'),
                              ],
                            ),
                            Visibility(
                              visible: _punchmarkBeforeEnter,
                              child: Container(
                                child: TextFormField(
                                    readOnly: true,
                                    controller: ctrlPunchMarkBeforeFinal,
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
                                    onChanged: (bool newvalue) {}),
                                Text('Enter Punch Mark'),
                                Checkbox(
                                    value: _punchmarkAftereNA,
                                    activeColor: kShadeColor1,
                                    onChanged: (bool newvalue) {}),
                                Text('N/A'),
                              ],
                            ),
                            Visibility(
                              visible: _punchmarkAfterEnter,
                              child: Container(
                                child: TextFormField(
                                    readOnly: true,
                                    controller: ctrlPunchMarkAfterFinal,
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
                                    onChanged: (bool newvalue) {}),
                                Text('Temp'),
                                Checkbox(
                                    value: _railTempNA,
                                    activeColor: kShadeColor1,
                                    onChanged: (bool newvalue) {}),
                                Text('N/A'),
                              ],
                            ),
                            Visibility(
                              visible: _railTempEnter,
                              child: Container(
                                child: TextFormField(
                                    controller: ctrlrailTempFinal,
                                    textAlign: TextAlign.center,
                                    readOnly: true,
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
                              ),
                            ),
                          ],
                        ),
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
                        child: TextFormField(
                            controller: ctrlkmFrom,
                            textAlign: TextAlign.center,
                            readOnly: true,
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 1.84 * SizeConfig.heightMultiplier),
                            decoration: kTextFieldDecorationNoback.copyWith(
                              hintText: '',
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 1.5 * SizeConfig.heightMultiplier,
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
                        child: TextFormField(
                            controller: ctrlkmTo,
                            readOnly: true,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 1.84 * SizeConfig.heightMultiplier),
                            decoration: kTextFieldDecorationNoback.copyWith(
                              hintText: '',
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 1.5 * SizeConfig.heightMultiplier,
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
                                    onChanged: (bool newvalue) {}),
                                Text('Temp'),
                                Checkbox(
                                    value: _railTempNA1,
                                    activeColor: kShadeColor1,
                                    onChanged: (bool newvalue) {}),
                                Text('N/A'),
                              ],
                            ),
                            Visibility(
                              visible: _railTempEnter1,
                              child: Container(
                                child: TextFormField(
                                    controller: ctrlrailTempFinal1,
                                    textAlign: TextAlign.center,
                                    readOnly: true,
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
                              ),
                            ),
                          ],
                        ),
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
                          border:
                              Border.all(color: Color(0xffe8e8e8), width: 1.0),
                        ),
                        child: ListTile(
                          trailing: IconButton(
                              icon: Icon(Icons.date_range_outlined),
                              onPressed: () {}),
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
                                    onChanged: (bool newvalue) {}),
                                Text('Yes'),
                                Checkbox(
                                    value: !_ok,
                                    activeColor: kShadeColor1,
                                    onChanged: (bool newvalue) {}),
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
                                    onChanged: (bool newvalue) {}),
                                Text('Yes'),
                                Checkbox(
                                    value: !_RailFlawCompleted,
                                    activeColor: kShadeColor1,
                                    onChanged: (bool newvalue) {}),
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
                                    onChanged: (bool newvalue) {}),
                                Text('Yes'),
                                Checkbox(
                                    value: !_punchMarckCheck,
                                    activeColor: kShadeColor1,
                                    onChanged: (bool newvalue) {}),
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
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
