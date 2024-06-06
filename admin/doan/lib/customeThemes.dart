import 'package:flutter/material.dart';

// Tạo một class để quản lý các theme của ứng dụng
class CustomThemes {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    
    // Các thiết lập thêm có thể được thêm vào ở đây
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Colors.orange,
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
          const EdgeInsets.symmetric(vertical: 10.0, horizontal: 30.0),
        ),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
        ),
        backgroundColor: MaterialStateProperty.all<Color>(Colors.orange),
      ),
    ),
    
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20.0),
        borderSide: BorderSide.none,
      ),
      filled: true,
      fillColor: Colors.white,
      labelStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      hintStyle: TextStyle(
        fontSize: 16.0,
        color: Colors.grey,
      ),
    ),

    textTheme: TextTheme(
      headlineLarge: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.black),
      headlineMedium: const TextStyle(fontSize: 24, fontWeight: FontWeight.w600, color: Colors.black),
      headlineSmall: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.black),

      titleLarge: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black),
      titleMedium: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black),
      titleSmall: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Colors.black),

      bodyLarge: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black),
      bodyMedium: const TextStyle(fontSize: 14, fontWeight: FontWeight.normal, color: Colors.black),
      bodySmall: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black.withOpacity(0.5)),

      labelLarge: const  TextStyle(fontSize: 12, fontWeight: FontWeight.normal, color: Colors.black),
      labelMedium: TextStyle(fontSize: 12, fontWeight: FontWeight.normal, color: Colors.black.withOpacity(0.5)),
      
    
    ),
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    // Các thiết lập thêm có thể được thêm vào ở đây
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Colors.red,
      
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
          const EdgeInsets.symmetric(vertical: 20.0, horizontal: 40.0),
        ),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
        ),
        backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
      ),
    ),
    // Thiết lập cho các input
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20.0),
        borderSide: BorderSide.none,
      ),
      filled: true,
      labelStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      hintStyle: TextStyle(
        fontSize: 16.0,
        color: Colors.grey,
      ),
    ),

    textTheme: TextTheme(
      headlineLarge: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white),
      headlineMedium: const TextStyle(fontSize: 24, fontWeight: FontWeight.w600, color: Colors.white),
      headlineSmall: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.white),

      titleLarge: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white),
      titleMedium: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.white),
      titleSmall: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Colors.white),

      bodyLarge: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.white),
      bodyMedium: const TextStyle(fontSize: 14, fontWeight: FontWeight.normal, color: Colors.white),
      bodySmall: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.white.withOpacity(0.5)),

      labelLarge: const  TextStyle(fontSize: 12, fontWeight: FontWeight.normal, color: Colors.white),
      labelMedium: TextStyle(fontSize: 12, fontWeight: FontWeight.normal, color: Colors.white.withOpacity(0.5)),
      
      

    ),
    
  );
}