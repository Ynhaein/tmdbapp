import 'package:flutter/material.dart';
import 'package:tmdb_app/config/constant/app_dimens.dart';
import 'package:tmdb_app/features/profile/widgets/profile_header.dart';
import 'package:tmdb_app/features/profile/widgets/profile_menu_section.dart';
import 'package:tmdb_app/features/profile/widgets/profile_stat_bar.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(
          AppDimens.paddingMedium,
          AppDimens.paddingLarge,
          AppDimens.paddingMedium,
          AppDimens.paddingXLarge,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // ── Header: Avatar + Name + Badge ──────────────────
            const ProfileHeader(),

            const SizedBox(height: AppDimens.gapLarge),

            // ── Stat Bar: Watched / Reviews / Watchlist ─────────
            const ProfileStatBar(),

            const SizedBox(height: AppDimens.gapLarge),

            // ── Menu List ──────────────────────────────────────
            const ProfileMenuSection(),

            const SizedBox(height: AppDimens.gapLarge),

            // ── Logout Button ──────────────────────────────────
            _LogoutButton(),
          ],
        ),
      ),
    );
  }
}

// ─── Private Widget ───────────────────────────────────────────────

class _LogoutButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: FilledButton.icon(
        onPressed: () {},
        style: FilledButton.styleFrom(
          backgroundColor: Colors.red.withAlpha(30),
          foregroundColor: Colors.redAccent,
          padding: const EdgeInsets.symmetric(
            vertical: AppDimens.paddingMedium,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDimens.radiusLarge),
            side: BorderSide(
              color: Colors.redAccent.withAlpha(100),
              width: 0.8,
            ),
          ),
        ),
        icon: const Icon(Icons.logout_rounded, size: AppDimens.iconMedium),
        label: const Text(
          'Log Out',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: AppDimens.fontSizeBase,
            letterSpacing: 0.5,
          ),
        ),
      ),
    );
  }
}