import 'dart:async';
import 'package:flutter/material.dart';
import 'package:tmdb_app/config/constant/app_dimens.dart';
import 'package:tmdb_app/config/theme/app_colors.dart';
import 'package:tmdb_app/core/presentation/page/main_navigation.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _isAnimated = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 50), () {
      if (mounted) {
        setState(() {
          _isAnimated = true;
        });
      }
    });

    Timer(const Duration(milliseconds: 2000), () {
      if(mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const MainNavigation())
        ); 
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryDark,
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Brand Logo Animation
            AnimatedContainer(
              duration: const Duration(milliseconds: 900),
              curve: Curves.easeOutCubic,
              margin: EdgeInsets.only(top: _isAnimated ? 0 : 500),

              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 800),
                opacity: _isAnimated ? 1.0 : 0.0,
                child: Icon(
                  Icons.movie_creation_outlined,
                  size: 100,
                  color: AppColors.primary,
                ),
              ),
            ),

            const SizedBox(height: AppDimens.gapMedium),

            // Text Animation
            AnimatedOpacity(
              duration: const Duration(milliseconds: 800),
              opacity: _isAnimated ? 1.0 : 0.0,
              child: const Text(
                'TMDB CINEMA',
                style: TextStyle(
                  color: AppColors.primary,
                  fontSize: AppDimens.fontSize2xl,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 2.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
