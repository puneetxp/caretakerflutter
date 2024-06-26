import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Credentials {
  final String username;
  final String password;

  Credentials(this.username, this.password);
}

// interface class Interface {
//   onSignIn(Credentials value, BuildContext context) async {}
//   void moveForward(Credentials credentials, BuildContext context) {}
// }

// const users = {
//   'dribbble@gmail.com': '12345',
//   'hunter@gmail.com': 'hunter',
// };
class SignInScreen extends StatefulWidget {
  var onSignIn;
  SignInScreen({required this.onSignIn, super.key});

  static const routeName = '/login';
  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  Duration get loginTime => const Duration(milliseconds: 2250);
  late LoginData user;
  Future<String?> _authUser(LoginData data) {
    debugPrint('Name: ${data.name}, Password: ${data.password}');
    return Future.delayed(loginTime).then((_) {
      user = data;
      return null;
      // if (!users.containsKey(data.name)) {
      //   return 'User not exists';
      // }
      // if (users[data.name] != data.password) {
      //   return 'Password does not match';
      // }
      // return null;
    });
  }

  Future<String?> _signupUser(SignupData data) {
    debugPrint('Signup Name: ${data.name}, Password: ${data.password}');
    return Future.delayed(loginTime).then((_) {
      return null;
    });
  }

  Future<String?> _recoverPassword(String name) {
    debugPrint('Name: $name');
    return Future.delayed(loginTime).then((_) {
      // if (!users.containsKey(name)) {
      //   return 'User not exists';
      // }
      return null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      title: 'Care',
      // logo: const AssetImage('assets/images/ecorp-lightblue.png'),
      onLogin: _authUser,
      onSignup: _signupUser,
      theme: LoginTheme(
        // primaryColor: Colors.teal,
        // accentColor: Colors.yellow,
        // errorColor: Colors.deepOrange,
        pageColorLight: Colors.green,
        pageColorDark: Colors.green,
        // logoWidth: 0.80,
        // titleStyle: TextStyle(
        //   color: Colors.greenAccent,
        //   fontFamily: 'Quicksand',
        //   letterSpacing: 4,
        // ),
        // // beforeHeroFontSize: 50,
        // // afterHeroFontSize: 20,
        // bodyStyle: TextStyle(
        //   fontStyle: FontStyle.italic,
        //   decoration: TextDecoration.underline,
        // ),
        // textFieldStyle: TextStyle(
        //   color: Colors.orange,
        //   shadows: [Shadow(color: Colors.yellow, blurRadius: 2)],
        // ),
        // buttonStyle: TextStyle(
        //   fontWeight: FontWeight.w800,
        //   color: Colors.yellow,
        // ),
        // cardTheme: CardTheme(
        //   color: Colors.yellow.shade100,
        //   elevation: 5,
        //   margin: EdgeInsets.only(top: 15),
        //   shape: ContinuousRectangleBorder(
        //       borderRadius: BorderRadius.circular(100.0)),
        // ),
        // inputTheme: InputDecorationTheme(
        //     filled: true,
        //     fillColor: Colors.purple.withOpacity(.1),
        //     contentPadding: EdgeInsets.zero,
        //     errorStyle: TextStyle(
        //       backgroundColor: Colors.orange,
        //       color: Colors.white,
        //     ),
        //     labelStyle: TextStyle(fontSize: 12)),
        // buttonTheme: const LoginButtonTheme(
        //     splashColor: Colors.purple,
        //     backgroundColor: Colors.pinkAccent,
        //     highlightColor: Colors.lightGreen,
        //     elevation: 9.0,
        //     highlightElevation: 6.0
        //     // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        //     // shape: CircleBorder(side: BorderSide(color: Colors.green)),
        //     // shape: ContinuousRectangleBorder(borderRadius: BorderRadius.circular(55.0)),
        //     ),
      ),
      loginProviders: <LoginProvider>[
        LoginProvider(
          icon: FontAwesomeIcons.google,
          label: 'Google',
          callback: () async {
            debugPrint('start google sign in');
            await Future.delayed(loginTime);
            debugPrint('stop google sign in');
            return null;
          },
        ),
        LoginProvider(
          icon: FontAwesomeIcons.facebookF,
          label: 'Facebook',
          callback: () async {
            debugPrint('start facebook sign in');
            await Future.delayed(loginTime);
            debugPrint('stop facebook sign in');
            return null;
          },
        )
      ],
      onSubmitAnimationCompleted: () {
        widget.onSignIn(Credentials(user.name, user.password), context);
        // Navigator.of(context).pushReplacement(
        //   FadePageRoute(
        //     builder: (context) => const MyHomePageScreen(
        //       title: 'Home',
        //     ),
        //   ),
        // );
      },
      onRecoverPassword: _recoverPassword,
    );
  }
}
