import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'viewmodels/news_viewmodel.dart';
import 'views/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => NewsViewModel()),
      ],
      child: MaterialApp(
        title: 'News App',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch(
            primarySwatch: Colors.blue,
          ).copyWith(
            secondary: const Color(0xFFFF7043), // Orange as the accent color
          ),
          scaffoldBackgroundColor: const Color(0xFFF5F5F5), // Light Grey
          cardColor: Colors.white, // White for Cards
          appBarTheme: const AppBarTheme(
            backgroundColor: Color(0xFF1E88E5),
            elevation: 2,
            titleTextStyle: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            iconTheme: IconThemeData(color: Colors.white),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF1E88E5), // Blue
              foregroundColor: Colors.white, // Ensure text is white
              textStyle: const TextStyle(fontSize: 16),
            ),
          ),
          textTheme: const TextTheme(
            bodyLarge: TextStyle(color: Colors.black87, fontSize: 16), // Replaces bodyText1
            bodyMedium: TextStyle(color: Colors.black54, fontSize: 14), // Replaces bodyText2
          ),
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
