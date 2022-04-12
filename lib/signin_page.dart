import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quinotes/email_sign_form.dart';
import 'package:quinotes/services/auth.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key key, @required this.auth, /*@required this.onSignIn*/}) : super(key: key);
  final AuthBase auth;

  //final void Function(User) onSignIn;

  Future<void> _signInAnonymously() async {
    try {
      //final user = await auth.signInAnonymously();
      //onSignIn(user);
      await auth.signInAnonymously();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> _signInWithGoogle() async {
    try {
      await auth.signInWithGoogle();
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
            child: Container(
          child: Column(
            children: <Widget>[
              _uidesign(),
              SizedBox(width: 30),
              Padding(
                padding: const EdgeInsets.only(left: 50.0, right: 50.0),
                child: Column(
                  children: [
                    EmailSignIn(auth: auth),
                    SizedBox(height: 15.0),
                    Text(
                      "-------------------or-------------------",
                      style: TextStyle(
                        fontSize: 17,
                      ),
                    ),
                    SizedBox(height: 5.0),
                    Container(
                      child: Row(
                        children: <Widget>[
                          SizedBox(width: 30),
                          FlatButton(
                            child: Image.asset('assets/images/glogo.png'),
                            onPressed: _signInWithGoogle,
                          ),
                          SizedBox(width: 30),
                          FlatButton(
                              onPressed: _signInAnonymously,
                              child: Text(
                                "Skip",
                                style: TextStyle(fontSize: 20),
                              )),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        )),
      ),
    );
  }
}

class _uidesign extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
     // width: 500,
      height: 320,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/cover3.png'),
              fit: BoxFit.fill)),
      /*child: Stack(
        children: <Widget>[
          Positioned(
              left: 30,
              width: 80,
              height: 200,
              child: Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/light-1.png'))),
              )),
          Positioned(
              left: 140,
              width: 80,
              height: 145,
              child: Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/light-2.png'))),
              )),
          Positioned(
              right: 30,
              top: 10,
              width: 80,
              height: 150,
              child: Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/clock.png'))),
              )),
          Positioned(
              child: Container(
            margin: EdgeInsets.only(top: 50, left: 22),
            child: Center(
              child: Text(
                "Quinotes",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 40,
                    fontWeight: FontWeight.bold),
              ),
            ),
          )),
        ],
      ),*/
    );
  }
}

/*_uidesign() {
  return Container(
    height: 300,
    decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/images/background.png'),
            fit: BoxFit.fill)),
    child: Stack(
      children: <Widget>[
        Positioned(
            left: 30,
            width: 80,
            height: 200,
            child: Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image:
                      AssetImage('assets/images/light-1.png'))),
            )),
        Positioned(
            left: 140,
            width: 80,
            height: 145,
            child: Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image:
                      AssetImage('assets/images/light-2.png'))),
            )),
        Positioned(
            right: 30,
            top: 10,
            width: 80,
            height: 150,
            child: Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image:
                      AssetImage('assets/images/clock.png'))),
            )),
        Positioned(
            child: Container(
              margin: EdgeInsets.only(top: 50, left: 22),
              child: Center(
                child: Text(
                  "Quinotes",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 40,
                      fontWeight: FontWeight.bold),
                ),
              ),
            )),
      ],
    ),
  );
}
*/
