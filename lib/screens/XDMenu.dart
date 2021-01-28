import 'package:easy_rails/alert.dart';
import 'package:easy_rails/bottomBar.dart';
import 'package:easy_rails/constants.dart';
import 'package:easy_rails/rounded_button.dart';
import 'package:easy_rails/screens/XDCalc.dart';
import 'package:easy_rails/screens/qrweldreturn/QRweldReturnForm.dart';
import 'package:easy_rails/screens/qrweldreturn/newQRWeldReturn.dart';
import 'package:easy_rails/screens/qrweldreturn/tabQRweldreturn.dart';
import 'package:flushbar/flushbar.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'artcweldreturn/tabartcweldreturn.dart';
import 'file:///C:/Users/test/AndroidStudioProjects/easy_rails/lib/screens/artcweldreturn/artcWeldReturn.dart';
import 'file:///C:/Users/test/AndroidStudioProjects/easy_rails/lib/screens/artcweldreturn/artcweldReturnForm.dart';
import 'file:///C:/Users/test/AndroidStudioProjects/easy_rails/lib/screens/aurizonweldreturn/tabawrweldreturn.dart';
import 'file:///C:/Users/test/AndroidStudioProjects/easy_rails/lib/screens/aurizonweldreturn/weldReturnForm.dart';
import 'package:easy_rails/size_config.dart';
import 'package:easy_rails/test.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'aurizonweldreturn/newWeldReturn.dart';

class XDMenu extends StatefulWidget {
  @override
  _XDMenuState createState() => _XDMenuState();
}

class _XDMenuState extends State<XDMenu> {
  int selectedIndex = 2;
  int selectedAppIndex = 2;

  @override
  void initState() {
    checkConnection();
    super.initState();
  }

