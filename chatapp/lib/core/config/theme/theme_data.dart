import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

part 'color_schemes.g.dart';

class AppThemeData {
  static ThemeData get lightTheme => ThemeData(
        useMaterial3: true,
        dividerColor: Colors.grey.shade300,
        // colorScheme: ColorScheme.fromSeed(
        //   brightness: Brightness.light,
        //   primarySwatch: kPrimaryColor,
        //   //  see : kPrimaryColor,
        // ),
        colorScheme: lightColorScheme,
        inputDecorationTheme: InputDecorationTheme(
          contentPadding: const EdgeInsets.all(10),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: BorderSide(color: Colors.red[300]!),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: BorderSide(color: Colors.grey[300]!),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: BorderSide(color: Colors.grey[300]!),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey[300]!),
            borderRadius: BorderRadius.circular(18),
          ),
          labelStyle: const TextStyle(
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w700,
            fontSize: 14,
            height: 1.3,
          ),
        ),
        appBarTheme: AppBarTheme(
          centerTitle: true,
          systemOverlayStyle: SystemUiOverlayStyle.light,
          backgroundColor: lightColorScheme.primary,
          foregroundColor: lightColorScheme.onPrimary,
          elevation: 0,
        ),
        tabBarTheme: const TabBarTheme(
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          indicatorSize: TabBarIndicatorSize.tab,
          labelStyle: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
          unselectedLabelStyle: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
          indicator: UnderlineTabIndicator(
            borderSide: BorderSide(
              color: Colors.white,
              width: 4,
            ),
          ),
        ),
      );
}
