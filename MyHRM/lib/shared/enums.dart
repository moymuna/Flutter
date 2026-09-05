enum AppRole {
  ADMIN,
  HR,
  MANAGER,
  EMPLOYEE,
  APPLICANT;

  String get displayName {
    switch (this) {
      case AppRole.ADMIN:
        return 'Admin';
      case AppRole.HR:
        return 'HR';
      case AppRole.MANAGER:
        return 'Manager';
      case AppRole.EMPLOYEE:
        return 'Employee';
      case AppRole.APPLICANT:
        return 'Applicant';
    }
  }

  String get apiValue => name;
}

enum EmployeeStatus {
  ACTIVE,
  ON_LEAVE,
  SUSPENDED,
  RESIGNED,
  TERMINATED;

  String get displayName {
    switch (this) {
      case EmployeeStatus.ACTIVE:
        return 'Active';
      case EmployeeStatus.ON_LEAVE:
        return 'On Leave';
      case EmployeeStatus.SUSPENDED:
        return 'Suspended';
      case EmployeeStatus.RESIGNED:
        return 'Resigned';
      case EmployeeStatus.TERMINATED:
        return 'Terminated';
    }
  }
}

enum EmploymentType {
  FULL_TIME,
  PART_TIME,
  CONTRACT,
  INTERN,
  FREELANCE;

  String get displayName {
    switch (this) {
      case EmploymentType.FULL_TIME:
        return 'Full Time';
      case EmploymentType.PART_TIME:
        return 'Part Time';
      case EmploymentType.CONTRACT:
        return 'Contract';
      case EmploymentType.INTERN:
        return 'Intern';
      case EmploymentType.FREELANCE:
        return 'Freelance';
    }
  }
}

enum Gender {
  MALE,
  FEMALE,
  OTHER;

  String get displayName {
    switch (this) {
      case Gender.MALE:
        return 'Male';
      case Gender.FEMALE:
        return 'Female';
      case Gender.OTHER:
        return 'Other';
    }
  }
}

enum AttendanceStatus {
  PRESENT,
  ABSENT,
  HALF_DAY,
  ON_LEAVE,
  HOLIDAY,
  WEEK_OFF,
  WORK_FROM_HOME;

  String get displayName {
    switch (this) {
      case AttendanceStatus.PRESENT:
        return 'Present';
      case AttendanceStatus.ABSENT:
        return 'Absent';
      case AttendanceStatus.HALF_DAY:
        return 'Half Day';
      case AttendanceStatus.ON_LEAVE:
        return 'On Leave';
      case AttendanceStatus.HOLIDAY:
        return 'Holiday';
      case AttendanceStatus.WEEK_OFF:
        return 'Week Off';
      case AttendanceStatus.WORK_FROM_HOME:
        return 'Work From Home';
    }
  }
}

enum LeaveStatus {
  PENDING,
  APPROVED,
  REJECTED,
  CANCELLED;

  String get displayName {
    switch (this) {
      case LeaveStatus.PENDING:
        return 'Pending';
      case LeaveStatus.APPROVED:
        return 'Approved';
      case LeaveStatus.REJECTED:
        return 'Rejected';
      case LeaveStatus.CANCELLED:
        return 'Cancelled';
    }
  }
}

enum LeavesType {
  CASUAL_LEAVE,
  SICK_LEAVE,
  EARNED_LEAVE,
  MATERNITY_LEAVE,
  PATERNITY_LEAVE,
  UNPAID_LEAVE,
  COMPENSATORY_LEAVE,
  STUDY_LEAVE;

  String get displayName {
    switch (this) {
      case LeavesType.CASUAL_LEAVE:
        return 'Casual Leave';
      case LeavesType.SICK_LEAVE:
        return 'Sick Leave';
      case LeavesType.EARNED_LEAVE:
        return 'Earned Leave';
      case LeavesType.MATERNITY_LEAVE:
        return 'Maternity Leave';
      case LeavesType.PATERNITY_LEAVE:
        return 'Paternity Leave';
      case LeavesType.UNPAID_LEAVE:
        return 'Unpaid Leave';
      case LeavesType.COMPENSATORY_LEAVE:
        return 'Compensatory Leave';
      case LeavesType.STUDY_LEAVE:
        return 'Study Leave';
    }
  }
}

enum PayrollStatus {
  DRAFT,
  PROCESSED,
  PAID,
  FAILED;

  String get displayName {
    switch (this) {
      case PayrollStatus.DRAFT:
        return 'Draft';
      case PayrollStatus.PROCESSED:
        return 'Processed';
      case PayrollStatus.PAID:
        return 'Paid';
      case PayrollStatus.FAILED:
        return 'Failed';
    }
  }
}

enum TrainingStatus {
  PENDING,
  APPROVED,
  REJECTED;

  String get displayName {
    switch (this) {
      case TrainingStatus.PENDING:
        return 'Pending';
      case TrainingStatus.APPROVED:
        return 'Approved';
      case TrainingStatus.REJECTED:
        return 'Rejected';
    }
  }
}

enum ReviewStatus {
  PENDING,
  IN_PROGRESS,
  COMPLETED,
  ACKNOWLEDGED;

  String get displayName {
    switch (this) {
      case ReviewStatus.PENDING:
        return 'Pending';
      case ReviewStatus.IN_PROGRESS:
        return 'In Progress';
      case ReviewStatus.COMPLETED:
        return 'Completed';
      case ReviewStatus.ACKNOWLEDGED:
        return 'Acknowledged';
    }
  }
}

enum ApplicationStatus {
  APPLIED,
  UNDER_REVIEW,
  SHORTLISTED,
  INTERVIEW_SCHEDULED,
  INTERVIEWED,
  ON_HOLD,
  SELECTED,
  REJECTED,
  WITHDRAWN,
  HIRED;

