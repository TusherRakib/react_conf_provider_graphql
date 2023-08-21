import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:react_conf/viewmodels/conference_info_view_model.dart';
import 'package:react_conf/viewmodels/conference_list_view_model.dart';
import 'package:react_conf/viewmodels/home_view_model.dart';
import 'package:react_conf/viewmodels/sponsor_list_view_model.dart';
import 'package:react_conf/views/home_view.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ConferenceListViewModel()),
        ChangeNotifierProvider(create: (_) => SponsorListViewModel()),

        ChangeNotifierProvider(create: (_) => HomeViewModel()),
      ],
      child: MaterialApp(
        title: 'Flutter MVVM GraphQL',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.white, // Set your desired background color
            centerTitle: true,
            elevation: 0,
            titleTextStyle: TextStyle(
              color: Colors.black, // Set your desired title text color
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            iconTheme: IconThemeData(
              color: Colors.black, // Set your desired icon color
            ),
          ),
        ),
        home: HomeView(),
      ),
    );
  }
}
