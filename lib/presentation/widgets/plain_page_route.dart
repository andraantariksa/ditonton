import 'package:flutter/material.dart';

class PlainPageRoute extends MaterialPageRoute {
  PlainPageRoute({builder}) : super(builder: builder);

  @override
  Duration get transitionDuration => Duration.zero;
}