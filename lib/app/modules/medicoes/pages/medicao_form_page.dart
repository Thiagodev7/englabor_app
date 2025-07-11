// lib/app/modules/medicoes/pages/medicao_form_page.dart

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';

import '../../../theme/app_theme.dart';
import '../stores/medicoes_store.dart';

class MedicaoFormPage extends StatefulWidget {
  const MedicaoFormPage({Key? key}) : super(key: key);
  @override
  _MedicaoFormPageState createState() => _MedicaoFormPageState();
}

class _MedicaoFormPageState extends State<MedicaoFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _store = Modular.get<MedicoesStore>();

  late final int _empresaId;
  late final int _funcionarioId;

  @override
  void initState() {
    super.initState();
    _store.resetForm();
    final args = Modular.args.data as Map<String, dynamic>;
    _empresaId = args['empresaId'] as int;
    _funcionarioId = args['funcionarioId'] as int;

    _store.resetForm();

    _store.loadEquipamentos();
    _store.initMedicao(_funcionarioId);
  }

  @override
  void dispose() {
    _store.resetForm(); // limpa ao sair da página
    super.dispose();
  }

  Future<void> _pickDate() async {
    final d = await showDatePicker(
      context: context,
      initialDate: _store.dataMedicao ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (d != null) _store.dataMedicao = d;
  }

  Future<void> _pickTimeStart() async {
    final t = await showTimePicker(
      context: context,
      initialTime: _store.horaInicio ?? TimeOfDay.now(),
    );
    if (t != null) _store.horaInicio = t;
  }

  Future<void> _pickTimeEnd() async {
    final t = await showTimePicker(
      context: context,
      initialTime: _store.horaFim ?? TimeOfDay.now(),
    );
    if (t != null) _store.horaFim = t;
  }

  Future<void> _pickInicioPausa() async {
    final t = await showTimePicker(
      context: context,
      initialTime: _store.inicioPausa ?? TimeOfDay.now(),
    );
    if (t != null) _store.inicioPausa = t;
  }

  Future<void> _pickFinalPausa() async {
    final t = await showTimePicker(
      context: context,
      initialTime: _store.finalPausa ?? TimeOfDay.now(),
    );
    if (t != null) _store.finalPausa = t;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            _store.currentMedicao == null ? 'Nova Medição' : 'Editar Medição'),
        backgroundColor: AppTheme.primary,
      ),
      body: Observer(builder: (_) {
        if (_store.loading)
          return const Center(child: CircularProgressIndicator());
        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(children: [
              // Equipamento
              DropdownButtonFormField<int>(
                isExpanded: true,
                decoration: const InputDecoration(labelText: 'Equipamento'),
                items: _store.equipList.map((e) {
                  return DropdownMenuItem<int>(
                    value: e['id'] as int,
                    child: Text('${e['tipo']} • ${e['marca']} ${e['modelo']}'),
                  );
                }).toList(),
                value: _store.equipamentoId,
                onChanged: (v) => _store.equipamentoId = v,
              ),
              const SizedBox(height: 12),

              // Data
              InkWell(
                onTap: _pickDate,
                child: InputDecorator(
                  decoration: const InputDecoration(labelText: 'Data'),
                  child: Text(_store.dataMedicao != null
                      ? DateFormat('dd/MM/yyyy').format(_store.dataMedicao!)
                      : 'Selecione (opcional)'),
                ),
              ),
              const SizedBox(height: 12),

              // Horários
              Row(children: [
                Expanded(
                  child: InkWell(
                    onTap: _pickTimeStart,
                    child: InputDecorator(
                      decoration:
                          const InputDecoration(labelText: 'Hora Início'),
                      child: Text(
                          _store.horaInicio?.format(context) ?? 'Selecione'),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: InkWell(
                    onTap: _pickTimeEnd,
                    child: InputDecorator(
                      decoration: const InputDecoration(labelText: 'Hora Fim'),
                      child:
                          Text(_store.horaFim?.format(context) ?? 'Selecione'),
                    ),
                  ),
                ),
              ]),
              const SizedBox(height: 12),

              // Tempo de Mostragem
              TextFormField(
                controller: _store.tempoMostragemCtrl,
                decoration: const InputDecoration(
                    labelText: 'Tempo Mostragem (hh:mm:ss)'),
              ),
              const SizedBox(height: 12),

              // NEN / LAVG Q5
              Row(children: [
                Expanded(
                  child: TextFormField(
                    controller: _store.nenQ5Ctrl,
                    decoration: const InputDecoration(labelText: 'NEN Q5'),
                    keyboardType: TextInputType.number,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextFormField(
                    controller: _store.lavgQ5Ctrl,
                    decoration: const InputDecoration(labelText: 'LAVG Q5'),
                    keyboardType: TextInputType.number,
                  ),
                ),
              ]),
              const SizedBox(height: 12),

              // NEN / LAVG Q3
              Row(children: [
                Expanded(
                  child: TextFormField(
                    controller: _store.nenQ3Ctrl,
                    decoration: const InputDecoration(labelText: 'NEN Q3'),
                    keyboardType: TextInputType.number,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextFormField(
                    controller: _store.lavgQ3Ctrl,
                    decoration: const InputDecoration(labelText: 'LAVG Q3'),
                    keyboardType: TextInputType.number,
                  ),
                ),
              ]),
              const SizedBox(height: 12),

              // Calibração Inicial / Final
              Row(children: [
                Expanded(
                  child: TextFormField(
                    controller: _store.calibInicialCtrl,
                    decoration:
                        const InputDecoration(labelText: 'Calibração Inicial'),
                    keyboardType: TextInputType.number,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextFormField(
                    controller: _store.calibFinalCtrl,
                    decoration:
                        const InputDecoration(labelText: 'Calibração Final'),
                    keyboardType: TextInputType.number,
                  ),
                ),
              ]),
              const SizedBox(height: 12),

              // Desvio
              TextFormField(
                controller: _store.desvioCtrl,
                decoration: const InputDecoration(labelText: 'Desvio'),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 12),

              // Tempo de Pausa
              TextFormField(
                controller: _store.tempoPausaCtrl,
                decoration:
                    const InputDecoration(labelText: 'Tempo Pausa (hh:mm:ss)'),
              ),
              const SizedBox(height: 12),

              // Início / Fim Pausa
              Row(children: [
                Expanded(
                  child: InkWell(
                    onTap: _pickInicioPausa,
                    child: InputDecorator(
                      decoration:
                          const InputDecoration(labelText: 'Início Pausa'),
                      child: Text(
                          _store.inicioPausa?.format(context) ?? 'Selecione'),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: InkWell(
                    onTap: _pickFinalPausa,
                    child: InputDecorator(
                      decoration: const InputDecoration(labelText: 'Fim Pausa'),
                      child: Text(
                          _store.finalPausa?.format(context) ?? 'Selecione'),
                    ),
                  ),
                ),
              ]),
              const SizedBox(height: 12),

              // Jornada de Trabalho
              TextFormField(
                controller: _store.jornadaCtrl,
                decoration:
                    const InputDecoration(labelText: 'Jornada (hh:mm:ss)'),
              ),
              const SizedBox(height: 12),

              // Observação
              TextFormField(
                controller: _store.obsCtrl,
                decoration: const InputDecoration(labelText: 'Observação'),
                maxLines: 3,
              ),
              const SizedBox(height: 24),

              // Botões Atualizar / Finalizar
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () async {
                        await _store.submit(_funcionarioId, 'ABERTO');
                        if (_store.error == null) {
                          await _store.selectEmpresa(_empresaId);
                          Modular.to.pop();
                        }
                      },
                      child: const Text('Atualizar'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () async {
                        await _store.submit(_funcionarioId, 'CONCLUIDO');
                        if (_store.error == null) {
                          await _store.selectEmpresa(_empresaId);
                          Modular.to.pop();
                        }
                      },
                      child: const Text('Finalizar'),
                    ),
                  ),
                ],
              ),

              // Erro geral
              if (_store.fieldErrors != null) ...[
                const SizedBox(height: 8),
                for (var fe in _store.fieldErrors!)
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      '${fe.field}: ${fe.message}',
                      style: TextStyle(
                        color: Theme.of(context)
                            .colorScheme
                            .error
                            .withOpacity(0.8),
                        fontSize: 12,
                      ),
                    ),
                  ),
              ],
            ]),
          ),
        );
      }),
    );
  }
}
