import 'package:flutter/material.dart';
import 'ui_constants.dart';

class MyAppBar extends AppBar {
  MyAppBar(String text, BuildContext context)
      : super(
          elevation: 15.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(25),
              bottomRight: Radius.circular(25),
            ),
          ),
          flexibleSpace: Container(
            alignment: Alignment.center,
            child: Text(
              text,
              style: TextStyleConstants.appBar(context),
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(25),
                bottomRight: Radius.circular(25),
              ),
              color: ColorConstants.kvrBlue100,
            ),
          ),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: ColorConstants.white,
              size: 25,
            ),
            alignment: Alignment.topCenter,
            onPressed: () => Navigator.of(context).pop(),
          ),
        );
}
