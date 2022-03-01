// ignore_for_file: prefer_const_constructors, must_be_immutable, use_key_in_widget_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:login1/model/profile.dart';
import 'package:login1/screen/welcome_screen.dart';

class LoginScreen extends StatelessWidget {
  final formKey = GlobalKey<FormState>();
  Profile profile = Profile(email: '', password: '');
  final Future<FirebaseApp> firebase = Firebase.initializeApp();

  get e => null;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: firebase,
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasError) {
          return Scaffold(
            appBar: AppBar(title: Text('error')),
            body: Center(child: Text("${snapshot.error}")),
          );
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Login'),
            ),
            body: Padding(
              padding: const EdgeInsets.all(25),
              child: Form(
                key: formKey,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "E-mail",
                        style: TextStyle(fontSize: 20),
                      ),
                      TextFormField(
                        validator: MultiValidator([
                          RequiredValidator(errorText: 'กรุณากรอก Email ด้วย'),
                          EmailValidator(errorText: 'รูปแบบ Email ไม่ถูกต้อง ')
                        ]),
                        keyboardType: TextInputType.emailAddress,
                        onSaved: (String? email) {
                          profile.email = email!;
                        },
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        "Password",
                        style: TextStyle(fontSize: 20),
                      ),
                      TextFormField(
                        validator: (str) {
                          if (str!.isEmpty) {
                            return "กรุณาป้อนจำนวนเงิน";
                          }
                          if (double.parse(str) <= 6) {
                            return "กรุณาใช้รหัสผ่านมากกว่า 6 ตัวขึ้นไป";
                          }
                          return null;
                        },
                        obscureText: true,
                        onSaved: (String? password) {
                          profile.password = password!;
                        },
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          child: Text("Login"),
                          onPressed: () async {
                            if (formKey.currentState!.validate()) {
                              formKey.currentState?.save();
                              try {
                                await FirebaseAuth.instance
                                    .signInWithEmailAndPassword(
                                        email: profile.email,
                                        password: profile.password);
                                formKey.currentState!.reset();
                                Navigator.pushReplacement(context,
                                    MaterialPageRoute(
                                        builder: (BuildContext context) {
                                  return WelcomeScreen();
                                }));
                              } on FirebaseAuthException catch (e) {
                                Fluttertoast.showToast(
                                    msg: e.message.toString(),
                                    gravity: ToastGravity.CENTER);
                              }
                            }
                          },
                        ),
                      )
                    ]),
              ),
            ),
          );
        }
        return Scaffold(
          body: Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
