import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_supabase_template/components/app_card.dart';
import 'package:flutter_supabase_template/main.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isLoading = false;

  final _formKey = GlobalKey<FormBuilderState>();

  Future<void> _signIn() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    try {
      setState(() {
        _isLoading = true;
      });

      await supabase.auth.signInWithPassword(
        email: _formKey.currentState?.fields['email']?.value,
        password: _formKey.currentState?.fields['password']?.value,
      );

      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Successfully signed in'),
      ));
    } on AuthException catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(error.message),
        backgroundColor: Theme.of(context).colorScheme.error,
      ));
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text('Ops, something went wrong!'),
        backgroundColor: Theme.of(context).colorScheme.error,
      ));
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  bool _redirecting = false;
  late final StreamSubscription<AuthState> _authStateSubscription;
  @override
  void initState() {
    _authStateSubscription = supabase.auth.onAuthStateChange.listen((data) {
      if (_redirecting) return;
      final session = data.session;
      if (session != null) {
        _redirecting = true;
        Navigator.of(context).pushReplacementNamed('/dashboard');
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _authStateSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Scaffold(
        appBar: AppBar(
          title: const Text('Access my account'),
          elevation: 0,
        ),
        backgroundColor: Colors.blue,
        body: LoadingOverlay(
            isLoading: _isLoading,
            child: Stack(children: [
              Center(
                  child: AppCard(
                      children: FormBuilder(
                          key: _formKey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              FormBuilderTextField(
                                  name: 'email',
                                  decoration:
                                      const InputDecoration(labelText: 'Email'),
                                  autovalidateMode: AutovalidateMode.always,
                                  validator: FormBuilderValidators.compose([
                                    FormBuilderValidators.required(
                                        errorText: "Required field"),
                                    FormBuilderValidators.email(
                                        errorText: "Invalid email"),
                                  ]),
                                  initialValue: ''),
                              const SizedBox(height: 24),
                              FormBuilderTextField(
                                name: 'password',
                                decoration: const InputDecoration(
                                    labelText: 'Password'),
                                obscureText: true,
                                autovalidateMode: AutovalidateMode.always,
                                validator: FormBuilderValidators.compose([
                                  FormBuilderValidators.required(
                                      errorText: 'Required field'),
                                ]),
                                initialValue: '',
                              ),
                              const SizedBox(height: 40),
                              FilledButton(
                                  onPressed: _signIn,
                                  style: ButtonStyle(
                                    minimumSize: MaterialStateProperty.all(
                                        const Size(double.infinity,
                                            62)), // Set the button to full width with 50 pixels height
                                  ),
                                  child: const Text(
                                    'Send',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  )),
                              const SizedBox(height: 24),
                              TextButton(
                                  onPressed: () {
                                    Navigator.of(context)
                                        .pushReplacementNamed('/register');
                                  },
                                  style: ButtonStyle(
                                    minimumSize: MaterialStateProperty.all(
                                        const Size(double.infinity,
                                            40)), // Set the button to full width with 50 pixels height
                                  ),
                                  child: const Text(
                                    'Don\'t have an account? Sign up',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  )),
                            ],
                          ))))
            ])));
  }
}
