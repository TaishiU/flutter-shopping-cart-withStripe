import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shopping_cart/Firebase/Firestore.dart';
import 'package:shopping_cart/Riverpod.dart';
import 'package:shopping_cart/main.dart';

class RegistrationScreen extends HookWidget {
  RegistrationScreen({Key? key}) : super(key: key);

  /*buildの外に出すことでエラーを防ぐ*/
  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final _email = useProvider(emailProvider).state;
    final _password = useProvider(passwordProvider).state;
    final _isObscure = useProvider(isObscureProvider);

    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Form(
            key: _formkey,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  SizedBox(height: 100),
                  Text(
                    'New account☘️',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 30,
                    ),
                  ),
                  SizedBox(height: 100),
                  Container(
                    height: 60,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                    ),
                    child: TextFormField(
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 20,
                        ),
                        hintText: 'Email',
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.w400,
                        ),
                        border: InputBorder.none,
                      ),
                      onChanged: (value) {
                        context.read(emailProvider).state = value;
                      },
                      keyboardType: TextInputType.emailAddress,
                      validator: (String? input) {
                        if (input!.isEmpty) {
                          return 'Enter your Email';
                        }
                        if (input.isNotEmpty && !input.contains('@')) {
                          return 'You need to check \'@\' mark';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    height: 60,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                    ),
                    child: TextFormField(
                      obscureText: _isObscure,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 20,
                        ),
                        hintText: 'Password',
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.w400,
                        ),
                        border: InputBorder.none,
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isObscure
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                          onPressed: () {
                            context
                                .read(isObscureProvider.notifier)
                                .update(!_isObscure);
                          },
                        ),
                      ),
                      onChanged: (value) {
                        context.read(passwordProvider).state = value;
                      },
                      keyboardType: TextInputType.visiblePassword,
                      validator: (String? input) {
                        if (input!.isEmpty) {
                          return 'Enter Password';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(height: 100),
                  Container(
                    height: 60,
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                      child: Text(
                        'Create account',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 23,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.black,
                        onPrimary: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () async {
                        _formkey.currentState!.save();
                        if (_formkey.currentState!.validate()) {
                          try {
                            final _auth = FirebaseAuth.instance;
                            final authResult =
                                await _auth.createUserWithEmailAndPassword(
                              email: _email,
                              password: _password,
                            );

                            /*ユーザーIDを更新*/
                            context.read(userIdProvider).state =
                                authResult.user!.uid;

                            Firestore().registerUser(
                              userId: authResult.user!.uid,
                              email: _email,
                            );

                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MyApp(),
                              ),
                            );
                          } catch (e) {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('Error'),
                                  content: Text(e.toString()),
                                  actions: [
                                    TextButton(
                                      child: Text(
                                        'OK',
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.red,
                                        ),
                                      ),
                                      style: TextButton.styleFrom(
                                        primary: Colors.black,
                                      ),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          }
                        }
                      },
                    ),
                  ),
                  SizedBox(height: 100),
                  ElevatedButton(
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Icon(
                        Icons.chevron_left,
                        size: 30,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                      onPrimary: Colors.black,
                      shape: const CircleBorder(
                        side: BorderSide(
                          color: Colors.black,
                          width: 1,
                          style: BorderStyle.solid,
                        ),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
