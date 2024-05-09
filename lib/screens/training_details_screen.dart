import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart' show TapGestureRecognizer;
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:grad_project/screens/models/external_training_model.dart';
import 'package:grad_project/screens/models/internal_training_model.dart';
import 'package:url_launcher/url_launcher.dart';

class TrainingDetailsScreen extends StatelessWidget {
  final ExternalTrainingModel? externalTrainingModel;
  final InternalTrainingModel? internalTrainingModel;

  const TrainingDetailsScreen({
    super.key,
    this.externalTrainingModel,
    this.internalTrainingModel,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                              border:
                                  Border.all(color: const Color(0xFFCCCCCC)),
                              shape: BoxShape.circle,
                            ),
                            child:
                                SvgPicture.asset("assets/icons/back-icon.svg"),
                          ),
                        ),
                      ),
                    ),
                    const Text(
                      "Training",
                      style: TextStyle(fontSize: 24),
                    ),
                    const Spacer(),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              CachedNetworkImage(
                imageUrl: externalTrainingModel != null
                    ? externalTrainingModel?.trainingPic?.secureUrl ?? ''
                    : internalTrainingModel?.trainingPicture?.secureUrl ?? '',
                height: 300,
                fit: BoxFit.cover,
                errorWidget: (context, url, error) => const Center(
                  child: CircularProgressIndicator(),
                ),
                placeholder: (context, error) => const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            externalTrainingModel != null
                                ? externalTrainingModel?.title ?? ''
                                : internalTrainingModel?.title ?? '',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 22,
                            ),
                          ),
                        ),
                        if (externalTrainingModel == null)
                          MaterialButton(
                            onPressed: () {},
                            height: 30,
                            color: const Color(
                              0xff3DB166,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: const Center(
                              child: Text(
                                "Apply",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      externalTrainingModel != null
                          ? externalTrainingModel?.description ?? ''
                          : internalTrainingModel?.description ?? '',
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Text(
                          externalTrainingModel != null
                              ? externalTrainingModel?.startsFrom
                                      ?.split('T')[0] ??
                                  ''
                              : internalTrainingModel?.startsFrom
                                      ?.split('T')[0] ??
                                  '',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Color(0xff3DB166),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const Text(
                          'To',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          externalTrainingModel != null
                              ? externalTrainingModel?.endsAt?.split('T')[0] ??
                                  ''
                              : internalTrainingModel?.endsAt?.split('T')[0] ??
                                  '',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Color(0xff3DB166),
                          ),
                        ),
                      ],
                    ),
                    if (externalTrainingModel != null) ...[
                      const Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 20,
                        ),
                        child: Divider(
                          color: Colors.grey,
                        ),
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
                              text: externalTrainingModel?.link ?? '',
                              style: const TextStyle(
                                color: Color(0xff3DB166),
                                decoration: TextDecoration.underline,
                                decorationColor: Color(0xff3DB166),
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () async {
                                  if (!await launchUrl(Uri.parse(
                                      externalTrainingModel?.link ?? ''))) {
                                    Fluttertoast.showToast(
                                        msg: 'Link Could not launch');
                                    throw Exception(
                                        'Could not launch ${externalTrainingModel?.link ?? ''}');
                                  }
                                },
                            ),
                          ],
                        ),
                      ),
                    ],
                    if (internalTrainingModel != null) ...[
                      const Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 20,
                        ),
                        child: Divider(
                          color: Colors.grey,
                        ),
                      ),
                      const Text(
                        'What you will learn ?',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                        ),
                        child: ListView.separated(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            String text = internalTrainingModel
                                    ?.whatYouWillLearn?[index] ??
                                '';
                            return Text(
                              '- $text',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.normal,
                              ),
                            );
                          },
                          separatorBuilder: (context, index) => const SizedBox(
                            height: 5,
                          ),
                          itemCount:
                              internalTrainingModel?.whatYouWillLearn?.length ??
                                  0,
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 20,
                        ),
                        child: Divider(
                          color: Colors.grey,
                        ),
                      ),
                      const Text(
                        'Instructors : ',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      ListView.separated(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          TeachingInstructor? teachingInstructor =
                              internalTrainingModel?.teachingInstructor?[index];
                          return Row(
                            children: [
                              CircleAvatar(
                                radius: 50,
                                backgroundColor: Colors.grey,
                                child: ClipOval(
                                  child: CachedNetworkImage(
                                    imageUrl: teachingInstructor
                                            ?.profilePicture?.secureUrl ??
                                        '',
                                    errorWidget: (context, url, error) =>
                                        const Center(
                                      child: Icon(
                                        Icons.person,
                                        color: Colors.black,
                                      ),
                                    ),
                                    width: double.infinity,
                                    height: double.infinity,
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) => const Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      teachingInstructor?.name ?? '',
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      teachingInstructor?.title ?? '',
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Text(
                                      teachingInstructor?.description ?? '',
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          );
                        },
                        separatorBuilder: (context, index) => const SizedBox(
                          height: 10,
                        ),
                        itemCount:
                            internalTrainingModel?.teachingInstructor?.length ??
                                0,
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
