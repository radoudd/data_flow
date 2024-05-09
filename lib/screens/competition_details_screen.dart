import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:grad_project/screens/models/competitions_model.dart';
import 'package:url_launcher/url_launcher.dart';

class ComeptitionDetailsScreen extends StatelessWidget {
  final CompetitionsModel competition;
  const ComeptitionDetailsScreen({super.key, required this.competition});

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
                  "Competition",
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
                        imageUrl:
                            '${competition.competitionPic?.secureUrl.toString()}',
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
                              competition.title ?? '',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 22,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              competition.description ?? '',
                              style: const TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            RichText(
                              text: TextSpan(
                                children: [
                                  const TextSpan(
                                    text: 'Go To Link : ',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black,
                                    ),
                                  ),
                                  const TextSpan(text: ' '),
                                  TextSpan(
                                    text: competition.link ?? '',
                                    style: const TextStyle(
                                      color: Color(0xff3DB166),
                                      decoration: TextDecoration.underline,
                                      decorationColor: Color(0xff3DB166),
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () async {
                                        if (!await launchUrl(Uri.parse(
                                            competition.link ?? ''))) {
                                          Fluttertoast.showToast(
                                              msg: 'Link Could not launch');
                                          throw Exception(
                                              'Could not launch ${competition.link ?? ''}');
                                        }
                                      },
                                  ),
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
          ),
        ],
      ),
    );
  }
}
