import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:myapp/Components/Rounded_Button.dart';
import 'package:myapp/Components/Rounded_input_field.dart';
import 'package:myapp/Components/already_hava_an_account_check.dart';
import 'package:myapp/Components/rounded_password_field.dart';
import 'package:myapp/Components/text_field_container.dart';
import 'package:myapp/Screens/HomeScreen/HomePage.dart';
import 'package:myapp/Screens/login/components/Background.dart';
import 'package:myapp/contants.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'dart:convert';
import 'package:myapp/auth.dart';

class Body extends StatelessWidget {
  const Body({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String id;
    String pass;
    Size size = MediaQuery.of(context).size;
    return Background(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          "LOGIN",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: size.height * 0.03),
        SvgPicture.asset(
          "assets/icons/login.svg",
          height: size.height * 0.35,
        ),
        SizedBox(height: size.height * 0.03),
        RoundedInputField(
          hintText: "Your Email",
          onchanged: (value) {
            id = value;
          },
        ),
        RoundedPasswordField(
          onchanged: (value) {
            pass = value;
          },
        ),
        RoundedButton(
          text: "LOGIN",
          press: () {
            Auth auth = new Auth();
            Future<String> result=auth.insertData(id, pass);
            result.then((value) {
              if(value=="Error"){
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    // return object of type Dialog
                    return AlertDialog(
                      title: new Text("로그인 에러"),
                      content: new Text("계정 정보를 확인해주세요"),
                      actions: <Widget>[
                        new FlatButton(
                          child: new Text("닫기"),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    );
                  },
                );
              }
              else{
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => HomePage()));

              }
            });
          },
        ),
        SizedBox(height: size.height * 0.03),
        AlreadyHaveAnAccountCheck(
          press: () {},
        ),
      ],
    ));
  }
}