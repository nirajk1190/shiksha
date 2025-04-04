import 'package:flutter/material.dart';
import 'package:shiksha/teacher/teacher_login.dart';

import 'student/student_login.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();

}
class _WelcomeScreenState extends State<WelcomeScreen> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
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
              mainAxisAlignment: MainAxisAlignment.center,  // Center all children vertically
              crossAxisAlignment: CrossAxisAlignment.center,  //
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
                  height: 50,
                ),
                const Text('Welcome Back',style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'OpenSans',
                    color: Colors.black
                ),
                ),
                const SizedBox(
                  height: 16,
                ),
                const Text('Shiksha Serves You Virtual Education At Your Home',style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'OpenSans',
                    color: Colors.black
                ),
                ),
                const SizedBox(height: 30,),
                GestureDetector(
                  onTap: (){
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) =>  StudentLoginScreen()));
                  },
                  child: Container(
                    height: 53,
                    width: 320,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Color(0xFF3854BD)),
                    ),
                    child: const Center(child: Text('Login as Student',style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'OpenSans',
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF3854BD)
                    ),),),
                  ),
                ),
                const SizedBox(height: 16,),
                GestureDetector(
                  onTap: (){

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
                    child: const Center(child: Text('Login as Parent',style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'OpenSans',
                        color: Colors.white
                    ),),),
                  ),
                ),
                SizedBox(height: 16,),
                GestureDetector(
                  onTap: (){
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) =>  TeacherLoginScreen()));
                  },
                  child: Container(
                    height: 53,
                    width: 320,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Color(0xFF3854BD)),
                    ),
                    child: const Center(child: Text('Login as Teacher',style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'OpenSans',
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF3854BD)
                    ),),),
                  ),
                ),
                const SizedBox(height: 30,),

              ]
          ),
        )
      ),

    );
  }
}