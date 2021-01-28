import 'dart:convert';
import 'package:easy_rails/screens/XDSignIn.dart';
import 'package:easy_rails/screens/qrweldreturn/newQRWeldReturn.dart';
import 'package:easy_rails/screens/artcweldreturn/artcWeldReturn.dart';
import 'package:easy_rails/screens/aurizonweldreturn/editWeldReturn.dart';
import 'package:easy_rails/screens/aurizonweldreturn/newWeldReturn.dart';
import 'package:easy_rails/size_config.dart';
import 'package:easy_rails/test.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

const kTextFieldDecoration = InputDecoration(
  fillColor: Color(0xffF5F5F5),
  filled: true,
  hintStyle: TextStyle(
    fontFamily: 'Poppins',
    fontSize: 14,
    color: const Color(0xff828282),
    fontWeight: FontWeight.w300,
  ),
  contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(30.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Color(0xffF5F5F5), width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(30.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Color(0xffF5F5F5), width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(30.0)),
  ),
);
const Color kShadeColor1 = Color(0xff359f40);
const kTextFieldDecorationNoback = InputDecoration(
  counterText: "",
  hintStyle: TextStyle(
    fontFamily: 'Poppins',
    fontSize: 14,
    color: const Color(0xff828282),
    fontWeight: FontWeight.w300,
  ),
  contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(30.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Color(0xffe8e8e8), width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(30.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: kShadeColor1 , width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(30.0)),
  ),
);

const kTextFieldDecorationSquare = InputDecoration(
  border: OutlineInputBorder(),
  labelText: 'Full Name',
);

const List<String> cityList = [
  'Adelaide',
  'Adelaide River',
  'Albany',
  'Albury',
  'Alice Springs',
  'Andamooka',
  'Ararat',
  'Armidale',
  'Atherton',
  'Ayr',
  'Bairnsdale East',
  'Ballarat',
  'Ballina',
  'Barcaldine',
  'Batemans Bay',
  'Bathurst',
  'Bedourie',
  'Bendigo',
  'Berri',
  'Bicheno',
  'Biloela',
  'Birdsville',
  'Bongaree',
  'Bordertown',
  'Boulia',
  'Bourke',
  'Bowen',
  'Brisbane',
  'Broken Hill',
  'Broome',
  'Bunbury',
  'Bundaberg',
  'Burketown',
  'Burnie',
  'Busselton',
  'Byron Bay',
  'Caboolture',
  'Cairns',
  'Caloundra',
  'Camooweal',
  'Canberra',
  'Carnarvon',
  'Ceduna',
  'Central Coast',
  'Charleville',
  'Charters Towers',
  'Clare',
  'Cloncurry',
  'Cobram',
  'Coffs Harbour',
  'Colac',
  'Cooma',
  'Cowell',
  'Cowra',
  'Cranbourne',
  'Currie',
  'Dalby',
  'Darwin',
  'Deniliquin',
  'Devonport',
  'Dubbo',
  'East Maitland',
  'Echuca',
  'Eidsvold',
  'Emerald',
  'Esperance',
  'Exmouth',
  'Forbes',
  'Forster',
  'Gawler',
  'Geelong',
  'Georgetown',
  'Geraldton',
  'Gingin',
  'Gladstone',
  'Gold Coast',
  'Goondiwindi',
  'Goulburn',
  'Griffith',
  'Gunnedah',
  'Gympie South',
  'Halls Creek',
  'Hamilton',
  'Hervey Bay',
  'Hobart',
  'Horsham',
  'Hughenden',
  'Innisfail',
  'Inverell',
  'Ivanhoe',
  'Kalbarri',
  'Kalgoorlie',
  'Karratha',
  'Karumba',
  'Katanning',
  'Katherine',
  'Katoomba',
  'Kempsey',
  'Kiama',
  'Kimba',
  'Kingaroy',
  'Kingoonya',
  'Kingston Beach',
  'Kingston South East',
  'Kununurra',
  'Kwinana',
  'Launceston',
  'Laverton',
  'Leeton',
  'Leonora',
  'Lithgow',
  'Longreach',
  'Mandurah',
  'Manjimup',
  'Maryborough',
  'Maryborough',
  'McMinns Lagoon',
  'Meekatharra',
  'Melbourne',
  'Melton',
  'Meningie',
  'Merredin',
  'Mildura',
  'Moranbah',
  'Morawa',
  'Moree',
  'Mount Barker',
  'Mount Gambier',
  'Mount Isa',
  'Mount Magnet',
  'Mudgee',
  'Murray Bridge',
  'Muswellbrook',
  'Narrabri West',
  'Narrogin',
  'Newcastle',
  'Newman',
  'Norseman',
  'North Lismore',
  'North Mackay',
  'North Scottsdale',
  'Northam',
  'Nowra',
  'Oatlands',
  'Onslow',
  'Orange',
  'Ouyen',
  'Pambula',
  'Pannawonica',
  'Parkes',
  'Penola',
  'Perth',
  'Peterborough',
  'Pine Creek',
  'Port Augusta West',
  'Port Denison',
  'Port Douglas',
  'Port Hedland',
  'Port Lincoln',
  'Port Macquarie',
  'Port Pirie',
  'Portland',
  'Proserpine',
  'Queanbeyan',
  'Queenstown',
  'Quilpie',
  'Ravensthorpe',
  'Richmond',
  'Richmond North',
  'Rockhampton',
  'Roebourne',
  'Roma',
  'Sale',
  'Scone',
  'Seymour',
  'Shepparton',
  'Singleton',
  'Smithton',
  'South Grafton',
  'South Ingham',
  'South Melbourne',
  'Southern Cross',
  'Stawell',
  'Streaky Bay',
  'Sunbury',
  'Swan Hill',
  'Sydney',
  'Taree',
  'Thargomindah',
  'Theodore',
  'Three Springs',
  'Tom Price',
  'Toowoomba',
  'Townsville',
  'Traralgon',
  'Tumby Bay',
  'Tumut',
  'Tweed Heads',
  'Ulladulla',
  'Victor Harbor',
  'Wagga Wagga',
  'Wagin',
  'Wallaroo',
  'Wangaratta',
  'Warrnambool',
  'Warwick',
  'Weipa',
  'West Tamworth',
  'Whyalla',
  'Wilcannia',
  'Windorah',
  'Winton',
  'Wollongong',
  'Wonthaggi',
  'Woomera',
  'Yamba',
  'Yeppoon',
  'Young',
  'Yulara'
];
List<String> countryList = ['Australia'];
List<String> Aurizon_SystemList = [];
List<String> standardCommentList = [];
List<String> railGradeList = [];
List<String> welderList = [];
List<String> supervisorList = [];
List<String> supervisorListARTC = [];
List<String> railOperatorList = [];
List<String> contractorList = [];
List<String> siteWeatherList = [];
List<String> siteTrackList = [];
List<String> siteWeldList = [];
List<String> artcWeldReasonList = [];
List<String> artcWeldTypeList = [];
List<String> qrRoadList = [];
List<String> qrTrackList = [];
List<String> qrWeldReasonList = [];
List<String> qrWeldTypeList = [];
List<String> qrHeating_TrolleyList = [];

Map<String, dynamic> AurizonWeldReturnMap = {};
Map<String, dynamic> QRWeldReturnMap = {};
Map<String, dynamic> AWR_CreatedMap = {};
Map<String, dynamic> AWR_SubmittedMap = {};
Map<String, dynamic> AWR_UnsyncedMap = {};
Map<String, dynamic> ARTCWeldReturnMapForForm = {};
Map<String, dynamic> ARTC_CreatedMap = {};
Map<String, dynamic> ARTC_SubmittedMap = {};
Map<String, dynamic> ARTC_UnsyncedMap = {};
Map<String, dynamic> QR_CreatedMap = {};
Map<String, dynamic> QR_SubmittedMap = {};
Map<String, dynamic> QR_UnsyncedMap = {};
Map<String, dynamic> ErUser = {};
Map<String, dynamic> Supervisor = {};
Map<String, dynamic> SupervisorARTC = {};
SharedPreferences sharedPreferences;
var mobileMaskAustralia = MaskTextInputFormatter(
    mask: "####-###-###", filter: {"#": RegExp(r'[0-9]')});
