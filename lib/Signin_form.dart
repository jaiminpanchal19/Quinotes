import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignInForm extends StatelessWidget {

  const SignInForm({Key key, @required this.onSignIn}) : super(key: key);
  final void Function(User) onSignIn;

  Future <void> _SignInAnonymously() async{
    try {
      final UserCredential = await FirebaseAuth.instance.signInAnonymously();
      onSignIn(UserCredential.user);
    } catch (e){
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          decoration: InputDecoration(
            labelText: 'Email',
            //hintText: 'test@test.com',
          ),
        ),
        SizedBox(height: 8.0),
        TextField(
          decoration: InputDecoration(
            labelText: 'Password',
          ),
          obscureText: true,
        ),
        SizedBox(height: 15.0),
        Container(
          height: 55.0,
          child: RaisedButton(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            color: Colors.blueAccent,
            child: Center(
              child: Text(
                'LOGIN',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Montserrat'),
              ),
            ),
            onPressed: () {},
          ),
        ),
        SizedBox(height: 8.0),
        FlatButton(
          child: Text(
            'Need an account? Register',
            style: TextStyle(
              fontSize: 15,
            ),
          ),
          onPressed: () {},
        ),
        SizedBox(height: 15.0),
        Text(
          "-------------------or-------------------",
          style: TextStyle(
            fontSize: 17,
          ),
        ),
        SizedBox(height: 5.0),
        Container(
          child: Row(children: <Widget>[
            SizedBox(width: 30),
            FlatButton(
                child: Image.asset('assets/images/glogo.png'),

                onPressed: () {}
                ),
            SizedBox(width:30),
            FlatButton(
                onPressed: _SignInAnonymously,
                child: Text(
                    "Skip",
                  style: TextStyle(
                    fontSize: 20
                  ),
                )
            ),
          ],
          ),
        ),
      ],
    );
  }
}
