import 'package:flutter/material.dart';
//import 'package:flutter_login_signup/FrmLogin.dart';

class ProfileScreen extends StatelessWidget {
// Creating String Var to Hold sent Email.
  final String email;
  final String username;

// Receiving Email using Constructor.
  ProfileScreen({Key key, @required this.email, this.username})
      : super(key: key);

// User Logout Function.
  logout(BuildContext context) {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
                title: Text('Profile Screen'),
                automaticallyImplyLeading: false),
            body: Center(
                child: Column(
              children: <Widget>[
                Container(
                  width: 280,
                  padding: EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      Text(
                        'User Name: ' + username,
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      Text(
                        'Email: ' + email,
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
                RaisedButton(
                  onPressed: () {
                    //LoginUserState().clearText();
                    logout(context);
                    //LoginUserState().clearText();
                  },
                  color: Colors.red,
                  textColor: Colors.white,
                  child: Text('Click Here To Logout'),
                ),
              ],
            ))));
  }
}