var steelAddedRemovedmm = MaskTextInputFormatter(mask: "###"+'mm', filter: {"#": RegExp(r'[0-9]')});


String kBaseURL = 'https://eventricity.online/app/';
String kAurizonSystemUrl =
    'https://eventricity.online/app/REST/EasyRails/GetAurizon_Systems';
String kCommentTemplateUrl =
    'https://eventricity.online/app/REST/EasyRails/App_Get_CommentTemplate';
String kRailGradeUrl =
    'https://eventricity.online/app/REST/EasyRails/App_Get_Rail_Grades';
String kWelderListUrl =
    'https://eventricity.online/app/REST/EasyRails/App_Get_Welder?SystemUserID=';
String kAllERUserDetails =
    'https://radreviews.online/app/REST/EasyRails/App_GetAllERUser';
String kSupervisorListUrl =
    'https://eventricity.online/app/REST/EasyRails/App_Get_Supervisor?RailOperatorID=';
String kAddSupervisorUrl =
    'https://eventricity.online/app/REST/EasyRails/App_Get_Supervisor?';
String kRailOperatorListUrl =
    'https://eventricity.online/app/REST/EasyRails/App_Get_Rail_Operator';
String kContractorListUrl =
    'https://eventricity.online/app/REST/EasyRails/App_GetContractor';
String kAurizonWeldListUrl =
    'https://eventricity.online/app/REST/EasyRails/App_AurizonWeldReturn_View?WelderID=';
String kAurizonWeldListCreatedSubmittedUrl =
    'https://eventricity.online/app/REST/EasyRails/App_AWR_CreatedSubmitted?WelderID=';
String kARTCWeldListCreatedSubmittedUrl =
    'https://eventricity.online/app/REST/EasyRails/App_ARTCWRCreatedSubmitted?WelderID=';
String kQRWeldListCreatedSubmittedUrl =
    'https://eventricity.online/app/REST/EasyRails/App_QR_CreatedSubmitted?WelderID=';
String kARTCWeldListUrl =
    'https://eventricity.online/app/REST/EasyRails/App_ARTCWeldReturn_View?WelderID=';
String kQRWeldListUrl =
    'https://eventricity.online/app/REST/EasyRails/App_QRWeldReturn_View?WelderID=';
String kGetNotification =
    'https://eventricity.online/app/REST/EasyRails/App_GetNotifications';
String kSiteConditionWeather =
    'https://radreviews.online/app/REST/EasyRails/App_SiteConditionWeather';
String kSiteConditionWeld =
    'https://radreviews.online/app/REST/EasyRails/App_SiteConditionWeld';
String kSiteConditionTrack =
    'https://radreviews.online/app/REST/EasyRails/App_SiteConditionTrack';
String kWeldReason =
    'https://radreviews.online/app/REST/EasyRails/App_WeldReason';
String kWeldType = 'https://radreviews.online/app/REST/EasyRails/App_WeldType';

String kLatestReportURL;
String kLatestARTCReportURL;
String supportEmail = 'support@ethink.solutions';
String loggedinUserName;
String loggedinUserPassword;
String loggedinUserFName;
String loggedinUserSName;
String loggedinUserContractor;
String loggedinUserID;
String aRTCLatestBatch;
String qRLatestBatch;
String signature;
String signature_Initials;
String masked_mobile;
String unmasked_mobile;
String country;
String serverOTP;
String localOTP;
String forgotUserID;
String confirm_Password;
String KActiveRailOperator;
String kActiveLicenseNumber;


DataConnectionStatus dataConnectionStatus;
bool haveInternetAccess;

class CustomIcons {}

void Syncdata() async {
  userList = sharedPreferences.getStringList('shareduserlist');
  int j = 0;
  if (userList.isNotEmpty) {
    print(userList);
    int _len = userList.length;
    print(_len);
    for (int i = 0; i < _len; i++) {
      print(i);
      var jsonRecord = jsonDecode(userList[j]);
      String _tempfirstName = jsonRecord['firstName'];
      String _tempsurName = jsonRecord['surname'];
      String _tempEmailAddress = jsonRecord['emailAddress'];
      print(kBaseURL +
          'REST/EasyRails/CreateTest?First_Name=$_tempfirstName&Surname=$_tempsurName&EmailAddress=$_tempEmailAddress');
      http.Response _response = await http.get(kBaseURL +
          'REST/EasyRails/CreateTest?First_Name=$_tempfirstName&Surname=$_tempsurName&EmailAddress=$_tempEmailAddress');
      try {
        String _data = _response.body;
        if (jsonDecode(_data)['Error'] == 'No Error') {
          userList.removeAt(j);

          sharedPreferences.setStringList('shareduserlist', userList);
          print(sharedPreferences.getStringList('shareduserlist'));
        } else {
          j++;
        }
      } catch (e) {
        j++;
        print(e);
      }
    }
  }
}

void SyncWeldReturn() async {
  int j = 0;
  if (unSyncWeldReturn.isNotEmpty) {
    int _len = unSyncWeldReturn.length;
    print(_len);
    for (int i = 0; i < _len; i++) {
      bool _connectionValilable = await checkConnectionNoListner();
      if (_connectionValilable == true) {
        print(i);
        var jsonRecord = jsonDecode(unSyncWeldReturn[j]);
        print(jsonRecord);
        String _apiURL = jsonRecord['apiURL'];

        if (_apiURL != null) {
          print(_apiURL);
          http.Response _response = await http.get(_apiURL);
          print('After http Request');
          try {
            print('In try');
            String _data = _response.body;
            if (jsonDecode(_data)['Error'] == 'No Error') {
              print('In Json No Error');
              unSyncWeldReturn.removeAt(j);
              sharedPreferences.setStringList(
                  'unSyncWeldReturn', unSyncWeldReturn);
              print(sharedPreferences.getStringList('unSyncWeldReturn'));
            } else {
              j++;
            }
          } catch (e) {
            j++;
            print(e);
          }
        }
      }
    }
  }
}

void SyncARTCWeldReturn() async {
  int j = 0;
  if (unSyncArtcWeldReturn.isNotEmpty) {
    int _len = unSyncArtcWeldReturn.length;
    print(_len);
    for (int i = 0; i < _len; i++) {
      bool _connectionValilable = await checkConnectionNoListner();
      if (_connectionValilable == true) {
        print(i);
        var jsonRecord = jsonDecode(unSyncArtcWeldReturn[j]);
        print(jsonRecord);
        String _apiURL = jsonRecord['apiURL'];

        if (_apiURL != null) {
          print(_apiURL);
          http.Response _response = await http.get(_apiURL);
          print('After http Request');
          try {
            print('In try');
            String _data = _response.body;
            if (jsonDecode(_data)['Error'] == 'No Error') {
              print('In Json No Error');
              unSyncArtcWeldReturn.removeAt(j);
              sharedPreferences.setStringList(
                  'unSyncArtcWeldReturn', unSyncArtcWeldReturn);
              print(sharedPreferences.getStringList('unSyncArtcWeldReturn'));
            } else {
              j++;
            }
          } catch (e) {
            j++;
            print(e);
          }
        }
      }
    }
  }
}

