// ignore_for_file: prefer_const_constructors, must_be_immutable
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:flutter_svg/svg.dart';
import 'package:grad_project/staff_model.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class MemeberDetailsScreen extends StatefulWidget {
  final StaffModel staff;
  const MemeberDetailsScreen({super.key, required this.staff});

  @override
  State<MemeberDetailsScreen> createState() => _MemeberDetailsScreenState();
}

class _MemeberDetailsScreenState extends State<MemeberDetailsScreen> {
  int currentIndex = 0;
  bool isLoading = false;

  Future<void> downloadAndView(String url) async {
    setState(() {
      isLoading = true;
    });
    await requestPermissions();
    downloadPdf(url).then((value) {
      openPdf(context, value).then((value) {
        setState(() {
          isLoading = false;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
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
                            border: Border.all(color: const Color(0xFFCCCCCC)),
                            shape: BoxShape.circle,
                          ),
                          child: SvgPicture.asset("assets/icons/back-icon.svg"),
                        ),
                      ),
                    ),
                  ),
                  const Text(
                    "Member Details",
                    style: TextStyle(fontSize: 24),
                  ),
                  const Spacer(),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView(
                padding: EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                children: <Widget>[
                  CircleAvatar(
                    radius: 80,
                    backgroundColor: Colors.grey.shade100,
                    child: ClipOval(
                      child: CachedNetworkImage(
                        imageUrl: widget.staff.profilePicture?.secureUrl ?? '',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  buildContent(),
                  Center(
                    child: DefaultTabController(
                      length: 3,
                      initialIndex: 0,
                      child: TabBar(
                        tabAlignment: TabAlignment.center,
                        indicatorWeight: 4.0,
                        indicatorColor: Colors.green,
                        indicatorSize: TabBarIndicatorSize.label,
                        dividerColor: Colors.white,
                        onTap: (selectedTabIndex) {
                          setState(() {
                            currentIndex = selectedTabIndex;
                          });
                        },
                        isScrollable: true,
                        tabs: const [
                          Tab(
                            child: Text('Brief'),
                          ),
                          Tab(
                            child: Text('Research Paper'),
                          ),
                          Tab(
                            child: Text('Subject History'),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  if (currentIndex == 0) _buildBreifWidget(),
                  if (currentIndex == 1) _buildResearchPaper(),
                  if (currentIndex == 2) _buildSubjectHistory(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSubjectHistory() => Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                border: Border.symmetric(
                  horizontal: BorderSide(
                    color: Color(
                      0xff3DB166,
                    ),
                  ),
                ),
              ),
              child: Row(
                children: const [
                  Expanded(
                    child: Center(
                      child: Text(
                        'Subject Code',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        'Subject Name',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            ...widget.staff.subjectHistory?.map(
                  (e) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Center(
                            child: Text(
                              e.subjectCode ?? '',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Center(
                            child: Text(
                              e.subjectName ?? '',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ) ??
                []
          ],
        ),
      );
  Widget buildContent() {
    return Column(
      children: [
        SizedBox(height: 10),
        Text(
          widget.staff.user?.name ?? '',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 6),
        Text(
          widget.staff.user?.role ?? '',
          style: TextStyle(fontSize: 18),
        ),
        SizedBox(height: 5),
      ],
    );
  }

  Widget _buildBreifWidget() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${widget.staff.brief}',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
            ),
          ),
        ],
      );

  Widget _buildResearchPaper() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                children: List.generate(
                  widget.staff.researchPapers?.length ?? 0,
                  (index) => MaterialButton(
                    onPressed: () {
                      downloadAndView(
                        widget.staff.researchPapers?[index].secureUrl ?? '',
                      );
                    },
                    color: Color(0xff3DB166),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      'Download pdf ${index + 1}',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
      );

  Future<void> requestPermissions() async {
    await Permission.storage.request();
  }

  Future<String> downloadPdf(String url) async {
    final response = await http.get(Uri.parse(url));
    final bytes = response.bodyBytes;
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/filename.pdf');

    await file.writeAsBytes(bytes);
    return file.path;
  }

  Future openPdf(BuildContext context, String path) {
    return Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => PDFView(
          filePath: path,
        ),
      ),
    );
  }
}
