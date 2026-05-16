import 'package:flutter/material.dart';
import 'package:tmdb_app/config/constant/app_dimens.dart';
import 'package:tmdb_app/config/theme/app_colors.dart';

class DetailSynopsis extends StatefulWidget {
  final String overview;

  const DetailSynopsis({super.key, required this.overview});

  @override
  State<DetailSynopsis> createState() => _DetailSynopsisState();
}

class _DetailSynopsisState extends State<DetailSynopsis> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Synopsis',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: AppDimens.fontSizeLarge,
            fontWeight: FontWeight.w700,
          ),
        ),

        const SizedBox(height: AppDimens.gapSmall),

        AnimatedCrossFade(
          duration: const Duration(milliseconds: 300),
          crossFadeState: _isExpanded
              ? CrossFadeState.showSecond
              : CrossFadeState.showFirst,
          firstChild: Text(
            widget.overview,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: AppColors.textSecondary,
              fontSize: AppDimens.fontSizeSmall,
              height: 1.6,
            ),
          ),
          secondChild: Text(
            widget.overview,
            style: const TextStyle(
              color: AppColors.textSecondary,
              fontSize: AppDimens.fontSizeSmall,
              height: 1.6,
            ),
          ),
        ),

        const SizedBox(height: AppDimens.gapXsmall),

        GestureDetector(
          onTap: () => setState(() => _isExpanded = !_isExpanded),
          child: Text(
            _isExpanded ? 'Show less' : 'Read more',
            style: const TextStyle(
              color: AppColors.primary,
              fontSize: AppDimens.fontSizeXs,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}