void SyncQRWeldReturn() async {
  int j = 0;
  if (unSyncQRWeldReturn.isNotEmpty) {
    int _len = unSyncQRWeldReturn.length;
    print(_len);
    for (int i = 0; i < _len; i++) {
      bool _connectionValilable = await checkConnectionNoListner();
      if (_connectionValilable == true) {
        print(i);
        var jsonRecord = jsonDecode(unSyncQRWeldReturn[j]);
        String _apiURL = jsonRecord['apiURL'];
print(_apiURL);
        if (_apiURL != null) {
          print(_apiURL);
          http.Response _response = await http.get(_apiURL);
          print('After http Request');
          try {
            print('In try');
            String _data = _response.body;
            if (jsonDecode(_data)['Error'] == 'No Error') {
              print('In Json No Error');
              unSyncQRWeldReturn.removeAt(j);
              sharedPreferences.setStringList(
                  'unSyncQRWeldReturn', unSyncQRWeldReturn);
              print(sharedPreferences.getStringList('unSyncQRWeldReturn'));
            } else {
              j++;
            }
          } catch (e) {
            j++;
            print(e);
          }
        }
      }
    }
  }
}

void SyncUpdateWeldReturn() async {
  int j = 0;
  if (listUpdateWeldReturnUnSynced.isNotEmpty) {
    int _len = listUpdateWeldReturnUnSynced.length;
    print(_len);
    for (int i = 0; i < _len; i++) {
      bool _connectionValilable = await checkConnectionNoListner();
      if (_connectionValilable == true) {
        print(i);
        var jsonRecord = jsonDecode(listUpdateWeldReturnUnSynced[j]);
        print(jsonRecord);
        String _apiURL = jsonRecord['apiURL'];

        if (_apiURL != null) {
          print(_apiURL);
          http.Response _response = await http.get(_apiURL);
          print('After http Request');
          try {
            print('In try');
            String _data = _response.body;
            if (jsonDecode(_data)['Error'] == 'No Error') {
              print('In Json No Error');
              listUpdateWeldReturnUnSynced.removeAt(j);
              sharedPreferences.setStringList(
                  'listUpdateWeldReturnUnSynced', listUpdateWeldReturnUnSynced);
              print(sharedPreferences
                  .getStringList('listUpdateWeldReturnUnSynced'));
            } else {
              j++;
            }
          } catch (e) {
            j++;
            print(e);
          }
        }
      }
    }
  }
}

Future<bool> checkConnection() async {
  {
    // Simple check to see if we have internet
    print("The statement 'this machine is connected to the Internet' is: ");
    print(await DataConnectionChecker().hasConnection);
    // returns a bool

    // We can also get an enum value instead of a bool
    print("Current status: ${await DataConnectionChecker().connectionStatus}");
    dataConnectionStatus = await DataConnectionChecker().connectionStatus;
    haveInternetAccess =
        dataConnectionStatus == DataConnectionStatus.connected ? true : false;
    // prints either DataConnectionStatus.connected
    // or DataConnectionStatus.disconnected

    // This returns the last results from the last call
    // to either hasConnection or connectionStatus
    print("Last results: ${DataConnectionChecker().lastTryResults}");

    // actively listen for status updates
    // this will cause DataConnectionChecker to check periodically
    // with the interval specified in DataConnectionChecker().checkInterval
    // until listener.cancel() is called
    var listener = DataConnectionChecker().onStatusChange.listen((status) {
      switch (status) {
        case DataConnectionStatus.connected:
          haveInternetAccess = true;
          print('Data connection is available.');
          SharedPreferences sharedPreferences;
          CheckSync();
          break;
        case DataConnectionStatus.disconnected:
          haveInternetAccess = false;
          print('You are disconnected from the internet.');
          break;
      }
    });

    // close listener after 30 seconds, so the program doesn't run forever
    // await Future.delayed(Duration(seconds: 60));
    // await listener.cancel();
  }
  return dataConnectionStatus == DataConnectionStatus.connected ? true : false;
}

Future<bool> checkConnectionNoListner() async {
  {
    dataConnectionStatus = await DataConnectionChecker().connectionStatus;
    haveInternetAccess =
        dataConnectionStatus == DataConnectionStatus.connected ? true : false;
  }
  return dataConnectionStatus == DataConnectionStatus.connected ? true : false;
}

CheckSync() async {
  print('In CheckSysnc');
  sharedPreferences = await SharedPreferences.getInstance();

  unSyncWeldReturn = await sharedPreferences.getStringList('unSyncWeldReturn');
  if(unSyncWeldReturn.isNotEmpty){
    bool connectionValilable = await checkConnectionNoListner();
    if(connectionValilable==true){
      SyncWeldReturn();
    }
  }

  unSyncArtcWeldReturn = await sharedPreferences.getStringList('unSyncArtcWeldReturn');
  if(unSyncArtcWeldReturn.isNotEmpty){
    bool connectionValilable = await checkConnectionNoListner();
    if(connectionValilable==true){
      SyncARTCWeldReturn();
    }
  }

  unSyncQRWeldReturn = await sharedPreferences.getStringList('unSyncQRWeldReturn');
  if(unSyncQRWeldReturn.isNotEmpty){
    bool connectionValilable = await checkConnectionNoListner();
    if(connectionValilable==true){
      SyncQRWeldReturn();
    }
  }

  listUpdateWeldReturnUnSynced = await sharedPreferences.getStringList('listUpdateWeldReturnUnSynced');
  if(listUpdateWeldReturnUnSynced.isNotEmpty){
    bool connectionValilable = await checkConnectionNoListner();
    if(connectionValilable==true){
      SyncUpdateWeldReturn();
    }
  }
}

// Aurizon weld Return Starts
Future<void> GetGenericDataForAurizon() async {
  await GetGenericDataAurizon_Systems(kAurizonSystemUrl);
  await GetGenericDataStandardComment(kCommentTemplateUrl);
  await GetGenericDataRailGrade(kRailGradeUrl);
}

Future<void> GetGenericDataAurizon_Systems(String url) async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  bool _hasConnectivity = await checkConnectionNoListner();
  if (_hasConnectivity == true) {
    print('within Connectivity');
    List<String> _localAurizon_SystemList = [];
    http.Response _response = await http.get(kAurizonSystemUrl);
    try {
      var _responseBody = _response.body;
      List _tempAurizon_SystemList = jsonDecode(_responseBody)["response"];
      if (_tempAurizon_SystemList != null) {
        int _len = _tempAurizon_SystemList.length;
        for (int i = 0; i < _len; i++) {
          var _lodata = _tempAurizon_SystemList[i];
          var _systemCode = _lodata['SystemCode'];
          _localAurizon_SystemList.add(_systemCode);
        }
      } else {
        var _lodata = jsonDecode(_responseBody)['SystemCode'];
        _localAurizon_SystemList.add(_lodata);
      }
      sharedPreferences.setStringList(
          'Aurizon_System', _localAurizon_SystemList);

      Aurizon_SystemList =
          await sharedPreferences.getStringList('Aurizon_System');
      print(Aurizon_SystemList);
    } catch (e) {
      print(e);
    }
  } else {
    print('without Connectivity');
    Aurizon_SystemList =
        await sharedPreferences.getStringList('Aurizon_System');
    print(Aurizon_SystemList);
  }
}

Future<void> GetGenericDataStandardComment(String url) async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  bool _hasConnectivity = await checkConnectionNoListner();
  if (_hasConnectivity == true) {
    List<String> _localStandardCommentList = [];
    print(kCommentTemplateUrl);
    http.Response _response = await http.get(kCommentTemplateUrl);
    try {
      var _responseBody = _response.body;
      List _tempStandardCommentList = jsonDecode(_responseBody)["response"];
      if (_tempStandardCommentList != null) {
        int _len = _tempStandardCommentList.length;
        for (int i = 0; i < _len; i++) {
          var _lodata = _tempStandardCommentList[i];
          var _systemCode = _lodata['Options'];
          _localStandardCommentList.add(_systemCode);
        }
      } else {
        var _lodata = jsonDecode(_responseBody)['Options'];
        _localStandardCommentList.add(_lodata);
      }
      sharedPreferences.setStringList(
          'Comment_Template', _localStandardCommentList);
      standardCommentList =
          await sharedPreferences.getStringList('Comment_Template');
      print(standardCommentList);
    } catch (e) {
      print(e);
    }
  } else {
    standardCommentList =
        await sharedPreferences.getStringList('Comment_Template');
    print(standardCommentList);
  }
}

