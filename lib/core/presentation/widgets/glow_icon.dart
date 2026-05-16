import 'package:flutter/material.dart';
import 'package:tmdb_app/config/theme/app_colors.dart';

class GlowIcon extends StatelessWidget {
  final IconData icon; 
  final bool isSelected; 

  const GlowIcon({
      super.key, 
      required this.icon, 
      required this.isSelected 
    });

  @override
  Widget build(BuildContext context) {
    return AnimatedScale(
      scale: isSelected ? 1.1 : 1.0 , 
      duration: const Duration(milliseconds: 150),
      child: Container(
        decoration: isSelected
          ? BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withValues(alpha: 0.5), 
                blurRadius: 5, 
                offset: const Offset(0, 0)  
              )
            ]
          ) 
          : null, 
          child: Icon(icon),
      ),
    );
  }
}