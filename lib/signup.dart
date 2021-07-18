import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:user_testapp/userlogin.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _name = '', _email = '', _password = '';
  var _mobileno ;

  checkAuthentication() async {
    _auth.authStateChanges().listen((user) async {
      if (user != null) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => PageView()),
        );
      }
    });
  }

  @override
  void initState() {
    super.initState();
    //this.checkAuthentication();
  }

  signUp() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      try {
        UserCredential user = await _auth.createUserWithEmailAndPassword(
            email: _email, password: _password);
        if (user != null) {
          //await _auth.currentUser.updateProfile(displayName: _name);
        }
      } catch (e) {
        // showError(e.message);
        print(e);
      }
    }
  }

  showError(String errormessage) {
    showDialog(
      context: context,
      builder: (cntx) => AlertDialog(
        title: Text('ERROR'),
        content: Text(errormessage),
        actions: <Widget>[
          FlatButton(
              onPressed: () {
                Navigator.of(cntx).pop();
              },
              child: Text('OK'))
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left:20,right: 50, top: 70),
              child: Container(
                  child: Text(
                      'Register In to get started \n\nExperience the all new App!',style: TextStyle(color: Colors.grey[600],fontSize: 20),)),
            ),
            SizedBox(height: 20),
            Padding(padding: EdgeInsets.all(20),
              child: Container(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      Container(
                        child: TextFormField(
                            validator: (input) {
                              if (input!.isEmpty) return 'Enter Name';
                            },
                            decoration: InputDecoration(
                              labelText: 'Name',
                              prefixIcon: Icon(Icons.person),
                            ),
                            onSaved: (input) => _name = input!),
                      ), SizedBox(height: 10),
                      Container(
                        child: TextFormField(
                            validator: (input) {
                              if (input!.isEmpty) return 'Enter Email';
                            },
                            decoration: InputDecoration(
                                labelText: 'E-mail ID',
                                prefixIcon: Icon(Icons.email)),
                            onSaved: (input) => _email = input!),
                      ), SizedBox(height: 10),
                      Container(
                        child: TextFormField(
                            validator: (input) {
                              if (input!.length < 6)
                                return 'Provide 10 Character';
                            },
                            decoration: InputDecoration(
                              labelText: 'Mobile Number',
                              prefixIcon: Icon(Icons.phone),
                            ),
                            obscureText: true,
                            onSaved: (input) => _mobileno = input!),
                      ), SizedBox(height: 10),
                      Container(
                        child: TextFormField(
                            validator: (input) {
                              if (input!.length < 6)
                                return 'Provide Minimum 6 Character';
                            },
                            decoration: InputDecoration(
                              labelText: 'Password',
                              prefixIcon: Icon(Icons.lock),
                            ),
                            obscureText: true,
                            onSaved: (input) => _password = input!),
                      ),
                      SizedBox(height: 10),
                      Container(
                        child: TextFormField(
                            validator: (input) {
                              if (input!.length < 6)
                                return 'Provide Minimum 6 Character';
                            },
                            decoration: InputDecoration(
                              labelText: 'Confirm Password',
                              prefixIcon: Icon(Icons.lock),
                            ),
                            obscureText: true,
                            onSaved: (input) => _password = input!),
                      ),
                      SizedBox(height: 20),
                      RaisedButton(
                        padding: EdgeInsets.fromLTRB(90, 10, 90, 10),
                        onPressed: signUp,
                        child: Text('REGISTER',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
                                fontWeight: FontWeight.w600)),
                        color: Colors.orangeAccent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                      Padding(
              padding: EdgeInsets.only(left:30,right: 40, top: 70),
              child: Container(
                  child: Text(
                      'Already have an Account? ',style: TextStyle(color: Colors.grey[600],fontSize: 18),)),
            ),TextButton(onPressed:()=> Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => UserLogin()),), child:Text(
                      'Login ',style: TextStyle(color: Colors.grey[900],fontSize: 18),))
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
