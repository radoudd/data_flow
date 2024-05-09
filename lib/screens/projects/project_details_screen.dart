import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:grad_project/screens/models/project_model.dart';

class ProjectDetailsScreen extends StatelessWidget {
  final ProjectModel project;
  const ProjectDetailsScreen({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F0F0),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
                  "Project Details",
                  style: TextStyle(fontSize: 24),
                ),
                const Spacer(),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CachedNetworkImage(
                        imageUrl: '${project.mainPic?.secureUrl.toString()}',
                        height: 250,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        errorWidget: (context, url, error) => const Center(
                          child: CircularProgressIndicator(),
                        ),
                        placeholder: (context, error) => const Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 10),
                            Text(
                              project.title ?? '',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 22,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              project.description ?? '',
                              style: const TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            const Text(
                              'Team Members',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 22,
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            SizedBox(
                              height: 150,
                              child: ListView.separated(
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  return Column(
                                    children: <Widget>[
                                      CircleAvatar(
                                        radius: 50,
                                        backgroundImage: NetworkImage(
                                          project.teamMembers?[index].pic
                                                  ?.secureUrl ??
                                              '',
                                        ),
                                      ),
                                      Text(
                                        project.teamMembers?[index].name
                                                ?.split(' ')
                                                .join('\n') ??
                                            '',
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  );
                                },
                                separatorBuilder: (context, index) =>
                                    const SizedBox(
                                  width: 10,
                                ),
                                itemCount: project.teamMembers?.length ?? 0,
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