  void showAlert() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return CustomAlertDialogNoInternetProceed();
      },
    );
  }

  void UpdateOperatorAlertBox() async {
    bool _localWaiting = false;
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return ModalProgressHUD(
              inAsyncCall: _localWaiting,
              child: AlertDialog(
                title: Text("Choose Rail Operator"),
                content: GestureDetector(
                  onTap: () {
                    FocusScope.of(context).unfocus();
                  },
                  child: SingleChildScrollView(
                    child: Form(
                      child: Container(
//                          height: 5.13 * SizeConfig.heightMultiplier,
                        width: 68.2 * SizeConfig.widthMultiplier,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                              3.95 * SizeConfig.heightMultiplier),
                          border:
                              Border.all(color: Color(0xffe8e8e8), width: 1.0),
                        ),
                        child: Center(
                          child: DropdownButton<String>(
                            onTap: () {
                              FocusManager.instance.primaryFocus.unfocus();
                            },
                            icon: Icon(
                              Icons.keyboard_arrow_down,
                              size: 2.5 * SizeConfig.heightMultiplier,
                            ),
                            underline: Container(
                              height: 1.0,
                              decoration: const BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        color: Colors.transparent, width: 1.0)),
                              ),
                            ),
                            value: KActiveRailOperator,
                            items: [
                              'Aurizon Weld Returns',
                              'QR Weld Returns',
                              'ARTC Weld Returns'
                            ].map(
                              (String dropdownitem) {
                                return DropdownMenuItem<String>(
                                  value: dropdownitem,
                                  child: Text(
                                    dropdownitem,
                                    style: TextStyle(
                                        fontFamily: 'Manrope',
                                        fontSize:
                                            1.84 * SizeConfig.heightMultiplier),
                                  ),
                                );
                              },
                            ).toList(),
                            onChanged: (String newselectedOperator) async {
                              setState(() {
                                _localWaiting = true;
                              });
                              String _error = await UpdateOperator(
                                  loggedinUserID, newselectedOperator);
                              SharedPreferences sharedPreferences =
                                  await SharedPreferences.getInstance();
                              if (_error == 'No Error') {
                                setState(
                                  ()  {
                                    KActiveRailOperator = newselectedOperator;
                                    sharedPreferences.setString(
                                        'ActiveRailOperator',
                                        newselectedOperator);

                                  },
                                );
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
                                    'You have successfully updated the Rail Operator',
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
                              } else {
                                print('Error');
                              }
                              setState(() {
                                _localWaiting = false;
                              });
                              Navigator.pop(context);
                            },
                          ),
                        ),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(leading: Container(),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        actions: [
          PopupMenuButton(
            // offset: Offset(0, 5*SizeConfig.widthMultiplier),
            icon: Icon(Icons.more_horiz),
            onSelected: (value) async {
              if (value == 2) {
                if (KActiveRailOperator == 'Aurizon Weld Returns') {
                  bool _hasConnectivity = await checkConnectionNoListner();
                  if (_hasConnectivity == false) {
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext context) {
                        return CustomAlertDialogNoInternetProceed();
                      },
                    );
                  } else {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => NewWeldReturn()));
                  }
                }
                else if (KActiveRailOperator == 'ARTC Weld Returns') {
                  bool _hasConnectivity = await checkConnectionNoListner();
                  if (_hasConnectivity == false) {
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext context) {
                        return AlertNoInterNetProceedARTCWeld();
                      },
                    );
                  } else {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => NewARTCWeldReturn()));
                  }
                }
                else if (KActiveRailOperator == 'QR Weld Returns') {
                  bool _hasConnectivity = await checkConnectionNoListner();
                  if (_hasConnectivity == false) {
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext context) {
                        return AlertNoInterNetProceedQRWeld();
                      },
                    );
                  } else {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => NewQRWeldReturn()));
                  }
                }
              }
              else if (value == 3) {
                if (KActiveRailOperator == 'Aurizon Weld Returns') {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => WeldReturnTab()));
                }
                if (KActiveRailOperator == 'ARTC Weld Returns') {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ARTCWeldReturnTab()));
                }
                if (KActiveRailOperator == 'QR Weld Returns') {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => QRWeldReturnTab()));
                }
              }
              else if (value == 4) {
                if (KActiveRailOperator == 'Aurizon Weld Returns') {
                  bool _hasConnectivity = await checkConnectionNoListner();
                  if (_hasConnectivity != true) {
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext context) {
                        return CustomAlertDialogNoInternetBlock();
                      },
                    );
                  } else {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => WeldReturnForm()));
                  }
                }
                if (KActiveRailOperator == 'ARTC Weld Returns') {
                  bool _hasConnectivity = await checkConnectionNoListner();
                  if (_hasConnectivity != true) {
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext context) {
                        return CustomAlertDialogNoInternetBlock();
                      },
                    );
                  } else {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ArtcWeldReturnForm()));
                  }
                }
                if (KActiveRailOperator == 'QR Weld Returns') {
                  bool _hasConnectivity = await checkConnectionNoListner();
                  if (_hasConnectivity != true) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => QRWeldReturnForm()));
                    // showDialog(
                    //   context: context,
                    //   barrierDismissible: false,
                    //   builder: (BuildContext context) {
                    //     return CustomAlertDialogNoInternetBlock();
                    //   },
                    // );
                  } else {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => QRWeldReturnForm()));
                  }
                }
              }
              else if (value == 1) {
                UpdateOperatorAlertBox();
              }
              else if (value == 8) {
                logout(context);
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                child: Text(
                  KActiveRailOperator + ' (Change)',
                  style: TextStyle(
                    fontFamily: 'Manrope',
                    fontSize: 11,
                    color: const Color(0xff363636),
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.left,
                ),
                value: 1,
              ),
              PopupMenuItem(
                height: 1,
                child: PopupMenuDivider(
                  height: 1,
                ),
              ),
              PopupMenuItem(
                child: Text(
                  'New Weld Return',
                  style: TextStyle(
                    fontFamily: 'Manrope',
                    fontSize: 11,
                    color: const Color(0xff363636),
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.left,
                ),
                value: 2,
              ),
              PopupMenuItem(
                height: 1,
                child: PopupMenuDivider(
                  height: 1,
                ),
              ),
              PopupMenuItem(
                child: Text(
                  // 'Image',
                  'All Weld Return',
                  style: TextStyle(
                    fontFamily: 'Manrope',
                    fontSize: 11,
                    color: const Color(0xff363636),
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.left,
                ),
                value: 3,
              ),
              PopupMenuItem(
                height: 1,
                child: PopupMenuDivider(
                  height: 1,
                ),
              ),
              PopupMenuItem(
                child: Text(
                  // 'New ARTC Weld Return',
                  'Weld Return Form',
                  style: TextStyle(
                    fontFamily: 'Manrope',
                    fontSize: 11,
                    color: const Color(0xff363636),
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.left,
                ),
                value: 4,
              ),
              PopupMenuItem(
                height: 1,
                child: PopupMenuDivider(
                  height: 1,
                ),
              ),
              PopupMenuItem(
                child: Text(
                  // 'ARTC Weld Return',
                  'Logout',
                  style: TextStyle(
                    fontFamily: 'Manrope',
                    fontSize: 11,
                    color: const Color(0xff363636),
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.left,
                ),
                value: 8,
              ),
              PopupMenuItem(
                height: 1,
                child: PopupMenuDivider(
                  height: 1,
                ),
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: BottomBar(),
      backgroundColor: const Color(0xffffffff),
      body: Stack(
        alignment: Alignment.center,
        children: [
          Column(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment(-1.32, -0.92),
                      end: Alignment(1.37, 0.51),
                      colors: [
                        const Color(0xff5eb533),
                        const Color(0xff097445),
                        const Color(0xff157079),
                        const Color(0xff02414d)
                      ],
                      stops: [0.0, 0.295, 0.712, 1.0],
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(
                        height: 70.0,
                      ),
                      Image.asset('images/erwhite.png',
                          width: 32.14 * SizeConfig.widthMultiplier,
                          height: 15.78 * SizeConfig.heightMultiplier),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xffF5F8FB),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        height: 43.0,
                        child: MaterialButton(
                          elevation: 10.0,
                          onPressed: () {
                            CustomAlertDialogNoInternetProceed();
                          },
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0)),
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
                                  borderRadius: BorderRadius.circular(30.0)),
                              child: Container(
                                constraints: BoxConstraints(
                                    maxWidth: 266.0, minHeight: 43.0),
                                alignment: Alignment.center,
                                child: Text(
                                  'Run Daily Report',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 16,
                                    color: const Color(0xffffffff),
                                    fontWeight: FontWeight.w600,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              )),
                        ),
                      ),
                      SizedBox(
                        height: 50.0,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Container(
            width: 78 * SizeConfig.widthMultiplier,
            height: 28.8 * SizeConfig.heightMultiplier,
            child: Card(
              color: Colors.white,
              elevation: 20.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    height: 15.0,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Color(0xffB7B7B7)),
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    height: 5.13 * SizeConfig.heightMultiplier,
                    width: 68.85 * SizeConfig.widthMultiplier,
                    child: RoundedButton(
                      title: 'New Weld',
                      colour: Colors.white,
                      textcolors: Color(0xff1F7F59),
                      fontweight: FontWeight.w600,
                      fontsize: 15.0,
                      onPressed: () {
                        CustomAlertDialog();
                      },
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Color(0xffB7B7B7)),
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    height: 5.13 * SizeConfig.heightMultiplier,
                    width: 68.85 * SizeConfig.widthMultiplier,
                    child: RoundedButton(
                      title: 'Pull & Weld Calc',
                      colour: Colors.white,
                      textcolors: Color(0xff1F7F59),
                      fontweight: FontWeight.w600,
                      fontsize: 15.0,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => XDCalc()),
                        );
                      },
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Color(0xffB7B7B7)),
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    height: 5.13 * SizeConfig.heightMultiplier,
                    width: 68.85 * SizeConfig.widthMultiplier,
                    child: RoundedButton(
                      title: 'Track Distance',
                      colour: Colors.white,
                      textcolors: Color(0xff1F7F59),
                      fontweight: FontWeight.w600,
                      fontsize: 15.0,
                      onPressed: () {
                        CustomAlertDialog();
                      },
                    ),
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
