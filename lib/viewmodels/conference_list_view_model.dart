import 'dart:developer';

import 'package:flutter/material.dart';

import '../apis/api_methods.dart';
import '../models/conf_list_model.dart';

class ConferenceListViewModel extends ChangeNotifier {
  List<Conference>? conferenceList = [];

  getConferenceList() async {
    conferenceList = await ApiMethods().fetchPosts();

    if (conferenceList != null) {
      log(conferenceList.toString());
    }
  }
}
