import 'dart:convert';
import 'home.dart';
import 'package:flutter/material.dart';
import './api.dart';
import 'package:http/http.dart' as http;
import './register.dart';
import 'register.dart';


void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: "Login Local Server",
    home: Login(),
  ));
}

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String apiUrl = Api.url;

  String msgError = "";

  getApi(String username, String password) async {
    final res = await http
        .post(apiUrl, body: {"username": username, "password": password});
    final data = jsonDecode(res.body);

    if (data['level'] == "admin") {
      print(data['msg'] + " dan status : " + data['level']);
      Navigator.of(context).push(MaterialPageRoute(
          builder: (c) => HomePage(username: data['username'])));
      _username.clear();
      _password.clear();
      setState(() {
        msgError = "";
      });
    } else if (data['level'] == "user") {
      print(data['msg'] + " dan status : " + data['level']);
      Navigator.of(context).push(MaterialPageRoute(
          builder: (c) => HomePage(username: data['username'])));
      _username.clear();
      _password.clear();
      setState(() {
        msgError = "";
      });
    } else {
      setState(() {
        msgError = "Username atau Password Salah";
      });
    }
  }

  TextEditingController _username = TextEditingController();
  TextEditingController _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Container(child: Text("Login")),
          backgroundColor: Colors.blueAccent,
          elevation: 0.5,
        ),
        body: Container(
          padding: EdgeInsets.only(top: 100.0),
          child: Center(
            child: ListView(
              children: <Widget>[
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 25.0),
                  child: TextField(
                    controller: _username,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Username",
                        hintText: "Username"),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Container(
                  alignment: Alignment.center,
                  padding:
                      EdgeInsets.only(left: 25.0, right: 25.0, bottom: 25.0),
                  child: TextField(
                    controller: _password,
                    obscureText: true,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Password",
                        hintText: "Password"),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Padding(
                  padding:
                      EdgeInsets.only(left: 25.0, right: 25.0, bottom: 25.0),
                  child: ButtonTheme(
                    minWidth: 200.0,
                    height: 50.0,
                    child: RaisedButton(
                      textColor: Colors.white,
                      color: Colors.blueAccent,
                      elevation: 10.0,
                      child: Text("Login"),
                      onPressed: () {
                        getApi(_username.text, _password.text);
                      },
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.only(left: 25.0, right: 25.0, bottom: 25.0),
                  child: ButtonTheme(
                    minWidth: 200.0,
                    height: 50.0,
                    child: RaisedButton(
                      textColor: Colors.white,
                      color: Colors.blueAccent,
                      elevation: 10.0,
                      child: Text("SIGN UP"),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RegisterPage()),
                        );
                      },
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0),
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Text(msgError, style: TextStyle(color: Colors.red)),
                )
              ],
            ),
          ),
        ));
  }
}