Future<void> GetGenericDataRailGrade(String url) async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  bool _hasConnectivity = await checkConnectionNoListner();
  if (_hasConnectivity == true) {
    List<String> _localRailGradeList = [];
    http.Response _response = await http.get(kRailGradeUrl);
    try {
      var _responseBody = _response.body;
      List _tempRailGradeList = jsonDecode(_responseBody)["response"];
      if (_tempRailGradeList != null) {
        int _len = _tempRailGradeList.length;
        for (int i = 0; i < _len; i++) {
          var _lodata = _tempRailGradeList[i];
          var _systemCode = _lodata['RailGradeDropDown'];
          _localRailGradeList.add(_systemCode);
        }
      } else {
        var _lodata = jsonDecode(_responseBody)['RailGradeDropDown'];
        _localRailGradeList.add(_lodata);
      }
      sharedPreferences.setStringList('RailGrade', _localRailGradeList);
      railGradeList = await sharedPreferences.getStringList('RailGrade');
      print(railGradeList);
    } catch (e) {
      print(e);
    }
  } else {
    railGradeList = await sharedPreferences.getStringList('RailGrade');
    print(railGradeList);
  }
}

Future<void> GetGenericDataForWeldreturnForm() async {
  await GetGenericDataWelder(kWelderListUrl + '$loggedinUserID');
  await GetGenericDataSupervisor(kSupervisorListUrl +'Aurizon Weld Returns');
  await GetGenericDataRailOperator(kRailOperatorListUrl);
  await GetGenericDataContractor(kContractorListUrl);
  await GetGenericDataAurizonWeldReturn(kAurizonWeldListUrl +loggedinUserFName +' '+loggedinUserSName);
}

Future<void> GetGenericDataWelder(String url) async {
  print(url);
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  bool _hasConnectivity = await checkConnectionNoListner();
  if (_hasConnectivity == true) {
    List<String> _localwelderList = [];
    print('1');
    http.Response _response = await http.get(url);
    print(_response.body);
    print('2');
    try {
      var _responseBody = _response.body;
      List _temp_localwelderListList = jsonDecode(_responseBody)["response"];
      print('4');
      if (_temp_localwelderListList != null) {
        int _len = _temp_localwelderListList.length;
        for (int i = 0; i < _len; i++) {
          print(i);
          var _lodata = _temp_localwelderListList[i];
          var _systemCode = _lodata['FullName'];
          _localwelderList.add(_systemCode);
        }
      } else {
        var _lodata = jsonDecode(_responseBody)['FullName'];
        _localwelderList.add(_lodata);
      }
      sharedPreferences.setStringList('WelderList', _localwelderList);
      welderList = await sharedPreferences.getStringList('WelderList');
      print(welderList);
    } catch (e) {
      print(e);
    }
  } else {
    welderList = await sharedPreferences.getStringList('WelderList');
    print(welderList);
  }
}

Future<void> GetGenericDataSupervisor(String url) async {
  print(url);
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  bool _hasConnectivity = await checkConnectionNoListner();
  if (_hasConnectivity == true) {
    List<String> _localSupervisorList = [];
    http.Response _response = await http.get(url);
    try {
      var _responseBody = _response.body;
      List _tempSupervisorList = jsonDecode(_responseBody)["response"];
      if (_tempSupervisorList != null) {
        int _len = _tempSupervisorList.length;
        for (int i = 0; i < _len; i++) {
          var _lodata = _tempSupervisorList[i];
          var _systemCode = _lodata['FullName'];
          _localSupervisorList.add(_systemCode);
        }
      } else {
        var _lodata = jsonDecode(_responseBody)['FullName'];
        _localSupervisorList.add(_lodata);
      }
      sharedPreferences.setStringList('SupervisorList', _localSupervisorList);
      supervisorList = await sharedPreferences.getStringList('SupervisorList');
      print(supervisorList);
    } catch (e) {
      print(e);
    }
  } else {
    supervisorList = await sharedPreferences.getStringList('SupervisorList');
    print(supervisorList);
  }
}

Future<void> GetGenericDataRailOperator(String url) async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  bool _hasConnectivity = await checkConnectionNoListner();
  if (_hasConnectivity == true) {
    List<String> _localRailOperatorList = [];
    http.Response _response = await http.get(kRailOperatorListUrl);
    try {
      var _responseBody = _response.body;
      List _tempRailOPeratorList = jsonDecode(_responseBody)["response"];
      if (_tempRailOPeratorList != null) {
        int _len = _tempRailOPeratorList.length;
        for (int i = 0; i < _len; i++) {
          var _lodata = _tempRailOPeratorList[i];
          var _systemCode = _lodata['Company_Name'];
          _localRailOperatorList.add(_systemCode);
        }
      } else {
        var _lodata = jsonDecode(_responseBody)['Company_Name'];
        _localRailOperatorList.add(_lodata);
      }
      sharedPreferences.setStringList(
          'RailOperatorList', _localRailOperatorList);
      railOperatorList =
          await sharedPreferences.getStringList('RailOperatorList');
      print(railOperatorList);
    } catch (e) {
      print(e);
    }
  } else {
    railOperatorList =
        await sharedPreferences.getStringList('RailOperatorList');
    print(railOperatorList);
  }
}

Future<void> GetGenericDataContractor(String url) async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  bool _hasConnectivity = await checkConnectionNoListner();
  if (_hasConnectivity == true) {
    List<String> _localContractorList = [];
    http.Response _response = await http.get(kContractorListUrl);
    try {
      var _responseBody = _response.body;
      List _tempContractorList = jsonDecode(_responseBody)["response"];
      if (_tempContractorList != null) {
        int _len = _tempContractorList.length;
        for (int i = 0; i < _len; i++) {
          var _lodata = _tempContractorList[i];
          var _systemCode = _lodata['Business_Name'];
          _localContractorList.add(_systemCode);
        }
      } else {
        var _lodata = jsonDecode(_responseBody)['Business_Name'];
        _localContractorList.add(_lodata);
      }
      sharedPreferences.setStringList('ContractorList', _localContractorList);
      contractorList =
          await sharedPreferences.getStringList('ContractorList');
      print(contractorList);
    } catch (e) {
      print(e);
    }
  } else {
    contractorList = await sharedPreferences.getStringList('ContractorList');
    print(contractorList);
  }
}

Future<void> GetGenericDataAurizonWeldReturn(String url) async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  AurizonWeldReturnMap = {};
  http.Response _response = await http.get(url);
  print(url);
  try {
    var _responseBody = _response.body;
    List _tempAurizonWeldReturnList = jsonDecode(_responseBody)["response"];
    if (_tempAurizonWeldReturnList != null) {
      int _len = _tempAurizonWeldReturnList.length;
      for (int i = 0; i < _len; i++) {
        var _lodata = _tempAurizonWeldReturnList[i];
        var _systemCode = _lodata['WeldNumber'];
        AurizonWeldReturnMap[_systemCode.toString()] = false;
      }
    } else {
      var _lodata = jsonDecode(_responseBody)['WeldNumber'];
      AurizonWeldReturnMap[_lodata.toString()] = false;
    }
    var s = jsonEncode(AurizonWeldReturnMap);
    sharedPreferences.setString('AurizonWeldReturnMap', s);
  } catch (e) {
    print(e);
  }
}

