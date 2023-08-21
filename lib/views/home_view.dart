import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:react_conf/utils/app_colors.dart';

import '../viewmodels/home_view_model.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeViewModel>(
      create: (context) => HomeViewModel(),
      child: Consumer<HomeViewModel>(
        builder: (context, viewModel, child) {
          return Scaffold(
            body: viewModel.pages[viewModel.currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              selectedItemColor: AppColors.colorSelectedYellow,
              unselectedItemColor: AppColors.colorUnselectedGrey,
              currentIndex: viewModel.currentIndex,
              onTap: (index) {
                viewModel.changePage(index);
              },
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.event),
                  label: 'Conference',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.campaign),
                  label: 'Sponsors',
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
