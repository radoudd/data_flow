import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart'
    show CarouselOptions, CarouselSlider;
import 'package:flutter/material.dart';
import 'package:grad_project/network/api_constants.dart';
import 'package:grad_project/network/data.dart';
import 'package:grad_project/network/dio_factory.dart';
import 'package:grad_project/screens/competition_details_screen.dart';
import 'package:grad_project/screens/competitions_screen.dart';
import 'package:grad_project/screens/members/member_details_screen.dart';
import 'package:grad_project/screens/members/members_screen.dart';
import 'package:grad_project/screens/models/competitions_model.dart';
import 'package:grad_project/screens/models/project_model.dart';
import 'package:grad_project/screens/models/success_story_model.dart';
import 'package:grad_project/screens/projects/project_details_screen.dart';
import 'package:grad_project/screens/projects/projects_screen.dart';
import 'package:grad_project/screens/success_stories_screen.dart';
import 'package:grad_project/screens/success_story_details_screen.dart';
import 'package:grad_project/staff_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List images = [
    'assets/images/banner_4.png',
    'assets/images/banner_2.png',
    'assets/images/banner_3.png',
    'assets/images/banner_5.png',
  ];
  int currentIndex = 0;
  List<SuccessStoryModel>? successStories;
  List<CompetitionsModel>? competitions;
  List<ProjectModel>? projects;
  List<StaffModel>? members;

  @override
  void initState() {
    super.initState();
    _getStories();
    _getCompetitions();
    _getProjects();
    _getAllStaff();
  }

  void _getAllStaff() {
    DioFactory.getData(ApiConstants.staff).then((value) {
      setState(() {
        members = (value.data as List<dynamic>)
            .map((e) => StaffModel.fromJson(e))
            .toList();
      });
    }).catchError((error) {});
  }

  void _getStories() async {
    DioFactory.getData(ApiConstants.successStory).then((value) {
      setState(() {
        successStories = (value.data as List<dynamic>)
            .map((e) => SuccessStoryModel.fromJson(e))
            .toList();
      });
    }).catchError((error) {});
  }

  void _getCompetitions() async {
    DioFactory.getData(ApiConstants.competitions).then((value) {
      setState(() {
        competitions = (value.data as List<dynamic>)
            .map((e) => CompetitionsModel.fromJson(e))
            .toList();
      });
    }).catchError((error) {});
  }

  void _getProjects() async {
    DioFactory.getData(ApiConstants.projects).then((value) {
      projects = (value.data as List<dynamic>)
          .map((e) => ProjectModel.fromJson(e))
          .toList();
    }).catchError((error) {});
  }

  @override
  Widget build(BuildContext context) {
    if (successStories == null ||
        competitions == null ||
        projects == null ||
        members == null) {
      return const Center(child: CircularProgressIndicator());
    }
    return Scaffold(
      backgroundColor: const Color(0xffD9D9D9),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.only(
                  left: 8.0,
                  top: 10.0,
                  right: 8.0,
                  bottom: 10,
                ),
                color: const Color(0xff052864),
                width: double.infinity,
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Hello ${userModel.name} ,',
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                        const Text(
                          'Information Technology',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.normal,
                              fontSize: 14),
                        )
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              CarouselSlider.builder(
                itemCount: images.length,
                itemBuilder: (context, index, realIndex) {
                  return Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(images[index]),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  );
                },
                options: CarouselOptions(
                  height: 200,
                  aspectRatio: 16 / 9,
                  autoPlay: true,
                  autoPlayCurve: Curves.easeInOut,
                  autoPlayAnimationDuration: const Duration(
                    milliseconds: 1500,
                  ),
                  autoPlayInterval: const Duration(
                    seconds: 3,
                  ),
                  enlargeCenterPage: true,
                  onPageChanged: (index, reason) {
                    setState(() {
                      currentIndex = index;
                    });
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    const Text(
                      'Department Members',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => MembersScreen(
                              members: members ?? [],
                            ),
                          ),
                        );
                      },
                      child: Container(
                        color: Colors.transparent,
                        child: const Text(
                          'See All',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Colors.green,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 180,
                width: double.infinity,
                child: ListView.builder(
                  itemCount: members?.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => MemeberDetailsScreen(
                              staff: members![index],
                            ),
                          ),
                        );
                      },
                      child: Container(
                        width: 160,
                        margin: const EdgeInsets.symmetric(horizontal: 6),
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(14)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CachedNetworkImage(
                              imageUrl:
                                  '${members?[index].profilePicture?.secureUrl.toString()}',
                              height: 130,
                              width: double.infinity,
                              fit: BoxFit.cover,
                              errorWidget: (context, url, error) =>
                                  const Center(
                                child: CircularProgressIndicator(),
                              ),
                              placeholder: (context, error) => const Center(
                                child: CircularProgressIndicator(),
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              members?[index].user?.name ?? '',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    const Text(
                      'Projects',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => ProjectsScreen(
                              projects: projects ?? [],
                            ),
                          ),
                        );
                      },
                      child: Container(
                        color: Colors.transparent,
                        child: const Text(
                          'See All',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: Colors.green),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 200,
                width: double.infinity,
                child: ListView.builder(
                  itemCount: projects?.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProjectDetailsScreen(
                            project: projects![index],
                          ),
                        ),
                      ),
                      child: Container(
                        width: 160,
                        margin: const EdgeInsets.symmetric(horizontal: 6),
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(14)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CachedNetworkImage(
                              imageUrl:
                                  '${projects?[index].mainPic?.secureUrl.toString()}',
                              height: 130,
                              width: double.infinity,
                              fit: BoxFit.cover,
                              errorWidget: (context, url, error) =>
                                  const Center(
                                child: CircularProgressIndicator(),
                              ),
                              placeholder: (context, error) => const Center(
                                child: CircularProgressIndicator(),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              projects?[index].title ?? '',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                            Text(
                              projects?[index].description ?? '',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w300,
                                color: Colors.grey,
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    const Text(
                      'Success Stories',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => SuccessStoriesScreen(
                              successStroies: successStories ?? [],
                            ),
                          ),
                        );
                      },
                      child: Container(
                        color: Colors.transparent,
                        child: const Text(
                          'See All',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Colors.green,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 180,
                width: double.infinity,
                child: ListView.builder(
                  itemCount: successStories?.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => SuccessStoryDetailsScreen(
                              successStory: successStories![index],
                            ),
                          ),
                        );
                      },
                      child: Container(
                        width: 160,
                        margin: const EdgeInsets.symmetric(horizontal: 6),
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(14)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CachedNetworkImage(
                              imageUrl:
                                  '${successStories?[index].mainPicture?.secureUrl.toString()}',
                              height: 130,
                              width: double.infinity,
                              fit: BoxFit.cover,
                              errorWidget: (context, url, error) =>
                                  const Center(
                                child: CircularProgressIndicator(),
                              ),
                              placeholder: (context, error) => const Center(
                                child: CircularProgressIndicator(),
                              ),
                            ),
                            Text(
                              successStories?[index].title ?? '',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    const Text(
                      'Competitions',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => CompetitionsScreen(
                              competitions: competitions ?? [],
                            ),
                          ),
                        );
                      },
                      child: Container(
                        color: Colors.transparent,
                        child: const Text(
                          'See All',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Colors.green,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 180,
                width: double.infinity,
                child: ListView.builder(
                  itemCount: competitions?.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => ComeptitionDetailsScreen(
                              competition: competitions![index],
                            ),
                          ),
                        );
                      },
                      child: Container(
                        width: 160,
                        margin: const EdgeInsets.symmetric(horizontal: 6),
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(14)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CachedNetworkImage(
                              imageUrl:
                                  '${competitions?[index].competitionPic?.secureUrl.toString()}',
                              height: 130,
                              width: double.infinity,
                              fit: BoxFit.cover,
                              errorWidget: (context, url, error) =>
                                  const Center(
                                child: CircularProgressIndicator(),
                              ),
                              placeholder: (context, error) => const Center(
                                child: CircularProgressIndicator(),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              competitions?[index].title ?? '',
                              style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 16)
            ],
          ),
        ),
      ),
    );
  }
}
