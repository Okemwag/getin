import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:getin/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:getin/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:getin/features/auth/domain/repositories/auth_repository.dart';
import 'package:getin/features/auth/presentation/providers/auth_providers.dart';
import 'package:getin/features/auth/presentation/screens/auth_screen.dart';
import 'package:getin/core/constants/app_constants.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MedyApp());
}

class MedyApp extends StatelessWidget {
  const MedyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthRemoteDataSource>(
          create: (_) => AuthRemoteDataSourceImpl(),
        ),
        Provider<AuthRepository>(
          create:
              (context) => AuthRepositoryImpl(
                remoteDataSource: context.read<AuthRemoteDataSource>(),
              ),
        ),
        ChangeNotifierProvider<AuthProvider>(
          create:
              (context) =>
                  AuthProvider(authRepository: context.read<AuthRepository>()),
        ),
      ],
      child: MaterialApp(
        title: AppConstants.appName,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.deepPurple,
            brightness: Brightness.light,
          ),
          inputDecorationTheme: InputDecorationTheme(
            filled: true,
            fillColor: Colors.grey.shade100,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.deepPurple, width: 2),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 16,
            ),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.deepPurple,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
        home: const AuthScreen(),
      ),
    );
  }
}
