class User {
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final String birthDate;
  final String program;
  final String phone;

  const User({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.birthDate,
    this.program = '',
    this.phone = '',
  });

  String get fullName {
    if (firstName.isEmpty && lastName.isEmpty) {
      return '';
    }
    if (firstName.isEmpty) return lastName;
    if (lastName.isEmpty) return firstName;
    return '$firstName $lastName';
  }

  User copyWith({
    String? firstName,
    String? lastName,
    String? email,
    String? password,
    String? birthDate,
    String? program,
    String? phone,
  }) {
    return User(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      password: password ?? this.password,
      birthDate: birthDate ?? this.birthDate,
      program: program ?? this.program,
      phone: phone ?? this.phone,
    );
  }
}
