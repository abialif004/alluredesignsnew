import 'package:alluredesigns/screens/cart_screen.dart';
import 'package:alluredesigns/screens/home_page.dart';
import 'package:flutter/material.dart';
import 'package:alluredesigns/screens/authentication.dart';
import 'package:alluredesigns/components/fireflutter.dart';


class Logsign extends StatefulWidget {
  @override
  _LogsignState createState() => _LogsignState();
}

class _LogsignState extends State<Logsign> {
  TextEditingController _emailcontroller = TextEditingController();
   TextEditingController _passwordcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image(
            image: AssetImage('assets/images/logsimage.jpg'),
            fit: BoxFit.cover,
            color: Colors.black54,
            colorBlendMode: BlendMode.darken,
          ),
          Positioned(
            left: size.width*.05,
            top: size.height*.15,
            child: Text(
              'Hello',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 80.00,
                  fontFamily: 'Montserrat',
                  color: Colors.white60),
            ),
          ),
          Positioned(
            left: size.width*.05,
            top: size.height*.25,
            child: Text(
              'There',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 80.00,
                fontFamily: 'Montserrat',
                color: Colors.white60,
              ),
            ),
          ),
          Positioned(
            left: size.width*.4,
            top: size.height*.25,
            child: Text(
              '.',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 80.00,
                  fontFamily: 'Montserrat',
                  color: Colors.white70),
            ),
          ),
          Positioned(
            top: size.height*.45,
            left: size.width *.2,
            child: Text(
              'WELCOME TO ALLURE DESIGNS',
              style: TextStyle(
                  color: Colors.white70,
                  fontSize: 14.00,
                  letterSpacing: 3.00,
                  fontFamily: 'Reemkufi'),
            ),
          ),
          Positioned(
            left: size.width*.05,
            top: size.height*.5,
            width: size.width*.7,
            child: TextField(
              keyboardType: TextInputType.emailAddress,
              controller: _emailcontroller,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white70)),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white70)),
                labelText: 'Enter Your Email',
                labelStyle: TextStyle(
                  fontSize: 20.00,
                  color: Colors.grey,
                ),
              ),
            ),
          ),
            Positioned(
            left: size.width*.2,
            top: size.height*.6,
            width: size.width*.7,
            child: TextField(
              controller: _passwordcontroller,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white70)),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white70)),
                labelText: 'Enter Your Password',
                labelStyle: TextStyle(
                  fontSize: 20.00,
                  color: Colors.grey,
                ),
              ),
            ),
          ),
          Positioned(
            top: size.height*.8,
            left: size.width*.28,
            child: MaterialButton(
              shape: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.teal),
              ),
              height: 40.00,
              minWidth: 200.00,
              splashColor: Colors.white60,
              colorBrightness: Brightness.dark,
              onPressed: () async{
                bool shouldNavigate = await loginuser(_emailcontroller.text.trim(), _passwordcontroller.text.trim());
                    if(shouldNavigate == true){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> CartScreen()));
                    }
              },
              child: Text(
                'Log In',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white70,
                    fontSize: 18.00,
                    letterSpacing: 1.00),
              ),
            ),
          ),
           Positioned(
              top: size.height*.87,
              left: size.width*.32,
              child: TextButton(
                onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> Authentication()));
                },
                child: Text('Dont Have an Account !', style: TextStyle(
                  color: Colors.white70,
                  fontWeight: FontWeight.bold,
                ),),
              ),
            )
        ],
      ),
    );
  }
}