Future<void> GetAurizonWeldReturn_Created(String url) async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  AWR_CreatedMap = {};
  print(url);
  http.Response _response = await http.get(url);
  print(url);
  print(AWR_CreatedMap);
  try {
    print('in Try');
    var _responseBody = _response.body;
    print(_responseBody);
    List _tempAWR_CreatedMap = jsonDecode(_responseBody)["response"];
    if (_tempAWR_CreatedMap != null) {
      int _len = _tempAWR_CreatedMap.length;
      for (int i = 0; i < _len; i++) {
        var _lodata = _tempAWR_CreatedMap[i];
        print('lodata');
        print(_lodata);
        var jsonEncodedValue = jsonEncode(_lodata);
        print(jsonEncodedValue);
        var _ID = _lodata['EXT_ID'].toString();
        AWR_CreatedMap[_ID] = jsonEncodedValue;
      }
    } else {
      var _lodata = jsonDecode(_responseBody);
      print(_lodata);
      AWR_CreatedMap[_lodata['EXT_ID'].toString()] =
          jsonEncode(_lodata).toString();
      print(_lodata);
    }
    print(AWR_CreatedMap);
    var s = jsonEncode(AWR_CreatedMap);
    sharedPreferences.setString('AWR_CreatedMap', s);
  } catch (e) {
    print(e);
  }
}

Future<void> GetAurizonWeldReturn_Submitted(String url) async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  AWR_SubmittedMap = {};
  print(url);
  http.Response _response = await http.get(url);
  print(url);
  print(AWR_SubmittedMap);
  try {
    print('in Try');
    var _responseBody = _response.body;
    print(_responseBody);
    List _tempAWR_SubmittedMap = jsonDecode(_responseBody)["response"];
    if (_tempAWR_SubmittedMap != null) {
      int _len = _tempAWR_SubmittedMap.length;
      for (int i = 0; i < _len; i++) {
        var _lodata = _tempAWR_SubmittedMap[i];
        print('lodata');
        print(_lodata);
        var jsonEncodedValue = jsonEncode(_lodata);
        print(jsonEncodedValue);
        var _ID = _lodata['EXT_ID'].toString();
        AWR_SubmittedMap[_ID] = jsonEncodedValue;
      }
    } else {
      var _lodata = jsonDecode(_responseBody);
      print(_lodata);
      AWR_SubmittedMap[_lodata['EXT_ID'].toString()] =
          jsonEncode(_lodata).toString();
      print(_lodata);
    }
    print(AWR_SubmittedMap);
    var s = jsonEncode(AWR_SubmittedMap);
    sharedPreferences.setString('AWR_SubmittedMap', s);
  } catch (e) {
    print(e);
  }
}

Future<void> GetAurizonWeldReturn_UnSynced() async {
  print('Inside GetAurizonWeldReturn_UnSynced');
  AWR_UnsyncedMap = {};
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  unSyncWeldReturn = sharedPreferences.getStringList('unSyncWeldReturn');
  print(unSyncWeldReturn.length);
  unSyncWeldReturn.forEach((element) {
    print(element);
    var _ID = unSyncWeldReturn.indexOf(element);
    AWR_UnsyncedMap[_ID.toString()] = element;
  });
  // AWR_UnsyncedMap = {};
  // print(url);
  // http.Response _response = await http.get(url);
  // print(url);
  // print(AWR_UnsyncedMap);
  // try{
  //   print('in Try');
  //   var _responseBody = _response.body;
  //   print(_responseBody);
  //   List _tempAWR_CreatedMap = jsonDecode(_responseBody)["response"];
  //   if(_tempAWR_CreatedMap !=null){
  //     int _len = _tempAWR_CreatedMap.length;
  //     for (int i = 0; i < _len; i++) {
  //       var _lodata = _tempAWR_CreatedMap[i];
  //       print('lodata');
  //       print(_lodata);
  //       var jsonEncodedValue = jsonEncode(_lodata);
  //       print(jsonEncodedValue);
  //       var _ID = _lodata['EXT_ID'].toString();
  //       AWR_CreatedMap[_ID] = jsonEncodedValue;
  //     }
  //   }
  //   else {
  //     var _lodata = jsonDecode(_responseBody);
  //     print(_lodata);
  //     AWR_CreatedMap[_lodata['EXT_ID'].toString()] = jsonEncode(_lodata).toString();
  //     print(_lodata);
  //   }
  //   print(AWR_CreatedMap);
  //   var s = jsonEncode(AWR_CreatedMap);
  //   sharedPreferences.setString('AWR_CreatedMap', s);
  // }
  //
  // catch(e){print(e);}
}

// Aurizon weld Return Ends

// ARTC weld Return Starts
Future<void> GetGenericDataForARTCWeldreturn() async {
  await GetSiteConditionWeather(kSiteConditionWeather);
  await GetSiteConditionTrack(kSiteConditionTrack);
  await GetSiteConditionWeld(kSiteConditionWeld);
  await GetWeldReason(kWeldReason);
  await GetWeldType(kWeldType);
}

Future<void> GetSiteConditionWeather(String url) async {
  print('Inside GetSiteConditionWeather');
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  bool _hasConnectivity = await checkConnectionNoListner();
  if (_hasConnectivity == true) {
    print('1');
    List<String> _localweatherList = [];
    http.Response _response = await http.get(url);
    try {
      var _responseBody = _response.body;
      print(_responseBody);
      List _temp_localweatherList = jsonDecode(_responseBody)["response"];
      if (_temp_localweatherList != null) {
        int _len = _temp_localweatherList.length;
        for (int i = 0; i < _len; i++) {
          var _lodata = _temp_localweatherList[i];
          var _condition = _lodata['Condition'];
          _localweatherList.add(_condition);
        }
      } else {
        var _lodata = jsonDecode(_responseBody)['Condition'];
        _localweatherList.add(_lodata);
      }
      sharedPreferences.setStringList('weatherList', _localweatherList);
      siteWeatherList = await sharedPreferences.getStringList('weatherList');
      print(siteWeatherList);
    } catch (e) {
      print(e);
    }
  } else {
    siteWeatherList = await sharedPreferences.getStringList('weatherList');
    print(siteWeatherList);
  }
}

Future<void> GetSiteConditionTrack(String url) async {
  print('Inside GetSiteConditionTrack');
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  bool _hasConnectivity = await checkConnectionNoListner();
  if (_hasConnectivity == true) {
    print('1');
    List<String> _localTrackList = [];
    http.Response _response = await http.get(url);
    try {
      var _responseBody = _response.body;
      print(_responseBody);
      List _temp_localTrackList = jsonDecode(_responseBody)["response"];
      if (_temp_localTrackList != null) {
        int _len = _temp_localTrackList.length;
        for (int i = 0; i < _len; i++) {
          var _lodata = _temp_localTrackList[i];
          var _condition = _lodata['Condition'];
          _localTrackList.add(_condition);
        }
      } else {
        var _lodata = jsonDecode(_responseBody)['Condition'];
        _localTrackList.add(_lodata);
      }
      sharedPreferences.setStringList('TrackList', _localTrackList);
      siteTrackList = await sharedPreferences.getStringList('TrackList');
      print(siteTrackList);
    } catch (e) {
      print(e);
    }
  } else {
    siteTrackList = await sharedPreferences.getStringList('TrackList');
    print(siteTrackList);
  }
}

Future<void> GetSiteConditionWeld(String url) async {
  print('Inside GetSiteConditionWeld');
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  bool _hasConnectivity = await checkConnectionNoListner();
  if (_hasConnectivity == true) {
    print('1');
    List<String> _localweldList = [];
    http.Response _response = await http.get(url);
    try {
      var _responseBody = _response.body;
      print(_responseBody);
      List _temp_localweldList = jsonDecode(_responseBody)["response"];
      if (_temp_localweldList != null) {
        int _len = _temp_localweldList.length;
        for (int i = 0; i < _len; i++) {
          var _lodata = _temp_localweldList[i];
          var _condition = _lodata['Condition'];
          _localweldList.add(_condition);
        }
      } else {
        var _lodata = jsonDecode(_responseBody)['Condition'];
        _localweldList.add(_lodata);
      }
      sharedPreferences.setStringList('weldList', _localweldList);
      siteWeldList = await sharedPreferences.getStringList('weldList');
      print(siteWeldList);
    } catch (e) {
      print(e);
    }
  } else {
    siteWeldList = await sharedPreferences.getStringList('weldList');
    print(siteWeldList);
  }
}

