import 'package:flutter/material.dart';
import 'package:pegawai/providers/materi_provider.dart';
import 'package:pegawai/providers/pengampu_provider.dart';
import 'package:pegawai/providers/presensi_provider.dart';
import 'package:pegawai/providers/sesi_provider.dart';
import 'package:pegawai/providers/tugas_provider.dart';
import 'package:pegawai/providers/user_provider.dart';
import 'package:pegawai/screens/kalender_screen.dart';
import 'package:pegawai/screens/login_screen.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:pegawai/screens/main_screen.dart';
import 'package:pegawai/screens/new_dashboard.dart';
import 'package:pegawai/screens/upload_tugas_screen.dart';
import 'package:pegawai/utils/token_manager.dart';
import 'package:provider/provider.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  await dotenv.load();
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('id_ID', null);
  String? token = await TokenManager.getAccessToken();
  Widget screen = LoginScreen();

  if (token != null) {
    screen = MainScreen();
  }

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => SesiProvider()),
        ChangeNotifierProvider(create: (_) => PresensiProvider()),
        ChangeNotifierProvider(create: (_) => PengampuProvider()),
        ChangeNotifierProvider(create: (_) => TugasProvider()),
        ChangeNotifierProvider(create: (_) => MateriProvider()),
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
        "/dashboard": (context) => NewDashboard(),
        "/kalender": (context) => KalenderScreen(),
        "/main-screen": (context) => MainScreen(),
        "/upload-tugas": (context) => UploadTugas(),
      },
    );
  }
}
