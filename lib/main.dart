import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:socialmedia/pages/homePage.dart';
import 'package:socialmedia/widgets/google_signIn.dart';
import 'package:socialmedia/widgets/progressWidget.dart';
import 'package:firebase_core/firebase_core.dart';

void main()async
{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);

  bool notSignedIn = true;
  bool isSigningIn = false;

  notsignedIn(){
    notSignedIn = false;
  }

  @override
  Widget build(BuildContext context) {

    GoogleSignInAccount user = _googleSignIn.currentUser;

    return MaterialApp(
      title: 'Social Media',
      debugShowCheckedModeBanner: false,
      theme: ThemeData
      (
        scaffoldBackgroundColor: Colors.black,
        dialogBackgroundColor: Colors.black,
        primarySwatch: Colors.grey,
        cardColor: Colors.white70,
        accentColor: Colors.black,
      ),
      home: isSigningIn ? circularProgress(): Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Instagram', style: TextStyle(
              fontSize: 65.0,
              color: Colors.white,
              fontWeight: FontWeight.bold
            ),),
            SizedBox(height: 24,),
            GestureDetector(
            onTap: (){  
              login();
              if(isSigningIn == false){
                Navigator.pushReplacement(context, MaterialPageRoute(////
                builder: (context) => HomePage()
              ));
               }
            },
            child: Image.asset('assets/images/google_signin_button.png', height: 65, )),
          ],
        )
      ),
    )
    //Widget buildLoading() => Center(child: CircularProgressIndicator());
    );
  }
}
