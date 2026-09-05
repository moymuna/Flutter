import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:my_hrm/core/theme/app_theme.dart';
import 'package:my_hrm/core/constants/app_constants.dart';
import 'package:my_hrm/shared/providers.dart';
import 'package:my_hrm/auth/auth_provider.dart';
import 'package:my_hrm/features/dashboard/screens/dashboard_screen.dart';

class NavigationShell extends ConsumerStatefulWidget {
  const NavigationShell({super.key, required this.child});
  final Widget child;

  @override
  ConsumerState<NavigationShell> createState() => _NavigationShellState();
}

class _NavigationShellState extends ConsumerState<NavigationShell> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final storage = ref.watch(storageServiceProvider);
    final screenSize = getScreenSize(context);

    return FutureBuilder<String?>(
      future: storage.getRole(),
      builder: (context, snapshot) {
        final role = snapshot.data ?? 'EMPLOYEE';
        final navItems = _getNavItemsForRole(role);
        final dashboardWidget = _getDashboardForRole(role);

        return Scaffold(
          appBar: AppBar(
            title: const Text('My HRM'),
            actions: [
              IconButton(
                icon: const Icon(Icons.person),
                onPressed: () => context.go('/profile'),
              ),
              IconButton(
                icon: const Icon(Icons.logout),
                onPressed: () async {
                  await ref.read(authControllerProvider.notifier).logout();
                  if (context.mounted) context.go('/login');
                },
              ),
            ],
          ),
          body: Row(
            children: [
              if (screenSize == ScreenSize.tablet) ...[
                _buildRail(context, navItems, dashboardWidget),
                const VerticalDivider(width: 1),
              ],
              if (screenSize == ScreenSize.desktop) ...[
                _buildDrawer(context, navItems, dashboardWidget),
                const VerticalDivider(width: 1),
              ],
              Expanded(
                child: _buildBody(navItems, dashboardWidget),
              ),
            ],
          ),
          bottomNavigationBar: screenSize == ScreenSize.mobile
              ? _buildBottomNav(context, navItems)
              : null,
        );
      },
    );
  }

  Widget _buildBody(List<_NavItem> navItems, Widget dashboard) {
    if (_currentIndex == 0) return dashboard;
    final route = navItems[_currentIndex].route;
    return _PlaceholderScreen(route: route);
  }

  Widget _buildBottomNav(BuildContext context, List<_NavItem> navItems) {
    final items = navItems.take(5).toList();
    return NavigationBar(
      selectedIndex: _currentIndex.clamp(0, items.length - 1),
      onDestinationSelected: (i) => setState(() => _currentIndex = i),
      destinations: items.map((item) {
        return NavigationDestination(
          icon: Icon(item.icon),
          selectedIcon: Icon(item.selectedIcon),
          label: item.label,
        );
      }).toList(),
    );
  }

  Widget _buildRail(
      BuildContext context, List<_NavItem> navItems, Widget dashboard) {
    return NavigationRail(
      selectedIndex: _currentIndex.clamp(0, navItems.length - 1),
      onDestinationSelected: (i) => setState(() => _currentIndex = i),
      labelType: NavigationRailLabelType.none,
      leading: const SizedBox(height: 8),
      destinations: navItems.map((item) {
        return NavigationRailDestination(
          icon: Icon(item.icon),
          selectedIcon: Icon(item.selectedIcon),
          label: Text(item.label),
        );
      }).toList(),
    );
  }

  Widget _buildDrawer(
      BuildContext context, List<_NavItem> navItems, Widget dashboard) {
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
                  itemCount: navItems.length,
                  itemBuilder: (context, index) {
                    final item = navItems[index];
                    final isSelected = index == _currentIndex;
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
                          fontWeight: isSelected
                              ? FontWeight.w600
                              : FontWeight.normal,
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
                      onTap: () => setState(() => _currentIndex = index),
                    );
                  },
                ),
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.person),
                title: const Text('Profile'),
                onTap: () => context.go('/profile'),
              ),
              ListTile(
                leading: const Icon(Icons.logout, color: AppColors.danger),
                title: const Text('Logout',
                    style: TextStyle(color: AppColors.danger)),
                onTap: () async {
                  await ref.read(authControllerProvider.notifier).logout();
                  if (context.mounted) context.go('/login');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _getDashboardForRole(String role) {
    switch (role) {
      case 'ADMIN':
        return const AdminDashboard();
      case 'HR':
        return const HRDashboard();
      case 'MANAGER':
        return const ManagerDashboard();
      case 'APPLICANT':
        return const ApplicantDashboard();
      default:
        return const EmployeeDashboard();
    }
  }

  List<_NavItem> _getNavItemsForRole(String role) {
    switch (role) {
      case 'ADMIN':
        return [
          _NavItem(Icons.dashboard, Icons.dashboard_outlined, 'Dashboard', '/'),
          _NavItem(Icons.people, Icons.people_outlined, 'Employees', '/employees'),
          _NavItem(Icons.business, Icons.business_outlined, 'Departments', '/departments'),
          _NavItem(Icons.work, Icons.work_outlined, 'Job Posts', '/job-posts'),
          _NavItem(Icons.payments, Icons.payments_outlined, 'Payroll', '/payrolls'),
          _NavItem(Icons.access_time, Icons.access_time_outlined, 'Attendance', '/attendance'),
          _NavItem(Icons.event_busy, Icons.event_busy_outlined, 'Leaves', '/leaves'),
          _NavItem(Icons.analytics, Icons.analytics_outlined, 'Audit Log', '/audit-log'),
        ];
      case 'HR':
        return [
          _NavItem(Icons.dashboard, Icons.dashboard_outlined, 'Dashboard', '/'),
          _NavItem(Icons.people, Icons.people_outlined, 'Employees', '/employees'),
          _NavItem(Icons.person_add, Icons.person_add_outlined, 'Applicants', '/applicants'),
          _NavItem(Icons.work, Icons.work_outlined, 'Job Posts', '/job-posts'),
          _NavItem(Icons.assignment, Icons.assignment_outlined, 'Applications', '/applications'),
          _NavItem(Icons.record_voice_over, Icons.record_voice_over_outlined, 'Interviews', '/interviews'),
          _NavItem(Icons.event_busy, Icons.event_busy_outlined, 'Leaves', '/leaves'),
        ];
      case 'MANAGER':
        return [
          _NavItem(Icons.dashboard, Icons.dashboard_outlined, 'Dashboard', '/'),
          _NavItem(Icons.group, Icons.group_outlined, 'My Team', '/employees'),
          _NavItem(Icons.event_busy, Icons.event_busy_outlined, 'Leaves', '/leaves'),
          _NavItem(Icons.folder, Icons.folder_outlined, 'Projects', '/projects'),
          _NavItem(Icons.assessment, Icons.assessment_outlined, 'Reviews', '/performance-reviews'),
        ];
      case 'APPLICANT':
        return [
          _NavItem(Icons.dashboard, Icons.dashboard_outlined, 'Dashboard', '/'),
          _NavItem(Icons.work, Icons.work_outlined, 'Job Posts', '/job-posts'),
          _NavItem(Icons.assignment, Icons.assignment_outlined, 'Applications', '/applications'),
        ];
      default: // EMPLOYEE
        return [
          _NavItem(Icons.dashboard, Icons.dashboard_outlined, 'Dashboard', '/'),
          _NavItem(Icons.access_time, Icons.access_time_outlined, 'Attendance', '/attendance'),
          _NavItem(Icons.event_busy, Icons.event_busy_outlined, 'Leaves', '/leaves'),
          _NavItem(Icons.payments, Icons.payments_outlined, 'Salary', '/salaries'),
          _NavItem(Icons.description, Icons.description_outlined, 'Documents', '/documents'),
        ];
    }
  }
}

class _NavItem {
  _NavItem(this.icon, this.selectedIcon, this.label, this.route);
  final IconData icon;
  final IconData selectedIcon;
  final String label;
  final String route;
}

class _PlaceholderScreen extends StatelessWidget {
  const _PlaceholderScreen({required this.route});
  final String route;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        route,
        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
      ),
    );
  }
}
