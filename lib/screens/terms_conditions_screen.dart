import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';

class TermsAndCondtionsScreen extends StatelessWidget {
  const TermsAndCondtionsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 20.0,
              horizontal: 20.0,
            ),
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
                              child: SvgPicture.asset(
                                  "assets/icons/back-icon.svg"),
                            ),
                          ),
                        ),
                      ),
                      const Text(
                        "Terms & Conditions",
                        style: TextStyle(fontSize: 24),
                      ),
                      const Spacer(),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  '1. GREEMENT TO OUR LEGAL TERMS',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10.0),
                const Text(
                  'We are Data Flow Automation Team as we operate this mobile application from A to Z , '
                  'Data Flow Automation mobile app is designed to streamline your Data Flow Automation process, making it simple and effective, '
                  'facilitates seamless collaboration among your team members, empowers you to identify, track, and resolve bugs seamlessly. ',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                const SizedBox(height: 16.0),
                const Text(
                  'By App Notifications',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8.0),
                const Text(
                  'The Services are likely intended for users who are working on technical projects. '
                  'or students and staff to track the data flow easily .',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                const SizedBox(height: 16.0),
                const Text(
                  '2. INTELLECTUAL PROPERTY RIGHTS',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8.0),
                const Text(
                  'Our intellectual property '
                  'We are the owner or the licensee of all intellectual property rights in our Services, '
                  'including all source code, databases, functionality, software, website designs, audio, video, text, photographs, and graphics '
                  'in the Services , as well as the trademarks, service marks, and logos contained there.'
                  'Our Content and Marks are protected by copyright and trademark laws '
                  'The Content and Marks are provided in or through the Services "AS IS" for your personal, non-commercial use or internal business purpose.',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                const SizedBox(height: 16.0),
                const Text(
                  '3.CONTACT US',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8.0),
                const Text(
                  '''In order to resolve a complaint regarding the Services or to receive further information regarding use of the Services, Please contact with Mail: to Data Flow Automation Team Email''',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                const SizedBox(height: 8.0),
                GestureDetector(
                  onTap: () => _launchEmail('team@dataflow.com'),
                  child: const Text(
                    'team@dataflow.com',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(
                        0xff3DB166,
                      ),
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                const SizedBox(height: 16.0),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _launchEmail(String email) async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: email,
    );

    try {
      await canLaunchUrl(emailLaunchUri);
    } catch (_) {}
  }
}
