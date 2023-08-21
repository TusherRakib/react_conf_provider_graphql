import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:react_conf/utils/app_constraints.dart';
import 'package:react_conf/utils/app_text_styles.dart';
import 'package:react_conf/viewmodels/conference_list_view_model.dart';

import '../models/conf_list_model.dart';
import '../utils/app_colors.dart';
import '../viewmodels/conference_info_view_model.dart';
import 'conference_info_view.dart';

class ConferenceListView extends StatelessWidget {
  const ConferenceListView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ConferenceListViewModel>(
      create: (context) => ConferenceListViewModel(),
      child: Consumer<ConferenceListViewModel>(
        builder: (context, viewModel, child) {
          return Scaffold(
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(60.0), // Adjust height as needed
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0x0F000000).withOpacity(0.1), // Box shadow color
                      offset: const Offset(0, 4),
                      blurRadius: 8,
                    ),
                  ],
                ),
                child: AppBar(
                  title: SvgPicture.asset(
                    'assets/logo_react_conf.svg', // Replace with your SVG asset path
                    width: 40,
                    height: 40,
                    //color: Colors.white, // Customize the color of the SVG
                  ),
                ),
              ),
            ),
            body: FutureBuilder(
              future: viewModel.getConferenceList(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator()); // Display loading indicator
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}'); // Display error message
                } else {
                  return SingleChildScrollView(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 15),
                          width: MediaQuery.of(context).size.width / 7,
                          child: ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 20),
                              itemCount: viewModel.conferenceList?.length ?? 0,
                              itemBuilder: (context, index) {
                                return Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.only(top: 10, bottom: 10),
                                      width: 48,
                                      height: 48,
                                      child: Container(
                                        decoration: ShapeDecoration(
                                          color: const Color(0xFFFFF9EA),
                                          shape: RoundedRectangleBorder(
                                            side: const BorderSide(width: 0.50, color: AppColors.colorSelectedYellow),
                                            borderRadius: BorderRadius.circular(48.29 / 2),
                                          ),
                                        ),
                                        child: const Icon(Icons.bolt, size: 24, color: AppColors.colorSelectedYellow),
                                      ),
                                    ),

                                    index == viewModel.conferenceList!.length - 1
                                        ? Container()
                                        : Container(
                                            width: 2,
                                            height: 95,
                                            color: const Color(0xFFFFC83D),
                                          ),
                                    //AppConstrains.height,
                                  ],
                                );
                              }),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 1.2,
                          child: ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                            itemCount: viewModel.conferenceList?.length ?? 0,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                  onTap: () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => ConferenceInfoView(id: viewModel.conferenceList![index].id),
                                          //settings: RouteSettings(arguments: viewModel.conferenceList![index].id),
                                        ),
                                      ),
                                  child: buildListItem(viewModel.conferenceList![index]));
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                }
              },
            ),
          );
        },
      ),
    );
  }

  Widget buildListItem(Conference item) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        Text(
          item.startDate,
          style: AppTextStyles.paragraph1.copyWith(color: AppColors.colorFontColorGrey),
        ),
        AppConstrains.height10,
        Card(
          margin: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8), // Adjust the radius as needed
          ),
          color: AppColors.colorSelectedYellow,
          child: buildContent(item),
        ),
        AppConstrains.height20,
      ],
    );
  }

  Widget buildContent(Conference item) {
    return Container(
      height: 110,
      margin: const EdgeInsets.only(top: 6),
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(8), bottomRight: Radius.circular(8)), // Adjust the radius as needed
        ),
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildTitle(item),
            const SizedBox(height: 10),
            buildDescription(item),
          ],
        ),
      ),
    );
  }

  Widget buildTitle(Conference item) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 16,
          height: 16,
          decoration: const BoxDecoration(
            color: Color(0xFFFFC83D),
            shape: BoxShape.circle,
          ),
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: Container(
              width: 6,
              height: 6,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Text(
            item.name,
            style: AppTextStyles.h3.copyWith(color: AppColors.colorFontColorBlue),
          ),
        ),
      ],
    );
  }

  Widget buildDescription(Conference item) {
    return Container(
      padding: const EdgeInsets.only(left: 33),
      child: Text(item.slogan, style: AppTextStyles.h4.copyWith(color: AppColors.colorFontColorGrey)),
    );
  }
}