Future<void> GetWeldReason(String url) async {
  print('Inside GetWeldReason');
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  bool _hasConnectivity = await checkConnectionNoListner();
  if (_hasConnectivity == true) {
    print('1');
    List<String> _localartcWeldReasonList = [];
    http.Response _response = await http.get(url);
    try {
      var _responseBody = _response.body;
      print(_responseBody);
      List _temp_localartcWeldReasonList = jsonDecode(_responseBody)["response"];
      if (_temp_localartcWeldReasonList != null) {
        int _len = _temp_localartcWeldReasonList.length;
        for (int i = 0; i < _len; i++) {
          var _lodata = _temp_localartcWeldReasonList[i];
          var _description = _lodata['Description'];
          _localartcWeldReasonList.add(_description);
        }
      } else {
        var _lodata = jsonDecode(_responseBody)['Description'];
        _localartcWeldReasonList.add(_lodata);
      }
      sharedPreferences.setStringList('artcWeldReasonList', _localartcWeldReasonList);
      artcWeldReasonList = await sharedPreferences.getStringList('artcWeldReasonList');
      print(artcWeldReasonList);
    } catch (e) {
      print(e);
    }
  } else {
    artcWeldReasonList = await sharedPreferences.getStringList('artcWeldReasonList');
    print(artcWeldReasonList);
  }
}

Future<void> GetWeldType(String url) async {
  print('Inside GetWeldType');
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  bool _hasConnectivity = await checkConnectionNoListner();
  if (_hasConnectivity == true) {
    print('1');
    List<String> _localartcWeldTypeList = [];
    http.Response _response = await http.get(url);
    try {
      var _responseBody = _response.body;
      print(_responseBody);
      List temp_localartcWeldTypeList = jsonDecode(_responseBody)["response"];
      if (temp_localartcWeldTypeList != null) {
        int _len = temp_localartcWeldTypeList.length;
        for (int i = 0; i < _len; i++) {
          var _lodata = temp_localartcWeldTypeList[i];
          var _description = _lodata['Description'];
          _localartcWeldTypeList.add(_description);
        }
      } else {
        var _lodata = jsonDecode(_responseBody)['Description'];
        _localartcWeldTypeList.add(_lodata);
      }
      sharedPreferences.setStringList('artcWeldTypeList', _localartcWeldTypeList);
      artcWeldTypeList = await sharedPreferences.getStringList('artcWeldTypeList');
      print(artcWeldTypeList);
    } catch (e) {
      print(e);
    }
  } else {
    artcWeldTypeList = await sharedPreferences.getStringList('artcWeldTypeList');
    print(artcWeldTypeList);
  }
}

Future<void> GetGenericDataForARTCWeldreturnForm() async {
  await GetERUser(kWelderListUrl + '$loggedinUserID');
  await GetARTCWeldReturn(kARTCWeldListUrl +loggedinUserFName +' '+loggedinUserSName);
  await GetSupervisor(kSupervisorListUrl +'ARTC Weld Returns');
}

Future<void> GetERUser(String url) async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  ErUser = {};
  print(url);
  http.Response _response = await http.get(url);
  print(url);
  print(ErUser);
  try {
    print('in Try');
    var _responseBody = _response.body;
    print(_responseBody);
    List _tempErUser = jsonDecode(_responseBody)["response"];
    if (_tempErUser != null) {
      int _len = _tempErUser.length;
      for (int i = 0; i < _len; i++) {
        var _lodata = _tempErUser[i];
        print('lodata');
        print(_lodata);
        var jsonEncodedValue = jsonEncode(_lodata);
        print(jsonEncodedValue);
        var _ID = _lodata['EXT_ID'].toString();
        ErUser[_ID] = jsonEncodedValue;
      }
    } else {
      var _lodata = jsonDecode(_responseBody);
      print(_lodata);
      ErUser[_lodata['EXT_ID'].toString()] = jsonEncode(_lodata).toString();
      print(_lodata);
    }
    print(ErUser);
    var s = jsonEncode(ErUser);
    sharedPreferences.setString('ErUser', s);
  } catch (e) {
    print(e);
  }
}

Future<void> GetSupervisor(String url) async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  SupervisorARTC = {};
  print(url);
  http.Response _response = await http.get(url);
  print(url);
  print(SupervisorARTC);
  try {
    print('in Try');
    var _responseBody = _response.body;
    print(_responseBody);
    List _tempSupervisorARTC = jsonDecode(_responseBody)["response"];
    if (_tempSupervisorARTC != null) {
      int _len = _tempSupervisorARTC.length;
      for (int i = 0; i < _len; i++) {
        var _lodata = _tempSupervisorARTC[i];
        print('lodata');
        print(_lodata);
        var jsonEncodedValue = jsonEncode(_lodata);
        print(jsonEncodedValue);
        var _ID = _lodata['EXT_ID'].toString();
        SupervisorARTC[_ID] = jsonEncodedValue;
      }
    } else {
      var _lodata = jsonDecode(_responseBody);
      print(_lodata);
      SupervisorARTC[_lodata['EXT_ID'].toString()] = jsonEncode(_lodata).toString();
      print(_lodata);
    }
    print(SupervisorARTC);
    var s = jsonEncode(SupervisorARTC);
    sharedPreferences.setString('SupervisorARTC', s);
  } catch (e) {
    print(e);
  }
}

Future<void> GetARTCWeldReturn(String url) async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  ARTCWeldReturnMapForForm = {};
  http.Response _response = await http.get(url);
  print(url);
  try {
    var _responseBody = _response.body;
    List _tempARTCAurizonWeldReturnList = jsonDecode(_responseBody)["response"];

    if (_tempARTCAurizonWeldReturnList != null) {
      int _len = _tempARTCAurizonWeldReturnList.length;
      for (int i = 0; i < _len; i++) {
        print(i);
        var _lodata = _tempARTCAurizonWeldReturnList[i];
        var _systemCode = _lodata['WeldNumber'];
        print(_systemCode);
        ARTCWeldReturnMapForForm[_systemCode.toString()] = false;
      }
    } else {
      var _lodata = jsonDecode(_responseBody)['WeldNumber'];
      ARTCWeldReturnMapForForm[_lodata.toString()] = false;
    }
    var s = jsonEncode(ARTCWeldReturnMapForForm);
    sharedPreferences.setString('ARTCAurizonWeldReturnMap', s);
  } catch (e) {
    print(e);
  }
}

Future<void> GetARTCWeldReturn_Created(String url) async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  ARTC_CreatedMap = {};
  print(url);
  http.Response _response = await http.get(url);
  print(url);
  print(ARTC_CreatedMap);
  try {
    print('in Try');
    var _responseBody = _response.body;
    print(_responseBody);
    List _tempARTC_CreatedMap = jsonDecode(_responseBody)["response"];
    if (_tempARTC_CreatedMap != null) {
      int _len = _tempARTC_CreatedMap.length;
      // _tempARTC_CreatedMap.forEach((element) {
      //   var jsonEncodedValue = jsonEncode(element);
      //   print(jsonEncodedValue);
      //   var _ID = element['EXT_ID'].toString();
      //   ARTC_CreatedMap[_ID] = jsonEncodedValue;
      // });
      for (int i = 0; i < _len; i++) {
        var _lodata = _tempARTC_CreatedMap[i];
        print('lodata');
        print(_lodata);
        var jsonEncodedValue = jsonEncode(_lodata);
        print(jsonEncodedValue);
        var _ID = _lodata['EXT_ID'].toString();
        ARTC_CreatedMap[_ID] = jsonEncodedValue;
      }
    } else {
      var _lodata = jsonDecode(_responseBody);
      print(_lodata);
      ARTC_CreatedMap[_lodata['EXT_ID'].toString()] =
          jsonEncode(_lodata).toString();
      print(_lodata);
    }
    print(ARTC_CreatedMap);
    var s = jsonEncode(ARTC_CreatedMap);
    sharedPreferences.setString('ARTC_CreatedMap', s);
  } catch (e) {
    print(e);
  }
}

