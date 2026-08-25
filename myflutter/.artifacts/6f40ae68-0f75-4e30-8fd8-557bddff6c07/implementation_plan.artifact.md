# HRM System Flutter Implementation Plan

This plan outlines the steps to implement the features from the Spring Boot HRM backend into the Flutter application.

## User Review Required

> [!IMPORTANT]
> The backend contains a large number of features. I will focus on the core modules first: Authentication, Employee Management, and Dashboard. Other modules (Leave, Attendance, Payroll, etc.) will be added sequentially.

> [!WARNING]
> You will need to provide the base URL for the backend API. For now, I will use a placeholder (e.g., `http://localhost:8080/api`).

## Proposed Changes

### Core Infrastructure

#### [MODIFY] [pubspec.yaml](file:///F:/JEE69 Course/FLUTTER/Flutter/myflutter/pubspec.yaml)
- Add dependencies: `http`, `shared_preferences`, `intl`, `provider`, `image_picker`, `http_parser`.

#### [NEW] [api_service.dart](file:///F:/JEE69 Course/FLUTTER/Flutter/myflutter/lib/services/api_service.dart)
- Base class for handling HTTP requests, headers (JWT token), and multipart requests for image uploads.

#### [NEW] [auth_service.dart](file:///F:/JEE69 Course/FLUTTER/Flutter/myflutter/lib/services/auth_service.dart)
- Methods for login, signup, logout, and token refresh.

#### [NEW] [auth_provider.dart](file:///F:/JEE69 Course/FLUTTER/Flutter/myflutter/lib/providers/auth_provider.dart)
- State management for user authentication status and profile.

### Models

#### [NEW] [user_model.dart](file:///F:/JEE69 Course/FLUTTER/Flutter/myflutter/lib/models/user_model.dart)
- Dart representation of `UserResponseDto` and `AuthResponse`.

#### [NEW] [employee_model.dart](file:///F:/JEE69 Course/FLUTTER/Flutter/myflutter/lib/models/employee_model.dart)
- Dart representation of `EmployeeResponseDto`.

### UI Modules

#### 1. Authentication Module
- **Login Screen**: Email and password fields with validation.
- **Signup Screen**: Fields for name, email, password, and role selection.

#### 2. Dashboard Module
- **Dashboard Screen**: Summary cards for employee counts, department headcount, etc.
- **Attendance Widget**: Quick clock-in/out buttons and today's status.

#### 3. Employee Module
- **Employee List**: Scrollable list of employees with search and filter functionality.
- **Employee Details**: Detailed view of an employee's profile including address and bank info.
- **Add/Edit Employee**: A comprehensive multi-step form to create or update employee records, including dropdowns for Departments, Designations, and Offices.

#### 4. Attendance & Leave Module
- **Attendance Page**: View monthly attendance history and summaries.
- **Leave Application**: Form to request leave with type selection (Sick, Casual, etc.).
- **Leave Status**: List of applied leaves with their current status (Pending, Approved, Rejected).
- **Leave Management (Admin)**: List for HR/Managers to approve or reject leave requests.

#### 5. Payroll & Salary Module
- **Salary Structure**: Detailed view of the employee's salary breakdown.
- **Payroll History**: List of past monthly payments and their status.
- **Payroll Management (Admin)**: Generate and process payroll for all employees.

#### 6. Notice Board & Notifications
- **Notice Board**: A feed of company-wide announcements.
- **Notice Management (Admin)**: Interface for HR/Admin to post and manage notices.
- **Notification Center**: A list of personal notifications (e.g., leave approval, payroll generation).
- **Notification Badge**: Real-time unread count indicator on the dashboard/drawer.

### New Models & Services

#### [NEW] [Metadata Models](file:///F:/JEE69 Course/FLUTTER/Flutter/myflutter/lib/models/metadata_models.dart)
- `Department`, `Designation`, `Office`, and `LeaveType` models.

#### [NEW] [Attendance & Leave Models](file:///F:/JEE69 Course/FLUTTER/Flutter/myflutter/lib/models/hrm_models.dart)
- `AttendanceResponse`, `AttendanceSummary`, `LeaveResponse` models.

#### [NEW] [Metadata Services](file:///F:/JEE69 Course/FLUTTER/Flutter/myflutter/lib/services/metadata_service.dart)
- Services to fetch lists of departments, designations, offices, and leave types.

#### [NEW] [Attendance Service](file:///F:/JEE69 Course/FLUTTER/Flutter/myflutter/lib/services/attendance_service.dart)
- Methods for clock-in/out, fetching today's status, and monthly history.

#### [NEW] [Leave Service](file:///F:/JEE69 Course/FLUTTER/Flutter/myflutter/lib/services/leave_service.dart)
- Methods for applying for leave, checking status, and (for admins) approving/rejecting requests.

#### [NEW] [Notice & Notification Models](file:///F:/JEE69 Course/FLUTTER/Flutter/myflutter/lib/models/communication_models.dart)
- `NoticeResponse` and `NotificationResponse` models.

#### [NEW] [Notice Service](file:///F:/JEE69 Course/FLUTTER/Flutter/myflutter/lib/services/notice_service.dart)
- CRUD operations for notices.

#### [NEW] [Notification Service](file:///F:/JEE69 Course/FLUTTER/Flutter/myflutter/lib/services/notification_service.dart)
- Fetch user notifications and manage read status.

### Navigation

#### [MODIFY] [main.dart](file:///F:/JEE69 Course/FLUTTER/Flutter/myflutter/lib/main.dart)
- Set up `MaterialApp` with `MultiProvider` and initial route based on auth status.

## Verification Plan

### Automated Tests
- Unit tests for API services and model parsing.
- Integration tests for the login flow.

### Manual Verification
- Test login with valid/invalid credentials.
- Verify that employee data is correctly fetched and displayed from the backend.
- Test CRUD operations for employees.
