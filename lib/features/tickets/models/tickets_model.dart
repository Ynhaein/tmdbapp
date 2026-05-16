import 'package:flutter/material.dart';

enum TicketStatus { upcoming, used, cancelled }

class TicketModel {
  final String movieTitle;
  final String posterPath;
  final String backdropPath;
  final String cinema;
  final String date;
  final String time;
  final String seat;
  final String hall;
  final String category;
  final double price;
  final TicketStatus status;

  const TicketModel({
    required this.movieTitle,
    required this.posterPath,
    required this.backdropPath,
    required this.cinema,
    required this.date,
    required this.time,
    required this.seat,
    required this.hall,
    required this.category,
    required this.price,
    required this.status,
  });
}

// ─── Static Placeholder Tickets ───────────────────────────────────

const List<TicketModel> kDummyTickets = [
  TicketModel(
    movieTitle: 'Thunderbolts*',
    posterPath: '/m9EtP1Yrzv6v7dMaC9RZHPG0vJJ.jpg',
    backdropPath: '/mDeAEtGJTlDm3B3N1DY3YXLVQml.jpg',
    cinema: 'CGV Grand Indonesia',
    date: 'Sat, 10 May 2025',
    time: '19:30',
    seat: 'F5, F6',
    hall: 'Hall 3 — IMAX',
    category: 'IMAX',
    price: 95000,
    status: TicketStatus.upcoming,
  ),
  TicketModel(
    movieTitle: 'Mission: Impossible',
    posterPath: '/aLVkiINlIeCkcZIzb7XHzPYgO6L.jpg',
    backdropPath: '/tEF9NrRPElkAjLJioMxu9m9hplt.jpg',
    cinema: 'XXI Plaza Senayan',
    date: 'Sun, 11 May 2025',
    time: '14:00',
    seat: 'C8, C9, C10',
    hall: 'Hall 1 — Premier',
    category: 'Premier',
    price: 75000,
    status: TicketStatus.upcoming,
  ),
  TicketModel(
    movieTitle: 'A Minecraft Movie',
    posterPath: '/iPPTGh2OXuIv6d7cwuoPkw3R4CG.jpg',
    backdropPath: '/fQdCFKG6dMczJGl8K5bkNbbBiJV.jpg',
    cinema: 'CGV Blitz Mega Mall',
    date: 'Mon, 28 Apr 2025',
    time: '20:00',
    seat: 'D4, D5',
    hall: 'Hall 2 — Regular',
    category: 'Regular',
    price: 50000,
    status: TicketStatus.used,
  ),
  TicketModel(
    movieTitle: 'Sinners',
    posterPath: '/wMq9kQXTeQCHUZOG4fAe5MyCPB.jpg',
    backdropPath: '/b0TxFDh6cDdBGc6waTbWfFMX4H.jpg',
    cinema: 'Platinum Cineplex',
    date: 'Fri, 18 Apr 2025',
    time: '17:15',
    seat: 'H7',
    hall: 'Hall 5 — Regular',
    category: 'Regular',
    price: 50000,
    status: TicketStatus.used,
  ),
  TicketModel(
    movieTitle: 'Snow White',
    posterPath: '/oC3dKP4DM2GBe5v7DQWkJQr6jl.jpg',
    backdropPath: '/gjdScbJFoFlrLZAiTDoqUkJg7dk.jpg',
    cinema: 'Cinepolis Living World',
    date: 'Tue, 15 Apr 2025',
    time: '13:30',
    seat: 'B2, B3',
    hall: 'Hall 4 — Regular',
    category: 'Regular',
    price: 50000,
    status: TicketStatus.cancelled,
  ),
  TicketModel(
    movieTitle: 'Captain America: Brave New World',
    posterPath: '/pzIddUEMWhWzfvLI3TwxUG2wGoi.jpg',
    backdropPath: '/gsQJOfeW45KLiQeEIsom94QPQwb.jpg',
    cinema: 'CGV Grand Indonesia',
    date: 'Sat, 08 Mar 2025',
    time: '21:00',
    seat: 'E6, E7, E8',
    hall: 'Hall 1 — 4DX',
    category: '4DX',
    price: 120000,
    status: TicketStatus.used,
  ),
];

// ─── Helper ───────────────────────────────────────────────────────

extension TicketStatusExtension on TicketStatus {
  String get label {
    switch (this) {
      case TicketStatus.upcoming:
        return 'Upcoming';
      case TicketStatus.used:
        return 'Used';
      case TicketStatus.cancelled:
        return 'Cancelled';
    }
  }

  Color get color {
    switch (this) {
      case TicketStatus.upcoming:
        return const Color(0xFFD4AF37); 
      case TicketStatus.used:
        return const Color(0xFF4CAF50);
      case TicketStatus.cancelled:
        return const Color(0xFFE53935);
    }
  }

  Color get backgroundColor {
    switch (this) {
      case TicketStatus.upcoming:
        return const Color(0xFFD4AF37).withAlpha(25);
      case TicketStatus.used:
        return const Color(0xFF4CAF50).withAlpha(25);
      case TicketStatus.cancelled:
        return const Color(0xFFE53935).withAlpha(25);
    }
  }
}