Future<void> GetARTCWeldReturn_Submitted(String url) async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  ARTC_SubmittedMap = {};
  print(url);
  http.Response _response = await http.get(url);
  print(url);
  print(ARTC_SubmittedMap);
  try {
    print('in Try');
    var _responseBody = _response.body;
    print(_responseBody);
    List _tempARTC_SubmittedMap = jsonDecode(_responseBody)["response"];
    if (_tempARTC_SubmittedMap != null) {
      int _len = _tempARTC_SubmittedMap.length;
      for (int i = 0; i < _len; i++) {
        var _lodata = _tempARTC_SubmittedMap[i];
        print('lodata');
        print(_lodata);
        var jsonEncodedValue = jsonEncode(_lodata);
        print(jsonEncodedValue);
        var _ID = _lodata['EXT_ID'].toString();
        ARTC_SubmittedMap[_ID] = jsonEncodedValue;
      }
    } else {
      var _lodata = jsonDecode(_responseBody);
      print(_lodata);
      ARTC_SubmittedMap[_lodata['EXT_ID'].toString()] =
          jsonEncode(_lodata).toString();
      print(_lodata);
    }
    print(ARTC_SubmittedMap);
    var s = jsonEncode(ARTC_SubmittedMap);
    sharedPreferences.setString('ARTC_SubmittedMap', s);
  } catch (e) {
    print(e);
  }
}

Future<void> GetARTCWeldReturn_UnSynced() async {
  print('inside GetARTCWeldReturn_UnSynced');
  ARTC_UnsyncedMap={};
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  unSyncArtcWeldReturn =
      sharedPreferences.getStringList('unSyncArtcWeldReturn');
  print(unSyncArtcWeldReturn.length);
  unSyncArtcWeldReturn.forEach((element) {
    print(element);
    var _ID = unSyncArtcWeldReturn.indexOf(element);
    ARTC_UnsyncedMap[_ID.toString()] = element;
  });
}

// ARTC weld Return Ends



// QR weld Return Starts

Future<void> GetGenericDataQR() async {
  await GetQRWeldReason('https://eventricity.online/app/REST/EasyRails/App_GetQRWeldReason');
  await GetQRTrack('https://eventricity.online/app/REST/EasyRails/App_GetQRTrack');
  await GetQRRoad('https://eventricity.online/app/REST/EasyRails/App_GetQRRoad');
  await GetQRWeldType('https://eventricity.online/app/REST/EasyRails/App_GetQRWeldType');
  await GetQRHeatingTrolley('https://eventricity.online/app/REST/EasyRails/App_GetQRHeatingTrolley');
}

Future<void> GetQRWeldReason(String url) async {
  print('Inside GetQRWeldReason');
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  bool _hasConnectivity = await checkConnectionNoListner();
  if (_hasConnectivity == true) {
    print('1');
    List<String> _localqrcWeldReasonList = [];
    http.Response _response = await http.get(url);
    try {
      var _responseBody = _response.body;
      print(_responseBody);
      List _temp_localqrcWeldReasonList = jsonDecode(_responseBody)["response"];
      if (_temp_localqrcWeldReasonList != null) {
        _temp_localqrcWeldReasonList.forEach((element) {
          var _lodata = element['Weld_Reason'];
          _localqrcWeldReasonList.add(_lodata);
        });
      } else {
        var _lodata = jsonDecode(_responseBody)['Weld_Reason'];
        _localqrcWeldReasonList.add(_lodata);
      }
      sharedPreferences.setStringList('qrWeldReasonList', _localqrcWeldReasonList);
      qrWeldReasonList = await sharedPreferences.getStringList('qrWeldReasonList');
      print(qrWeldReasonList);
    } catch (e) {
      print(e);
    }
  } else {
    qrWeldReasonList = await sharedPreferences.getStringList('qrWeldReasonList');
    print(qrWeldReasonList);
  }
}
Future<void> GetQRTrack(String url) async {
  print('Inside GetQRTrack');
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  bool _hasConnectivity = await checkConnectionNoListner();
  if (_hasConnectivity == true) {
    print('1');
    List<String> _localqrcTrackList = [];
    http.Response _response = await http.get(url);
    try {
      var _responseBody = _response.body;
      print(_responseBody);
      List _temp_localqrTrackList = jsonDecode(_responseBody)["response"];
      if (_temp_localqrTrackList != null) {
        _temp_localqrTrackList.forEach((element) {
          var _lodata = element['Track'];
          _localqrcTrackList.add(_lodata);
        });
      } else {
        var _lodata = jsonDecode(_responseBody)['Track'];
        _localqrcTrackList.add(_lodata);
      }
      sharedPreferences.setStringList('qrTrackList', _localqrcTrackList);
      qrTrackList = await sharedPreferences.getStringList('qrTrackList');
      print(qrTrackList);
    } catch (e) {
      print(e);
    }
  } else {
    qrTrackList = await sharedPreferences.getStringList('qrTrackList');
    print(qrTrackList);
  }
}
Future<void> GetQRRoad(String url) async {
  print('Inside GetQRRoad');
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  bool _hasConnectivity = await checkConnectionNoListner();
  if (_hasConnectivity == true) {
    print('1');
    List<String> _localqrcRoadList = [];
    http.Response _response = await http.get(url);
    try {
      var _responseBody = _response.body;
      print(_responseBody);
      List _temp_localqrRoadList = jsonDecode(_responseBody)["response"];
      if (_temp_localqrRoadList != null) {
        _temp_localqrRoadList.forEach((element) {
          var _lodata = element['Road'];
          _localqrcRoadList.add(_lodata);
        });
      } else {
        var _lodata = jsonDecode(_responseBody)['Road'];
        _localqrcRoadList.add(_lodata);
      }
      sharedPreferences.setStringList('qrRoadList', _localqrcRoadList);
      qrRoadList = await sharedPreferences.getStringList('qrRoadList');
      print(qrRoadList);
    } catch (e) {
      print(e);
    }
  } else {
    qrRoadList = await sharedPreferences.getStringList('qrRoadList');
    print(qrRoadList);
  }
}
Future<void> GetQRWeldType(String url) async {
  print('Inside GetQRWeldType');
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  bool _hasConnectivity = await checkConnectionNoListner();
  if (_hasConnectivity == true) {
    print('1');
    List<String> _localqrWeldTypeList = [];
    http.Response _response = await http.get(url);
    try {
      var _responseBody = _response.body;
      print(_responseBody);
      List _temp_localqrWeldTypeList = jsonDecode(_responseBody)["response"];
      if (_temp_localqrWeldTypeList != null) {
        _temp_localqrWeldTypeList.forEach((element) {
          var _lodata = element['WeldType'];
          _localqrWeldTypeList.add(_lodata);
        });
      } else {
        var _lodata = jsonDecode(_responseBody)['WeldType'];
        _localqrWeldTypeList.add(_lodata);
      }
      sharedPreferences.setStringList('qrWeldTypeList', _localqrWeldTypeList);
      qrWeldTypeList = await sharedPreferences.getStringList('qrWeldTypeList');
      print(qrWeldTypeList);
    } catch (e) {
      print(e);
    }
  } else {
    qrWeldTypeList = await sharedPreferences.getStringList('qrWeldTypeList');
    print(qrWeldTypeList);
  }
}
Future<void> GetQRHeatingTrolley(String url) async {
  print('Inside GetQRHeatingTrolley');
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  bool _hasConnectivity = await checkConnectionNoListner();
  if (_hasConnectivity == true) {
    print('1');
    List<String> _localqrHeatingTrolleyList = [];
    http.Response _response = await http.get(url);
    try {
      var _responseBody = _response.body;
      print(_responseBody);
      List _temp_localqrHeatingTrolleyList = jsonDecode(_responseBody)["response"];
      if (_temp_localqrHeatingTrolleyList != null) {
        _temp_localqrHeatingTrolleyList.forEach((element) {
          var _lodata = element['Heating_Trolley'];
          _localqrHeatingTrolleyList.add(_lodata);
        });
      } else {
        var _lodata = jsonDecode(_responseBody)['Heating_Trolley'];
        _localqrHeatingTrolleyList.add(_lodata);
      }
      sharedPreferences.setStringList('qrHeating_TrolleyList', _localqrHeatingTrolleyList);
      qrHeating_TrolleyList = await sharedPreferences.getStringList('qrHeating_TrolleyList');
      print(qrHeating_TrolleyList);
    } catch (e) {
      print(e);
    }
  } else {
    qrHeating_TrolleyList = await sharedPreferences.getStringList('qrHeating_TrolleyList');
    print(qrHeating_TrolleyList);
  }
}

