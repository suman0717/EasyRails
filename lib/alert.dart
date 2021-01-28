import 'package:easy_rails/screens/qrweldreturn/newQRWeldReturn.dart';
import 'package:easy_rails/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'screens/artcweldreturn/artcWeldReturn.dart';
import 'screens/aurizonweldreturn/newWeldReturn.dart';

class CustomAlertDialog extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return AlertDialog(title: Text(''),backgroundColor: Colors.transparent,elevation: 0.0,
      contentPadding: EdgeInsets.all(0.0),
      content:
      Stack(
        alignment: Alignment.topCenter,
        children: <Widget>[
          GestureDetector(onTap: (){
            Navigator.pop(context);
          },
            child: Container(
              width: 200.0,
              height: 230.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(19.0),
                gradient: LinearGradient(
                  begin: Alignment(-0.63, 0.0),
                  end: Alignment(0.59, 0.0),
                  colors: [const Color(0xff36b033), const Color(0xff50d94c)],
                  stops: [0.0, 1.0],
                ),
              ),
              child:Column(mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Back to Main Screen',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 13,
                      color: const Color(0xffffffff),
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height:12.0),
                ],
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(19.0),
              color: const Color(0xffffffff),
            ),
            height: 191.0,
            width: 326.0,
            child: Column(mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  child: Text(
                    'Coming Soon',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 26,
                      color: const Color(0xff1a1a1a),
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  child: Text(
                    'This feature will be added soon to\nthis application.',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 13,
                      color: const Color(0xff737373),
                      fontWeight: FontWeight.w300,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  width: 306.0,
                  height: 20.0,
                )
              ],
            ),
          ),
          Container(
            child: Stack(
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    Transform.translate(
                      offset: Offset(0.0, 0.0),//this is half Circle background in Alert Box
                      child: SvgPicture.string(
                        '<svg viewBox="104.4 256.0 165.7 83.1" ><defs><linearGradient id="gradient" x1="0.185576" y1="0.5" x2="0.794173" y2="0.5"><stop offset="0.0" stop-color="#ff36b033"  /><stop offset="1.0" stop-color="#ff50d94c"  /></linearGradient></defs><path transform="translate(3313.0, 173.36)" d="M -3202.469970703125 114.1974029541016 C -3206.69384765625 103.859977722168 -3208.674560546875 93.159423828125 -3208.63916015625 82.63980102539063 L -3042.918701171875 82.63980102539063 C -3042.852294921875 115.3598709106445 -3062.302490234375 146.4168090820313 -3094.441162109375 159.5511016845703 C -3104.6884765625 163.7379150390625 -3115.291748046875 165.7207183837891 -3125.72265625 165.7207946777344 C -3158.38330078125 165.7209930419922 -3189.360107421875 146.2825927734375 -3202.469970703125 114.1974029541016 Z" fill="url(#gradient)" fill-opacity="0.06" stroke="none" stroke-width="0.5" stroke-opacity="0.06" stroke-miterlimit="4" stroke-linecap="butt" /><defs><linearGradient id="gradient" x1="0.185576" y1="0.5" x2="0.794173" y2="0.5"><stop offset="0.0" stop-color="#ff36b033"  /><stop offset="1.0" stop-color="#ff50d94c"  /></linearGradient></defs><path transform="translate(3313.0, 187.42)" d="M -3189.460693359375 94.82670593261719 C -3192.973388671875 86.22982025146484 -3194.61767578125 77.33236694335938 -3194.58349609375 68.58450317382813 L -3056.974365234375 68.58450317382813 C -3056.906494140625 95.76638031005859 -3073.059326171875 121.5760726928711 -3099.757568359375 132.4871978759766 C -3108.2666015625 135.9637908935547 -3117.07080078125 137.6102294921875 -3125.732421875 137.6102600097656 C -3152.8525390625 137.6103210449219 -3178.574951171875 121.4690856933594 -3189.460693359375 94.82670593261719 Z" fill="url(#gradient)" fill-opacity="0.06" stroke="none" stroke-width="0.5" stroke-opacity="0.06" stroke-miterlimit="4" stroke-linecap="butt" /><defs><linearGradient id="gradient" x1="0.185576" y1="0.5" x2="0.794173" y2="0.5"><stop offset="0.0" stop-color="#ff36b033"  /><stop offset="1.0" stop-color="#ff50d94c"  /></linearGradient></defs><path transform="translate(3313.0, 201.14)" d="M -3176.761474609375 75.91680145263672 C -3179.579345703125 69.0206298828125 -3180.8955078125 61.87998962402344 -3180.862548828125 54.86310195922852 L -3070.69482421875 54.86310195922852 C -3070.621826171875 76.64174652099609 -3083.556884765625 97.32583618164063 -3104.947021484375 106.0668029785156 C -3111.759033203125 108.8501663208008 -3118.80810546875 110.1683654785156 -3125.742431640625 110.1684646606445 C -3147.454345703125 110.1687927246094 -3168.046630859375 97.24667358398438 -3176.761474609375 75.91680145263672 Z" fill="url(#gradient)" fill-opacity="0.06" stroke="none" stroke-width="0.5" stroke-opacity="0.06" stroke-miterlimit="4" stroke-linecap="butt" /></svg>',
                        allowDrawingOutsideViewBox: true,
                      ),
                    ),
                  ],
                ),
                Stack(
                  children: <Widget>[
                    Transform.translate(
                      offset: Offset(46.0, -33.0), //Circular green box in Alert Box
                      child: SvgPicture.string(
                        '<svg viewBox="150.3 219.3 73.8 73.8" ><defs><filter id="shadow"><feDropShadow dx="0" dy="5" stdDeviation="17"/></filter><linearGradient id="gradient" x1="0.185576" y1="0.5" x2="0.794173" y2="0.5"><stop offset="0.0" stop-color="#ff36b033"  /><stop offset="1.0" stop-color="#ff50d94c"  /></linearGradient></defs><path transform="translate(-42.84, 443.3)" d="M 216.1126403808594 -221.2132263183594 C 234.9553070068359 -228.9127807617188 256.5003051757813 -219.8683471679688 264.201171875 -201.0242919921875 C 271.9006958007813 -182.1816711425781 262.8562622070313 -160.6366424560547 244.01220703125 -152.9357604980469 C 225.1682281494141 -145.2362670898438 203.6232147216797 -154.2806701660156 195.9237213134766 -173.1247253417969 C 188.2242584228516 -191.9687805175781 197.2686767578125 -213.5123291015625 216.1126403808594 -221.2132263183594 Z" fill="url(#gradient)" stroke="none" stroke-width="0.5" stroke-miterlimit="4" stroke-linecap="butt" filter="url(#shadow)"/></svg>',
                        allowDrawingOutsideViewBox: true,
                      ),
                    ),
                    Transform.translate(
                      offset: Offset(63.0, -20.0),
                      child:
                      // Adobe XD layer: 'passage-of-time' (group)
                      Stack(
                        children: <Widget>[
                          Transform.translate(
                            offset: Offset(0.0, 1.77),
                            child:
                            // Adobe XD layer: 'Layer_1_65_' (group)
                            Stack(
                              children: <Widget>[
                                Stack(
                                  children: <Widget>[
                                    SvgPicture.string(
                                      '<svg viewBox="0.0 0.0 43.1 39.9" ><path transform="translate(0.0, -1.78)" d="M 43.04938888549805 18.61131286621094 C 42.89979553222656 18.2928524017334 42.58041000366211 18.08910942077637 42.22707366943359 18.08910942077637 L 39.54078674316406 18.08910942077637 C 37.83283615112305 8.820646286010742 29.69413757324219 1.775000095367432 19.93926048278809 1.775000095367432 C 8.945409774780273 1.775000095367432 0 10.72041130065918 0 21.71426200866699 C 0 32.7081184387207 8.944492340087891 41.65260696411133 19.93926048278809 41.65260696411133 C 27.03446960449219 41.65260696411133 33.65152359008789 37.83380508422852 37.20784378051758 31.68848419189453 C 37.70894241333008 30.82120323181152 37.41341781616211 29.71346473693848 36.54521560668945 29.21145057678223 C 35.67885589599609 28.70943450927734 34.57019424438477 29.00495338439941 34.07001876831055 29.87223815917969 C 31.15888404846191 34.90248489379883 25.74409866333008 38.02837753295898 19.93926429748535 38.02837753295898 C 10.94429492950439 38.02837753295898 3.625155925750732 30.71015548706055 3.625155925750732 21.71610069274902 C 3.625155925750732 12.72021484375 10.94429588317871 5.401993751525879 19.93926429748535 5.401993751525879 C 27.68699836730957 5.401993751525879 34.17831420898438 10.8360538482666 35.83211898803711 18.09003067016602 L 33.16694641113281 18.09003067016602 C 32.8136100769043 18.09003067016602 32.49514389038086 18.29377365112305 32.34463119506836 18.61223602294922 C 32.19503784179688 18.93070030212402 32.24367523193359 19.30606651306152 32.46944808959961 19.57680320739746 L 37.00134658813477 25.01453590393066 C 37.17388534545898 25.22103118896484 37.42810821533203 25.34033966064453 37.69792556762695 25.34033966064453 C 37.96683120727539 25.34033966064453 38.22196578979492 25.22011184692383 38.39358901977539 25.01453590393066 L 42.92548751831055 19.57680511474609 C 43.1512565612793 19.30514144897461 43.19898223876953 18.92977523803711 43.04938888549805 18.61131286621094 Z" fill="#ffffff" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(-1.5, -2.18)" d="M 21.44178009033203 6.713000297546387 C 20.44050407409668 6.713000297546387 19.62920188903809 7.524299144744873 19.62920188903809 8.525576591491699 L 19.62920188903809 19.52401924133301 C 18.80964279174805 20.09853744506836 18.27000045776367 21.04566764831543 18.27000045776367 22.12128067016602 C 18.27000045776367 23.87053108215332 19.69344711303711 25.29397964477539 21.44269943237305 25.29397964477539 C 21.9217700958252 25.29397964477539 22.37331008911133 25.17925834655762 22.78079605102539 24.98744773864746 L 29.08580780029297 28.62636566162109 C 29.37214851379395 28.79248237609863 29.68235206604004 28.87049102783203 29.99071884155273 28.87049102783203 C 30.61663055419922 28.87049102783203 31.22602272033691 28.54560470581055 31.56192398071289 27.9637451171875 C 32.06210327148438 27.09829711914063 31.76566696166992 25.98872375488281 30.89746856689453 25.48854446411133 L 24.58603286743164 21.84411811828613 C 24.5015983581543 20.8859748840332 24.00325393676758 20.04897880554199 23.25619888305664 19.52585220336914 L 23.25619888305664 8.525576591491699 C 23.25435829162598 7.52521800994873 22.44214057922363 6.713000297546387 21.44178009033203 6.713000297546387 Z M 21.44178009033203 23.47956466674805 C 20.69197082519531 23.47956466674805 20.08257675170898 22.86925506591797 20.08257675170898 22.12128067016602 C 20.08257675170898 21.37238883972168 20.6928882598877 20.76207733154297 21.4417781829834 20.76207733154297 C 22.19067001342773 20.76207733154297 22.80098152160645 21.37238883972168 22.80098152160645 22.12127685546875 C 22.80098533630371 22.86925506591797 22.190673828125 23.47956466674805 21.44178009033203 23.47956466674805 Z" fill="#ffffff" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>',
                                      allowDrawingOutsideViewBox: true,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )

        ],
      ),
    );
  }
}

class CustomAlertDialogNoInternetProceed extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        children: [

            Icon(Icons.signal_cellular_connected_no_internet_4_bar,size: 3.94 * SizeConfig.heightMultiplier,),
          SizedBox(width: 2 * SizeConfig.widthMultiplier,),
          Text('No Internet',style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 3.5 * SizeConfig.heightMultiplier,
            fontWeight: FontWeight.w500,
          ),
          ),
        ],
      ),
      content: Text("Are You Sure you Want To Proceed ?"),
      actions: <Widget>[Row(
        children: [FlatButton(
          child: Text("Cancel",style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 2.0 * SizeConfig.heightMultiplier,
            fontWeight: FontWeight.w500,
          ),),
          onPressed: () {

            Navigator.of(context).pop();
          },
        ),
          FlatButton(
          child: Text("Proceed",style: TextStyle(
      fontFamily: 'Poppins',
      fontSize: 2.0 * SizeConfig.heightMultiplier,
      fontWeight: FontWeight.w500,
    ),),
          onPressed: () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>NewWeldReturn()));
          },
        ),

          ],
      )
      ],
    );
  }
}
class AlertNoInterNetProceedARTCWeld extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        children: [

          Icon(Icons.signal_cellular_connected_no_internet_4_bar,size: 3.94 * SizeConfig.heightMultiplier,),
          SizedBox(width: 2 * SizeConfig.widthMultiplier,),
          Text('No Internet',style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 3.5 * SizeConfig.heightMultiplier,
            fontWeight: FontWeight.w500,
          ),
          ),
        ],
      ),
      content: Text("Are You Sure you Want To Proceed ?"),
      actions: <Widget>[Row(
        children: [FlatButton(
          child: Text("Cancel",style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 2.0 * SizeConfig.heightMultiplier,
            fontWeight: FontWeight.w500,
          ),),
          onPressed: () {

            Navigator.of(context).pop();
          },
        ),
          FlatButton(
            child: Text("Proceed",style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 2.0 * SizeConfig.heightMultiplier,
              fontWeight: FontWeight.w500,
            ),),
            onPressed: () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>NewARTCWeldReturn()));
            },
          ),
        ],
      )
      ],
    );
  }
}
class AlertNoInterNetProceedQRWeld extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        children: [

          Icon(Icons.signal_cellular_connected_no_internet_4_bar,size: 3.94 * SizeConfig.heightMultiplier,),
          SizedBox(width: 2 * SizeConfig.widthMultiplier,),
          Text('No Internet',style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 3.5 * SizeConfig.heightMultiplier,
            fontWeight: FontWeight.w500,
          ),
          ),
        ],
      ),
      content: Text("Are You Sure you Want To Proceed ?"),
      actions: <Widget>[Row(
        children: [FlatButton(
          child: Text("Cancel",style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 2.0 * SizeConfig.heightMultiplier,
            fontWeight: FontWeight.w500,
          ),),
          onPressed: () {

            Navigator.of(context).pop();
          },
        ),
          FlatButton(
            child: Text("Proceed",style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 2.0 * SizeConfig.heightMultiplier,
              fontWeight: FontWeight.w500,
            ),),
            onPressed: () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>NewQRWeldReturn()));
            },
          ),

        ],
      )
      ],
    );
  }
}

class CustomAlertDialogNoInternetBlock extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        children: [

          Icon(Icons.signal_cellular_connected_no_internet_4_bar,size: 3.94 * SizeConfig.heightMultiplier,),
          SizedBox(width: 2 * SizeConfig.widthMultiplier,),
          Text('No Internet',style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 3.5 * SizeConfig.heightMultiplier,
            fontWeight: FontWeight.w500,
          ),
          ),
        ],
      ),
      content: Text("You can not use this functionality without internet."),
      actions: [
        FlatButton(
          child: Text("OK",style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 2.0 * SizeConfig.heightMultiplier,
            fontWeight: FontWeight.w500,
          ),),
          onPressed: () {

            Navigator.of(context).pop();
          },
        ),
      ],

    );
  }
}