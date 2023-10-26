import 'package:flutter/material.dart';
import 'package:flutter_supabase_template/pages/login_page.dart';
import 'package:flutter_supabase_template/pages/register_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      padding: const EdgeInsets.only(bottom: 20),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.blue,
            Colors.orange
          ], // Replace with your desired colors
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SizedBox(
              width: double.infinity,
              child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: FilledButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) {
                          return const RegisterPage();
                        }),
                      );
                    },
                    style: FilledButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 26),
                    ),
                    child: const Text('Register',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ))),
          const SizedBox(height: 10),
          SizedBox(
              width: double.infinity,
              child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginPage()));
                      },
                      style: FilledButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                      ),
                      child: const Text('Access my account',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          )))))
        ],
      ),
    ));
  }
}
