import 'package:flutter/material.dart';
import 'package:tmdb_app/config/constant/app_dimens.dart';
import 'package:tmdb_app/config/theme/app_colors.dart';
import 'package:tmdb_app/core/presentation/widgets/app_drawer.dart';
import 'package:tmdb_app/core/presentation/widgets/custom_app_bar.dart';
import 'package:tmdb_app/core/presentation/widgets/glow_icon.dart';
import 'package:tmdb_app/features/home/page/home_page.dart';
import 'package:tmdb_app/features/explore/page/explore_page.dart';
import 'package:tmdb_app/features/tickets/page/tickets_page.dart';
import 'package:tmdb_app/features/profile/page/profile_page.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>(); 

  int _currentIndex = 0;

  static const List<String> _pageTitles = [
    'Home', 
    'Explore', 
    'Tickets', 
    'ProfilPage'
  ];

  List<Widget> get _pages => [
    HomePage(
      onSeeAllTapped: () => _onTabTapped(1)
    ),
    ExplorePage(),
    TicketsPage(), 
    ProfilePage()
  ];

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void _onAvatarTapped() {
    setState(() {
      _currentIndex = 3; 
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      extendBody: true,
      drawer: const AppDrawer(),
      appBar: CustomAppBar(
        title: _pageTitles[_currentIndex],
        scaffoldKey: _scaffoldKey,
        onAvatarTapped: _onAvatarTapped,
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(AppDimens.radiusExtraLarge),
            topRight: Radius.circular(AppDimens.radiusExtraLarge),
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.outline.withAlpha(100),
              blurRadius: 1.5,
              spreadRadius: 1.5,
              offset: const Offset(0, 0), // ← FIX: shadow ke atas agar terlihat di atas nav bar
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(AppDimens.radiusLarge),
            topRight: Radius.circular(AppDimens.radiusLarge),
          ),
          child: NavigationBar(
            overlayColor: WidgetStateProperty.all(Colors.transparent),
            selectedIndex: _currentIndex,
            onDestinationSelected: _onTabTapped,
            destinations: [
              // Api Data (Dinamis)
              NavigationDestination(
                icon: GlowIcon(icon: Icons.movie_outlined, isSelected: _currentIndex == 0),
                selectedIcon: GlowIcon(icon: Icons.movie, isSelected: _currentIndex == 0),
                label: 'Home',
              ),
              NavigationDestination(
                icon: GlowIcon(icon: Icons.explore_outlined, isSelected: _currentIndex == 1),
                selectedIcon: GlowIcon(icon: Icons.explore, isSelected: _currentIndex == 1),
                label: 'Explore',
              ),

              // Statis Data
              NavigationDestination(
                icon: GlowIcon(icon: Icons.confirmation_num_outlined, isSelected: _currentIndex == 2),
                selectedIcon: GlowIcon(icon: Icons.confirmation_num, isSelected: _currentIndex == 2),
                label: 'Tickets',
              ),
              NavigationDestination(
                icon: GlowIcon(icon: Icons.person_outlined, isSelected: _currentIndex == 3),
                selectedIcon: GlowIcon(icon: Icons.person, isSelected: _currentIndex == 3),
                label: 'Profile',
              ),
            ],
          ),
        ),
      ),
    );
  }
}