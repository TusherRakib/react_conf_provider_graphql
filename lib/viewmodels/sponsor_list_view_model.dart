import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:react_conf/models/conf_info_model.dart';

import '../apis/api_methods.dart';
import '../models/conf_list_model.dart';
import '../models/sponsors_model.dart';

class SponsorListViewModel extends ChangeNotifier {

  List<SponsorModel>? sponsors = [];

  List<String> sponsorIcons = [
    'assets/ic_layers.svg',
    'assets/ic_sisyphus.svg',
    'assets/ic_circooles.svg',
    'assets/ic_catalog.svg',
    'assets/ic_sisyphus.svg',
    'assets/ic_quotient.svg',
    'assets/ic_layers.svg',
    'assets/ic_circooles.svg',
  ];

  getConferenceInfo() async {
    sponsors = await ApiMethods().fetchSponsors();

    ///TOO MANY RESPONSES///
  }
}
