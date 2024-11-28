enum UserRole {
  professor,
  student;

  bool get isProfessor => this == UserRole.professor;
  bool get isStudent => this == UserRole.student;
}
