import 'package:easy_rails/bottomBar.dart';
import 'package:easy_rails/roundiconbutton.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:url_launcher/url_launcher.dart';

int adjustementLength = 250;
int neutralTemp = 38;
int minAdjustedTemp = 28;
double weldGap = 5.0;

class XDCalc extends StatefulWidget {
  @override
  _XDCalcState createState() => _XDCalcState();
}

class _XDCalcState extends State<XDCalc> {
  void reSetValue() {
    adjustementLength = 250;
    neutralTemp = 38;
    minAdjustedTemp = 28;
    weldGap = 5.0;
  }

  @override
  void initState() {
    // TODO: implement initState
    reSetValue();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Pull & Weld Calculator',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 16,
          ),
          textAlign: TextAlign.center,
        ),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                Navigator.pop(context);
              })
        ],
      ),
      bottomNavigationBar: BottomBar(),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment(-0.63, -0.87),
            end: Alignment(1.14, -0.04),
            colors: [const Color(0xff02414d), const Color(0xff0a7449)],
            stops: [0.0, 1.0],
          ),
        ),
        child: ListView(
          children: [
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                    height: 15.0,
                  ),
                  Center(
                    child: Text(
                      'Adjustment length',
                      style: TextStyle(
                          color: Color(0xff749197),
                          fontSize: 13.0,
                          fontFamily: 'Poppins'),
                    ),
                  ),
                  Center(
                    child: Text(
                      '${adjustementLength.toString()}m',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 32.0,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      trackHeight: 2.0,
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(left: 12.0, right: 12.0),
                      child: Slider(
                          activeColor: Color(0xff5eb533),
                          min: 0,
                          max: 1000,
                          value: adjustementLength.toDouble(),
                          onChanged: (double value) {
                            setState(() {
                              adjustementLength = value.toInt();
                            });
                          }),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30.0),
                          topRight: Radius.circular(30.0),
                        ),
                        color: Colors.white),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 0.0),
                          child: Text(
                            'Other Adjustments',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 13,
                              color: const Color(0xff737373),
                              fontWeight: FontWeight.w300,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        ListTile(
                          title: Text(
                            'Neutral Temp:',
                            style: TextStyle(
                                fontSize: 15.0, fontFamily: 'Poppins'),
                          ),
                          trailing: SizedBox(
                            width: 130.0,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                RoundIconButton(
                                  iconColor: Color(0xffaeaeae),
                                  icon: FontAwesomeIcons.minus,
                                  onPress: () {
                                    setState(() {
                                      neutralTemp--;
                                    });
                                  },
                                ),
                                Text(
                                  '$neutralTemp',
                                  style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w600),
                                ),
                                RoundIconButton(
                                  iconColor: Color(0xff37b033),
                                  icon: FontAwesomeIcons.plus,
                                  onPress: () {
                                    setState(() {
                                      neutralTemp++;
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                        Divider(
                          indent: 20.0,
                          endIndent: 25.0,
                          color: Color(0xffECECEC),
                        ),
                        ListTile(
                          title: Text(
                            'Minimum Adjustment Temp:',
                            style: TextStyle(
                                fontSize: 15.0, fontFamily: 'Poppins'),
                          ),
                          trailing: SizedBox(
                            width: 130.0,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                RoundIconButton(
                                  iconColor: Color(0xffaeaeae),
                                  icon: FontAwesomeIcons.minus,
                                  onPress: () {
                                    setState(() {
                                      minAdjustedTemp--;
                                    });
                                  },
                                ),
                                Text(
                                  '$minAdjustedTemp',
                                  style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w600),
                                ),
                                RoundIconButton(
                                  iconColor: Color(0xff37b033),
                                  icon: FontAwesomeIcons.plus,
                                  onPress: () {
                                    setState(() {
                                      minAdjustedTemp++;
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                        Divider(
                          indent: 20.0,
                          endIndent: 25.0,
                          color: Color(0xffECECEC),
                        ),
                        ListTile(
                          title: Text(
                            'Weld gap:',
                            style: TextStyle(
                                fontSize: 15.0, fontFamily: 'Poppins'),
                          ),
                          trailing: SizedBox(
                            width: 160.0,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                RoundIconButton(
                                  iconColor: Color(0xffaeaeae),
                                  icon: FontAwesomeIcons.minus,
                                  onPress: () {
                                    setState(() {
                                      weldGap--;
                                    });
                                  },
                                ),
                                Text(
                                  '${weldGap}',
                                  style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  'mm',
                                  style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.w600),
                                ),
                                RoundIconButton(
                                  iconColor: Color(0xff37b033),
                                  icon: FontAwesomeIcons.plus,
                                  onPress: () {
                                    setState(() {
                                      weldGap++;
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        DottedBorder(
                          borderType: BorderType.RRect,
                          strokeWidth: 0.2,
                          strokeCap: StrokeCap.butt,
                          dashPattern: [3, 3],
                          radius: Radius.circular(20.0),
                          padding: EdgeInsets.all(6),
                          child: Container(
                            height: 240.0,
                            width: 327.0,
                            child: Padding(
                              padding: const EdgeInsets.all(25.0),
                              child: ListView(
                                padding: EdgeInsets.all(0.0),
                                children: getListView(),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void hitLink(String urlString) async {
    //This funciton can make call, Send SMS, Send Email, open URL in Browser
    String url = '$urlString';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}

List<Card> getListView() {
  List<Card> listItems = [];
  for (int i = 0; i < (neutralTemp - minAdjustedTemp); i++) {
    double _requiredPull =
        ((neutralTemp - i) - minAdjustedTemp) * adjustementLength * 0.0115;
    var itemTemp = Card(
      elevation: 0.0,
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                flex: 4,
                child: Text(
                  'Rail Temperature',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 15,
                    color: const Color(0xff1a1a1a),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Text(
                  '${minAdjustedTemp.toDouble() + i}',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 16,
                    color: const Color(0xff1f7f59),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              )
            ],
          ),
          Text(
            'Required Pull: ${_requiredPull.ceil()}mm',
            style: TextStyle(
              fontSize: 13.0,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w300,
            ),
          ),
        ],
      ),
    );
    listItems.add(itemTemp);
  }
  return listItems;
}
