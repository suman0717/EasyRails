import 'package:easy_rails/size_config.dart';
import 'package:flutter/material.dart';
import 'artcreated.dart';
import 'artcsubmitted.dart';
import 'artcunsynced.dart';

class ARTCWeldReturnTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          bottom: TabBar(
            tabs: [
              Tab(
                child: Text(
                  'Submitted',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 1.9 * SizeConfig.heightMultiplier,
                    color: const Color(0xffffffff),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Tab(
                child: Text(
                  'Synced',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 1.9 * SizeConfig.heightMultiplier,
                    color: const Color(0xffffffff),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Tab(
                child: Text(
                  'Unsynced',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 1.9 * SizeConfig.heightMultiplier,
                    color: const Color(0xffffffff),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          title: Text(
            'ARTC Weld Return',
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
        body: TabBarView(
          children: [
            ARTCSubmitted(),
            ARTCCreated(),
            ARTCUnsynced(),
          ],
        ),
      ),
    );
  }
}
