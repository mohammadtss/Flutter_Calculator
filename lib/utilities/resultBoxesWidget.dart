import 'package:flutter/material.dart';
import 'package:pymt_calc/utilities/constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class resultBoxes {
  String titleLabel = '';
  String withoutLabel = '';
  String includingLabel = '';
  Color backColor = Colors.grey[200];
  Color borderColor = Colors.black;
  Color firstColor = Colors.grey[200];
  Color secondColor = Colors.grey[200];
  TextStyle firstStyle = resultBoxFirstLabelStyle;
  TextStyle secondStyle = resultBoxSecondLabelStyle;
  bool showIncluding = true;

  resultBoxes(
      {@required this.titleLabel,
      @required this.withoutLabel,
      @required this.includingLabel,
      @required this.backColor,
      @required this.borderColor,
      @required this.showIncluding});

  Widget ResultBox(BuildContext context) {
    if (titleLabel == 'WEEKLY:') {
      firstColor = Colors.red[700];
      secondColor = Colors.green[600];

      firstStyle = TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w500,
      );

      secondStyle = TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w500,
      );

      borderColor = Colors.transparent;
    }

    Size screenSize = MediaQuery.of(context).size;

    if (showIncluding == true) {
      return Wrap(
        alignment: WrapAlignment.spaceEvenly,
        direction: Axis.horizontal,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(left: 10.0, right: 20.0, top: 8.0),
            height: 50.0,
            child: Wrap(
              direction: Axis.horizontal,
              alignment: WrapAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                  width: screenSize.width * 0.45,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        color: borderColor,
                        width: 1.2,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    elevation: 4.0,
                    color: firstColor,
                    child: Container(
                      margin: EdgeInsets.only(top: 12.0, left: 6.0),
                      child: RichText(
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        text: new TextSpan(
                          // Note: Styles for TextSpans must be explicitly defined.
                          // Child text spans will inherit styles from parent
                          style: firstStyle,
                          children: <TextSpan>[
                            new TextSpan(text: titleLabel),
                            new TextSpan(
                              text: withoutLabel,
                              style: secondStyle,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  height: 50.0,
                ),
                Container(
                  width: screenSize.width * 0.45,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        color: borderColor,
                        width: 1.2,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    elevation: 4.0,
                    color: secondColor,
                    child: Container(
                      margin: EdgeInsets.only(top: 12.0, left: 6.0),
                      child: RichText(
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        textAlign: TextAlign.center,
                        text: new TextSpan(
                          // Note: Styles for TextSpans must be explicitly defined.
                          // Child text spans will inherit styles from parent
                          style: firstStyle,
                          children: <TextSpan>[
                            new TextSpan(text: titleLabel),
                            new TextSpan(
                              text: includingLabel,
                              style: secondStyle,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  height: 50.0,
                ),
              ],
            ),
          ),
        ],
      );
    } else {
      return Wrap(
        alignment: WrapAlignment.spaceEvenly,
        direction: Axis.horizontal,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(left: 10.0, right: 20.0, top: 8.0),
            height: 50.0,
            child: Wrap(
              direction: Axis.horizontal,
              alignment: WrapAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                  width: screenSize.width * 0.9,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        color: borderColor,
                        width: 1.2,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    elevation: 4.0,
                    color: firstColor,
                    child: Container(
                      margin: EdgeInsets.only(top: 12.0, left: 6.0),
                      child: RichText(
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        text: new TextSpan(
                          // Note: Styles for TextSpans must be explicitly defined.
                          // Child text spans will inherit styles from parent
                          style: firstStyle,
                          children: <TextSpan>[
                            new TextSpan(text: titleLabel),
                            new TextSpan(
                              text: withoutLabel,
                              style: secondStyle,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  height: 50.0,
                ),
              ],
            ),
          ),
        ],
      );
    }
  }

  Widget totalBox(BuildContext context) {
    if (titleLabel == 'WEEKLY:') {
      firstColor = Colors.red[700];
      secondColor = Colors.green[600];

      firstStyle = TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w500,
      );

      secondStyle = TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w500,
      );

      borderColor = Colors.transparent;
    }

    Size screenSize = MediaQuery.of(context).size;
    return Wrap(
      alignment: WrapAlignment.center,
      direction: Axis.horizontal,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(left: 18.0, right: 26.0, top: 8.0),
          height: 50.0,
          child: Wrap(
            direction: Axis.horizontal,
            children: <Widget>[
              Container(
                width: double.infinity,
                child: Card(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      color: borderColor,
                      width: 1.2,
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  elevation: 4.0,
                  color: firstColor,
                  child: Container(
                    margin: EdgeInsets.only(top: 12.0, left: 6.0),
                    child: RichText(
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      textAlign: TextAlign.center,
                      text: new TextSpan(
                        // Note: Styles for TextSpans must be explicitly defined.
                        // Child text spans will inherit styles from parent
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontWeight: FontWeight.bold,
                          fontSize: 17.0,
                        ),
                        children: <TextSpan>[
                          new TextSpan(text: titleLabel),
                          new TextSpan(
                            text: withoutLabel,
                            style: secondStyle,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                height: 50.0,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
