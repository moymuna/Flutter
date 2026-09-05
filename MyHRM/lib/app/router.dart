import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:my_hrm/auth/screen/login_screen.dart';
import 'package:my_hrm/features/auth/screens/forgot_password_screen.dart';
import 'package:my_hrm/features/auth/screens/reset_password_screen.dart';
import 'package:my_hrm/features/navigation/navigation_shell.dart';
import 'package:my_hrm/features/office/screens/office_list_screen.dart';
import 'package:my_hrm/features/office/screens/office_form_screen.dart';
import 'package:my_hrm/features/department/screens/department_list_screen.dart';
import 'package:my_hrm/features/department/screens/department_form_screen.dart';
import 'package:my_hrm/features/designation/screens/designation_list_screen.dart';
import 'package:my_hrm/features/designation/screens/designation_form_screen.dart';
import 'package:my_hrm/features/employee/screens/employee_list_screen.dart';
import 'package:my_hrm/features/employee/screens/employee_detail_screen.dart';
import 'package:my_hrm/features/employee/screens/employee_form_screen.dart';
import 'package:my_hrm/features/user/screens/user_list_screen.dart';
import 'package:my_hrm/features/user/screens/user_form_screen.dart';
import 'package:my_hrm/features/job_post/screens/job_post_list_screen.dart';
import 'package:my_hrm/features/job_post/screens/job_post_form_screen.dart';
import 'package:my_hrm/features/job_post/screens/job_post_detail_screen.dart';
import 'package:my_hrm/features/applicant/screens/applicant_list_screen.dart';
import 'package:my_hrm/features/applicant/screens/applicant_detail_screen.dart';
import 'package:my_hrm/features/application/screens/application_list_screen.dart';
import 'package:my_hrm/features/application/screens/application_detail_screen.dart';
import 'package:my_hrm/features/interview/screens/interview_list_screen.dart';
import 'package:my_hrm/features/interview/screens/interview_form_screen.dart';
import 'package:my_hrm/features/interview/screens/interview_detail_screen.dart';
import 'package:my_hrm/features/attendance/screens/attendance_list_screen.dart';
import 'package:my_hrm/features/leave/screens/leave_list_screen.dart';
import 'package:my_hrm/features/leave/screens/leave_form_screen.dart';
import 'package:my_hrm/features/leave/screens/leave_detail_screen.dart';
import 'package:my_hrm/features/leave_type/screens/leave_type_list_screen.dart';
import 'package:my_hrm/features/leave_type/screens/leave_type_form_screen.dart';
import 'package:my_hrm/features/leave_balance/screens/leave_balance_list_screen.dart';
import 'package:my_hrm/features/holiday/screens/holiday_list_screen.dart';
import 'package:my_hrm/features/holiday/screens/holiday_form_screen.dart';
import 'package:my_hrm/features/salary/screens/salary_list_screen.dart';
import 'package:my_hrm/features/salary_grade/screens/salary_grade_list_screen.dart';
import 'package:my_hrm/features/salary_grade/screens/salary_grade_form_screen.dart';
import 'package:my_hrm/features/payroll/screens/payroll_list_screen.dart';
import 'package:my_hrm/features/payslip/screens/payslip_list_screen.dart';
import 'package:my_hrm/features/training/screens/training_list_screen.dart';
import 'package:my_hrm/features/training/screens/training_form_screen.dart';
import 'package:my_hrm/features/project/screens/project_list_screen.dart';
import 'package:my_hrm/features/project/screens/project_form_screen.dart';
import 'package:my_hrm/features/performance_review/screens/performance_review_list_screen.dart';
import 'package:my_hrm/features/notice/screens/notice_list_screen.dart';
import 'package:my_hrm/features/document/screens/document_list_screen.dart';
import 'package:my_hrm/features/advance/screens/advance_list_screen.dart';
import 'package:my_hrm/features/advance/screens/advance_form_screen.dart';
import 'package:my_hrm/features/advance/screens/advance_detail_screen.dart';
import 'package:my_hrm/features/audit_log/screens/audit_log_list_screen.dart';
import 'package:my_hrm/features/notification/screens/notification_list_screen.dart';
import 'package:my_hrm/features/profile/screens/profile_screen.dart';


