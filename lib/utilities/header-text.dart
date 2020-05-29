import 'package:pymt_calc/utilities/constants.dart';
import 'package:flutter/material.dart';

class HeaderTitle extends StatelessWidget {
  const HeaderTitle({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
//      width: double.infinity,
//      margin: EdgeInsets.only(right: 0.0, left: 0.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            color: Colors.transparent,
            child: Text(
              'auto',
              style: TextStyle(
                backgroundColor: Colors.transparent,
                fontSize: 25.0,
                fontWeight: FontWeight.w300,
                fontFamily: 'ArialBlack',
              ),
            ),
          ),
          Container(
            color: Colors.transparent,
            child: Text(
              'gard',
              style: TextStyle(
                backgroundColor: Colors.transparent,
                fontSize: 25.0,
                color: Color(0xff983330),
                fontFamily: 'ArialBlack',
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
          Container(
            color: Colors.transparent,
            padding: EdgeInsets.only(left: 4.0),
            child: Text(
              'advantage',
              style: TextStyle(
                backgroundColor: Colors.transparent,
                fontSize: 25.0,
                fontWeight: FontWeight.w300,
                fontFamily: 'ArialBlack',
              ),
            ),
          ),
          Container(
            color: Colors.transparent,
            margin: EdgeInsets.only(top: 0.0),
            child: Text(
              'TM',
              style: TextStyle(
                backgroundColor: Colors.transparent,
                fontSize: 9.0,
                fontWeight: FontWeight.w300,
                fontFamily: 'ArialBlack',
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class HeaderTitleLogin extends StatelessWidget {
  const HeaderTitleLogin({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
//      width: double.infinity,
//      margin: EdgeInsets.only(right: 0.0, left: 0.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            color: Colors.white.withOpacity(0.0),
            child: Text(
              'auto',
              style: TextStyle(
                backgroundColor: Colors.white.withOpacity(0.0),
                fontSize: 25.0,
                fontWeight: FontWeight.w300,
                fontFamily: 'ArialBlack',
              ),
            ),
          ),
          Container(
            color: Colors.white.withOpacity(0.0),
            child: Text(
              'gard',
              style: TextStyle(
                backgroundColor: Colors.white.withOpacity(0.0),
                fontSize: 25.0,
                color: Color(0xff983330),
                fontFamily: 'ArialBlack',
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
          Container(
            color: Colors.white.withOpacity(0.0),
            padding: EdgeInsets.only(left: 4.0),
            child: Text(
              'advantage',
              style: TextStyle(
                backgroundColor: Colors.white.withOpacity(0.0),
                fontSize: 25.0,
                fontWeight: FontWeight.w300,
                fontFamily: 'ArialBlack',
              ),
            ),
          ),
          Container(
            color: Colors.white.withOpacity(0.0),
            margin: EdgeInsets.only(top: 0.0),
            child: Text(
              'TM',
              style: TextStyle(
                backgroundColor: Colors.white.withOpacity(0.0),
                fontSize: 9.0,
                fontWeight: FontWeight.w300,
                fontFamily: 'ArialBlack',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
