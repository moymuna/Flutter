import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../services/employee_service.dart';
import '../widgets/attendance_widget.dart';
import '../models/enums.dart';
import 'employee_list_page.dart';
import 'attendance_page.dart';
import 'leave_page.dart';
import 'leave_approval_page.dart';
import 'salary_page.dart';
import 'payroll_management_page.dart';
import 'notice_board_page.dart';
import 'notification_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final EmployeeService _employeeService = EmployeeService();
  int _employeeCount = 0;
  Map<String, int> _deptStats = {};
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadDashboardData();
  }

  Future<void> _loadDashboardData() async {
    final count = await _employeeService.getEmployeeCount();
    final stats = await _employeeService.getHeadcountByDepartment();
    if (mounted) {
      setState(() {
        _employeeCount = count;
        _deptStats = stats;
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text("HRM Dashboard"),
        actions: [
          IconButton(
            icon: Stack(
              children: [
                const Icon(Icons.notifications),
                if (authProvider.unreadNotifications > 0)
                  Positioned(
                    right: 0,
                    top: 0,
                    child: Container(
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(6)),
                      constraints: const BoxConstraints(minWidth: 12, minHeight: 12),
                      child: Text(
                        '${authProvider.unreadNotifications}',
                        style: const TextStyle(color: Colors.white, fontSize: 8),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
              ],
            ),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const NotificationPage()));
            },
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => authProvider.logout(),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(authProvider.user?.fullName ?? "User"),
              accountEmail: Text(authProvider.user?.email ?? ""),
              currentAccountPicture: const CircleAvatar(child: Icon(Icons.person)),
            ),
            ListTile(
              leading: const Icon(Icons.dashboard),
              title: const Text("Dashboard"),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.people),
              title: const Text("Employees"),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const EmployeeListPage()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.access_time),
              title: const Text("Attendance"),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AttendancePage()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.event_note),
              title: const Text("Leave Management"),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LeavePage()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.monetization_on),
              title: const Text("My Salary"),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SalaryPage()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.announcement),
              title: const Text("Notice Board"),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const NoticeBoardPage()),
                );
              },
            ),
            if (authProvider.user?.role == Role.admin || authProvider.user?.role == Role.hr || authProvider.user?.role == Role.manager)
              ...[
                ListTile(
                  leading: const Icon(Icons.rule),
                  title: const Text("Leave Approvals"),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const LeaveApprovalPage()),
                    );
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.account_balance_wallet),
                  title: const Text("Payroll Management"),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const PayrollManagementPage()),
                    );
                  },
                ),
              ],
          ],
        ),
      ),
      body: RefreshIndicator(
        onRefresh: _loadDashboardData,
        child: _isLoading 
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const AttendanceWidget(),
                  const SizedBox(height: 20),
                  _buildStatCard("Total Employees", _employeeCount.toString(), Icons.people, Colors.blue),
                  const SizedBox(height: 24),
                  const Text("Headcount by Department", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  ..._deptStats.entries.map((e) => Card(
                    child: ListTile(
                      title: Text(e.key),
                      trailing: Text(e.value.toString(), style: const TextStyle(fontWeight: FontWeight.bold)),
                    ),
                  )),
                ],
              ),
            ),
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Icon(icon, size: 40, color: color),
            const SizedBox(width: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontSize: 16, color: Colors.grey)),
                Text(value, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              ],
            )
          ],
        ),
      ),
    );
  }
}
