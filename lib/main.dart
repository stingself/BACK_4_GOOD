import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'home_screen.dart';
 
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ),
  );
  runApp(const SharinganApp());
}
 
class SharinganApp extends StatelessWidget {
  const SharinganApp({super.key});
 
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "I'm Back",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFCC0000),
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFF0A0A0A),
      ),
      home: const HomeScreen(),
    );
  }
}
 
