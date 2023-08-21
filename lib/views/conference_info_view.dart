import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:react_conf/utils/app_constraints.dart';
import '../viewmodels/conference_info_view_model.dart';

class ConferenceInfoView extends StatelessWidget {
  final String? id;
  const ConferenceInfoView({this.id,super.key});

  @override
  Widget build(BuildContext context) {

    return ChangeNotifierProvider<ConferenceInfoViewModel>(
      create: (context) => ConferenceInfoViewModel(id),
      child: Consumer<ConferenceInfoViewModel>(
        builder: (context, viewModel, child) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Vertical Scroll to Tab Example'),
              bottom: TabBar(
                labelColor: Colors.black,
                controller: viewModel.tabController,
                tabs: const [
                  Tab(text: 'Organizer'),
                  Tab(text: 'Speakers'),
                  Tab(text: 'Schedule'),
                  Tab(text: 'Sponsors'),
                ],
              ),
            ),
            body: FutureBuilder(
              future: viewModel.getConferenceInfo(viewModel.id!),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  return SingleChildScrollView(
                    controller: viewModel.scrollController,
                    child: Container(
                      color: Colors.white,
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          _buildOrganizerSection(viewModel),
                          _buildSpeakersSection(viewModel),
                          _buildScheduleSection(viewModel),
                          _buildSponsorSection(viewModel),
                        ],
                      ),
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

  Widget _buildSpeakersSection(ConferenceInfoViewModel model) {
    return Container(
      key: model.speakersKey,
      child: speakers(model),
    );
  }

  Widget _buildOrganizerSection(ConferenceInfoViewModel model) {
    return Container(
      key: model.organizerKey,
      child: organizer(model),
    );
  }

  Widget _buildScheduleSection(ConferenceInfoViewModel model) {
    return Container(
      key: model.scheduleKey,
      child: schedule(model),
    );
  }

  Widget _buildSponsorSection(ConferenceInfoViewModel model) {
    return Container(
      key: model.sponsorKey,
      child: sponsors(model),
    );
  }

  Widget organizer(ConferenceInfoViewModel model) {
    return model.conferenceInfoModel.organizer == null
        ? Container()
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Organizer',
                style: TextStyle(
                  color: Color(0xFF212121),
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              AppConstrains.height10,
              Container(
                alignment: Alignment.center,
                height: 120,
                decoration: ShapeDecoration(
                  color: const Color(0xFFF9FAFB),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                child: Container(
                  alignment: Alignment.center,
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 88,
                        height: 88,
                        decoration: ShapeDecoration(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                        child: SvgPicture.network(
                          model.conferenceInfoModel.organizer?.image?.url ?? "",
                        ),
                      ),
                      AppConstrains.width10,
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              model.conferenceInfoModel.organizer?.name ?? "",
                              style: const TextStyle(
                                color: Color(0xFF0A142F),
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Text(
                              model.conferenceInfoModel.organizer?.about ?? "",
                              style: const TextStyle(
                                color: Color(0xFF0A142F),
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          );
  }

  Widget speakers(ConferenceInfoViewModel model) {
    return model.conferenceInfoModel.speakers?.length == 0
        ? Container()
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Speakers',
                style: TextStyle(
                  color: Color(0xFF212121),
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              AppConstrains.height10,
              ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 20),
                  itemCount: model.conferenceInfoModel.speakers?.length ?? 0,
                  itemBuilder: (context, index) {
                    return Container(
                      alignment: Alignment.center,
                      height: 120,
                      decoration: ShapeDecoration(
                        color: const Color(0xFFF9FAFB),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                      child: Container(
                        alignment: Alignment.center,
                        decoration: ShapeDecoration(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 88.27,
                              height: 88,
                              decoration: ShapeDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(model.conferenceInfoModel.speakers?[index].image?.url ?? ""),
                                  fit: BoxFit.fill,
                                ),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                              ),
                            ),
                            AppConstrains.width10,
                            Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    model.conferenceInfoModel.speakers?[index].name ?? "",
                                    style: const TextStyle(
                                      color: Color(0xFF0A142F),
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  AppConstrains.height5,
                                  Row(
                                    children: [
                                      SvgPicture.asset(
                                        'assets/ic_twitter.svg',
                                        width: 15,
                                        height: 15,
                                      ),
                                      AppConstrains.width10,
                                      SvgPicture.asset(
                                        'assets/ic_linkedin.svg',
                                        width: 15,
                                        height: 15,
                                      ),
                                      AppConstrains.width10,
                                      SvgPicture.asset(
                                        'assets/ic_ball.svg',
                                        width: 15,
                                        height: 15,
                                      ),
                                      AppConstrains.width10,
                                      SvgPicture.asset(
                                        'assets/ic_github.svg',
                                        width: 15,
                                        height: 15,
                                      ),
                                    ],
                                  ),
                                  AppConstrains.height5,
                                  Text(
                                    model.conferenceInfoModel.speakers?[index].about ?? "",
                                    style: const TextStyle(
                                      color: Color(0xFF0A142F),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  })
            ],
          );
  }

  Widget sponsors(ConferenceInfoViewModel model) {
    return model.conferenceInfoModel.sponsors?.length == 0
        ? Container()
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Sponsors',
                style: TextStyle(
                  color: Color(0xFF212121),
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              AppConstrains.height10,
              ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 20),
                  itemCount: model.conferenceInfoModel.sponsors?.length ?? 0,
                  itemBuilder: (context, index) {
                    return Container(
                      alignment: Alignment.center,
                      height: 120,
                      decoration: ShapeDecoration(
                        color: const Color(0xFFF9FAFB),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                      child: Container(
                        alignment: Alignment.center,
                        decoration: ShapeDecoration(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 88,
                              height: 88,
                              decoration: ShapeDecoration(
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                              ),
                              child: SvgPicture.network(
                                model.conferenceInfoModel.sponsors?[index].image?.url ?? "",
                              ),
                            ),
                            AppConstrains.width10,
                            Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    model.conferenceInfoModel.sponsors?[index].name ?? "",
                                    style: const TextStyle(
                                      color: Color(0xFF0A142F),
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  Text(
                                    model.conferenceInfoModel.sponsors?[index].about ?? "",
                                    style: const TextStyle(
                                      color: Color(0xFF0A142F),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  })
            ],
          );
  }

  Widget schedule(ConferenceInfoViewModel model) {
    return model.conferenceInfoModel.schedules?.length == 0
        ? Container()
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Schedule',
                style: TextStyle(
                  color: Color(0xFF212121),
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              AppConstrains.height10,
              ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 20),
                  itemCount: model.conferenceInfoModel.schedules?.length ?? 0,
                  itemBuilder: (context, index) {
                    return Container(
                      alignment: Alignment.topLeft,
                      decoration: ShapeDecoration(
                        color: const Color(0xFFF9FAFB),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                      child: Container(
                          alignment: Alignment.topLeft,
                          decoration: ShapeDecoration(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          ),
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                model.conferenceInfoModel.schedules?[index].day ?? "",
                                style: const TextStyle(
                                  color: Color(0xFF0A142F),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Text(
                                model.conferenceInfoModel.schedules?[index].description ?? "",
                                style: const TextStyle(
                                  color: Color(0xFF0A142F),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              model.conferenceInfoModel.schedules?[index].intervals?.length == 0
                                  ? Container()
                                  : ListView.builder(
                                      physics: const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 20),
                                      itemCount: model.conferenceInfoModel.schedules?[index].intervals?.length ?? 0,
                                      itemBuilder: (context, scheduleIndex) {
                                        return model.conferenceInfoModel.schedules![index].intervals?[scheduleIndex].sessions?.length == 0
                                            ? Container()
                                            : ListView.builder(
                                                shrinkWrap: true,
                                                physics: const NeverScrollableScrollPhysics(),
                                                itemCount: model.conferenceInfoModel.schedules![index].intervals?[scheduleIndex].sessions?.length,
                                                itemBuilder: (context, intervalIndex) {
                                                  return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                                    Padding(
                                                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                                                      child: Row(
                                                        children: [
                                                          const Text(
                                                            "Duration : ",
                                                            style: TextStyle(
                                                              color: Color(0xFF0A142F),
                                                              fontSize: 14,
                                                              fontFamily: 'Inter',
                                                              fontWeight: FontWeight.w400,
                                                            ),
                                                          ),
                                                          Text(
                                                            model.conferenceInfoModel.schedules![index].intervals![scheduleIndex].sessions![intervalIndex].begin ?? '',
                                                            style: const TextStyle(
                                                              color: Color(0xFF0A142F),
                                                              fontSize: 14,
                                                              fontFamily: 'Inter',
                                                              fontWeight: FontWeight.w400,
                                                            ),
                                                          ),
                                                          const SizedBox(width: 8),
                                                          const Text(
                                                            '-',
                                                            style: TextStyle(
                                                              color: Color(0xFF0A142F),
                                                              fontSize: 14,
                                                              fontFamily: 'Inter',
                                                              fontWeight: FontWeight.w400,
                                                            ),
                                                          ),
                                                          const SizedBox(width: 8),
                                                          Text(
                                                            model.conferenceInfoModel.schedules![index].intervals![scheduleIndex].sessions![intervalIndex].end ?? '',
                                                            style: const TextStyle(
                                                              color: Color(0xFF0A142F),
                                                              fontSize: 14,
                                                              fontFamily: 'Inter',
                                                              fontWeight: FontWeight.w400,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Text(
                                                      "  • ${model.conferenceInfoModel.schedules?[index].intervals?[scheduleIndex].sessions?[intervalIndex].title}",
                                                      style: const TextStyle(
                                                        color: Color(0xFF0A142F),
                                                        fontSize: 14,
                                                        fontWeight: FontWeight.w400,
                                                      ),
                                                    ),
                                                  ]);
                                                },
                                              );
                                      },
                                    )
                            ],
                          )),
                    );
                  })
            ],
          );
  }
}
