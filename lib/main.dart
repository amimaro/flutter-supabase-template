import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_supabase_template/config/environment.dart';
import 'package:flutter_supabase_template/pages/account_page.dart';
import 'package:flutter_supabase_template/pages/dashboard_page.dart';
import 'package:flutter_supabase_template/pages/login_page.dart';
import 'package:flutter_supabase_template/pages/register_page.dart';
import 'package:flutter_supabase_template/pages/splash_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: Environment.fileName);

  await Supabase.initialize(
      url: Environment.supabaseUrl,
      anonKey: Environment.supabaseAnonKey,
      authFlowType: AuthFlowType.pkce,
      debug: kDebugMode);
  runApp(const MyApp());
}

final supabase = Supabase.instance.client;

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Supabase Flutter',
      initialRoute: '/',
      routes: <String, WidgetBuilder>{
        '/': (_) => const SplashPage(),
        '/login': (_) => const LoginPage(),
        '/register': (_) => const RegisterPage(),
        '/account': (_) => const AccountPage(),
        '/dashboard': (_) => const DashboardPage(),
      },
    );
  }
}