Future<void> GetGenericDataForQRWeldreturnForm() async {
  await GetGenericDataWelder(kWelderListUrl + '$loggedinUserID');
  await GetGenericDataQRWeldReturn(kQRWeldListUrl +loggedinUserFName +' '+loggedinUserSName);
}

Future<void> GetGenericDataQRWeldReturn(String url) async {
  print('Inside GetGenericDataQRWeldReturn');
  print(url);
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  QRWeldReturnMap = {};
  http.Response _response = await http.get(url);
  print(url);
  try {
    var _responseBody = _response.body;
    List _tempQRWeldReturnList = jsonDecode(_responseBody)["response"];
    if (_tempQRWeldReturnList != null) {
      int _len = _tempQRWeldReturnList.length;
      for (int i = 0; i < _len; i++) {
        var _lodata = _tempQRWeldReturnList[i];
        var _systemCode = _lodata['WeldNumber'];
        QRWeldReturnMap[_systemCode.toString()] = false;
      }
    } else {
      var _lodata = jsonDecode(_responseBody)['WeldNumber'];
      QRWeldReturnMap[_lodata.toString()] = false;
    }
    var s = jsonEncode(QRWeldReturnMap);
    sharedPreferences.setString('QRWeldReturnMap', s);
  } catch (e) {
    print(e);
  }
}

Future<void> GetQRWeldReturn_Created(String url) async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  QR_CreatedMap = {};
  print(url);
  http.Response _response = await http.get(url);
  print(url);
  print(QR_CreatedMap);
  try {
    print('in Try');
    var _responseBody = _response.body;
    print(_responseBody);
    List _tempQR_CreatedMap = jsonDecode(_responseBody)["response"];
    if (_tempQR_CreatedMap != null) {
      int _len = _tempQR_CreatedMap.length;
      for (int i = 0; i < _len; i++) {
        var _lodata = _tempQR_CreatedMap[i];
        print('lodata');
        print(_lodata);
        var jsonEncodedValue = jsonEncode(_lodata);
        print(jsonEncodedValue);
        var _ID = _lodata['EXT_ID'].toString();
        QR_CreatedMap[_ID] = jsonEncodedValue;
      }
    } else {
      var _lodata = jsonDecode(_responseBody);
      print(_lodata);
      QR_CreatedMap[_lodata['EXT_ID'].toString()] =
          jsonEncode(_lodata).toString();
      print(_lodata);
    }
    print(QR_CreatedMap);
    var s = jsonEncode(QR_CreatedMap);
    sharedPreferences.setString('QR_CreatedMap', s);
  } catch (e) {
    print(e);
  }
}

Future<void> GetQRWeldReturn_Submitted(String url) async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  QR_SubmittedMap = {};
  print(url);
  http.Response _response = await http.get(url);
  print(url);
  print(QR_SubmittedMap);
  try {
    print('in Try');
    var _responseBody = _response.body;
    print(_responseBody);
    List _tempQR_SubmittedMap = jsonDecode(_responseBody)["response"];
    if (_tempQR_SubmittedMap != null) {
      int _len = _tempQR_SubmittedMap.length;
      for (int i = 0; i < _len; i++) {
        var _lodata = _tempQR_SubmittedMap[i];
        print('lodata');
        print(_lodata);
        var jsonEncodedValue = jsonEncode(_lodata);
        print(jsonEncodedValue);
        var _ID = _lodata['EXT_ID'].toString();
        QR_SubmittedMap[_ID] = jsonEncodedValue;
      }
    } else {
      var _lodata = jsonDecode(_responseBody);
      print(_lodata);
      QR_SubmittedMap[_lodata['EXT_ID'].toString()] =
          jsonEncode(_lodata).toString();
      print(_lodata);
    }
    print(QR_SubmittedMap);
    var s = jsonEncode(QR_SubmittedMap);
    sharedPreferences.setString('QR_SubmittedMap', s);
  } catch (e) {
    print(e);
  }
}

Future<void> GetQRWeldReturn_UnSynced() async {
  print('inside GetQRWeldReturn_UnSynced');
  QR_UnsyncedMap={};
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  unSyncQRWeldReturn =
      sharedPreferences.getStringList('unSyncQRWeldReturn');
  print(unSyncQRWeldReturn.length);
  unSyncQRWeldReturn.forEach((element) {
    print(element);
    var _ID = unSyncQRWeldReturn.indexOf(element);
    QR_UnsyncedMap[_ID.toString()] = element;
  });
}

// QR weld Return End


Future<void> launchInBrowser(String url) async {
  if (await canLaunch(url)) {
    await launch(
      url,
      forceSafariVC: false,
      forceWebView: false,
      headers: <String, String>{'my_header_key': 'my_header_value'},
    );
  } else {
    throw 'Could not launch $url';
  }
}

void ShowFlushbar(String error, String message, IconData icondata, context) async {
  Flushbar(
    titleText: Text(
      error,
      style: TextStyle(
        fontFamily: 'Poppins',
        fontSize: 2.0 * SizeConfig.heightMultiplier,
        color: const Color(0xffffffff),
        fontWeight: FontWeight.w600,
      ),
      textAlign: TextAlign.left,
    ),
    messageText: Text(
      message,
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
      icondata,
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
}

void logout(context) async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  sharedPreferences.clear();
  print('object');
  Navigator.pushAndRemoveUntil(context,
      MaterialPageRoute(builder: (context) => XDSignIn()), (route) => false);
}

Future<String> UpdateOperator(String userId, String operator) async{
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  bool _hasConnectivity = await checkConnectionNoListner();
  if(_hasConnectivity != true){
    KActiveRailOperator = operator;
    sharedPreferences.setString('ActiveRailOperator', operator);
    return 'No Error';
  }
  else {
    print(kBaseURL +
        'REST/EasyRails/App_UpdateOperator?SystemUserID=$userId&RailOperatorID=$operator');
    http.Response _response = await http.get(kBaseURL +
        'REST/EasyRails/App_UpdateOperator?SystemUserID=$userId&RailOperatorID=$operator');
    print(_response.body);
    var _responseBody = _response.body;
    var _data = jsonDecode(_responseBody);
    String _error = _data['Error'];
    if(_error == 'No Error'){
      sharedPreferences.setString('ActiveRailOperator', operator);
      KActiveRailOperator = operator;
    }
    return _error;
  }
}


AppBar buildAppBar(String appbarTitle) {
  return AppBar(
    centerTitle: true,
    title: Text(
      appbarTitle,
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
  );
}