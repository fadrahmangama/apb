import 'package:apb/component/sign_in_button.dart';
import 'package:apb/component/textfield.dart';
import 'package:apb/services/auth_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';


class RegisterPage extends StatefulWidget {
  final void Function()? onTap;

  const RegisterPage({
    super.key,
    required this.onTap,
  });

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // text editing controllers
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  // register method
  void register() async {
    // get auth service
    final _authService = AuthServices();

    // check if password match -> create user
    if (passwordController.text == confirmPasswordController.text) {
      // try creating user
      try {
        await _authService.signUpWithEmailPassword(emailController.text, passwordController.text);
      }

      // display any error
      catch (e) {
        showDialog(
          context: context, 
          builder: (context) => AlertDialog(
            title: Text(e.toString()), 
          ),
        );
      }
    }

    // if password don't match -> show error
    else{
      showDialog(
        context: context, 
        builder: (context) => const AlertDialog(
          title: Text("password don't match"), 
        ),
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // logo
            Icon(
              Icons.lock_open_rounded,
              size: 100.0,
              color: Theme.of(context).colorScheme.inversePrimary,
            ),

            const SizedBox(height: 25),

            // message, app slogan
            Text(
              "Let's create an Account",
              style: TextStyle(
                fontSize: 16,
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
            ),

            const SizedBox(height: 25),

            MyTextField(
              controller: emailController,
              hintText: 'Email',
              obscureText: false,
            ),

            const SizedBox(height: 10),

            MyTextField(
              controller: passwordController,
              hintText: 'Password',
              obscureText: true,
            ),

            const SizedBox(height: 10),

            // confirm password textfield
            MyTextField(
              controller: confirmPasswordController,
              hintText: 'Confirm Password',
              obscureText: true,
            ),
            const SizedBox(height: 10),

            //Sign up Button
            SignInButton(
              text: "Sign Up",
              onTap: () {},
            ),

            const SizedBox(height: 25),

            //Login here
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Already have an account ?',
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.inversePrimary),
                ),
                const SizedBox(width: 4),
                GestureDetector(
                  onTap: widget.onTap,
                  child: Text(
                    'Login here',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.inversePrimary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
        //
      ),
    );
  }
}
