import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:grad_project/network/api_constants.dart';
import 'package:grad_project/network/dio_factory.dart';
import 'package:grad_project/screens/models/external_training_model.dart';
import 'package:grad_project/screens/models/internal_training_model.dart';
import 'package:grad_project/screens/training_details_screen.dart';

class TrainingScreen extends StatefulWidget {
  const TrainingScreen({Key? key}) : super(key: key);

  @override
  State<TrainingScreen> createState() => _TrainingScreenState();
}

class _TrainingScreenState extends State<TrainingScreen> {
  int selectedIndex = 0;
  List<ExternalTrainingModel>? externalTraining;
  List<InternalTrainingModel>? internalTraining;
  @override
  void initState() {
    super.initState();
    DioFactory.getData(ApiConstants.externalTrainings).then((value) {
      setState(() {
        externalTraining = (value.data as List<dynamic>)
            .map((e) => ExternalTrainingModel.fromJson(e))
            .toList();
      });
    }).catchError((error) {});

    DioFactory.getData(ApiConstants.internalTrainings).then((value) {
      setState(() {
        internalTraining = (value.data as List<dynamic>)
            .map((e) => InternalTrainingModel.fromJson(e))
            .toList();
      });
    }).catchError((error) {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text(
          'Training',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: (internalTraining == null || externalTraining == null)
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : LayoutBuilder(
              builder: (context, constraints) {
                return Column(
                  children: [
                    DefaultTabController(
                      length: 2,
                      child: TabBar(
                        tabAlignment: TabAlignment.center,
                        indicatorWeight: 4.0,
                        indicatorColor: Colors.green,
                        indicatorSize: TabBarIndicatorSize.label,
                        dividerColor: Colors.transparent,
                        onTap: (selectedTabIndex) {
                          setState(() {
                            selectedIndex = selectedTabIndex;
                          });
                        },
                        isScrollable: true,
                        tabs: const [
                          Tab(
                            child: Text('External Training'),
                          ),
                          Tab(
                            child: Text('Internal Trainig'),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: GridView.count(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          childAspectRatio: 0.7,
                          children: List.generate(
                            selectedIndex == 0
                                ? externalTraining?.length ?? 0
                                : internalTraining?.length ?? 0,
                            (index) => GestureDetector(
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => TrainingDetailsScreen(
                                    externalTrainingModel: selectedIndex == 0
                                        ? externalTraining![index]
                                        : null,
                                    internalTrainingModel: selectedIndex == 0
                                        ? null
                                        : internalTraining![index],
                                  ),
                                ),
                              ),
                              child: Container(
                                clipBehavior: Clip.antiAlias,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    CachedNetworkImage(
                                      imageUrl: selectedIndex == 0
                                          ? externalTraining![index]
                                                  .trainingPic
                                                  ?.secureUrl ??
                                              ''
                                          : internalTraining![index]
                                                  .trainingPicture
                                                  ?.secureUrl ??
                                              '',
                                      height: 130,
                                      fit: BoxFit.cover,
                                      errorWidget: (context, url, error) =>
                                          const Center(
                                        child: CircularProgressIndicator(),
                                      ),
                                      placeholder: (context, error) =>
                                          const Center(
                                        child: CircularProgressIndicator(),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 10,
                                      ),
                                      height: 100,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                selectedIndex == 0
                                                    ? externalTraining![index]
                                                            .title ??
                                                        ''
                                                    : internalTraining![index]
                                                            .title ??
                                                        '',
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              Text(
                                                selectedIndex == 0
                                                    ? externalTraining![index]
                                                            .description ??
                                                        ''
                                                    : internalTraining![index]
                                                            .description ??
                                                        '',
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1,
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.normal,
                                                ),
                                              ),
                                            ],
                                          ),
                                          const Spacer(),
                                          const SizedBox(height: 10),
                                          const Text(
                                            'From 12 jan to 1 Oct',
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                              color: Color(0xff3DB166),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
    );
  }
}
