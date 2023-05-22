// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
//
// class SignupScreen extends StatefulWidget {
//   const SignupScreen({Key? key}) : super(key: key);
//
//   @override
//   State<SignupScreen> createState() => _SignupScreenState();
// }
//
// class _SignupScreenState extends State<SignupScreen> {
//   // firebase authentication instance 생성
//   final _auth = FirebaseAuth.instance;
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//
//   Widget _userIdWidget() {
//     return TextFormField(
//       controller: _emailController,
//       keyboardType: TextInputType.emailAddress,
//       decoration: const InputDecoration(
//           border: OutlineInputBorder(), labelText: 'email'),
//       validator: (String? value) {
//         if (value!.isEmpty) {
//           return '이메일을 입력해주세요.';
//         }
//         return null;
//       },
//     );
//   }
//
//   Widget _passwordWidget() {
//     return TextFormField(
//       controller: _passwordController,
//       obscureText: true,
//       keyboardType: TextInputType.number,
//       decoration: const InputDecoration(
//           border: OutlineInputBorder(), labelText: 'password'),
//       validator: (String? value) {
//         if (value!.isEmpty) {
//           // null or isEmpty
//           return '비밀번호를 입력해주세요.';
//         }
//         return null;
//       },
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         resizeToAvoidBottomInset: false,
//         backgroundColor: const Color(0xFFffffff),
//         appBar: AppBar(
//           title: const Text("회원가입"),
//           centerTitle: true,
//         ),
//       body: SafeArea(
//           child: Form(
//               key: _formKey,
//               child: Padding(
//                   padding: const EdgeInsets.all(20.0),
//                   child: Column(
//                     children: [
//                       _userIdWidget(),
//                       const SizedBox(
//                         height: 20.0,
//                       ),
//                       _passwordWidget(),
//                       Container(
//                         height: 50,
//                         width: double.infinity,
//                         margin: const EdgeInsets.only(top: 8.0),
//                         child: ElevatedButton(
//                           onPressed: () => _signup(),
//                           child: const Text("회원가입"),
//                         ),
//                       ),
//                       const SizedBox(
//                         height: 20.0,
//                       ),
//                     ],
//                   )))),
//     );
//   }
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//   }
//
//   @override
//   void dispose() {
//     _emailController.dispose();
//     _passwordController.dispose();
//     super.dispose();
//   }
//
//   _signup() async {
//     // 키보드 숨기기
//     if (_formKey.currentState!.validate()) {
//       FocusScope.of(context).requestFocus(FocusNode());
//
//       //firebase 사용자 인증, 사용자 등록
//       try {
//         UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
//             email: _emailController.text, password: _passwordController.text).then((value) {
//           if (value.user!.email == null) {
//           } else {
//             ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//               content: Text('회원가입 완료'),
//               backgroundColor: Colors.blue,
//             ));
//             // Navigator.pop(context);
//           }
//           return value;
//         });
//         // _auth.currentUser?.sendEmailVerification();
//       } on FirebaseAuthException catch (e) {
//         print(e.code);
//         var errorCode = e.message.toString().split('(')[1].split(')')[0].split('/')[1];
//         String message = '';
//
//         if (errorCode == 'weak-password') {
//           message = '취약한 비밀번호입니다. ';
//         } else if (errorCode == 'email-already-in-use') {
//           message = '이미 사용중인 이메일입니다.';
//         } else {
//           message = errorCode;
//         }
//
//         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//           content: Text(message),
//           backgroundColor: Colors.deepOrange,
//         ));
//       }
//     }
//   }
// }

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;

final String URL = "http://15.164.95.116:8000/";

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  // firebase authentication instance 생성
  final _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Widget _userIdWidget() {
    return TextFormField(
      controller: _emailController,
      keyboardType: TextInputType.emailAddress,
      decoration: const InputDecoration(
          border: OutlineInputBorder(), labelText: 'email'),
      validator: (String? value) {
        if (value!.isEmpty) {
          return '이메일을 입력해주세요.';
        }
        return null;
      },
    );
  }

  Widget _passwordWidget() {
    return TextFormField(
      controller: _passwordController,
      obscureText: true,
      keyboardType: TextInputType.number,
      decoration: const InputDecoration(
          border: OutlineInputBorder(), labelText: 'password'),
      validator: (String? value) {
        if (value!.isEmpty) {
          // null or isEmpty
          return '비밀번호를 입력해주세요.';
        }
        return null;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xFFffffff),
      appBar: AppBar(
        title: const Text("회원가입"),
        centerTitle: true,
      ),
      body: SafeArea(
          child: Form(
              key: _formKey,
              child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      _userIdWidget(),
                      const SizedBox(
                        height: 20.0,
                      ),
                      _passwordWidget(),
                      Container(
                        height: 50,
                        width: double.infinity,
                        margin: const EdgeInsets.only(top: 8.0),
                        child: ElevatedButton(
                          onPressed: () => _signup(),
                          child: const Text("회원가입"),
                        ),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                    ],
                  )))),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  _signup() async {
    // 키보드 숨기기
    if (_formKey.currentState!.validate()) {
      FocusScope.of(context).requestFocus(FocusNode());

      String message = '';

      final request = Uri.parse(URL + "user/signup");

      Future<Map<String, String>> fetch() async {
        print("here");
        Map<String, String> body = {
          "email": _emailController.text,
          "password": _passwordController.text
        };
        print("here1");
        final response = await http.post(request, body: body);
        var decodedResult = jsonDecode(response.body) as Map<String, dynamic>;

        print(decodedResult);

        var result =
        decodedResult.map((key, value) => MapEntry(key, value.toString()));

        return result;
      }

      var response = fetch();

      // print(response);

      message = await response.then((value) => value['result'].toString());

      message =
      await response.then((value) => value["error_message"].toString());

      if (message == "signup success") {
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(message),
          backgroundColor: Colors.deepOrange,
        ));
      }
    }
  }
}