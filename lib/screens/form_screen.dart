import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:grad_project/network/api_constants.dart';
import 'package:grad_project/network/data.dart';
import 'package:grad_project/network/dio_factory.dart';
import 'package:grad_project/screens/models/form_model.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;

class FormScreen extends StatefulWidget {
  const FormScreen({super.key});

  @override
  State<StatefulWidget> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  String? formTypeSelected;
  final List<String> formTypes = [
    'Subject Hours',
    'Overload Hours',
    'Subject Request',
  ];
  final TextEditingController _controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  List<FormModel>? forms;
  void submitForm() {
    if (formTypeSelected == null) {
      Fluttertoast.showToast(msg: 'Please Select Form Type');
      return;
    }
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });

      DioFactory.postData(
        ApiConstants.createForm,
        data: {
          'userId': userModel.id,
          'subject': formTypeSelected,
          'description': _controller.text,
          'status': 'pending',
        },
      ).then((value) {
        Fluttertoast.showToast(msg: 'Form has been sent');
        setState(() {
          _controller.clear();
          formTypeSelected = null;
          isLoading = false;
        });
      }).catchError((e) {
        Fluttertoast.showToast(msg: 'Failed to sent the form. try again');
        setState(() {
          isLoading = false;
        });
      });
    }
  }

  @override
  void initState() {
    super.initState();
    if (userModel.role == 'staff') {
      getForms();
    }
  }

  void getForms() {
    DioFactory.getData(ApiConstants.form).then((value) {
      setState(() {
        forms = (value.data as List<dynamic>)
            .map((e) => FormModel.fromJson(e))
            .toList();
      });
    }).catchError((e) {});
  }

  bool isDownloading = false;
  Future<String> createPdf(String text) async {
    setState(() {
      isDownloading = true;
    });
    final pdf = pw.Document();
    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Padding(
            padding:
                const pw.EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: pw.Text(
              text,
              style: const pw.TextStyle(
                fontSize: 20,
              ),
            ),
          );
        },
      ),
    );
    try {
      final dir = await getApplicationDocumentsDirectory();
      final file = File('${dir.path}/example.pdf');
      await file.writeAsBytes(await pdf.save());
      return file.path;
    } catch (e) {
      throw Exception('Error saving PDF: $e');
    }
  }

  Future<void> openPdf(String path) async {
    final result = await OpenFile.open(path);
    if (result.type != ResultType.done) {
      throw Exception('Error opening the PDF file.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return userModel.role! == 'staff'
        ? _buildStaffWidget()
        : _buildStudentWidget();
  }

  Widget _buildStaffWidget() => Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: const Text(
            'Form',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
        ),
        body: forms == null
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : ListView.separated(
                itemBuilder: (context, index) => Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 10,
                  ),
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Image.asset(
                            'assets/images/logo.png',
                            fit: BoxFit.cover,
                            width: 70,
                            height: 70,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  forms?[index].userId?.name ?? '',
                                  style: const TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  forms?[index].userId?.userId ?? '',
                                  style: const TextStyle(
                                    fontSize: 13.0,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  children: [
                                    const Text(
                                      'Form Type : ',
                                      style: TextStyle(
                                        fontSize: 13.0,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        forms?[index].subject ?? '',
                                        style: const TextStyle(
                                          fontSize: 13.0,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      Align(
                        alignment: AlignmentDirectional.centerEnd,
                        child: isDownloading
                            ? const Center(
                                child: CircularProgressIndicator(),
                              )
                            : MaterialButton(
                                onPressed: () async {
                                  final path = await createPdf(
                                      forms?[index].description ?? '');
                                  await openPdf(path);
                                  setState(() {
                                    isDownloading = false;
                                  });
                                },
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                color: const Color(0xff3DB166),
                                child: const Text(
                                  'Open and Download',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                      ),
                    ],
                  ),
                ),
                separatorBuilder: (context, index) => const SizedBox(
                  height: 10,
                ),
                itemCount: forms?.length ?? 0,
              ),
      );

  Widget _buildStudentWidget() => Scaffold(
        backgroundColor: Colors.transparent,
        floatingActionButton: isLoading
            ? const CircularProgressIndicator()
            : MaterialButton(
                onPressed: () => submitForm(),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                color: const Color(0xff3DB166),
                child: const Text(
                  'Send',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: const Text(
            'Form',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Text(
                    'Form Type : ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  Expanded(
                    child: SubmenuButton(
                      style: ButtonStyle(
                        shape: MaterialStatePropertyAll(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                            side: const BorderSide(
                              color: Color(
                                0xff3DB166,
                              ),
                            ),
                          ),
                        ),
                      ),
                      menuChildren: formTypes
                          .map(
                            (e) => MenuItemButton(
                              child: Text(
                                e,
                              ),
                              onPressed: () {
                                setState(() {
                                  formTypeSelected = e;
                                });
                              },
                            ),
                          )
                          .toList(),
                      child: Text(formTypeSelected ?? 'Select Form Type'),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Description : ',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Form(
                key: _formKey,
                child: TextFormField(
                  controller: _controller,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter description';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    hintText: 'Enter the Description',
                    hintMaxLines: null,
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Color(0xff3DB166),
                        style: BorderStyle.solid,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  textInputAction: TextInputAction.newline,
                  keyboardType: TextInputType.multiline,
                  maxLength: null,
                  maxLines: null,
                ),
              ),
            ],
          ),
        ),
      );
}
