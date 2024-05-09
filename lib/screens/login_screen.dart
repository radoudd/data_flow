// ignore_for_file: file_names, unused_import, duplicate_import, sized_box_for_whitespace, prefer_const_constructors
import 'package:animate_do/animate_do.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:grad_project/network/api_constants.dart';
import 'package:grad_project/network/cache_helper.dart';
import 'package:grad_project/network/dio_factory.dart';
import 'package:grad_project/screens/main_layout.dart';
import 'package:jaguar_jwt/jaguar_jwt.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _idController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(),
        child: Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: [
            Image.asset(
              'assets/images/soso.png',
              height: double.infinity,
              width: double.infinity,
              alignment: Alignment.topCenter,
            ),
            Container(
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 255, 255, 255),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(60),
                      topRight: Radius.circular(60))),
              padding: EdgeInsets.symmetric(
                vertical: 40,
                horizontal: 30,
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      "Login",
                      style: TextStyle(
                          color: const Color.fromARGB(255, 0, 0, 0),
                          fontSize: 40),
                    ),
                    FadeInUp(
                        duration: Duration(milliseconds: 1400),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: const [
                              BoxShadow(
                                  color: Color.fromRGBO(255, 255, 255, 0.298),
                                  blurRadius: 20,
                                  offset: Offset(0, 10))
                            ],
                          ),
                          child: Column(
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            color: Colors.grey.shade200))),
                                child: TextFormField(
                                  controller: _idController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please Enter Your id';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    hintText: "Enter you id",
                                    hintStyle: TextStyle(color: Colors.grey),
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            color: Colors.grey.shade200))),
                                child: TextFormField(
                                  controller: _passwordController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please Enter your password';
                                    }
                                    return null;
                                  },
                                  obscureText: true,
                                  decoration: InputDecoration(
                                    hintText: "Enter your password",
                                    hintStyle: TextStyle(color: Colors.grey),
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )),
                    SizedBox(
                      height: 10,
                    ),
                    FadeInUp(
                        duration: Duration(milliseconds: 1600),
                        child: isLoading
                            ? const Center(
                                child: CircularProgressIndicator(
                                  color: Color(0xff3DB166),
                                ),
                              )
                            : MaterialButton(
                                onPressed: () async {
                                  await login();
                                },
                                height: 50,
                                color: Color(0xff3DB166),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child: const Center(
                                  child: Text(
                                    "Login",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              )),
                    SizedBox(height: 130)
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> login() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      try {
        final response = await DioFactory.postData(ApiConstants.login, data: {
          'id': _idController.text,
          'password': _passwordController.text,
        });
        CacheHelper.setToken(response.data['token']).then((value) {
          Fluttertoast.showToast(
            msg: 'Logged in successfully',
            backgroundColor: Colors.green,
          );

          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => MainLayout(),
              ),
              (route) => false);
        });
      } on Exception catch (_) {
        setState(() {
          isLoading = false;
        });
        Fluttertoast.showToast(
          msg: 'Id or Password are wrong',
          backgroundColor: Colors.red,
        );
      }
    }
  }
}
