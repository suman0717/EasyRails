import 'dart:convert';
import 'package:easy_rails/constants.dart';
import 'package:easy_rails/customdropdown.dart';
import 'package:easy_rails/size_config.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:email_validator/email_validator.dart';

int aWCounter = 0;
bool _waiting = false;
String error = 'No Error';
String temparr;
bool isReportGenerated = false;

var _weldReturnFormKey = GlobalKey<FormState>();
var _supervisorFormKey = GlobalKey<FormState>();


class WeldReturnForm extends StatefulWidget {
  @override
  _WeldReturnFormState createState() => _WeldReturnFormState();
}

class _WeldReturnFormState extends State<WeldReturnForm> {
  String _welder;
  String _supervisor;
  String _operator;
  String _contractor;
  var ctrlRailOperator = TextEditingController();
  var ctrlContractor = TextEditingController();

  var tmpArray = [];
  getCheckboxItems(){

    AurizonWeldReturnMap.forEach((key, value) {
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
    AurizonWeldReturnMap = {};
    _welder = loggedinUserFName +' '+loggedinUserSName;
    print(loggedinUserContractor);
    ctrlContractor.text = _contractor = loggedinUserContractor;
    ctrlRailOperator.text = _operator = 'Aurizon Weld Returns';

    GetGenericDataForWeldreturnForm().whenComplete(() {
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
    AurizonWeldReturnMap = {};
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
      else if(_supervisor == null){
        _isWeldReurnvalid = false;
        ShowFlushbar('Error','Please Provide Supervisor',Icons.close,context);
      }
      else if(_operator == null){
        _isWeldReurnvalid = false;
        ShowFlushbar('Error','Please Provide Operator',Icons.close,context);
      }
      else if(_contractor == null){
        _isWeldReurnvalid = false;
        ShowFlushbar('Error','Please Provide Contractor',Icons.close,context);
      }
      else if(aWCounter<1){

        _isWeldReurnvalid = false;
        ShowFlushbar('Error','Please Choose Atleast One Weld Return',Icons.close,context);
      }
    }
    return Scaffold(resizeToAvoidBottomPadding: true,
      appBar: AppBar( centerTitle: true,
        title: Text('Aurizon Weld Return Form',style: TextStyle(
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
                      key: _weldReturnFormKey,
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
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
                              await GetGenericDataAurizonWeldReturn(kAurizonWeldListUrl +s);
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
                              padding: EdgeInsets.only(bottom: 8.0, top: 20),
                              child: Text(
                                'Choose Rail Operator',
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
                                  controller: ctrlRailOperator,
                                  // textAlign: TextAlign.center,
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
                              child: Row(
                                children: [
                                  Text(
                                    'Choose Supervisor',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 1.7 * SizeConfig.heightMultiplier,
                                      color: const Color(0xffa1a1a1),
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                  IconButton(icon: Icon(Icons.add),onPressed:
                                  AddNewSupervisorToOperator
                                  ),
                                  IconButton(icon: Icon(Icons.refresh),onPressed: () async{
                                    setState(() {
                                      _waiting = true;
                                    });
                                    await GetGenericDataSupervisor(kSupervisorListUrl +'Aurizon Weld Returns');
                                    setState(() {
                                      _waiting = false;
                                    });
                                  }
                                  ),
                                ],
                              ),
                            ),
                            DropDownField(onValueChanged: (dynamic s) async {
                              print('akjsdsa');
                              print(s);
                              setState(() {
                                _waiting=true;
                              });

                              setState(()  {
                                _supervisor = s;
                                _waiting=false;
                              },
                              );
                            },textStyle: TextStyle(height: 0.9,
                                fontFamily: 'Poppins', fontSize: 1.84 * SizeConfig.heightMultiplier),
                                value: _supervisor,
                                required: false,
                                hintText: 'Choose a Supervisor',
                                hintStyle: TextStyle(height: 1.0,
                                    fontFamily: 'Poppins', fontSize: 1.84 * SizeConfig.heightMultiplier),
                                items: supervisorList,
                                strict: true,
                                setter: (dynamic newValue) {
                                  print('Setter');
                                  _supervisor = newValue;
                                }),

                            Padding(
                              padding: EdgeInsets.only(bottom: 8.0, top: 20),
                              child: Text(
                                'Choose Contractor',
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
                                  controller: ctrlContractor,
                                  // textAlign: TextAlign.center,
                                  readOnly: true,
                                  style: TextStyle(
                                      fontFamily: 'Poppins', fontSize: 1.84 * SizeConfig.heightMultiplier),
                                  decoration: kTextFieldDecorationNoback.copyWith(
                                    hintText: '',contentPadding: EdgeInsets.symmetric(vertical: 1.5 * SizeConfig.heightMultiplier, horizontal: 20.0),)
                              ),
                              width: 68.2 * SizeConfig.widthMultiplier,
                            ),
                            // DropDownField(onValueChanged: (dynamic s) async {
                            //   print('akjsdsa');
                            //   print(s);
                            //   setState(() {
                            //     _waiting=true;
                            //   });
                            //
                            //   setState(()  {
                            //     _contractor = s;
                            //     _waiting=false;
                            //   },
                            //   );
                            // },textStyle: TextStyle(height: 0.9,
                            //     fontFamily: 'Poppins', fontSize: 1.84 * SizeConfig.heightMultiplier),
                            //     value: _contractor,
                            //     required: false,
                            //     hintText: 'Choose a Contractor',
                            //     hintStyle: TextStyle(height: 1.0,
                            //         fontFamily: 'Poppins', fontSize: 1.84 * SizeConfig.heightMultiplier),
                            //     items: contractorList,
                            //     strict: true,
                            //     setter: (dynamic newValue) {
                            //       print('Setter');
                            //       _contractor = newValue;
                            //     }),

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
                                  getCheckboxItems();
                                  _validate();
                                  if(_isWeldReurnvalid){
                                    print('https://eventricity.online/app/REST/EasyRails/App_Create_WeldReturnForm?WelderID=$_welder&RailOperatorID=$_operator&SupervisorID=$_supervisor&ContractorID=$_contractor&pm_AWRID=$temparr');
                                    http.Response _response = await http.get('https://eventricity.online/app/REST/EasyRails/App_Create_WeldReturnForm?WelderID=$_welder&RailOperatorID=$_operator&SupervisorID=$_supervisor&ContractorID=$_contractor&pm_AWRID=$temparr');
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

  void AddNewSupervisorToOperator() async {
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
            return ModalProgressHUD(inAsyncCall: _localWaiting,
              child: AlertDialog(
                title: Text("Add Supervisor"),
                content: GestureDetector(onTap: (){
                  FocusScope.of(context).unfocus();
                },
                  child: SingleChildScrollView(
                    child: Form(key: _supervisorFormKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            child: TextFormField(validator: (String value){
                              if(value.isEmpty){
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
                            child: TextFormField(validator: (String value){
                              if(value.isEmpty){
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
                            child: TextFormField(validator: (String value) {
                              if (value.isEmpty) {
                                return 'Email address must be provided';
                              } else if (EmailValidator.validate(
                                  value) !=
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
                                inputFormatters: [
                                  mobileMaskAustralia
                                ],
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
                                  _mobile = ( mobileMaskAustralia).getUnmaskedText();
                                  _maskednumber = (mobileMaskAustralia).getMaskedText();
                                  print(_mobile);
                                  print(_maskednumber);
                                },
                                style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 2 * SizeConfig.heightMultiplier),
                                decoration:
                                kTextFieldDecorationNoback.copyWith(
                                  hintText: 'Mobile',
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical:
                                      1.5 * SizeConfig.heightMultiplier,
                                      horizontal: 5.10 *
                                          SizeConfig.widthMultiplier),
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
                                if(_supervisorFormKey.currentState.validate()){
                                  setState(() {
                                    _localWaiting=true;
                                  });
                                  FocusManager.instance.primaryFocus.unfocus();
                                  print('https://eventricity.online/app/REST/EasyRails/App_AddNewSupervisor?First_Name=$_firstName&Surname=$_surname&EmailAddress=$_emailAddress&Temp_pdw=$_password&Mobile=$_mobile&Mobile_validated=$_maskednumber&RailOperatorID=$_operator');
                                  http.Response _response = await http.get('https://eventricity.online/app/REST/EasyRails/App_AddNewSupervisor?First_Name=$_firstName&Surname=$_surname&EmailAddress=$_emailAddress&Temp_pdw=$_password&Mobile=$_mobile&Mobile_validated=$_maskednumber&RailOperatorID=$_operator');
                                  print(_response.body);
                                  var _responseBody = _response.body;
                                  error = jsonDecode(_responseBody)['Error'];
                                  print(error);
                                  if(error!='No Error'){
                                    ShowFlushbar('Error',error,Icons.close,context);
                                  }
                                  else if(error=='No Error'){
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

                                    await GetGenericDataSupervisor(kSupervisorListUrl +'Aurizon Weld Returns');
                                    setState(() {
                                      _supervisor = jsonDecode(_responseBody)['FullName'];
                                      _localWaiting=false;
                                        ctrlMobile.text='';
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
                                  padding: EdgeInsets.only(left: 0.0, right: 0.0),
                                  child: Container(
                                    constraints: BoxConstraints(
                                        maxWidth: 67.85 * SizeConfig.widthMultiplier,
                                        minHeight: 6.57 * SizeConfig.heightMultiplier),
                                    alignment: Alignment.center,
                                    child: Text(
                                      'Add',
                                      style: TextStyle(
                                        fontFamily: 'Manrope',
                                        fontSize: 2.0 * SizeConfig.heightMultiplier,
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

}

class CheckboxWidget extends StatefulWidget {
  @override
  CheckboxWidgetState createState() => new CheckboxWidgetState();
}

class CheckboxWidgetState extends State {
  var tmpArray = [];

  getCheckboxItems(){

    AurizonWeldReturnMap.forEach((key, value) {
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
      children: AurizonWeldReturnMap.keys.map((String key) {

        return CheckboxListTile(
          title: Text(key),
          value: AurizonWeldReturnMap[key],
          activeColor: kShadeColor1,
          checkColor: Colors.white,
          onChanged: (bool value) {
            setState(() {
              print(value);
              if(value == true && aWCounter < 7){
                aWCounter++;
                AurizonWeldReturnMap[key] = value;
              }
              else if(value == false && aWCounter > 0){
                aWCounter--;
                AurizonWeldReturnMap[key] = value;
              }
              print(aWCounter);
            });
          },
        );
      }).toList(),
    );
  }
}
