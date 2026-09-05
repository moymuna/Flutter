class ApiConstants {
  ApiConstants._();

  static const String baseUrl = 'http://localhost:8085/api/';
  static const String imgUrl = 'http://10.0.2.2:8085/images/';

  // ── Auth ─────────────────────────────────────────────
  static const String login = 'auth/login';
  static const String register = 'auth/signup';
  static const String registerApplicant = 'auth/register-applicant';
  static const String refreshToken = 'auth/refresh-token';
  static const String logout = 'auth/logout';
  static const String verifyEmail = 'auth/verify-email';
  static const String sendVerification = 'auth/send-verification';
  static const String forgotPassword = 'auth/forgot-password';
  static const String resetPassword = 'auth/reset-password';

  // ── User ─────────────────────────────────────────────
  static const String user = 'user';
  static String userById(int id) => 'user/$id';
  static String userByEmail(String email) => 'user/email/$email';
  static String userRole(int id) => 'user/$id/role';
  static String userActivate(int id) => 'user/$id/activate';
  static String userDeactivate(int id) => 'user/$id/deactivate';
  static String userResetPassword(int id) => 'user/$id/reset-password';
  static String userChangePassword(int id) => 'user/$id/change-password';

  // ── Employee ─────────────────────────────────────────
  static const String employees = 'employees';
  static String employeeById(int id) => 'employees/$id';
  static String employeeByCode(String code) => 'employees/code/$code';
  static String employeeByEmail(String email) => 'employees/email/$email';
  static String employeeByUserId(int userId) => 'employees/user/$userId';
  static String employeesByDepartment(int id) => 'employees/department/$id';
  static String employeesByDesignation(int id) =>
      'employees/designation/$id';
  static String employeesByOffice(int id) => 'employees/office/$id';
  static String employeesByManager(int id) => 'employees/manager/$id';
  static String employeesByStatus(String status) =>
      'employees/status/$status';
  static String employeesByType(String type) =>
      'employees/employment-type/$type';
  static String employeesByGender(String gender) =>
      'employees/gender/$gender';
  static String employeeSearch(String keyword) =>
      'employees/search?keyword=$keyword';
  static const String employeeCount = 'employees/count';
  static const String employeeCountActive = 'employees/count/active';
  static const String employeeCountInactive = 'employees/count/inactive';
  static const String employeeStatsByDept = 'employees/stats/by-department';
  static String employeePage(int page, int size) =>
      'employees/page?page=$page&size=$size';
  static String employeeHire(int applicationId) =>
      'employees/hire/$applicationId';

  // ── Department ───────────────────────────────────────
  static const String departments = 'department';
  static String departmentById(int id) => 'department/$id';
  static String departmentEmployees(int id) => 'department/$id/employees';
  static String departmentByName(String name) => 'department/name/$name';
  static String departmentByCode(String code) => 'department/code/$code';
  static String departmentSearch(String keyword) =>
      'department/search?keyword=$keyword';
  static const String departmentCount = 'department/count';
  static String departmentPage(int page, int size) =>
      'department/page?page=$page&size=$size';

  // ── Designation ──────────────────────────────────────
  static const String designations = 'designation';
  static String designationById(int id) => 'designation/$id';
  static String designationsByDepartment(int id) =>
      'designation/department/$id';
  static String designationSearch(String keyword) =>
      'designation/search?keyword=$keyword';
  static const String designationCount = 'designation/count';
  static String designationPage(int page, int size) =>
      'designation/page?page=$page&size=$size';

  // ── Office ───────────────────────────────────────────
  static const String offices = 'office';
  static String officeById(int id) => 'office/$id';
  static String officeSearch(String keyword) =>
      'office/search?keyword=$keyword';
  static const String officeCount = 'office/count';
  static String officePage(int page, int size) =>
      'office/page?page=$page&size=$size';

  // ── Applicant ────────────────────────────────────────
  static const String applicants = 'applicants';
  static String applicantById(int id) => 'applicants/$id';
  static String applicantByEmail(String email) =>
      'applicants/email/$email';
  static String applicantSearch(String keyword) =>
      'applicants/search?keyword=$keyword';
  static const String applicantCount = 'applicants/count';
  static String applicantPage(int page, int size) =>
      'applicants/page?page=$page&size=$size';

  // ── Applicant Document ───────────────────────────────
  static const String applicantDocuments = 'applicant-documents';
  static String applicantDocumentById(int id) =>
      'applicant-documents/$id';
  static String applicantDocumentsByApplicant(int id) =>
      'applicant-documents/applicant/$id';
  static String applicantDocumentVerify(int id) =>
      'applicant-documents/$id/verify';
  static String applicantDocumentReject(int id) =>
      'applicant-documents/$id/reject';

  // ── Application ──────────────────────────────────────
  static const String applications = 'applications';
  static const String applicationApply = 'applications/apply';
  static String applicationById(int id) => 'applications/$id';
  static String applicationsByApplicant(int id) =>
      'applications/applicant/$id';
  static String applicationsByJobPost(int id) =>
      'applications/job/$id';
  static String applicationsByStatus(String status) =>
      'applications/status/$status';
  static String applicationStatus(int id) =>
      'applications/$id/status';
  static String applicationWithdraw(int id) =>
      'applications/$id/withdraw';
  static String applicationSearch(String keyword) =>
      'applications/search?keyword=$keyword';
  static const String applicationCount = 'applications/count';
  static String applicationPage(int page, int size) =>
      'applications/page?page=$page&size=$size';

  // ── Job Post ─────────────────────────────────────────
  static const String jobPosts = 'job-posts';
  static String jobPostById(int id) => 'job-posts/$id';
  static String jobPostsByStatus(String status) =>
      'job-posts/status/$status';
  static String jobPostsByDepartment(int id) =>
      'job-posts/department/$id';
  static String jobPostSearch(String keyword) =>
      'job-posts/search?keyword=$keyword';
  static const String jobPostCount = 'job-posts/count';
  static String jobPostPage(int page, int size) =>
      'job-posts/page?page=$page&size=$size';

  // ── Attendance ───────────────────────────────────────
  static const String attendance = 'attendance';
  static const String attendanceSave = 'attendance/save';
  static String attendanceById(int id) => 'attendance/$id';
  static const String attendanceAll = 'attendance/all';
  static String attendanceUpdate(int id) => 'attendance/update/$id';
  static String attendanceDelete(int id) => 'attendance/delete/$id';
  static String attendanceClockIn(int employeeId) =>
      'attendance/clock-in/$employeeId';
  static String attendanceClockOut(int employeeId) =>
      'attendance/clock-out/$employeeId';
  static String attendanceToday(int employeeId) =>
      'attendance/today/$employeeId';
  static String attendanceByEmployee(int employeeId, int year, int month) =>
      'attendance/employee/$employeeId?year=$year&month=$month';
  static const String attendanceStatsToday = 'attendance/stats/today';
  static String attendanceSummary(int employeeId, int year, int month) =>
      'attendance/employee/$employeeId/summary?year=$year&month=$month';
  static String attendanceSearch(String keyword) =>
      'attendance/search?keyword=$keyword';
  static const String attendanceCount = 'attendance/count';
  static String attendancePage(int page, int size) =>
      'attendance/page?page=$page&size=$size';

  // ── Leave ────────────────────────────────────────────
  static const String leaves = 'leaves';
  static const String leavesSave = 'leaves/save';
  static String leaveById(int id) => 'leaves/$id';
  static const String leavesAll = 'leaves/all';
  static String leaveUpdate(int id) => 'leaves/update/$id';
  static String leaveDelete(int id) => 'leaves/delete/$id';
  static String leavesByEmployee(int id) => 'leaves/employee/$id';
  static String leavesByStatus(String status) => 'leaves/status/$status';
  static String leavesBetween(String start, String end) =>
      'leaves/between?startDate=$start&endDate=$end';
  static String leaveApprove(int id) => 'leaves/approve/$id';
  static String leaveReject(int id) => 'leaves/reject/$id';
  static String leaveCancel(int id) => 'leaves/cancel/$id';
  static String leaveSearch(String keyword) =>
      'leaves/search?keyword=$keyword';
  static const String leaveCount = 'leaves/count';
  static String leavePage(int page, int size) =>
      'leaves/page?page=$page&size=$size';

  // ── Leave Type ───────────────────────────────────────
  static const String leaveTypes = 'leave-types';
  static String leaveTypeById(int id) => 'leave-types/$id';
  static const String leaveTypesAll = 'leave-types/all';
  static String leaveTypeUpdate(int id) => 'leave-types/update/$id';
  static String leaveTypeDelete(int id) => 'leave-types/delete/$id';
  static String leaveTypeByName(String name) => 'leave-types/name/$name';

  // ── Leave Balance ────────────────────────────────────
  static const String leaveBalance = 'leave-balance';
  static String leaveBalanceById(int id) => 'leave-balance/$id';
  static const String leaveBalanceAll = 'leave-balance/all';
  static String leaveBalanceUpdate(int id) => 'leave-balance/update/$id';
  static String leaveBalanceDelete(int id) => 'leave-balance/delete/$id';
  static String leaveBalanceByEmployee(int id) =>
      'leave-balance/employee/$id';
  static String leaveBalanceByLeaveType(int id) =>
      'leave-balance/leave-type/$id';
  static String leaveBalanceByYear(int year) =>
      'leave-balance/year/$year';
  static String leaveBalanceDetail(int empId, int ltId, int year) =>
      'leave-balance/employee/$empId/leave-type/$ltId/year/$year';
  static String leaveBalanceAccrue(int year) =>
      'leave-balance/accrue/$year';
  static String leaveBalanceStats(int year) =>
      'leave-balance/stats/utilization?year=$year';

  // ── Holiday ──────────────────────────────────────────
  static const String holidays = 'holiday';
  static String holidayById(int id) => 'holiday/$id';
  static const String holidaysAll = 'holiday/all';
  static String holidayUpdate(int id) => 'holiday/update/$id';
  static String holidayDelete(int id) => 'holiday/delete/$id';
  static String holidayUpcoming(int limit) => 'holiday/upcoming?limit=$limit';
  static String holidayByName(String name) => 'holiday/name/$name';
  static String holidayByDate(String date) => 'holiday/date/$date';

  // ── Salary ───────────────────────────────────────────
  static const String salaries = 'salary';
  static String salaryById(int id) => 'salary/$id';
  static String salaryByEmployee(int id) => 'salary/employee/$id';
  static String salaryHistoryByEmployee(int id) =>
      'salary/employee/$id/history';

  // ── Salary Grade ─────────────────────────────────────
  static const String salaryGrades = 'salary-grades';
  static String salaryGradeById(int id) => 'salary-grades/$id';
  static const String salaryGradesActive = 'salary-grades/active';
  static String salaryGradeByNumber(int num) =>
      'salary-grades/number/$num';

  // ── Payroll ──────────────────────────────────────────
  static const String payrolls = 'payroll';
  static String payrollById(int id) => 'payroll/$id';
  static String payrollByEmployee(int id) => 'payroll/employee/$id';
  static String payrollSheet(int year, int month) =>
      'payroll/sheet?year=$year&month=$month';
  static String payrollPay(int id) => 'payroll/$id/pay';
  static String payrollGenerate(int empId, int year, int month) =>
      'payroll/generate/$empId/$year/$month';
  static String payrollGenerateAll(int year, int month) =>
      'payroll/generate-all/$year/$month';
  static String payrollMonthlyCost(int year) =>
      'payroll/stats/monthly-cost?year=$year';
  static String payrollSearch(String keyword) =>
      'payroll/search?keyword=$keyword';
  static const String payrollCount = 'payroll/count';
  static String payrollPage(int page, int size) =>
      'payroll/page?page=$page&size=$size';

  // ── Payslip ──────────────────────────────────────────
  static const String payslips = 'payslip';
  static String payslipById(int id) => 'payslip/$id';
  static String payslipByEmployee(int id) => 'payslip/employee/$id';

  // ── Training ─────────────────────────────────────────
  static const String trainings = 'training';
  static String trainingById(int id) => 'training/$id';
  static String trainingApprove(int id) => 'training/$id/approve';
  static String trainingReject(int id) => 'training/$id/reject';
  static String trainingApply(int id, int empId) =>
      'training/$id/apply?employeeId=$empId';

  // ── Project ──────────────────────────────────────────
  static const String projects = 'project';
  static String projectById(int id) => 'project/$id';
  static String projectsByEmployee(int id) =>
      'project/employee/$id/projects';

  // ── Performance Review ───────────────────────────────
  static const String performanceReviews = 'performancereview';
  static String performanceReviewById(int id) => 'performancereview/$id';

  // ── Interview ────────────────────────────────────────
  static const String interviews = 'interviews';
  static const String interviewSchedule = 'interviews/schedule';
  static String interviewById(int id) => 'interviews/$id';
  static String interviewsByApplication(int id) =>
      'interviews/application/$id';
  static const String interviewsMy = 'interviews/my';
  static String interviewBoard(int id) => 'interviews/$id/board';
  static const String interviewBoardMemberMine =
      'interviews/board-member/mine';
  static String interviewsByInterviewer(int id) =>
      'interviews/interviewer/$id';

  // ── Interview Evaluation ─────────────────────────────
  static String interviewEvaluations(int interviewId) =>
      'interviews/$interviewId/evaluations';

  // ── Notice ───────────────────────────────────────────
  static const String notices = 'notice';
  static String noticeById(int id) => 'notice/$id';

  // ── Notification ─────────────────────────────────────
  static const String notifications = 'notifications';
  static const String notificationsMine = 'notifications/mine';
  static const String notificationsUnreadCount =
      'notifications/mine/unread-count';
  static String notificationRead(int id) => 'notifications/$id/read';

  // ── Document ─────────────────────────────────────────
  static const String documents = 'document';
  static String documentById(int id) => 'document/$id';
  static String documentsByEmployee(int id) => 'document/employee/$id';

  // ── Audit Log ────────────────────────────────────────
  static const String auditLog = 'audit-log';
  static String auditLogPage(int page, int size) =>
      'audit-log/page?page=$page&size=$size';
  static const String auditLogLatest = 'audit-log/latest';
  static String auditLogByEntity(String type, int id) =>
      'audit-log/entity/$type/$id';

  // ── Advance ──────────────────────────────────────────
  static const String advances = 'advances';
  static const String advancesSave = 'advances/save';
  static String advanceById(int id) => 'advances/$id';
  static const String advancesAll = 'advances/all';
  static String advancesByEmployee(int id) => 'advances/employee/$id';
  static String advancesByStatus(String status) =>
      'advances/status/$status';
  static String advanceUpdate(int id) => 'advances/update/$id';
  static String advanceDelete(int id) => 'advances/delete/$id';
  static String advanceApprove(int id) => 'advances/approve/$id';
  static String advanceReject(int id) => 'advances/reject/$id';
  static String advancePay(int id) => 'advances/pay/$id';
  static String advanceRecover(int id, double amount) =>
      'advances/recover/$id?amount=$amount';
  static String advanceSearch(String keyword) =>
      'advances/search?keyword=$keyword';
  static const String advanceCount = 'advances/count';
  static const String advanceCountPending = 'advances/count/pending';
  static String advancePage(int page, int size) =>
      'advances/page?page=$page&size=$size';

  // ── Address ──────────────────────────────────────────
  static const String addresses = 'addresses';
  static String addressById(int id) => 'addresses/$id';

  // ── Country ──────────────────────────────────────────
  static const String countries = 'country';
  static String countryById(int id) => 'country/$id';
  static const String countriesAll = 'country/all';
  static String countryUpdate(int id) => 'country/update/$id';
  static String countryDelete(int id) => 'country/delete/$id';
  static String countryByName(String name) => 'country/name/$name';

  // ── Division ─────────────────────────────────────────
  static const String divisions = 'division';
  static String divisionById(int id) => 'division/$id';
  static String divisionsByCountry(int id) => 'division/country/$id';
  static String divisionUpdate(int id) => 'division/$id';
  static String divisionDelete(int id) => 'division/$id';
  static String divisionsByCountryName(String name) =>
      'division/country/name/$name';

  // ── District ─────────────────────────────────────────
  static const String districts = 'district';
  static String districtById(int id) => 'district/$id';
  static String districtsByDivision(int id) => 'district/division/$id';
  static String districtUpdate(int id) => 'district/$id';
  static String districtDelete(int id) => 'district/$id';
  static String districtsByDivisionName(String name) =>
      'district/division-name/$name';

  // ── Police Station ───────────────────────────────────
  static const String policeStations = 'policeStation';
  static String policeStationById(int id) => 'policeStation/$id';
  static String policeStationsByDistrict(int id) =>
      'policeStation/district/$id';
  static String policeStationUpdate(int id) => 'policeStation/$id';
  static String policeStationDelete(int id) => 'policeStation/$id';
  static String policeStationsByDistrictName(String name) =>
      'policeStation/district/name/$name';

  // ── Upload ───────────────────────────────────────────
  static const String upload = 'upload';
}
