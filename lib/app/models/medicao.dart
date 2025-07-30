class Medicao {
  final int? id;
  final int funcionarioId;
  final int? equipamentoId;
  final int avaliadorId;
  final String status;
  final DateTime? dataMedicao;

  // Horários da medição
  final String? horaInicio;
  final String? horaFim;

  // Tempos calculados
  final String? tempoMostragem;
  final String? tempoPausa;
  final String? jornadaTrabalho;

  // Pausa
  final String? inicioPausa;
  final String? finalPausa;

  // Níveis sonoros
  final double? nenQ5;
  final double? lavgQ5;
  final double? nenQ3;
  final double? lavgQ3;

  // Calibração (valores e horários)
  final double? calibracaoInicial;
  final double? calibracaoFinal;
  final String? horaCalibracaoInicio;
  final String? horaCalibracaoFim;

  // Outros
  final double? desvio;
  final String? observacao;

  // Foto (base64 ou URL)
  final String? foto_base64;
  final String? assinaturaBase64;

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
    this.tempoPausa,
    this.jornadaTrabalho,
    this.inicioPausa,
    this.finalPausa,
    this.nenQ5,
    this.lavgQ5,
    this.nenQ3,
    this.lavgQ3,
    this.calibracaoInicial,
    this.calibracaoFinal,
    this.horaCalibracaoInicio,
    this.horaCalibracaoFim,
    this.desvio,
    this.observacao,
    this.foto_base64,
    this.assinaturaBase64,
  });

  factory Medicao.fromJson(Map<String, dynamic> j) {
    String? parseInterval(dynamic v, {bool includeSeconds = true}) {
      if (v == null) return null;
      if (v is String) {
        if (!includeSeconds && v.split(':').length == 3) {
          return v.substring(0, 5);
        }
        return v;
      }
      if (v is Map<String, dynamic>) {
        final h = (v['hours'] ?? 0).toString().padLeft(2, '0');
        final m = (v['minutes'] ?? 0).toString().padLeft(2, '0');
        if (includeSeconds) {
          final s = (v['seconds'] ?? 0).toString().padLeft(2, '0');
          return '$h:$m:$s';
        } else {
          return '$h:$m';
        }
      }
      return null;
    }

    double? parseDouble(dynamic v) {
      if (v == null) return null;
      if (v is num) return v.toDouble();
      return double.tryParse(v.toString());
    }

    return Medicao(
      id:                   j['id'] as int?,
      funcionarioId:        j['funcionario_id'] as int,
      equipamentoId:        j['equipamento_id'] as int?,
      avaliadorId:          j['avaliador_id'] as int,
      status:               j['status'] as String,
      dataMedicao:          j['data_medicao'] != null
                              ? DateTime.parse(j['data_medicao'] as String)
                              : null,
      horaInicio:           j['hora_inicio'] as String?,
      horaFim:              j['hora_fim'] as String?,
      tempoMostragem:       parseInterval(j['tempo_mostragem'], includeSeconds: true),
      tempoPausa:           parseInterval(j['tempo_pausa'], includeSeconds: false),
      jornadaTrabalho:      parseInterval(j['jornada_trabalho'], includeSeconds: true),
      inicioPausa:          j['inicio_pausa'] as String?,
      finalPausa:           j['final_pausa'] as String?,
      nenQ5:                parseDouble(j['nen_q5']),
      lavgQ5:               parseDouble(j['lavg_q5']),
      nenQ3:                parseDouble(j['nen_q3']),
      lavgQ3:               parseDouble(j['lavg_q3']),
      calibracaoInicial:    parseDouble(j['calibracao_inicial']),
      calibracaoFinal:      parseDouble(j['calibracao_final']),
      horaCalibracaoInicio: j['hora_calibracao_inicio'] as String?,
      horaCalibracaoFim:    j['hora_calibracao_fim'] as String?,
      desvio:               parseDouble(j['desvio']),
      observacao:           j['observacao'] as String?,
      foto_base64:          j['foto_base64'] as String?,
      assinaturaBase64:     j['assinatura_base64'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'funcionario_id':            funcionarioId,
        'equipamento_id':            equipamentoId,
        'avaliador_id':              avaliadorId,
        'status':                    status,
        'data_medicao':              dataMedicao != null
                                        ? dataMedicao!.toIso8601String().split('T').first
                                        : null,
        'hora_inicio':               horaInicio,
        'hora_fim':                  horaFim,
        'tempo_mostragem':           tempoMostragem,
        'tempo_pausa':               tempoPausa,
        'jornada_trabalho':          jornadaTrabalho,
        'inicio_pausa':              inicioPausa,
        'final_pausa':               finalPausa,
        'nen_q5':                    nenQ5,
        'lavg_q5':                   lavgQ5,
        'nen_q3':                    nenQ3,
        'lavg_q3':                   lavgQ3,
        'calibracao_inicial':        calibracaoInicial,
        'calibracao_final':          calibracaoFinal,
        'hora_calibracao_inicio':    horaCalibracaoInicio,
        'hora_calibracao_fim':       horaCalibracaoFim,
        'desvio':                    desvio,
        'observacao':                observacao,
        'foto_base64':               foto_base64,
        'assinatura_base64':         assinaturaBase64,
      };
}