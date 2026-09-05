import 'package:flutter/material.dart';
import 'package:my_hrm/core/theme/app_theme.dart';
import 'package:my_hrm/core/constants/app_constants.dart';

class AdaptiveScaffold extends StatelessWidget {
  const AdaptiveScaffold({
    super.key,
    required this.body,
    required this.navigationItems,
    this.currentIndex = 0,
    this.onIndexChanged,
    this.title,
    this.actions,
    this.floatingActionButton,
    this.drawer,
  });

  final Widget body;
  final List<NavItem> navigationItems;
  final int currentIndex;
  final ValueChanged<int>? onIndexChanged;
  final String? title;
  final List<Widget>? actions;
  final Widget? floatingActionButton;
  final Widget? drawer;

  @override
  Widget build(BuildContext context) {
    final screenSize = getScreenSize(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(title ?? 'My HRM'),
        actions: actions,
      ),
      drawer: drawer,
      body: body,
      floatingActionButton: floatingActionButton,
      bottomNavigationBar: screenSize == ScreenSize.mobile
          ? _buildBottomNav()
          : null,
    );
  }

  Widget? _buildBottomNav() {
    final items = navigationItems.take(5).toList();
    return NavigationBar(
      selectedIndex: currentIndex.clamp(0, items.length - 1),
      onDestinationSelected: onIndexChanged,
      destinations: items.map((item) {
        return NavigationDestination(
          icon: Icon(item.icon),
          selectedIcon: Icon(item.selectedIcon),
          label: item.label,
        );
      }).toList(),
    );
  }
}

class AdaptiveScaffoldWithRail extends StatelessWidget {
  const AdaptiveScaffoldWithRail({
    super.key,
    required this.body,
    required this.navigationItems,
    this.currentIndex = 0,
    this.onIndexChanged,
    this.title,
    this.actions,
    this.floatingActionButton,
    this.trailingWidgets,
  });

  final Widget body;
  final List<NavItem> navigationItems;
  final int currentIndex;
  final ValueChanged<int>? onIndexChanged;
  final String? title;
  final List<Widget>? actions;
  final Widget? floatingActionButton;
  final List<Widget>? trailingWidgets;

  @override
  Widget build(BuildContext context) {
    final screenSize = getScreenSize(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(title ?? 'My HRM'),
        actions: actions,
      ),
      body: Row(
        children: [
          if (screenSize == ScreenSize.tablet) ...[
            _buildRail(context),
            const VerticalDivider(width: 1),
          ],
          if (screenSize == ScreenSize.desktop) ...[
            _buildDrawer(context),
            const VerticalDivider(width: 1),
          ],
          Expanded(child: body),
        ],
      ),
      floatingActionButton: floatingActionButton,
      bottomNavigationBar: screenSize == ScreenSize.mobile
          ? _buildBottomNav(context)
          : null,
    );
  }

  Widget _buildRail(BuildContext context) {
    return NavigationRail(
      selectedIndex: currentIndex.clamp(0, navigationItems.length - 1),
      onDestinationSelected: onIndexChanged,
      labelType: NavigationRailLabelType.none,
      leading: const SizedBox(height: 8),
      trailing: Expanded(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ...?trailingWidgets,
            const SizedBox(height: 8),
          ],
        ),
      ),
      destinations: navigationItems.map((item) {
        return NavigationRailDestination(
          icon: Icon(item.icon),
          selectedIcon: Icon(item.selectedIcon),
          label: Text(item.label),
        );
      }).toList(),
    );
  }

  Widget _buildDrawer(BuildContext context) {
    return SizedBox(
      width: 256,
      child: Drawer(
        child: SafeArea(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(
                        Icons.business,
                        color: AppColors.primary,
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 12),
                    const Text(
                      'My HRM',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(),
              Expanded(
                child: ListView.builder(
                  itemCount: navigationItems.length,
                  itemBuilder: (context, index) {
                    final item = navigationItems[index];
                    final isSelected = index == currentIndex;
                    return ListTile(
                      leading: Icon(
                        isSelected ? item.selectedIcon : item.icon,
                        color: isSelected
                            ? AppColors.primary
                            : AppColors.textSecondary,
                      ),
                      title: Text(
                        item.label,
                        style: TextStyle(
                          color: isSelected
                              ? AppColors.primary
                              : AppColors.textPrimary,
                          fontWeight:
                              isSelected ? FontWeight.w600 : FontWeight.normal,
                        ),
                      ),
                      selected: isSelected,
                      selectedTileColor:
                          AppColors.primary.withValues(alpha: 0.08),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 16),
                      onTap: () => onIndexChanged?.call(index),
                    );
                  },
                ),
              ),
              if (trailingWidgets != null) ...[
                const Divider(),
                ...trailingWidgets!,
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget? _buildBottomNav(BuildContext context) {
    final items = navigationItems.take(5).toList();
    return NavigationBar(
      selectedIndex: currentIndex.clamp(0, items.length - 1),
      onDestinationSelected: onIndexChanged,
      destinations: items.map((item) {
        return NavigationDestination(
          icon: Icon(item.icon),
          selectedIcon: Icon(item.selectedIcon),
          label: item.label,
        );
      }).toList(),
    );
  }
}

class NavItem {
  const NavItem({
    required this.icon,
    required this.selectedIcon,
    required this.label,
    required this.route,
  });

  final IconData icon;
  final IconData selectedIcon;
  final String label;
  final String route;
}
