import 'package:flutter/material.dart';
import 'package:flutter_login_signup/FrmLogin.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class FrmRegister extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('User Registration Form'),
        ),
        body: Center(
          child: RegisterUser(),
        ),
      ),
    );
  }
}

class RegisterUser extends StatefulWidget {
  RegisterUserState createState() => RegisterUserState();
}

class RegisterUserState extends State {
  // Boolean variable for CircularProgressIndicator.
  bool visible = false;

  // Getting value from TextField widget.
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  Future userRegistration() async {
    // Showing CircularProgressIndicator.
    setState(() {
      visible = true;
    });

    // Getting value from Controller
    String name = nameController.text;
    String email = emailController.text;
    String password = passwordController.text;

    // SERVER API URL
    // var url = 'http://172.16.2.107/flutter_php/register_user.php';
    var url = 'http://192.168.100.14/flutter_php/register_user.php';

    // Store all data with Param Name.
    var data = {'name': name, 'email': email, 'password': password};

    // Starting Web API Call.
    var response = await http.post(url, body: json.encode(data));

    // Getting Server response into variable.
    var message = jsonDecode(response.body);

    // If Web call Success than Hide the CircularProgressIndicator.
    if (response.statusCode == 200) {
      setState(
        () {
          visible = false;
        },
      );
    }

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

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Center(
        child: Column(
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
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                'User Registration Form',
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
                controller: nameController,
                autocorrect: true,
                autofocus: true,
                decoration: InputDecoration(
                  labelText: 'Enter Your Name Here',
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
                controller: emailController,
                autocorrect: true,
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
                    onPressed: () => emailController.clear(),
                  ),
                ),
              ),
            ),
            RaisedButton(
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  // If the form is valid, display a snackbar. In the real world,
                  // you'd often call a server or save the information in a database.

                  userRegistration();

                  // Scaffold.of(context)
                  // .showSnackBar(SnackBar(content: Text('Processing Data')));
                }

                nameController.clear();
                emailController.clear();
                passwordController.clear();
              },
              color: Colors.green,
              textColor: Colors.white,
              padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: Text('Register'),
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
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FrmLogin()),
                );
              },
              color: Colors.green,
              textColor: Colors.white,
              padding: EdgeInsets.fromLTRB(9, 9, 9, 9),
              child: Text('Already Register Go to Login'),
            ),
          ],
        ),
      ),
    );
  }
}
