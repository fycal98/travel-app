import 'dart:ui';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Widgets/BottomSheet.dart';
import 'MainScreen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'StartSceen.dart';
import '../Data.dart';
import 'package:provider/provider.dart';

final TextInputstyle = TextStyle(color: Colors.white);

class LoginScreen extends StatelessWidget {
  static const route = 'LoginScreen';
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  FocusNode emailF = FocusNode();
  FocusNode passwordF = FocusNode();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var fontfactor = size.height / 720;
    return Scaffold(
      body: Container(
        height: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: size.height * 0.2,
              ),
              Center(
                child: Text(
                  'Topdeck',
                  style: TextStyle(
                      fontFamily: 'Pacifico-Regular',
                      fontSize: 45 * fontfactor,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: size.height * 0.07,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
                child: ClipRect(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                    child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            border: Border.all(color: Colors.white, width: 1)),
                        child: Padding(
                          padding: EdgeInsets.all(size.width * 0.01),
                          child: TextField(
                            focusNode: emailF,
                            controller: email,
                            style: TextInputstyle,
                            decoration: InputDecoration(
                              hintText: 'Email',
                              hintStyle: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12 * fontfactor),
                              border: InputBorder.none,
                            ),
                          ),
                        )),
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.03,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
                child: ClipRect(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                    child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            border: Border.all(color: Colors.white, width: 1)),
                        child: Padding(
                          padding: EdgeInsets.all(size.width * 0.01),
                          child: TextField(
                            focusNode: passwordF,
                            controller: password,
                            obscureText: true,
                            style: TextInputstyle,
                            decoration: InputDecoration(
                              hintText: 'Password',
                              hintStyle: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12 * fontfactor),
                              border: InputBorder.none,
                            ),
                          ),
                        )),
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.04,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  onPressed: () async {
                    var res =
                        await http.post('http://192.168.1.50:3000/user/login',
                            headers: {"Content-Type": "Application/json"},
                            body: jsonEncode({
                              'password': password.value.text,
                              'email': email.value.text,
                            }));
                    Map data = jsonDecode(res.body);
                    if (data.containsKey('error')) return;
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    await prefs.setStringList('userInfo', [
                      data['token'],
                      data['email'],
                      data['username'],
                      data['imageUrl']
                    ]);
                    Provider.of<Data>(context, listen: false).changeUserInfo([
                      data['token'],
                      data['email'],
                      data['username'],
                      data['imageUrl']
                    ]);

                    emailF.unfocus();
                    passwordF.unfocus();

                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => MainScreen()));
                  },
                  color: Colors.blue.shade500,
                  child: Padding(
                    padding: EdgeInsets.all(size.height * 0.03),
                    child: Text(
                      'LOG IN',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: size.height * 0.04),
                child: Align(
                    alignment: Alignment.topRight,
                    child: TextButton(
                        onPressed: () {},
                        child: Text(
                          'Find your Password',
                          style: TextStyle(
                              fontSize: 10 * fontfactor,
                              color: Colors.white.withOpacity(0.5)),
                        ))),
              ),
              SizedBox(
                height: size.height * 0.07,
              ),
              Center(
                child: Text(
                  'If You Dont Have Any Account',
                  style: TextStyle(
                      fontSize: 10 * fontfactor,
                      color: Colors.white.withOpacity(0.5)),
                ),
              ),
              Center(
                child: TextButton(
                  onPressed: () {
                    showModalBottomSheet(
                        elevation: 0,
                        backgroundColor: Colors.black54.withOpacity(0),
                        isScrollControlled: true,
                        context: context,
                        builder: (context) => Sheet());
                  },
                  child: Text(
                    'SIGN UP',
                    style: TextStyle(
                        fontSize: 15 * fontfactor,
                        color: Colors.white.withOpacity(0.5)),
                  ),
                ),
              )
            ],
          ),
        ),
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/image.jpg'), fit: BoxFit.cover)),
      ),
    );
  }
}
