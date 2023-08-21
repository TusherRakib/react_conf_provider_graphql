import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:react_conf/apis/api_methods.dart';

import '../models/conf_info_model.dart';

class ConferenceInfoViewModel extends ChangeNotifier {
  ConferenceInfoModel conferenceInfoModel = ConferenceInfoModel();
  final GlobalKey speakersKey = GlobalKey();
  final GlobalKey organizerKey = GlobalKey();
  final GlobalKey scheduleKey = GlobalKey();
  final GlobalKey sponsorKey = GlobalKey();
  String? id;

  final TickerProvider _tickerProvider = _CustomTickerProvider();
  late TabController tabController;
  late PageController pageController;

  final ScrollController scrollController = ScrollController();
  final List<ScrollController> scrollControllers = List.generate(4, (_) => ScrollController());

  void scrollToWidgetStartingPosition(GlobalKey key) {
    final RenderBox renderBox = key.currentContext!.findRenderObject() as RenderBox;
    final widgetOffset = renderBox.localToGlobal(Offset(0,-AppBar().preferredSize.height));
    log(widgetOffset.toString());
    scrollController.animateTo(
      widgetOffset.dy,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  ConferenceInfoViewModel(this.id) {
    tabController = TabController(length: 4, vsync: _tickerProvider);
    pageController = PageController();

    tabController.addListener(_onTabIndexChanged);
  }

  void _onTabIndexChanged() {
    if (tabController.index == 0) {
      scrollToWidgetStartingPosition(organizerKey);
    } else if (tabController.index == 1) {
      scrollToWidgetStartingPosition(speakersKey);
    } else if (tabController.index == 2) {
      scrollToWidgetStartingPosition(scheduleKey);
    } else if (tabController.index == 3) {
      scrollToWidgetStartingPosition(sponsorKey);
    }
  }




  getConferenceInfo(String id) async {
    conferenceInfoModel = await ApiMethods().fetchConferenceById(id);
  }
}

class _CustomTickerProvider extends TickerProvider {
  @override
  Ticker createTicker(TickerCallback onTick) {
    return Ticker(onTick);
  }
}
