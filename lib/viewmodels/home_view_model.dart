import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:react_conf/views/conference_list_view.dart';

import '../views/sponsors_list_view.dart';

class HomeViewModel extends ChangeNotifier {
  int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  void changePage(int index) {
    _currentIndex = index;
    notifyListeners();
  }

  List<Widget> pages = [
    ConferenceListView(),
    SponsorListView(),
  ];
}
