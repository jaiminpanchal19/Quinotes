import 'package:flutter/material.dart';
import 'package:quinotes/services/auth.dart';
import 'package:quinotes/services/show_alert_dialog.dart';
import 'package:quinotes/validators.dart';

enum EmailSignInFormType{ signIN, register}

class EmailSignIn extends StatefulWidget with EmailAndPasswordValidators {
  EmailSignIn({Key key, this.auth});
  final AuthBase auth;

  @override
  _EmailSignInState createState() => _EmailSignInState();
}

class _EmailSignInState extends State<EmailSignIn> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  EmailSignInFormType _formType = EmailSignInFormType.signIN;

  String get _email => _emailController.text;
  String get _password => _passwordController.text;
  bool _submitted = false;
  bool _isLoading = false;

  void _submit() async{
    setState(() {
      _submitted = true;
      _isLoading = true;
    });
    try {
      if (_formType == EmailSignInFormType.signIN) {
        await widget.auth.signInWithEmailAndPassword(_email, _password);
      } else {
        await widget.auth.createUserWithEmailAndPassword(_email, _password);
      }
    } catch (e){
     showAlertDialog(
         context,
         title: 'Sign in failed',
         content: e.toString(),
         defaultActionText: 'OK'
     );
    } finally{
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _emailEditingCompleted() {
    final newFocus = widget.emailValidator.isValid(_email)
    ? _passwordFocusNode : _emailFocusNode;
    FocusScope.of(context).requestFocus(newFocus);
  }

  void _toggleFormType(){
    setState(() {
      _submitted = false;
      _formType = _formType == EmailSignInFormType.signIN ?
          EmailSignInFormType.register : EmailSignInFormType.signIN;
    });
    _emailController.clear();
    _passwordController.clear();
  }

  Widget build(BuildContext context) {
    final primaryText = _formType == EmailSignInFormType.signIN
        ?'Login'
        : 'Create an account';
    final secondaryText = _formType == EmailSignInFormType.signIN
        ? 'Need an account? Register'
        : 'Have an account? Sign in';
    final thirdText = _formType == EmailSignInFormType.signIN
        ? 'Sign in'
        : 'Sign up';

    bool submitEnable = widget.emailValidator.isValid(_email) &&
        widget.passwordValidator.isValid(_password) && !_isLoading;
    return Column(
      children: [
        SizedBox(height: 5.0),
        Text(
          thirdText,
          //style: Theme.of(context).textTheme.display1,
          style: TextStyle(color: Colors.blueAccent, fontSize: 35),
        ),
        SizedBox(height: 8.0),
        _buildEmailTextField(),
        SizedBox(height: 8.0),
        _buildPasswordTextField(),
        SizedBox(height: 15.0),
        Container(
          height: 55.0,
          child: RaisedButton(
            shape: RoundedRectangleBorder(
                borderRadius:
                BorderRadius.all(Radius.circular(20.0))),
            color: Colors.blueAccent,
            child: Center(
              child: Text(
                primaryText,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Montserrat'),
              ),
            ),
            onPressed: submitEnable ? _submit : null,
          ),
        ),
        SizedBox(height: 8.0),
        FlatButton(
          child: Text(
            secondaryText,
            style: TextStyle(
              fontSize: 15,
            ),
          ),
          onPressed: !_isLoading ? _toggleFormType : null,
        ),
      ],
    );
  }

  TextField _buildPasswordTextField() {
    bool showErrorText = _submitted && !widget.passwordValidator.isValid(_password);
    return TextField(
        controller: _passwordController,
        focusNode: _passwordFocusNode,
        decoration: InputDecoration(
          labelText: 'Password',
          errorText: showErrorText ? widget.invalidPasswordErrorText : null,
          enabled: _isLoading == false,
        ),
        obscureText: true,
        textInputAction: TextInputAction.done,
        onChanged: (password) => _updateState(),
        onEditingComplete: _submit,
      );
  }

  TextField _buildEmailTextField() {
    bool showErrorText = _submitted && !widget.emailValidator.isValid(_email);
    return TextField(
        controller: _emailController,
        focusNode: _emailFocusNode,
        decoration: InputDecoration(
          labelText: 'Email',
          errorText: showErrorText ? widget.invalidEmailErrorText : null,
          enabled: _isLoading == false,
          //hintText: 'test@test.com',
        ),
        autocorrect: false,
        keyboardType: TextInputType.emailAddress,
        textInputAction: TextInputAction.next,
        onChanged: (email) => _updateState(),
        onEditingComplete: _emailEditingCompleted,
      );
  }

 void _updateState() {
    setState(() {});
  }
}
