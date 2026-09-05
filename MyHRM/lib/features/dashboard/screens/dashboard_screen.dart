import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:my_hrm/features/employee/providers/employee_providers.dart';
import 'package:my_hrm/features/leave/providers/leave_providers.dart';
import 'package:my_hrm/core/theme/app_theme.dart';
import 'package:my_hrm/shared/enums.dart';

class AdminDashboard extends ConsumerWidget {
  const AdminDashboard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final employeeCount = ref.watch(employeeCountProvider);
    final pendingLeaves = ref.watch(leavesByStatusProvider(LeaveStatus.PENDING.name));

    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
        ref.invalidate(employeeCountProvider);
        ref.invalidate(leavesByStatusProvider(LeaveStatus.PENDING.name));
        },
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Text(
              'Admin Dashboard',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: _StatCard(
                    title: 'Employees',
                    value: employeeCount.when(
                      data: (c) => '$c',
                      loading: () => '--',
                      error: (_, __) => '0',
                    ),
                    icon: Icons.people,
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _StatCard(
                    title: 'Pending Leaves',
                    value: pendingLeaves.when(
                      data: (l) => '${l.length}',
                      loading: () => '--',
                      error: (_, __) => '0',
                    ),
                    icon: Icons.pending_actions,
                    color: Colors.orange,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _StatCard(
                    title: 'Active Employees',
                    value: employeeCount.when(
                      data: (c) => '$c',
                      loading: () => '--',
                      error: (_, __) => '0',
                    ),
                    icon: Icons.access_time,
                    color: Colors.green,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _StatCard(
                    title: 'Departments',
                    value: '--',
                    icon: Icons.business,
                    color: Colors.purple,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            _QuickActions(
              actions: [
                _QuickAction('Employees', Icons.people, () => context.go('/employees')),
                _QuickAction('Departments', Icons.business, () => context.go('/departments')),
                _QuickAction('Job Posts', Icons.work, () => context.go('/job-posts')),
                _QuickAction('Payroll', Icons.payments, () => context.go('/payrolls')),
                _QuickAction('Attendance', Icons.access_time, () => context.go('/attendance')),
                _QuickAction('Leaves', Icons.event_busy, () => context.go('/leaves')),
                _QuickAction('Reports', Icons.analytics, () => context.go('/audit-log')),
                _QuickAction('Settings', Icons.settings, () => context.go('/users')),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class HRDashboard extends ConsumerWidget {
  const HRDashboard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final employeeCount = ref.watch(employeeCountProvider);
    final pendingLeaves = ref.watch(leavesByStatusProvider(LeaveStatus.PENDING.name));

    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          ref.invalidate(employeeCountProvider);
          ref.invalidate(leavesByStatusProvider(LeaveStatus.PENDING.name));
        },
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Text(
              'HR Dashboard',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: _StatCard(
                    title: 'Employees',
                    value: employeeCount.when(
                      data: (c) => '$c',
                      loading: () => '--',
                      error: (_, __) => '0',
                    ),
                    icon: Icons.people,
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _StatCard(
                    title: 'Pending Leaves',
                    value: pendingLeaves.when(
                      data: (l) => '${l.length}',
                      loading: () => '--',
                      error: (_, __) => '0',
                    ),
                    icon: Icons.pending_actions,
                    color: Colors.orange,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _StatCard(
                    title: 'Applicants',
                    value: '--',
                    icon: Icons.person_add,
                    color: Colors.teal,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _StatCard(
                    title: 'Applications',
                    value: '--',
                    icon: Icons.assignment,
                    color: Colors.indigo,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            _QuickActions(
              actions: [
                _QuickAction('Employees', Icons.people, () => context.go('/employees')),
                _QuickAction('Applicants', Icons.person_add, () => context.go('/applicants')),
                _QuickAction('Job Posts', Icons.work, () => context.go('/job-posts')),
                _QuickAction('Applications', Icons.assignment, () => context.go('/applications')),
                _QuickAction('Interviews', Icons.record_voice_over, () => context.go('/interviews')),
                _QuickAction('Leaves', Icons.event_busy, () => context.go('/leaves')),
                _QuickAction('Attendance', Icons.access_time, () => context.go('/attendance')),
                _QuickAction('Documents', Icons.description, () => context.go('/documents')),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ManagerDashboard extends ConsumerWidget {
  const ManagerDashboard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pendingLeaves = ref.watch(leavesByStatusProvider(LeaveStatus.PENDING.name));

    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          ref.invalidate(leavesByStatusProvider(LeaveStatus.PENDING.name));
        },
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Text(
              'Manager Dashboard',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: _StatCard(
                    title: 'Pending Leaves',
                    value: pendingLeaves.when(
                      data: (l) => '${l.length}',
                      loading: () => '--',
                      error: (_, __) => '0',
                    ),
                    icon: Icons.pending_actions,
                    color: Colors.orange,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _StatCard(
                    title: 'My Team',
                    value: '--',
                    icon: Icons.group,
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            _QuickActions(
              actions: [
                _QuickAction('My Team', Icons.group, () => context.go('/employees')),
                _QuickAction('Leaves', Icons.event_busy, () => context.go('/leaves')),
                _QuickAction('Attendance', Icons.access_time, () => context.go('/attendance')),
                _QuickAction('Projects', Icons.folder, () => context.go('/projects')),
                _QuickAction('Performance', Icons.assessment, () => context.go('/performance-reviews')),
                _QuickAction('Trainings', Icons.school, () => context.go('/trainings')),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class EmployeeDashboard extends ConsumerWidget {
  const EmployeeDashboard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {},
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Text(
              'Employee Dashboard',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: _StatCard(
                    title: 'My Attendance',
                    value: '--',
                    icon: Icons.access_time,
                    color: Colors.green,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _StatCard(
                    title: 'Leave Balance',
                    value: '--',
                    icon: Icons.event_busy,
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            _QuickActions(
              actions: [
                _QuickAction('My Profile', Icons.person, () => context.go('/profile')),
                _QuickAction('Attendance', Icons.access_time, () => context.go('/attendance')),
                _QuickAction('Apply Leave', Icons.event, () => context.go('/leaves')),
                _QuickAction('My Salary', Icons.payments, () => context.go('/salaries')),
                _QuickAction('Documents', Icons.description, () => context.go('/documents')),
                _QuickAction('Trainings', Icons.school, () => context.go('/trainings')),
                _QuickAction('Projects', Icons.folder, () => context.go('/projects')),
                _QuickAction('Notices', Icons.announcement, () => context.go('/notices')),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ApplicantDashboard extends ConsumerWidget {
  const ApplicantDashboard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {},
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Text(
              'Applicant Dashboard',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: _StatCard(
                    title: 'My Applications',
                    value: '--',
                    icon: Icons.assignment,
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _StatCard(
                    title: 'Interviews',
                    value: '--',
                    icon: Icons.record_voice_over,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            _QuickActions(
              actions: [
                _QuickAction('Browse Jobs', Icons.work, () => context.go('/job-posts')),
                _QuickAction('My Applications', Icons.assignment, () => context.go('/applications')),
                _QuickAction('My Profile', Icons.person, () => context.go('/profile')),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ── Shared widgets ──────────────────────────────────

class _StatCard extends StatelessWidget {
  const _StatCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  final String title;
  final String value;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: color, size: 28),
            const SizedBox(height: 12),
            Text(
              value,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              title,
              style: const TextStyle(
                fontSize: 13,
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _QuickActions extends StatelessWidget {
  const _QuickActions({required this.actions});
  final List<_QuickAction> actions;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: actions.map((action) {
        return SizedBox(
          width: 120,
          height: 100,
          child: Card(
            child: InkWell(
              onTap: action.onTap,
              borderRadius: BorderRadius.circular(12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(action.icon, color: AppColors.primary, size: 28),
                  const SizedBox(height: 8),
                  Text(
                    action.label,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 12),
                  ),
                ],
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}

class _QuickAction {
  _QuickAction(this.label, this.icon, this.onTap);
  final String label;
  final IconData icon;
  final VoidCallback onTap;
}
