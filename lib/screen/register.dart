// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors, avoid_print, empty_catches, unused_catch_clause
// ignore_for_file: prefer_const_literals_to_create_immutables
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:login1/model/profile.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
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
              title: Text('register'),
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
                          child: Text("register"),
                          onPressed: () async {
                            if (formKey.currentState!.validate()) {
                              formKey.currentState?.save();
                              try {
                                await FirebaseAuth.instance
                                    .createUserWithEmailAndPassword(
                                        email: profile.email,
                                        password: profile.password);
                                Fluttertoast.showToast(
                                    msg: "สร้างบัญชีเรียบร้อยแล้ว",
                                    gravity: ToastGravity.CENTER);
                                formKey.currentState?.reset();
                              } on FirebaseAuthException catch (e) {
                                String message;
                                if (e.code == 'email-already-in-use') {
                                  message =
                                      "มีอีเมลนี้เคยใช้แล้ว กรุณาใช้ อีเมล อื่น";
                                  Fluttertoast.showToast(
                                      msg: message,
                                      gravity: ToastGravity.CENTER);
                                }
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
