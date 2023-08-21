import 'package:flutter/material.dart';
import 'package:react_conf/views/home_view.dart';

class Routes {
  Routes._();

  //static variables
  static const String home = '/home';
  static const String post_detail = '/post_detail';

  static final routes = <String, WidgetBuilder>{
    home: (BuildContext context) => HomeView(),
    //post_detail: (BuildContext context) => PostDetailPage(),
  };
}
