// lib/app/modules/equipamentos/models/equipamento.dart

class Equipamento {
  final int? id;
  final String tipo;
  final String marca;
  final String modelo;
  final String numeroSerie;
  final DateTime dataUltimaCalibracao;
  final String numeroCertificado;
  final DateTime dataVencimento;

  Equipamento({
    this.id,
    required this.tipo,
    required this.marca,
    required this.modelo,
    required this.numeroSerie,
    required this.dataUltimaCalibracao,
    required this.numeroCertificado,
    required this.dataVencimento,
  });

  factory Equipamento.fromJson(Map<String, dynamic> json) {
    return Equipamento(
      id: json['id'] as int?,
      tipo: json['tipo'] as String,
      marca: json['marca'] as String,
      modelo: json['modelo'] as String,
      numeroSerie: json['numero_serie'] as String? ?? '',
      dataUltimaCalibracao: DateTime.parse(json['data_ultima_calibracao'] as String),
      numeroCertificado: json['numero_certificado'] as String? ?? '',
      dataVencimento: DateTime.parse(json['data_vencimento'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'tipo': tipo,
      'marca': marca,
      'modelo': modelo,
      'numero_serie': numeroSerie,
      'data_ultima_calibracao': dataUltimaCalibracao.toIso8601String(),
      'numero_certificado': numeroCertificado,
      'data_vencimento': dataVencimento.toIso8601String(),
    };
  }

  @override
  String toString() {
    return 'Equipamento(id: $id, tipo: $tipo, marca: $marca, modelo: $modelo)';
  }
}