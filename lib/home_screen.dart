import 'package:flutter/material.dart';
import 'package:gdg_app/firebase_Auth/authFunction.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_database/firebase_database.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _formkey = GlobalKey<FormState>();
  bool isLogin = false;
  String email = '';
  String password = '';
  String username = '';

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final double width = screenSize.width;
    final double height = screenSize.height;
    final double padding = width * 0.05;
    final double fontSize = width * 0.05;

    return Scaffold(
      backgroundColor: Colors.lime[50],
      appBar: AppBar(
        title: Text(
          'GDG Task',
          style: GoogleFonts.aclonica(
              fontSize: fontSize * 2,
              fontWeight: FontWeight.w700,
              color: Colors.lightGreen[700],
            ),
          ),
          backgroundColor: Colors.lime[50],
          centerTitle: true,
      ),
      body: Form(
          key: _formkey,
          child: Container(
            margin: EdgeInsets.all(padding * 2),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                !isLogin? TextFormField(
                  key: ValueKey('username'),
                  decoration: const InputDecoration(
                    hintText: 'Enter your username',
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.lightGreen),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.green),
                    ),
                  ),
                  validator: (value){
                    if(value.toString().length < 8){
                      return 'Username must contain at least 8 characters';
                    } else {
                      return null;
                    }
                  },
                  onSaved: (value){
                    setState(() {
                      username = value!;
                    });
                  },
                ) : Container(),
                TextFormField(
                  key: ValueKey('email'),
                  decoration: const InputDecoration(
                    hintText: 'Enter your email',
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.lightGreen),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.green),
                    ),
                  ),
                  validator: (value){
                    if(!(value.toString().contains('@'))){
                      return 'email is invalid';
                    } else {
                      return null;
                    }
                  },
                  onSaved: (value){
                    setState(() {
                      email = value!;
                    });
                  },
                ),
                TextFormField(
                  obscureText: true,
                  key: ValueKey('password'),
                  decoration: const InputDecoration(
                    hintText: 'Enter your password',
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.lightGreen),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.green),
                    ),
                  ),
                  validator: (value){
                    if(value.toString().length < 8){
                      return 'Password must contain at least 8 characters';
                    } else {
                      return null;
                    }
                  },
                  onSaved: (value){
                    setState(() {
                      password = value!;
                    });
                  },
                ),
                SizedBox(height: height * 0.03,),
                ElevatedButton(
                  onPressed: (){
                    if(_formkey.currentState!.validate()){
                      _formkey.currentState!.save();
                      isLogin? signIn(email, password) : signUp(email, password);
                    }
                  },
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all<Color>(Colors.lime[50]!),
                    side: WidgetStateProperty.all(BorderSide(color: Colors.lightGreen[900]!))
                  ),
                  child: Text(!isLogin? 'Sign Up!' : 'Login',
                    style: TextStyle(
                      color: Colors.green[900],
                      fontSize: fontSize,
                    ),
                  ),
                ),
                SizedBox(height: height * 0.01,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      !isLogin?
                      "Already have an account?" : "Don't have an account?",
                      style: TextStyle(
                        color: Colors.lightGreen[700],
                        fontWeight: FontWeight.normal,
                        fontSize: fontSize * 0.75,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isLogin = !isLogin;
                        });
                      },
                      child: Text(
                        isLogin ?
                        ' Sign Up' : ' Login',
                        style: TextStyle(
                          color: Colors.lightGreen[700],
                          fontWeight: FontWeight.bold,
                          fontSize: fontSize * 0.78,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
      ),
    );
  }
}
