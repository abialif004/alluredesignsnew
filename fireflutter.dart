import 'package:alluredesigns/screens/home_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:core';


Future<bool> loginuser(String email, String password) async {
  try {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    return true;
  } catch (e) {
    print(e);
    return false;
  }
}
// For Registering user with email and password

Future<bool> registeruser(String email, String password) async {
  FirebaseAuth _auth = FirebaseAuth.instance;
  User firebaseUser;
  try {
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password).then((_auth){  firebaseUser = FirebaseAuth.instance.currentUser;});
    return true;
  } on FirebaseAuthException catch (e) {
    // ignore: unnecessary_statements
    if (e.code == 'weak password') {
      print("Password too weak");
    }
    // ignore: unnecessary_statements
    else if (e.code == 'this email already exists') {
      print("this email already exists");
    }
    return false;
  } catch (e) {
    print(e.toString());
  }
  return false;
}

//Login in user with phone number

Future<bool> signUserwithphone(String phonenumber) async {
  try {
    RecaptchaVerifier(
  onSuccess: () => print('reCAPTCHA Completed!'),
  onError: (FirebaseAuthException error) => print(error),
  onExpired: () => print('reCAPTCHA Expired!'),
);
    await FirebaseAuth.instance.signInWithPhoneNumber(phonenumber);
   ConfirmationResult confirmationResult = await FirebaseAuth.instance.signInWithPhoneNumber(phonenumber, RecaptchaVerifier(
  container: 'recaptcha',
  size: RecaptchaVerifierSize.compact,
  theme: RecaptchaVerifierTheme.dark,
));
UserCredential userCredential = await confirmationResult.confirm('123456');
    return true;
  } catch (e) {
    print(e);
    return false;
  }
}

// Code verification for the phone number

Future<bool> verifyPhone(String number, BuildContext context) async {
  TextEditingController _codecontroller = TextEditingController();
  try {
    FirebaseAuth auth = FirebaseAuth.instance;
    auth.verifyPhoneNumber(
      phoneNumber: '+91 8943439490',
      verificationCompleted: (PhoneAuthCredential credential) async {
        await auth.signInWithCredential(credential);
      },
      verificationFailed: (FirebaseAuthException exception) {
        if (exception.code == 'invalid-phone-number ') {
          print('U have entered a wrong number');
        }
      },
      codeSent: (String verificationId, int forceResendingToken) async {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) {
            return AlertDialog(
              title: Text("Give the code?"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  TextField(
                    controller: _codecontroller,
                  ),
                ],
              ),
              actions: <Widget>[
                FlatButton(
                  child: Text("Confirm"),
                  textColor: Colors.white,
                  color: Colors.blue,
                  onPressed: () async {
                    PhoneAuthCredential phoneAuthCredential =
                        PhoneAuthProvider.credential(
                            verificationId: verificationId,
                            smsCode: _codecontroller.toString());

                    await auth.signInWithCredential(phoneAuthCredential);

                    // await FirebaseAuth.instance.signInWithCredential(phoneAuthCredential)
                  },
                )
              ],
            );
          },
        );
      },
       codeAutoRetrievalTimeout: (String verificationId) {
    // Auto-resolution timed out...
  },
  timeout: Duration(seconds: 20)
    );
    return true;
  } catch (e) {
    print(e);
    return false;
  }
}





class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  String phoneNo, smssent, verificationId;


  Future<void> verfiyPhone() async{
    final PhoneCodeAutoRetrievalTimeout autoRetrieve = (String verId){
      this.verificationId = verId;
    };
  final PhoneCodeSent smsCodeSent= (String verId, [int forceCodeResent]) {
    this.verificationId = verId;
    smsCodeDialoge(context).then((value){
     print("Code Sent");
    });
  };
    final PhoneVerificationCompleted verifiedSuccess= (PhoneAuthCredential credential)async {
        await FirebaseAuth.instance.signInWithCredential(credential);
    };
    final PhoneVerificationFailed verifyFailed= (FirebaseAuthException e){
      print('${e.message}');
    };
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phoneNo,
      timeout: const Duration(seconds: 120),
      verificationCompleted : verifiedSuccess,
      verificationFailed: verifyFailed,
      codeSent: smsCodeSent,
      codeAutoRetrievalTimeout: autoRetrieve,

    );
  
  }
  Future<bool> smsCodeDialoge(BuildContext context){
    return showDialog(context: context,
    barrierDismissible: false,
    builder: (BuildContext context){
      return new AlertDialog(
        title: Text('Enter OTP'),
        content: TextField(
          onChanged: (value){
            if(this.smssent == value){
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> HomeScreen()));
            }
            else{
              AlertDialog(title: Text('You have entererd the wrong code',style: TextStyle(color: Colors.red),),);
            }
          },
        ),
        contentPadding: EdgeInsets.all(10.0),
        actions: <Widget>[
          FlatButton(
            onPressed: (){
             User user = FirebaseAuth.instance.currentUser;{
                if(user == null){
                  Navigator.of(context).pop();
                  Navigator.push(
                    context, 
                    MaterialPageRoute(
                      builder: (context)=> LoginPage()),
                    );
                  
                }
                else{
                  Navigator.of(context).pop();
                  signIn(smssent);
                }
              }
            },
            child: Text('done', 
            style:TextStyle(color: Colors.white) ,),
          ),
        ],

      );
    }
    );
  }
  Future<void> signIn(String smsCode) async{
    final PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: verificationId,
       smsCode: smsCode.toString(),);
  
    await FirebaseAuth.instance.signInWithCredential(
      credential).then((user) {
      Navigator.push(context, MaterialPageRoute(
        builder: (context) => LoginPage(),),
      );
   }).catchError((e){
     print(e);
   });
  }

  
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('PhoneNumber Login'),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Enter your phone number",
              ),
              onChanged: (value){
                this.phoneNo= value;
              },
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          RaisedButton(
            onPressed: verfiyPhone,
            child: Text("verify",
            style: TextStyle(color: Colors.white),),
            elevation: 7.0,
            color: Colors.blue,
          )
        ],
      ),
      
    );
  }
}