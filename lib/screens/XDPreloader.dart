import 'package:easy_rails/size_config.dart';
import 'package:flutter/material.dart';


class XDPreloader extends StatefulWidget {
  @override
  _XDPreloaderState createState() => _XDPreloaderState();
}

class _XDPreloaderState extends State<XDPreloader> {
@override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffffffff),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment(-1.43, -1.02),
            end: Alignment(1.17, 1.0),
            colors: [
              const Color(0xff5eb533),
              const Color(0xff097445),
              const Color(0xff157079),
              const Color(0xff02414d)
            ],
            stops: [0.0, 0.391, 0.712, 1.0],
          ),
        ),
        child: Center(
          child: Image.asset(
              'images/erwhite.png',
              width: 32.14 * SizeConfig.widthMultiplier,
              height: 18.78 * SizeConfig.heightMultiplier
          ),
        ),
      ),
    );
  }
}
