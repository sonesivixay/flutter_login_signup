import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'FrmProfileScreen.dart';
import 'FrmRegister.dart';

class FrmLogin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(title: Text('User Login Form')),
            body: Center(child: LoginUser())));
  }
}

class LoginUser extends StatefulWidget {
  LoginUserState createState() => LoginUserState();
}

class LoginUserState extends State {
  // For CircularProgressIndicator.
  bool visible = false;
  final _formKey = GlobalKey<FormState>();

  // Getting value from TextField widget.
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void clearText() {
    emailController.clear();
    passwordController.clear();
  }

  Future userLogin() async {
    // Showing CircularProgressIndicator.
    setState(() {
      visible = true;
    });

    // Getting value from Controller
    String email = emailController.text;
    String password = passwordController.text;

    // SERVER LOGIN API URL
    // var url = 'http://172.16.2.107/flutter_php/login_user.php';
    var url = 'http://192.168.100.14/flutter_php/login_user.php';

    // Store all data with Param Name.
    var data = {'email': email, 'password': password};

    // Starting Web API Call.
    var response = await http.post(url, body: json.encode(data));

    // Getting Server response into variable.
    var message = jsonDecode(response.body);

    // If the Response Message is Matched.
    if (message == 'Login Matched') {
      // Hiding the CircularProgressIndicator.
      setState(() {
        visible = false;
      });

      // Navigate to Profile Screen & Sending Email to Next Screen.
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ProfileScreen(
            email: email,
            username: username,
          ),
        ),
      );
    } else {
      // If Email or Password did not Matched.
      // Hiding the CircularProgressIndicator.
      setState(() {
        visible = false;
      });

      // Showing Alert Dialog with Response JSON Message.
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Text(message),
            actions: <Widget>[
              FlatButton(
                child: new Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Center(
        child: Column(
          //crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(53, 35, 53, 23),
              child: Container(
                //padding: const EdgeInsets.all(235),
                height: 100,
                decoration: BoxDecoration(
                  // color: Colors.orangeAccent,
                  image: DecorationImage(
                    image: AssetImage("images/logo.png"),
                    fit: BoxFit.fitWidth,
                    alignment: Alignment.topCenter,
                  ),
                ),
                alignment: Alignment.center,
              ),
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: Text(
                    'User Login Form',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Divider(),
                Container(
                  width: 280,
                  padding: EdgeInsets.all(10.0),
                  child: TextFormField(
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                    controller: emailController,
                    autocorrect: true,
                    autofocus: true,
                    decoration: InputDecoration(
                      labelText: 'Enter Your Email Here',
                      suffixIcon: IconButton(
                        icon: Icon(Icons.clear),
                        onPressed: () => emailController.clear(),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 280,
                  padding: EdgeInsets.all(10.0),
                  child: TextFormField(
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                    controller: passwordController,
                    autocorrect: true,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Enter Your Password Here',
                      suffixIcon: IconButton(
                        icon: Icon(Icons.clear),
                        onPressed: () => passwordController.clear(),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: RaisedButton(
                    onPressed: () {
                      // Validate returns true if the form is valid, or false
                      // otherwise.
                      if (_formKey.currentState.validate()) {
                        // If the form is valid, display a Snackbar.
                        userLogin();

                        //Scaffold.of(context).showSnackBar(
                        //   SnackBar(content: Text('Processing Data')));
                      }
                      clearText();
                    },
                    color: Colors.green,
                    textColor: Colors.white,
                    padding: EdgeInsets.fromLTRB(9, 9, 9, 9),
                    child: Text('Login'),
                  ),
                ),
              ],
            ),
            Visibility(
              visible: visible,
              child: Container(
                margin: EdgeInsets.only(bottom: 30),
                child: CircularProgressIndicator(),
              ),
            ),
            Divider(),
            RaisedButton(
              onPressed: () {
                clearText();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FrmRegister()),
                );
              },
              color: Colors.green,
              textColor: Colors.white,
              padding: EdgeInsets.fromLTRB(9, 9, 9, 9),
              child: Text('Don\'t Have Account Go To Register'),
            ),
          ],
        ),
      ),
    );
  }
}