final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/login',
    redirect: (context, state) {
      final isLoggedIn = state.matchedLocation == '/login' ||
          state.matchedLocation == '/forgot-password' ||
          state.matchedLocation.startsWith('/reset-password');
      if (isLoggedIn) return null;
      return null;
    },
    routes: [
      // ── Auth ────────────────────────────────────────
      GoRoute(
        path: '/login',
        name: 'login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/forgot-password',
        name: 'forgotPassword',
        builder: (context, state) => const ForgotPasswordScreen(),
      ),
      GoRoute(
        path: '/reset-password',
        name: 'resetPassword',
        builder: (context, state) {
          final token = state.uri.queryParameters['token'];
          return ResetPasswordScreen(token: token);
        },
      ),

      // ── Profile ─────────────────────────────────────
      GoRoute(
        path: '/profile',
        name: 'profile',
        builder: (context, state) => const ProfileScreen(),
      ),

      // ── Main Shell with Navigation ──────────────────
      ShellRoute(
        builder: (context, state, child) {
          return NavigationShell(child: child);
        },
        routes: [
          // ── Home ──────────────────────────────────
          GoRoute(
            path: '/',
            name: 'home',
            builder: (context, state) => const _DashboardWrapper(),
          ),

          // ── Employee ──────────────────────────────
          GoRoute(
            path: '/employees',
            name: 'employees',
            builder: (context, state) => const EmployeeListScreen(),
          ),
          GoRoute(
            path: '/employees/new',
            name: 'employeeForm',
            builder: (context, state) => const EmployeeFormScreen(),
          ),
          GoRoute(
            path: '/employees/:id',
            name: 'employeeDetail',
            builder: (context, state) {
              final id = int.parse(state.pathParameters['id']!);
              return EmployeeDetailScreen(employeeId: id);
            },
          ),
          GoRoute(
            path: '/employees/:id/edit',
            builder: (context, state) {
              final id = int.parse(state.pathParameters['id']!);
              return EmployeeFormScreen(employeeId: id);
            },
          ),

          // ── Department ────────────────────────────
          GoRoute(
            path: '/departments',
            name: 'departments',
            builder: (context, state) => const DepartmentListScreen(),
          ),
          GoRoute(
            path: '/departments/new',
            name: 'departmentForm',
            builder: (context, state) => const DepartmentFormScreen(),
          ),
          GoRoute(
            path: '/departments/:id',
            builder: (context, state) {
              final id = int.parse(state.pathParameters['id']!);
              return DepartmentFormScreen(departmentId: id);
            },
          ),

          // ── Designation ───────────────────────────
          GoRoute(
            path: '/designations',
            name: 'designations',
            builder: (context, state) => const DesignationListScreen(),
          ),
          GoRoute(
            path: '/designations/new',
            name: 'designationForm',
            builder: (context, state) => const DesignationFormScreen(),
          ),
          GoRoute(
            path: '/designations/:id',
            builder: (context, state) {
              final id = int.parse(state.pathParameters['id']!);
              return DesignationFormScreen(designationId: id);
            },
          ),

          // ── Office ────────────────────────────────
          GoRoute(
            path: '/offices',
            name: 'offices',
            builder: (context, state) => const OfficeListScreen(),
          ),
          GoRoute(
            path: '/offices/new',
            name: 'officeForm',
            builder: (context, state) => const OfficeFormScreen(),
          ),
          GoRoute(
            path: '/offices/:id',
            builder: (context, state) {
              final id = int.parse(state.pathParameters['id']!);
              return OfficeFormScreen(officeId: id);
            },
          ),

          // ── Users ─────────────────────────────────
          GoRoute(
            path: '/users',
            name: 'users',
            builder: (context, state) => const UserListScreen(),
          ),
          GoRoute(
            path: '/users/new',
            name: 'userForm',
            builder: (context, state) => const UserFormScreen(),
          ),

          // ── Job Posts ─────────────────────────────
          GoRoute(
            path: '/job-posts',
            name: 'jobPosts',
            builder: (context, state) => const JobPostListScreen(),
          ),
          GoRoute(
            path: '/job-posts/new',
            name: 'jobPostForm',
            builder: (context, state) => const JobPostFormScreen(),
          ),
          GoRoute(
            path: '/job-posts/:id',
            name: 'jobPostDetail',
            builder: (context, state) {
              final id = int.parse(state.pathParameters['id']!);
              return JobPostDetailScreen(jobPostId: id);
            },
          ),
          GoRoute(
            path: '/job-posts/:id/edit',
            builder: (context, state) {
              final id = int.parse(state.pathParameters['id']!);
              return JobPostFormScreen(jobPostId: id);
            },
          ),

          // ── Applicants ────────────────────────────
          GoRoute(
            path: '/applicants',
            name: 'applicants',
            builder: (context, state) => const ApplicantListScreen(),
          ),
          GoRoute(
            path: '/applicants/:id',
            name: 'applicantDetail',
            builder: (context, state) {
              final id = int.parse(state.pathParameters['id']!);
              return ApplicantDetailScreen(applicantId: id);
            },
          ),

          // ── Applications ──────────────────────────
          GoRoute(
            path: '/applications',
            name: 'applications',
            builder: (context, state) => const ApplicationListScreen(),
          ),
          GoRoute(
            path: '/applications/:id',
            name: 'applicationDetail',
            builder: (context, state) {
              final id = int.parse(state.pathParameters['id']!);
              return ApplicationDetailScreen(applicationId: id);
            },
          ),

          // ── Interviews ────────────────────────────
          GoRoute(
            path: '/interviews',
            name: 'interviews',
            builder: (context, state) => const InterviewListScreen(),
          ),
          GoRoute(
            path: '/interviews/new',
            name: 'interviewForm',
            builder: (context, state) => const InterviewFormScreen(),
          ),
          GoRoute(
            path: '/interviews/:id',
            name: 'interviewDetail',
            builder: (context, state) {
              final id = int.parse(state.pathParameters['id']!);
              return InterviewDetailScreen(interviewId: id);
            },
          ),
          GoRoute(
            path: '/interviews/:id/edit',
            builder: (context, state) {
              final id = int.parse(state.pathParameters['id']!);
              return InterviewFormScreen(interviewId: id);
            },
          ),

          // ── Attendance ────────────────────────────
          GoRoute(
            path: '/attendance',
            name: 'attendance',
            builder: (context, state) => const AttendanceListScreen(),
          ),

          // ── Leaves ───────────────────────────────
          GoRoute(
            path: '/leaves',
            name: 'leaves',
            builder: (context, state) => const LeaveListScreen(),
          ),
          GoRoute(
            path: '/leaves/new',
            name: 'leaveForm',
            builder: (context, state) => const LeaveFormScreen(),
          ),
          GoRoute(
            path: '/leaves/:id',
            name: 'leaveDetail',
            builder: (context, state) {
              final id = int.parse(state.pathParameters['id']!);
              return LeaveDetailScreen(leaveId: id);
            },
          ),

          // ── Leave Types ──────────────────────────
          GoRoute(
            path: '/leave-types',
            name: 'leaveTypes',
            builder: (context, state) => const LeaveTypeListScreen(),
          ),
          GoRoute(
            path: '/leave-types/new',
            name: 'leaveTypeForm',
            builder: (context, state) => const LeaveTypeFormScreen(),
          ),

          // ── Leave Balances ───────────────────────
          GoRoute(
            path: '/leave-balances',
            name: 'leaveBalances',
            builder: (context, state) => const LeaveBalanceListScreen(),
          ),

          // ── Holidays ─────────────────────────────
          GoRoute(
            path: '/holidays',
            name: 'holidays',
            builder: (context, state) => const HolidayListScreen(),
          ),
          GoRoute(
            path: '/holidays/new',
            name: 'holidayForm',
            builder: (context, state) => const HolidayFormScreen(),
          ),

          // ── Salary ───────────────────────────────
          GoRoute(
            path: '/salaries',
            name: 'salaries',
            builder: (context, state) => const SalaryListScreen(),
          ),

          // ── Salary Grades ────────────────────────
          GoRoute(
            path: '/salary-grades',
            name: 'salaryGrades',
            builder: (context, state) => const SalaryGradeListScreen(),
          ),
          GoRoute(
            path: '/salary-grades/new',
            name: 'salaryGradeForm',
            builder: (context, state) => const SalaryGradeFormScreen(),
          ),

          // ── Payroll ──────────────────────────────
          GoRoute(
            path: '/payrolls',
            name: 'payrolls',
            builder: (context, state) => const PayrollListScreen(),
          ),

          // ── Payslip ──────────────────────────────
          GoRoute(
            path: '/payslips',
            name: 'payslips',
            builder: (context, state) => const PayslipListScreen(),
          ),

          // ── Training ─────────────────────────────
          GoRoute(
            path: '/trainings',
            name: 'trainings',
            builder: (context, state) => const TrainingListScreen(),
          ),
          GoRoute(
            path: '/trainings/new',
            name: 'trainingForm',
            builder: (context, state) => const TrainingFormScreen(),
          ),

          // ── Projects ─────────────────────────────
          GoRoute(
            path: '/projects',
            name: 'projects',
            builder: (context, state) => const ProjectListScreen(),
          ),
          GoRoute(
            path: '/projects/new',
            name: 'projectForm',
            builder: (context, state) => const ProjectFormScreen(),
          ),

          // ── Performance Reviews ──────────────────
          GoRoute(
            path: '/performance-reviews',
            name: 'performanceReviews',
            builder: (context, state) =>
                const PerformanceReviewListScreen(),
          ),

          // ── Notices ──────────────────────────────
          GoRoute(
            path: '/notices',
            name: 'notices',
            builder: (context, state) => const NoticeListScreen(),
          ),

          // ── Notifications ────────────────────────
          GoRoute(
            path: '/notifications',
            name: 'notifications',
            builder: (context, state) => const NotificationListScreen(),
          ),

          // ── Documents ────────────────────────────
          GoRoute(
            path: '/documents',
            name: 'documents',
            builder: (context, state) => const DocumentListScreen(),
          ),

          // ── Advances ─────────────────────────────
          GoRoute(
            path: '/advances',
            name: 'advances',
            builder: (context, state) => const AdvanceListScreen(),
          ),
          GoRoute(
            path: '/advances/new',
            name: 'advanceForm',
            builder: (context, state) => const AdvanceFormScreen(),
          ),
          GoRoute(
            path: '/advances/:id',
            name: 'advanceDetail',
            builder: (context, state) {
              final id = int.parse(state.pathParameters['id']!);
              return AdvanceDetailScreen(advanceId: id);
            },
          ),

          // ── Audit Log ────────────────────────────
          GoRoute(
            path: '/audit-log',
            name: 'auditLog',
            builder: (context, state) => const AuditLogListScreen(),
          ),
        ],
      ),
    ],
  );
});

class _DashboardWrapper extends StatelessWidget {
  const _DashboardWrapper();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Dashboard',
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
      ),
    );
  }
}
