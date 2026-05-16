import 'package:flutter/material.dart';
import 'package:tmdb_app/config/constant/app_config.dart';
import 'package:tmdb_app/config/constant/app_dimens.dart';
import 'package:tmdb_app/config/theme/app_colors.dart';
import 'package:tmdb_app/features/tickets/models/tickets_model.dart';
import 'package:tmdb_app/features/tickets/widgets/ticket_status_badge.dart';

class TicketCard extends StatelessWidget {
  final TicketModel ticket;

  const TicketCard({super.key, required this.ticket});

  String get _formattedPrice {
    final formatted = ticket.price.toStringAsFixed(0).replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (m) => '${m[1]}.',
        );
    return 'Rp $formatted';
  }

  @override
  Widget build(BuildContext context) {
    final isGreyedOut = ticket.status == TicketStatus.cancelled ||
        ticket.status == TicketStatus.used;

    return Opacity(
      opacity: isGreyedOut ? 0.65 : 1.0,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.surfacePrimary,
          borderRadius: BorderRadius.circular(AppDimens.radiusLarge),
          border: Border.all(color: AppColors.divider, width: 0.5),
          boxShadow: [
            BoxShadow(
              color: AppColors.primaryDark.withAlpha(60),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(AppDimens.radiusLarge),
          child: Column(
            children: [
              // ── Top Section: Backdrop + Poster ─────────────────
              _TicketTopSection(ticket: ticket),

              // ── Perforated Divider ──────────────────────────────
              const _PerforatedDivider(),

              // ── Bottom Section: Ticket Details ──────────────────
              _TicketBottomSection(
                ticket: ticket,
                formattedPrice: _formattedPrice,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─── Top Section ──────────────────────────────────────────────────

class _TicketTopSection extends StatelessWidget {
  final TicketModel ticket;

  const _TicketTopSection({required this.ticket});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 140,
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Backdrop
          Image.network(
            '${AppConfig.imageBaseUrl}/w780${ticket.backdropPath}',
            fit: BoxFit.cover,
            errorBuilder: (_, _, _) => Container(
              color: AppColors.surfaceSecondary,
            ),
          ),

          // Gradient overlay
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  AppColors.surfacePrimary,
                  Colors.transparent,
                  Colors.transparent,
                  AppColors.surfacePrimary,
                ],
                stops: [0.0, 0.15, 0.85, 1.0],
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppColors.surfacePrimary.withAlpha(60),
                  AppColors.surfacePrimary.withAlpha(120),
                ],
              ),
            ),
          ),

          // Poster + Title Row
          Padding(
            padding: const EdgeInsets.all(AppDimens.paddingMedium),
            child: Row(
              children: [
                // Poster
                ClipRRect(
                  borderRadius: BorderRadius.circular(AppDimens.radiusSmall),
                  child: Image.network(
                    '${AppConfig.imageBaseUrl}/w200${ticket.posterPath}',
                    width: 70,
                    height: 105,
                    fit: BoxFit.cover,
                    errorBuilder: (_, _, _) => Container(
                      width: 70,
                      height: 105,
                      color: AppColors.surfaceSecondary,
                      child: const Icon(
                        Icons.movie_outlined,
                        color: AppColors.iconSecondary,
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: AppDimens.gapMedium),

                // Title + Cinema + Status
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TicketStatusBadge(status: ticket.status),

                      const SizedBox(height: AppDimens.gapSmall),

                      Text(
                        ticket.movieTitle,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: AppDimens.fontSizeLarge,
                          fontWeight: FontWeight.w800,
                          height: 1.2,
                        ),
                      ),

                      const SizedBox(height: AppDimens.gapXsmall),

                      Row(
                        children: [
                          const Icon(
                            Icons.location_on_outlined,
                            color: AppColors.iconPrimary,
                            size: AppDimens.iconSmall,
                          ),
                          const SizedBox(width: 3),
                          Expanded(
                            child: Text(
                              ticket.cinema,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: AppColors.textSecondary,
                                fontSize: AppDimens.fontSizeXs,
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: AppDimens.gapXsmall),

                      // Category Badge
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppDimens.paddingSmall,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.primary.withAlpha(20),
                          borderRadius: BorderRadius.circular(
                            AppDimens.radiusSmall,
                          ),
                          border: Border.all(
                            color: AppColors.primary.withAlpha(80),
                            width: 0.5,
                          ),
                        ),
                        child: Text(
                          ticket.category,
                          style: const TextStyle(
                            color: AppColors.primary,
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Perforated Divider ───────────────────────────────────────────

class _PerforatedDivider extends StatelessWidget {
  const _PerforatedDivider();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 24,
      child: Row(
        children: [
          // Left notch
          Container(
            width: 14,
            height: 24,
            decoration: const BoxDecoration(
              color: AppColors.backgroundPrimary,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(12),
                bottomRight: Radius.circular(12),
              ),
            ),
          ),

          // Dashed line
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                const dashWidth = 6.0;
                const dashSpace = 5.0;
                final count =
                    (constraints.maxWidth / (dashWidth + dashSpace)).floor();

                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(
                    count,
                    (_) => Container(
                      width: dashWidth,
                      height: 1.5,
                      decoration: BoxDecoration(
                        color: AppColors.divider,
                        borderRadius: BorderRadius.circular(1),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          // Right notch
          Container(
            width: 14,
            height: 24,
            decoration: const BoxDecoration(
              color: AppColors.backgroundPrimary,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                bottomLeft: Radius.circular(12),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Bottom Section ───────────────────────────────────────────────

class _TicketBottomSection extends StatelessWidget {
  final TicketModel ticket;
  final String formattedPrice;

  const _TicketBottomSection({
    required this.ticket,
    required this.formattedPrice,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppDimens.paddingMedium,
        AppDimens.paddingSmall,
        AppDimens.paddingMedium,
        AppDimens.paddingMedium,
      ),
      child: Column(
        children: [
          // Row 1: Date + Time
          Row(
            children: [
              Expanded(
                child: _InfoTile(
                  icon: Icons.calendar_today_outlined,
                  label: 'Date',
                  value: ticket.date,
                ),
              ),
              const SizedBox(width: AppDimens.gapSmall),
              Expanded(
                child: _InfoTile(
                  icon: Icons.access_time_rounded,
                  label: 'Time',
                  value: ticket.time,
                ),
              ),
            ],
          ),

          const SizedBox(height: AppDimens.gapSmall),

          // Row 2: Seat + Hall
          Row(
            children: [
              Expanded(
                child: _InfoTile(
                  icon: Icons.event_seat_outlined,
                  label: 'Seat',
                  value: ticket.seat,
                ),
              ),
              const SizedBox(width: AppDimens.gapSmall),
              Expanded(
                child: _InfoTile(
                  icon: Icons.meeting_room_outlined,
                  label: 'Hall',
                  value: ticket.hall,
                ),
              ),
            ],
          ),

          const SizedBox(height: AppDimens.gapMedium),

          // Price Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Total',
                style: TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: AppDimens.fontSizeSmall,
                ),
              ),
              Text(
                formattedPrice,
                style: const TextStyle(
                  color: AppColors.primary,
                  fontSize: AppDimens.fontSizeLarge,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ─── Info Tile ────────────────────────────────────────────────────

class _InfoTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _InfoTile({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppDimens.paddingSmall),
      decoration: BoxDecoration(
        color: AppColors.surfaceSecondary,
        borderRadius: BorderRadius.circular(AppDimens.radiusMedium),
      ),
      child: Row(
        children: [
          Icon(icon, color: AppColors.primary, size: AppDimens.iconSmall),
          const SizedBox(width: AppDimens.gapXsmall),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 9,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  value,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: AppDimens.fontSizeXs,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}