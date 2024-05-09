import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:grad_project/screens/models/project_model.dart';
import 'package:grad_project/screens/projects/project_details_screen.dart';

class ProjectsScreen extends StatelessWidget {
  final List<ProjectModel> projects;
  const ProjectsScreen({super.key, required this.projects});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F0F0),
      body: Column(
        children: <Widget>[
          SizedBox(height: 20 + MediaQuery.paddingOf(context).top),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Align(
                      alignment: AlignmentDirectional.centerStart,
                      child: Container(
                        height: 48,
                        width: 48,
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(.25),
                          border: Border.all(color: const Color(0xFFCCCCCC)),
                          shape: BoxShape.circle,
                        ),
                        child: SvgPicture.asset("assets/icons/back-icon.svg"),
                      ),
                    ),
                  ),
                ),
                const Text(
                  "Projects",
                  style: TextStyle(fontSize: 24),
                ),
                const Spacer(),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200,
                childAspectRatio: 0.8,
                crossAxisSpacing: 15,
                mainAxisSpacing: 20,
              ),
              itemCount: projects.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProjectDetailsScreen(
                        project: projects[index],
                      ),
                    ),
                  ),
                  child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(11),
                            topRight: Radius.circular(11),
                          ),
                          child: CachedNetworkImage(
                            imageUrl:
                                '${projects[index].mainPic?.secureUrl.toString()}',
                            height: 130,
                            width: double.infinity,
                            fit: BoxFit.cover,
                            errorWidget: (context, url, error) => const Center(
                              child: CircularProgressIndicator(),
                            ),
                            placeholder: (context, error) => const Center(
                              child: CircularProgressIndicator(),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 7, vertical: 7),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                projects[index].title ?? '',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
