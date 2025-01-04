import 'package:flutter/material.dart';
import 'package:shiksha/register.dart';

import 'login.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();

}
class _WelcomeScreenState extends State<WelcomeScreen> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: [
                  Colors.white,
                  Colors.white,
                ]
            )
        ),
        child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 100.0),
          child: Image(
            image: AssetImage('assets/logo_.jpeg'),
            width: 100,  // Set the desired width
            height: 100, // Set the desired height
          )
              ),
              const SizedBox(
                height: 100,
              ),
              const Text('Welcome Back',style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'OpenSans',
                  color: Colors.black
              ),),
              const SizedBox(height: 30,),
              GestureDetector(
                onTap: (){
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) =>  LoginScreen()));
                },
                child: Container(
                  height: 53,
                  width: 320,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Color(0xFF3854BD)),
                  ),
                  child: const Center(child: Text('SIGN IN',style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'OpenSans',
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF3854BD)
                  ),),),
                ),
              ),
              const SizedBox(height: 30,),
              GestureDetector(
                onTap: (){
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) =>  RegisterScreen()));
                },
                child: Container(
                  height: 53,
                  width: 320,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFF3854BD), Color(0xFFA365DB)], // Replace with your gradient colors
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: const Center(child: Text('SIGN UP',style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'OpenSans',
                      color: Colors.white
                  ),),),
                ),
              ),
              SizedBox(height: 30,),
              const Text('OR',style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'OpenSans',
                  color: Colors.grey
              )),
              SizedBox(height: 30,),

              const Text('Login with Social Media',style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'OpenSans',
                  color: Colors.black
              ),),//
              const SizedBox(height: 30,),
              GestureDetector(
                onTap: (){

                },
                child: Image(
                  image: AssetImage('assets/search.png'),
                  width: 50,  // Set the desired width
                  height: 50, // Set the desired height
                ),
              ),

              const SizedBox(height: 16,),

            ]
        ),
      ),

    );
  }
}