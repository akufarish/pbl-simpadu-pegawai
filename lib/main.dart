import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:pegawai_bloc/core/di/di.dart';
import 'package:pegawai_bloc/core/utils/token_manager.dart';
import 'package:pegawai_bloc/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:pegawai_bloc/features/auth/presentation/screen/login_screen.dart';
import 'package:pegawai_bloc/features/dashboard/presentation/screen/main_screen.dart';

void main() async {
  await dotenv.load();
  WidgetsFlutterBinding.ensureInitialized();
  String? token = await TokenManager.getAccessToken();
  Widget screen = LoginScreen();

  if (token != null && !JwtDecoder.isExpired(token)) {
    screen = MainScreen();
  }
  setup();
  runApp(MainApp(screen: screen));

  runApp(MainApp(screen: screen));
}

class MainApp extends StatelessWidget {
  final Widget screen;

  const MainApp({super.key, required this.screen});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(
          create: (BuildContext context) => AuthCubit(getIt()),
        ),
      ],
      child: MaterialApp(
        home: screen,
        routes: {
          "login": (context) => LoginScreen(),
          "dashboard": (context) => MainScreen(),
        },
      ),
    );
  }
}
