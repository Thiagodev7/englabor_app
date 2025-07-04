// lib/app/models/company.dart
class Company {
  final int id;
  final String nome;
  final String cnpj;

  Company({required this.id, required this.nome, required this.cnpj});

  factory Company.fromJson(Map<String, dynamic> json) {
    return Company(
      id:   json['id']   as int,
      nome: json['nome'] as String,
      cnpj: json['cnpj'] as String,
    );
  }
}