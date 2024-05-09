import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:grad_project/screens/members/member_details_screen.dart';
import 'package:grad_project/staff_model.dart';

class MembersScreen extends StatelessWidget {
  final List<StaffModel> members;
  const MembersScreen({super.key, required this.members});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F0F0),
      body: SafeArea(
        child: Column(
          children: <Widget>[
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
                    "Members",
                    style: TextStyle(fontSize: 24),
                  ),
                  const Spacer(),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 5,
                mainAxisSpacing: 5,
                childAspectRatio: 1.0,
                children: List.generate(
                  members.length,
                  (index) => GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MemeberDetailsScreen(
                            staff: members[index],
                          ),
                        ),
                      );
                    },
                    child: Container(
                      color: Colors.transparent,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ClipOval(
                            child: CachedNetworkImage(
                              imageUrl:
                                  '${members[index].profilePicture?.secureUrl.toString()}',
                              height: 130,
                              width: 130,
                              fit: BoxFit.cover,
                              errorWidget: (context, url, error) =>
                                  const Center(
                                child: CircularProgressIndicator(),
                              ),
                              placeholder: (context, error) => const Center(
                                child: CircularProgressIndicator(),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Column(
                            children: [
                              Text(
                                members[index]
                                        .user
                                        ?.name
                                        ?.split(' ')
                                        .join('\n') ??
                                    '',
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
