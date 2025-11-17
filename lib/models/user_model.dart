class UserModel {
  final int? id;
  final String nombres;
  final String apellidos;
  final String correo;
  final String telefono;
  final String password;
  final String birthDate;
  final String program;
  final String rol;

  const UserModel({
    this.id,
    required this.nombres,
    required this.apellidos,
    required this.correo,
    required this.telefono,
    required this.password,
    this.birthDate = '',
    this.program = '',
    this.rol = '',
  });

  // Compatibilidad con pantallas anteriores
  String get fullName {
    if (nombres.isEmpty && apellidos.isEmpty) return '';
    if (nombres.isEmpty) return apellidos;
    if (apellidos.isEmpty) return nombres;
    return '$nombres $apellidos';
  }

  String get firstName => nombres;
  String get lastName => apellidos;
  String get email => correo;
  String get phone => telefono;

  UserModel copyWith({
    int? id,
    String? nombres,
    String? apellidos,
    String? correo,
    String? telefono,
    String? password,
    String? birthDate,
    String? program,
    String? rol,
  }) {
    return UserModel(
      id: id ?? this.id,
      nombres: nombres ?? this.nombres,
      apellidos: apellidos ?? this.apellidos,
      correo: correo ?? this.correo,
      telefono: telefono ?? this.telefono,
      password: password ?? this.password,
      birthDate: birthDate ?? this.birthDate,
      program: program ?? this.program,
      rol: rol ?? this.rol,
    );
  }

  factory UserModel.fromProfile(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as int?,
      nombres: (json['nombre'] ?? json['nombres'] ?? '') as String,
      apellidos: (json['apellido'] ?? json['apellidos'] ?? '') as String,
      correo: (json['correo'] ?? '') as String,
      telefono: (json['telefono'] ?? '') as String,
      password: (json['password'] ?? '') as String,
      birthDate: (json['fechaNacimiento'] ?? json['birthDate'] ?? '') as String,
      program: (json['programa'] ?? json['program'] ?? '') as String,
      rol: (json['rol'] ?? '') as String,
    );
  }

  factory UserModel.fromRegisterData(Map<String, dynamic> json) {
    final data = json['data'];
    if (data is Map<String, dynamic>) {
      return UserModel.fromProfile(data);
    }
    return UserModel.fromProfile(json);
  }

  Map<String, dynamic> toRegisterJson() {
    return {
      'nombre': nombres,
      'apellido': apellidos,
      'correo': correo,
      'contrasena': password,
      'telefono': telefono,
      'fechaNacimiento': birthDate,
      'genero': 'OTRO',
    };
  }
}
