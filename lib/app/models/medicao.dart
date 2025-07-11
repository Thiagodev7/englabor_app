// lib/app/modules/medicoes/models/medicao.dart

class Medicao {
  final int? id;
  final int funcionarioId;
  final int? equipamentoId;
  final int avaliadorId;
  final String status;
  final DateTime? dataMedicao;
  final String? horaInicio;
  final String? horaFim;
  final String? tempoMostragem;
  final double? nenQ5;
  final double? lavgQ5;
  final double? nenQ3;
  final double? lavgQ3;
  final double? calibracaoInicial;
  final double? calibracaoFinal;
  final double? desvio;
  final String? tempoPausa;
  final String? inicioPausa;
  final String? finalPausa;
  final String? jornadaTrabalho;
  final String? observacao;

  Medicao({
    this.id,
    required this.funcionarioId,
    this.equipamentoId,
    required this.avaliadorId,
    required this.status,
    this.dataMedicao,
    this.horaInicio,
    this.horaFim,
    this.tempoMostragem,
    this.nenQ5,
    this.lavgQ5,
    this.nenQ3,
    this.lavgQ3,
    this.calibracaoInicial,
    this.calibracaoFinal,
    this.desvio,
    this.tempoPausa,
    this.inicioPausa,
    this.finalPausa,
    this.jornadaTrabalho,
    this.observacao,
  });

  factory Medicao.fromJson(Map<String, dynamic> j) {
    double? parseDouble(dynamic v) {
      if (v == null) return null;
      // se já for num, converte direto; se for String, tenta dar parse
      if (v is num) return v.toDouble();
      return double.tryParse(v.toString());
    }

    return Medicao(
      id:               j['id'] as int?,
      funcionarioId:    j['funcionario_id'] as int,
      equipamentoId:    j['equipamento_id'] as int?,
      avaliadorId:      j['avaliador_id'] as int,
      status:           j['status'] as String,
      dataMedicao:      j['data_medicao'] != null
                          ? DateTime.parse(j['data_medicao'] as String)
                          : null,
      horaInicio:       j['hora_inicio'] as String?,
      horaFim:          j['hora_fim'] as String?,
      tempoMostragem:   j['tempo_mostragem'] as String?,
      nenQ5:            parseDouble(j['nen_q5']),
      lavgQ5:           parseDouble(j['lavg_q5']),
      nenQ3:            parseDouble(j['nen_q3']),
      lavgQ3:           parseDouble(j['lavg_q3']),
      calibracaoInicial: parseDouble(j['calibracao_inicial']),
      calibracaoFinal:   parseDouble(j['calibracao_final']),
      desvio:           parseDouble(j['desvio']),
      tempoPausa:       j['tempo_pausa'] as String?,
      inicioPausa:      j['inicio_pausa'] as String?,
      finalPausa:       j['final_pausa'] as String?,
      jornadaTrabalho:  j['jornada_trabalho'] as String?,
      observacao:       j['observacao'] as String?,
    );
  }



  Map<String, dynamic> toJson() => {
        'funcionario_id':    funcionarioId,
        'equipamento_id':    equipamentoId,
        'avaliador_id':      avaliadorId,
        'status':            status,
        'data_medicao':      dataMedicao != null ? dataMedicao!.toIso8601String().split('T').first : null,
        'hora_inicio':       horaInicio,
        'hora_fim':          horaFim,
        'tempo_mostragem':   tempoMostragem,
        'nen_q5':            nenQ5,
        'lavg_q5':           lavgQ5,
        'nen_q3':            nenQ3,
        'lavg_q3':           lavgQ3,
        'calibracao_inicial':calibracaoInicial,
        'calibracao_final':  calibracaoFinal,
        'desvio':            desvio,
        'tempo_pausa':       tempoPausa,
        'inicio_pausa':      inicioPausa,
        'final_pausa':       finalPausa,
        'jornada_trabalho':  jornadaTrabalho,
        'observacao':        observacao,
      };
}