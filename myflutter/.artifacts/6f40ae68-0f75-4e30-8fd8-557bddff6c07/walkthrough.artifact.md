# HRM System Flutter Implementation Walkthrough

I have successfully implemented the core features of the HRM System in Flutter, integrating with your Spring Boot backend.

## Changes Summary

### 1. Core Infrastructure & Models
- **Enums**: Created `Role`, `EmployeeStatus`, `EmploymentType`, and `Gender` enums to match backend definitions.
- **Models**: Implemented `AuthResponse`, `UserResponse`, `EmployeeResponse`, and `AddressResponse` with JSON parsing.
- **Services**:
    - `ApiService`: A robust base client for handling JWT authentication headers and HTTP requests.
    - `AuthService`: Handles login, signup, and token persistence.
    - `EmployeeService`: Fetches employee lists and dashboard statistics.
- **State Management**: Integrated `Provider` with `AuthProvider` to manage user sessions across the app.

### 2. User Interface
- **Authentication**:
    - **Login Screen**: Secure login with email/password validation.
    - **Registration Screen**: Allows users to sign up with different roles.
- **Main App**:
    - **Dashboard**: Features summary cards for total employee count and department-wise headcount breakdown.
    - **Navigation Drawer**: Provides easy access to different modules and includes a logout feature.
    - **Employee List**: A dynamic list fetching real-time data from the backend.
- **Employee Management**:
    - **Employee Form**: A comprehensive form with metadata-driven dropdowns (Departments, etc.) and image upload support via `image_picker`.
    - **Employee Details**: A professional profile view showing all employee information, including their role and location.

### 3. Advanced Backend Integration
- **Multipart Uploads**: Upgraded `ApiService` to handle `http.MultipartRequest`, enabling the app to upload employee profile pictures directly to the Spring Boot server.
- **Metadata Management**: Implemented `MetadataService` to fetch dynamic lists of departments, designations, offices, and leave types.

### 4. Attendance & Leave Management
- **Today's Attendance Widget**: A new dashboard widget that allows employees to Clock In and Clock Out. It displays their check-in time and status in real-time.
- **Attendance History**: A monthly calendar-style view where employees can see their past attendance, worked hours, and monthly summaries (present/absent days).
- **Leave Application**: A user-friendly form to apply for leave with type selection, date picking, and reason validation.
- **Leave History**: A list for employees to track the status of their leave requests (Pending, Approved, Rejected).
- **Leave Approvals (Admin)**: A dedicated management interface for HR and Managers to review, approve, or reject pending leave requests from other employees.

### 5. Payroll & Salary Module
- **My Salary Structure**: Employees can view their detailed salary breakdown, including basic salary, house rent, and other allowances.
- **Payroll History**: A complete log of past payments, showing net salary paid and payment status for each month.
- **Payroll Management (Admin)**: An administrative dashboard for HR to generate monthly payroll for all employees and mark individual payments as "PAID" once processed.

### 6. Notice Board & Notifications
- **Notice Board Feed**: A company-wide announcement system where employees can view the latest updates. HR and Admins have the ability to post and delete notices directly from the app.
- **Notification Center**: A personalized inbox for alerts related to HRM events (e.g., leave approvals, salary generation).
- **Real-time Indicators**: Integrated a notification badge in the app bar that displays the current count of unread notifications, ensuring employees never miss important updates.

### 7. Code Quality & Stability
- **Zero Static Analysis Issues**: Resolved all 50+ issues identified by `flutter analyze`, including naming conventions, deprecations, and potential runtime errors.
- **Modern Standards**: Updated code to use the latest Flutter best practices (e.g., `initialValue` for form fields, `withValues` for colors).
- **Environment Preparedness**: Identified and provided solutions for platform-specific build issues (like symlink support on Windows).

## How to Test

1. **Backend Connection**: Ensure your Spring Boot backend is running on `http://localhost:8080`.
    - If using an Android Emulator, the app is configured to use `10.0.2.2` which maps to your host's localhost.
2. **Login**: Use an existing user from your database or register a new one using the Registration screen.
3. **Dashboard**: Once logged in, you should see the total number of employees and a list of departments with their headcounts.

> [!NOTE]
> The base URL is currently set to `http://10.0.2.2:8080/api` in `lib/services/api_service.dart`. If you are testing on a physical device or a different environment, you may need to update this URL.

## Next Steps
- Implement **Employee Details** and **Edit/Add Employee** forms.
- Integrate **Attendance** and **Leave Management** modules.
- Add **Payroll** and **Notice Board** features.