  String get displayName {
    switch (this) {
      case ApplicationStatus.APPLIED:
        return 'Applied';
      case ApplicationStatus.UNDER_REVIEW:
        return 'Under Review';
      case ApplicationStatus.SHORTLISTED:
        return 'Shortlisted';
      case ApplicationStatus.INTERVIEW_SCHEDULED:
        return 'Interview Scheduled';
      case ApplicationStatus.INTERVIEWED:
        return 'Interviewed';
      case ApplicationStatus.ON_HOLD:
        return 'On Hold';
      case ApplicationStatus.SELECTED:
        return 'Selected';
      case ApplicationStatus.REJECTED:
        return 'Rejected';
      case ApplicationStatus.WITHDRAWN:
        return 'Withdrawn';
      case ApplicationStatus.HIRED:
        return 'Hired';
    }
  }
}

enum InterviewType {
  IN_PERSON,
  PHONE,
  VIDEO;

  String get displayName {
    switch (this) {
      case InterviewType.IN_PERSON:
        return 'In Person';
      case InterviewType.PHONE:
        return 'Phone';
      case InterviewType.VIDEO:
        return 'Video';
    }
  }
}

enum InterviewStatus {
  PASS,
  FAIL,
  PENDING;

  String get displayName {
    switch (this) {
      case InterviewStatus.PASS:
        return 'Pass';
      case InterviewStatus.FAIL:
        return 'Fail';
      case InterviewStatus.PENDING:
        return 'Pending';
    }
  }
}

enum InterviewStage {
  SCHEDULED,
  COMPLETED,
  CANCELLED;

  String get displayName {
    switch (this) {
      case InterviewStage.SCHEDULED:
        return 'Scheduled';
      case InterviewStage.COMPLETED:
        return 'Completed';
      case InterviewStage.CANCELLED:
        return 'Cancelled';
    }
  }
}

enum DocumentType {
  RESUME,
  ID_PROOF,
  OFFER_LETTER,
  CONTRACT,
  CERTIFICATE,
  OTHER;

  String get displayName {
    switch (this) {
      case DocumentType.RESUME:
        return 'Resume';
      case DocumentType.ID_PROOF:
        return 'ID Proof';
      case DocumentType.OFFER_LETTER:
        return 'Offer Letter';
      case DocumentType.CONTRACT:
        return 'Contract';
      case DocumentType.CERTIFICATE:
        return 'Certificate';
      case DocumentType.OTHER:
        return 'Other';
    }
  }
}

enum ApplicantDocumentType {
  CV,
  NID,
  PHOTO,
  CERTIFICATE,
  COVER_LETTER,
  OTHER;

  String get displayName {
    switch (this) {
      case ApplicantDocumentType.CV:
        return 'CV';
      case ApplicantDocumentType.NID:
        return 'NID';
      case ApplicantDocumentType.PHOTO:
        return 'Photo';
      case ApplicantDocumentType.CERTIFICATE:
        return 'Certificate';
      case ApplicantDocumentType.COVER_LETTER:
        return 'Cover Letter';
      case ApplicantDocumentType.OTHER:
        return 'Other';
    }
  }
}

enum VerificationStatus {
  PENDING,
  VERIFIED,
  REJECTED;

  String get displayName {
    switch (this) {
      case VerificationStatus.PENDING:
        return 'Pending';
      case VerificationStatus.VERIFIED:
        return 'Verified';
      case VerificationStatus.REJECTED:
        return 'Rejected';
    }
  }
}

enum EducationLevel {
  SSC,
  HSC,
  BACHELORS,
  MASTERS,
  PHD;

  String get displayName {
    switch (this) {
      case EducationLevel.SSC:
        return 'SSC';
      case EducationLevel.HSC:
        return 'HSC';
      case EducationLevel.BACHELORS:
        return 'Bachelors';
      case EducationLevel.MASTERS:
        return 'Masters';
      case EducationLevel.PHD:
        return 'PhD';
    }
  }
}

enum ExperienceLevel {
  FRESHER,
  JUNIOR,
  MID,
  SENIOR;

  String get displayName {
    switch (this) {
      case ExperienceLevel.FRESHER:
        return 'Fresher';
      case ExperienceLevel.JUNIOR:
        return 'Junior';
      case ExperienceLevel.MID:
        return 'Mid';
      case ExperienceLevel.SENIOR:
        return 'Senior';
    }
  }
}

enum JobStatus {
  OPEN,
  CLOSED,
  DRAFT;

  String get displayName {
    switch (this) {
      case JobStatus.OPEN:
        return 'Open';
      case JobStatus.CLOSED:
        return 'Closed';
      case JobStatus.DRAFT:
        return 'Draft';
    }
  }
}

enum AdvanceStatus {
  PENDING,
  APPROVED,
  REJECTED,
  PAID,
  SETTLED;

  String get displayName {
    switch (this) {
      case AdvanceStatus.PENDING:
        return 'Pending';
      case AdvanceStatus.APPROVED:
        return 'Approved';
      case AdvanceStatus.REJECTED:
        return 'Rejected';
      case AdvanceStatus.PAID:
        return 'Paid';
      case AdvanceStatus.SETTLED:
        return 'Settled';
    }
  }
}

enum EmailStatus {
  PENDING,
  SENT,
  FAILED;

  String get displayName {
    switch (this) {
      case EmailStatus.PENDING:
        return 'Pending';
      case EmailStatus.SENT:
        return 'Sent';
      case EmailStatus.FAILED:
        return 'Failed';
    }
  }
}
