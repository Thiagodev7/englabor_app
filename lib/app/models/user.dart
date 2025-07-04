// lib/app/models/user.dart
class User {
  final int    id;
  final String nome;
  final String cpf;
  final String email;
  final String telefone;
  final String role;

  User({
    required this.id,
    required this.nome,
    required this.cpf,
    required this.email,
    required this.telefone,
    required this.role,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id:       json['id'] as int,
      nome:     json['nome'] as String,
      cpf:      json['cpf'] as String,
      email:    json['email'] as String,
      telefone: (json['telefone'] as String?) ?? '',
      role:     json['role'] as String,
    );
  }
}