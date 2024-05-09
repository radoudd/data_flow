import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class StudyPlanScreen extends StatelessWidget {
  const StudyPlanScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
          ),
          child: Column(
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
                      "Study Plan",
                      style: TextStyle(fontSize: 24),
                    ),
                    const Spacer(),
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Image.asset(
                'assets/images/study_plan.png',
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
