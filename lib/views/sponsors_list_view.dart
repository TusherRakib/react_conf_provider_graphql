import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../viewmodels/sponsor_list_view_model.dart';

class SponsorListView extends StatelessWidget {
  const SponsorListView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SponsorListViewModel>(
      create: (context) => SponsorListViewModel(),
      child: Consumer<SponsorListViewModel>(
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
                  centerTitle: false,
                  title: const Text(
                    'Our Sponsor',
                    style: TextStyle(
                      color: Color(0xFF111D5E),
                      fontSize: 24,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  leading: const Icon(Icons.arrow_back),
                ),
              ),
            ),
            body: FutureBuilder(
              future: viewModel.getConferenceInfo(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  return  GridView.builder(
                    itemCount: viewModel.sponsorIcons.length, // Total number of images
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, // Number of images in each row
                    ),
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: SvgPicture.asset(
                          viewModel.sponsorIcons[index], // Replace with your image URL
                        ),
                      );
                    },
                  );
                }
              },
            ),
          );
        },
      ),
    );
  }
}
