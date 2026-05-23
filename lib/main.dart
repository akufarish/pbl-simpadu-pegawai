import 'package:flutter/material.dart';
import 'package:pegawai/providers/sesi_provider.dart';
import 'package:pegawai/providers/user_provider.dart';
import 'package:pegawai/screens/dashboard_screen.dart';
import 'package:pegawai/screens/kalender_screen.dart';
import 'package:pegawai/screens/login_screen.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:pegawai/screens/main_screen.dart';
import 'package:pegawai/utils/token_manager.dart';
import 'package:provider/provider.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

void main() async {
  await dotenv.load();
  WidgetsFlutterBinding.ensureInitialized();

  String? token = await TokenManager.getAccessToken();
  Widget screen = LoginScreen();

  if (token != null && !JwtDecoder.isExpired(token)) {
    screen = MainScreen();
  }

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => SesiProvider()),
      ],
      child: MainApp(screen: screen),
    ),
  );
}

class MainApp extends StatelessWidget {
  final Widget screen;

  const MainApp({super.key, required this.screen});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(body: screen),
      routes: {
        "/login": (context) => LoginScreen(),
        "/dashboard": (context) => DashboardScreen(),
        "/kalender": (context) => KalenderScreen(),
      },
    );
  }
}
