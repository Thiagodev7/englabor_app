class Funcionario {
  final int id;
  final int? empresaId;
  final String setor;
  final String ghe;
  final String cargo;
  final String matricula;
  final String nome;
  final String medicaoStatus; // <-- novo campo

  Funcionario({
    required this.id,
    this.empresaId,
    required this.setor,
    required this.ghe,
    required this.cargo,
    required this.matricula,
    required this.nome,
    required this.medicaoStatus,
  });

  factory Funcionario.fromJson(Map<String, dynamic> json) => Funcionario(
        id: json['id'] as int,
        empresaId: json['empresa_id'] as int?,
        setor: json['setor'] as String? ?? '',
        ghe: json['ghe'] as String? ?? '',
        cargo: json['cargo'] as String? ?? '',
        matricula: json['matricula'] as String? ?? '',
        nome: json['nome'] as String? ?? '',
        medicaoStatus: json['medicao_status'] as String? ?? 'NENHUMA',
      );
}