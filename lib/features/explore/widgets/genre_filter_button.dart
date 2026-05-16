import 'package:flutter/material.dart';
import 'package:tmdb_app/config/constant/app_dimens.dart';
import 'package:tmdb_app/config/theme/app_colors.dart';
import 'package:tmdb_app/features/explore/models/genre_model.dart';

class GenreFilterButton extends StatelessWidget {
  final int selectedGenreId; 
  final List<GenreModel> genres; 
  final Function(int) onGenreSelected; 

  const GenreFilterButton({super.key, required this.selectedGenreId, required this.genres, required this.onGenreSelected}) ;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40, 
      child: ListView.separated(
        scrollDirection: Axis.horizontal, 
        itemCount: genres.length, 
        separatorBuilder: (_,_) => const SizedBox(width: AppDimens.gapSmall), 
        itemBuilder: (context, index) {
          final genre = genres[index]; 
          final isSelected = selectedGenreId == genre.id; 

          return GestureDetector(
            onTap: () => onGenreSelected(genre.id),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: AppDimens.paddingMedium, vertical: AppDimens.paddingSmall), 
              decoration: BoxDecoration(
                color: isSelected ? AppColors.primary : AppColors.surfaceSecondary, 
                borderRadius: BorderRadius.circular(AppDimens.radiusExtraLarge), 
                border: Border.all(color: isSelected ? Colors.transparent : AppColors.divider)
              ),
              alignment: Alignment.center,
              child: Text(
                genre.name, 
                style: TextStyle(
                  color: isSelected ? AppColors.primaryDark : AppColors.textPrimary, 
                  fontWeight: FontWeight.w600, 
                  fontSize: AppDimens.fontSizeBase 
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}