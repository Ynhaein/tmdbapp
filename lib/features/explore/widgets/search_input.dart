import 'package:flutter/material.dart';
import 'package:tmdb_app/config/theme/app_colors.dart';
import 'package:tmdb_app/config/constant/app_dimens.dart';

class SearchInput extends StatelessWidget {
  final Function(String) onChanged;
  const SearchInput({super.key, required this.onChanged}); 

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged, 
      style: const TextStyle(color: AppColors.textPrimary), 
      decoration: InputDecoration(
        hintText: 'Search movies, director, or genres', 
        hintStyle: const TextStyle(color: AppColors.textSecondary), 
        prefixIcon: Icon(Icons.search, color: AppColors.textSecondary), 
        filled: true, 
        fillColor: AppColors.surfacePrimary, 
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimens.radiusExtraLarge), 
          borderSide: const BorderSide(color: AppColors.divider, width: 0.5) 
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimens.radiusExtraLarge), 
          borderSide: const BorderSide(color: AppColors.primary, width: 1) 
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: AppDimens.paddingMedium, horizontal: AppDimens.paddingSmall) 
      ),
    );
  }
}