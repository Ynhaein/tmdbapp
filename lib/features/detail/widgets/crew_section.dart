import 'package:flutter/material.dart';
import 'package:tmdb_app/config/constant/app_dimens.dart';
import 'package:tmdb_app/config/theme/app_colors.dart';
import 'package:tmdb_app/features/detail/models/credits_model.dart';

class CrewSection extends StatelessWidget {
  final List<CrewModel> crew;

  const CrewSection({super.key, required this.crew});

  String _findByJob(List<String> jobs) {
    for (final job in jobs) {
      final found = crew.firstWhere(
        (e) => e.job == job,
        orElse: () => const CrewModel(id: 0, name: '', job: ''),
      );
      if (found.name.isNotEmpty) return found.name;
    }
    return '-';
  }

  @override
  Widget build(BuildContext context) {
    final director = _findByJob(['Director']);
    final writer = _findByJob(['Screenplay', 'Writer', 'Story']);
    final producer = _findByJob(['Producer', 'Executive Producer']);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Filmmakers',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: AppDimens.fontSizeLarge,
            fontWeight: FontWeight.w700,
          ),
        ),

        const SizedBox(height: AppDimens.gapMedium),

        Container(
          decoration: BoxDecoration(
            color: AppColors.surfacePrimary,
            borderRadius: BorderRadius.circular(AppDimens.radiusMedium),
            border: Border.all(color: AppColors.divider, width: 0.5),
          ),
          child: Column(
            children: [
              _CrewTile(
                icon: Icons.movie_creation_outlined,
                role: 'Director',
                name: director,
                showDivider: true,
              ),
              _CrewTile(
                icon: Icons.edit_outlined,
                role: 'Writer',
                name: writer,
                showDivider: true,
              ),
              _CrewTile(
                icon: Icons.business_center_outlined,
                role: 'Producer',
                name: producer,
                showDivider: false,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ─── Private Widget ───────────────────────────────────────────────

class _CrewTile extends StatelessWidget {
  final IconData icon;
  final String role;
  final String name;
  final bool showDivider;

  const _CrewTile({
    required this.icon,
    required this.role,
    required this.name,
    required this.showDivider,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimens.paddingMedium,
            vertical: AppDimens.paddingMedium,
          ),
          child: Row(
            children: [
              Icon(icon, color: AppColors.primary, size: AppDimens.iconSmall),
              const SizedBox(width: AppDimens.gapSmall),
              Text(
                role,
                style: const TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: AppDimens.fontSizeXs,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Spacer(),
              Text(
                name,
                style: const TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: AppDimens.fontSizeSmall,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        if (showDivider)
          const Divider(
            color: AppColors.divider,
            height: 1,
            thickness: 0.55,
            indent: 0,
            endIndent: 0,
          ),
      ],
    );
  }
}