import 'package:flutter/material.dart';
import 'package:pegawai/providers/presensi_provider.dart';
import 'package:pegawai/providers/sesi_provider.dart';
import 'package:pegawai/providers/user_provider.dart';
import 'package:pegawai/screens/dashboard_screen.dart';
import 'package:pegawai/screens/detail_sesi_screen.dart';
import 'package:pegawai/screens/kalender_screen.dart';
import 'package:pegawai/screens/login_screen.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:pegawai/screens/main_screen.dart';
import 'package:pegawai/utils/token_manager.dart';
import 'package:provider/provider.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  await dotenv.load();
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('id_ID', null);
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
        ChangeNotifierProvider(create: (_) => PresensiProvider()),
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
        "/main-screen": (context) => MainScreen(),
        "/detail-sesi": (context) => DetailSesiScreen(),
      },
    );
  }
}
