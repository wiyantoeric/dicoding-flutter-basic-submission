import 'package:renote/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:renote/user.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth <= 768) {
            return MobileLoginScreen();
          } else {
            return WideLoginScreen();
          }
        },
      ),
      resizeToAvoidBottomInset: false,
    );
  }
}

class MobileLoginScreen extends StatelessWidget {
  MobileLoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 48),
                child: Stack(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(left: 200),
                      alignment: Alignment.bottomCenter,
                      child: Image.asset('images/sticky-notes-logo-rotated.png',
                          width: 200),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                            'Welcome to',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 36,
                            ),
                            textAlign: TextAlign.left,
                          ),Text(
                            'Renote',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 54,
                            ),
                            textAlign: TextAlign.left,
                          ),Text(
                            'Note with community',
                            style: TextStyle(
                              fontSize: 12,
                            ),
                            textAlign: TextAlign.left,
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const Expanded(
              flex: 1,
              child: MobileSignInForm(),
            ),
          ],
        ),
      ),
    );
  }
}

class WideLoginScreen extends StatelessWidget {
  WideLoginScreen({ Key? key }) : super(key: key);
  late String inputUsername;
  late String inputPassword;
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              flex: 1,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  color: const Color(0xFFCCF2F4),
                  padding: const EdgeInsets.only(top: 48, left: 72, right: 36),
                  child: Stack(
                    children: [
                      Container(
                        padding: const EdgeInsets.only(left: 100),
                        alignment: Alignment.centerRight,
                        child: Image.asset('images/sticky-notes-logo-rotated.png',
                            width: 450),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                              'Welcome to',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 36,
                              ),
                              textAlign: TextAlign.left,
                            ),Text(
                              'Renote',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 72,
                              ),
                              textAlign: TextAlign.left,
                            ),Text(
                              'Note with community',
                              style: TextStyle(
                                fontSize: 14,
                              ),
                              textAlign: TextAlign.left,
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Flexible(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Sign in',
                      style: TextStyle(fontSize: 24),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    width: 500,
                    child: Column(
                      children: [
                      SizedBox(
                      width: 500,
                      child: TextField(
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Username',
                        ),
                        style: const TextStyle(fontSize: 12),
                        onChanged: (value) {
                          inputUsername = value;
                        },
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: 500,
                      child: TextField(
                        obscureText: true,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Password',
                        ),
                        style: const TextStyle(fontSize: 12),
                        onChanged: (value) {
                          inputPassword = value;
                        },
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        child: const Text(
                          'Reset password',
                        ),
                        style: TextButton.styleFrom(
                          textStyle: const TextStyle(fontSize: 12),
                        ),
                        onPressed: () {},
                      ),
                    ),
                      ],
                    ),
                  ),
                  
                  const SizedBox(height: 24),
                  ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            const Color(0xFFA4EBF3)),
                        foregroundColor: MaterialStateProperty.all<Color>(
                            const Color.fromARGB(221, 66, 66, 66))),
                    onPressed: () {
                      if (inputUsername == null || inputPassword == null) { 
                        showAlertDialog(context);
                      } else {
                        user.username = inputUsername;
                        user.password = inputPassword;
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const HomeScreen()));
                      }
                    },
                    child: const Text('Login'),
                  ),
                  const SizedBox(height: 14),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Don\'t have any account?',
                        style: TextStyle(fontSize: 12),
                      ),
                      TextButton(
                        child: const Text(
                          'Sign Up',
                          style: TextStyle(
                            color: Color(0xFFAAAAAA),
                          ),
                        ),
                        style: TextButton.styleFrom(
                          textStyle: const TextStyle(fontSize: 12),
                        ),
                        onPressed: () {},
                      )
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  
  }
}

class MobileSignInForm extends StatefulWidget {
  const MobileSignInForm({ Key? key }) : super(key: key);

  @override
  State<MobileSignInForm> createState() => _MobileSignInFormState();
}

class _MobileSignInFormState extends State<MobileSignInForm> {
  String? inputUsername;
  String? inputPassword;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 48),
      child: Column(
        children: [
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Sign in',
              style: TextStyle(fontSize: 18),
            ),
          ),
          const SizedBox(height: 20),
          Column(
            children: [
              TextField(
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Username',
            ),
            style: const TextStyle(fontSize: 12),
            onChanged: (String value) {
              setState(() {
                inputUsername = value;
              });
            },
          ),
          const SizedBox(height: 20),
          TextField(
            obscureText: true,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Password',
            ),
            style: const TextStyle(fontSize: 12),
            onChanged: (String value) {
              setState(() {
                inputPassword = value;
              });
            },
          ),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  child: const Text(
                    'Reset password',
                  ),
                  style: TextButton.styleFrom(
                    textStyle: const TextStyle(fontSize: 12),
                  ),
                  onPressed: () {},
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                    const Color(0xFFA4EBF3)),
                foregroundColor: MaterialStateProperty.all<Color>(
                    const Color.fromARGB(221, 66, 66, 66))),
            onPressed: () {
              if (inputUsername == null || inputPassword == null) { 
              showAlertDialog(context);
            } else {
              user.username = inputUsername;
              user.password = inputPassword;
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const HomeScreen()));
            }
            },
            child: const Text('Login'),
          ),
          const SizedBox(height: 14),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Don\'t have any account?',
                style: TextStyle(fontSize: 12),
              ),
              TextButton(
                child: const Text(
                  'Sign Up',
                  style: TextStyle(
                    color: Color(0xFFAAAAAA),
                  ),
                ),
                style: TextButton.styleFrom(
                  textStyle: const TextStyle(fontSize: 12),
                ),
                onPressed: () {},
              )
            ],
          )
        ],
      ),
    );
  }
}

Future<void> showAlertDialog(BuildContext context) async {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return const AlertDialog(
        title: Text('Failed to login'),
        content: Text(
          'Make sure to fill your Username and Password correctly',
          style: TextStyle(fontSize: 12),
        ),
      );
    },
  );
}
