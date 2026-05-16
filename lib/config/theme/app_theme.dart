import 'package:flutter/material.dart'; 
import 'package:flutter/services.dart';
import 'package:tmdb_app/config/constant/app_dimens.dart';
import 'package:tmdb_app/config/theme/app_colors.dart'; 

class AppTheme {
  static ThemeData baseTheme() {
  return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark, 
      scaffoldBackgroundColor: AppColors.backgroundPrimary, 
      appBarTheme: const AppBarTheme(
        toolbarHeight: AppDimens.barHeight,
        backgroundColor: AppColors.primaryDark, 
        elevation: 0, 
        scrolledUnderElevation: 0, 
      ), 
      
      navigationBarTheme: NavigationBarThemeData(
        height: AppDimens.barHeight, 
        backgroundColor: AppColors.primaryDark, 
        indicatorColor: Colors.transparent, 
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          if(states.contains(WidgetState.selected)) {
            return const TextStyle(
              color: AppColors.primary, 
              fontWeight: FontWeight.w600 
            );
          } 

          return const TextStyle(
            color: AppColors.iconPrimary, 
            fontWeight: FontWeight.w500
          );
        }),

        iconTheme: WidgetStateProperty.resolveWith((states) {
          if(states.contains(WidgetState.selected)) {
            return const IconThemeData(
              color: AppColors.primary, 
              size: 26 
            );
          } 

          return const IconThemeData(
            color: AppColors.iconPrimary, 
            size: 26  
          );
        })
      ), 

      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: AppColors.primary 
      )
    );   
  } 

  static SystemUiOverlayStyle get systemUiOverlayStyle {
    return const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, 
      statusBarIconBrightness: Brightness.light, 
      statusBarBrightness: Brightness.dark, 
      systemNavigationBarColor: AppColors.backgroundPrimary, 
      systemNavigationBarIconBrightness: Brightness.light,  
      systemStatusBarContrastEnforced: false 
    );  
  }
}