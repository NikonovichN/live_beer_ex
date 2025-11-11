import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:live_beer_ex/src/ui/molecules/svg_icon.dart';
import 'package:live_beer_ex/src/ui/ui.dart';

class MainTabsScreen extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const MainTabsScreen({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: navigationShell.currentIndex,
        onTap: (index) =>
            navigationShell.goBranch(index, initialLocation: index == navigationShell.currentIndex),
        items: [
          BottomNavigationBarItem(
            icon: SvgIcon(assetName: 'assets/svg/tab_home.svg', color: AppColors.pureWhite),
            activeIcon: SvgIcon(assetName: 'assets/svg/tab_home.svg', color: theme.primaryColor),
            label: 'Главная',
          ),
          BottomNavigationBarItem(
            icon: SvgIcon(assetName: 'assets/svg/tab_info.svg', color: AppColors.pureWhite),
            activeIcon: SvgIcon(assetName: 'assets/svg/tab_info.svg', color: theme.primaryColor),
            label: 'Информация',
          ),
          BottomNavigationBarItem(
            icon: SvgIcon(
              assetName: 'assets/svg/tab_shopping_cart.svg',
              color: AppColors.pureWhite,
            ),
            activeIcon: SvgIcon(
              assetName: 'assets/svg/tab_shopping_cart.svg',
              color: theme.primaryColor,
            ),
            label: 'Магазины',
          ),
          BottomNavigationBarItem(
            icon: SvgIcon(assetName: 'assets/svg/tab_user.svg', color: AppColors.pureWhite),
            activeIcon: SvgIcon(assetName: 'assets/svg/tab_user.svg', color: theme.primaryColor),
            label: 'Профиль',
          ),
        ],
      ),
    );
  }
}
