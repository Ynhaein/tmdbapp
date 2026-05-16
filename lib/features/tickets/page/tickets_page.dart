import 'package:flutter/material.dart';
import 'package:tmdb_app/config/constant/app_dimens.dart';
import 'package:tmdb_app/config/theme/app_colors.dart';
import 'package:tmdb_app/features/tickets/models/tickets_model.dart';
import 'package:tmdb_app/features/tickets/widgets/ticket_card.dart';

class TicketsPage extends StatefulWidget {
  const TicketsPage({super.key});

  @override
  State<TicketsPage> createState() => _TicketsPageState();
}

class _TicketsPageState extends State<TicketsPage> {
  TicketStatus? _selectedFilter;

  static const List<_FilterOption> _filters = [
    _FilterOption(label: 'All', status: null),
    _FilterOption(label: 'Upcoming', status: TicketStatus.upcoming),
    _FilterOption(label: 'Used', status: TicketStatus.used),
    _FilterOption(label: 'Cancelled', status: TicketStatus.cancelled),
  ];

  List<TicketModel> get _filteredTickets {
    if (_selectedFilter == null) return kDummyTickets;
    return kDummyTickets
        .where((t) => t.status == _selectedFilter)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Summary Bar ─────────────────────────────────────────
          _TicketSummaryBar(tickets: kDummyTickets),

          const SizedBox(height: AppDimens.gapMedium),

          // ── Filter Tabs ─────────────────────────────────────────
          _FilterTabBar(
            filters: _filters,
            selectedFilter: _selectedFilter,
            onFilterChanged: (status) =>
                setState(() => _selectedFilter = status),
          ),

          const SizedBox(height: AppDimens.gapMedium),

          // ── Ticket List ─────────────────────────────────────────
          Expanded(
            child: _filteredTickets.isEmpty
                ? _EmptyState(filter: _selectedFilter)
                : ListView.separated(
                    padding: const EdgeInsets.fromLTRB(
                      AppDimens.paddingMedium,
                      0,
                      AppDimens.paddingMedium,
                      AppDimens.paddingMedium,
                    ),
                    itemCount: _filteredTickets.length,
                    separatorBuilder: (_, _) =>
                        const SizedBox(height: AppDimens.gapMedium),
                    itemBuilder: (context, index) {
                      return TicketCard(ticket: _filteredTickets[index]);
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

// ─── Summary Bar ──────────────────────────────────────────────────

class _TicketSummaryBar extends StatelessWidget {
  final List<TicketModel> tickets;

  const _TicketSummaryBar({required this.tickets});

  int _count(TicketStatus status) =>
      tickets.where((t) => t.status == status).length;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimens.paddingMedium,
        vertical: AppDimens.paddingMedium
      ),
      child: Row(
        children: [
          Expanded(
            child: _SummaryChip(
              label: 'Total',
              count: tickets.length,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(width: AppDimens.gapSmall),
          Expanded(
            child: _SummaryChip(
              label: 'Upcoming',
              count: _count(TicketStatus.upcoming),
              color: AppColors.primary,
            ),
          ),
          const SizedBox(width: AppDimens.gapSmall),
          Expanded(
            child: _SummaryChip(
              label: 'Used',
              count: _count(TicketStatus.used),
              color: const Color(0xFF4CAF50),
            ),
          ),
          const SizedBox(width: AppDimens.gapSmall),
          Expanded(
            child: _SummaryChip(
              label: 'Cancelled',
              count: _count(TicketStatus.cancelled),
              color: const Color(0xFFE53935),
            ),
          ),
        ],
      ),
    );
  }
}

class _SummaryChip extends StatelessWidget {
  final String label;
  final int count;
  final Color color;

  const _SummaryChip({
    required this.label,
    required this.count,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: AppDimens.paddingSmall,
        horizontal: AppDimens.paddingXsmall,
      ),
      decoration: BoxDecoration(
        color: color.withAlpha(15),
        borderRadius: BorderRadius.circular(AppDimens.radiusMedium),
        border: Border.all(color: color.withAlpha(60), width: 0.8),
      ),
      child: Column(
        children: [
          Text(
            '$count',
            style: TextStyle(
              color: color,
              fontSize: AppDimens.fontSizeLarge,
              fontWeight: FontWeight.w800,
            ),
          ),
          Text(
            label,
            style: const TextStyle(
              color: AppColors.textSecondary,
              fontSize: 9,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Filter Tab Bar ───────────────────────────────────────────────

class _FilterTabBar extends StatelessWidget {
  final List<_FilterOption> filters;
  final TicketStatus? selectedFilter;
  final ValueChanged<TicketStatus?> onFilterChanged;

  const _FilterTabBar({
    required this.filters,
    required this.selectedFilter,
    required this.onFilterChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 36,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(
          horizontal: AppDimens.paddingMedium,
        ),
        itemCount: filters.length,
        separatorBuilder: (_, _) =>
            const SizedBox(width: AppDimens.gapSmall),
        itemBuilder: (context, index) {
          final filter = filters[index];
          final isSelected = selectedFilter == filter.status;

          return GestureDetector(
            onTap: () => onFilterChanged(filter.status),
            child: AnimatedContainer(
              alignment: Alignment.center,
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(
                horizontal: AppDimens.paddingMedium,
                vertical: AppDimens.paddingXsmall,
              ),
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColors.primary
                    : AppColors.surfaceSecondary,
                borderRadius:
                    BorderRadius.circular(AppDimens.radiusExtraLarge),
                border: Border.all(
                  color: isSelected
                      ? Colors.transparent
                      : AppColors.divider,
                  width: 0.8,
                ),
              ),
              child: Text(
                filter.label,
                style: TextStyle(
                  color: isSelected
                      ? AppColors.primaryDark
                      : AppColors.textSecondary,
                  fontSize: AppDimens.fontSizeSmall,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

// ─── Empty State ──────────────────────────────────────────────────

class _EmptyState extends StatelessWidget {
  final TicketStatus? filter;

  const _EmptyState({required this.filter});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.confirmation_num_outlined,
            color: AppColors.iconSecondary,
            size: 56,
          ),
          const SizedBox(height: AppDimens.gapMedium),
          Text(
            filter == null
                ? 'No tickets yet'
                : 'No ${filter!.label.toLowerCase()} tickets',
            style: const TextStyle(
              color: AppColors.textPrimary,
              fontSize: AppDimens.fontSizeLarge,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: AppDimens.gapSmall),
          const Text(
            'Your booked tickets will appear here',
            style: TextStyle(
              color: AppColors.textSecondary,
              fontSize: AppDimens.fontSizeSmall,
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Data Class ───────────────────────────────────────────────────

class _FilterOption {
  final String label;
  final TicketStatus? status;

  const _FilterOption({required this.label, required this.status});
}