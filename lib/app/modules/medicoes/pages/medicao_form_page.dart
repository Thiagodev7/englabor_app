// lib/app/modules/medicoes/pages/medicao_form_page.dart

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:signature/signature.dart';

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
  final _picker = ImagePicker();

  late final int _empresaId;
  late final int _funcionarioId;
  final _dateFmt = DateFormat('dd/MM/yyyy');

  @override
  void initState() {
    super.initState();
    final args = Modular.args.data as Map<String, dynamic>;
    _empresaId = args['empresaId'] as int;
    _funcionarioId = args['funcionarioId'] as int;

    _store.resetForm();
    _store.loadEmpresas();
    _store.loadEquipamentos();
    _store.initMedicao(_funcionarioId);
  }

  Future<TimeOfDay?> _pickTime(BuildContext ctx, TimeOfDay? initial) =>
      showTimePicker(context: ctx, initialTime: initial ?? TimeOfDay.now());

  Future<void> _pickDate() async {
    final d = await showDatePicker(
      context: context,
      initialDate: _store.dataMedicao ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (d != null) _store.dataMedicao = d;
  }

  Future<void> _pickPhoto() async {
    final XFile? file = await _picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 75,
    );
    if (file != null) {
      final bytes = await File(file.path).readAsBytes();
      final base64Img = base64Encode(bytes);
      _store.setFoto(base64Img);
    }
  }

  Future<void> _chooseFromGallery() async {
    final XFile? file = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 75,
    );
    if (file != null) {
      final bytes = await File(file.path).readAsBytes();
      final base64Img = base64Encode(bytes);
      _store.setFoto(base64Img);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _store.currentMedicao == null ? 'Nova Medição' : 'Editar Medição',
        ),
        backgroundColor: AppTheme.primary,
      ),
      body: Observer(builder: (_) {
        if (_store.loading) {
          return const Center(child: CircularProgressIndicator());
        }
        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Empresa (opcional)
                  DropdownButtonFormField<int>(
                    isExpanded: true,
                    decoration: const InputDecoration(labelText: 'Empresa'),
                    items: _store.empresas.map((e) {
                      return DropdownMenuItem<int>(
                        value: e['id'] as int,
                        child: Text(e['nome'] as String),
                      );
                    }).toList(),
                    value: _store.selectedEmpresaId,
                    onChanged: (v) {
                      if (v != null) _store.selectEmpresa(v);
                    },
                  ),
                  const SizedBox(height: 12),

                  // Equipamento
                  DropdownButtonFormField<int>(
                    isExpanded: true,
                    decoration: const InputDecoration(labelText: 'Equipamento'),
                    items: _store.equipList.map((e) {
                      return DropdownMenuItem<int>(
                        value: e['id'] as int,
                        child:
                            Text('${e['tipo']} • ${e['marca']} ${e['modelo']}'),
                      );
                    }).toList(),
                    value: _store.equipamentoId,
                    onChanged: (v) => _store.equipamentoId = v,
                    validator: (v) =>
                        v == null ? 'Selecione o equipamento' : null,
                  ),
                  const SizedBox(height: 12),

                  // Data
                  InkWell(
                    onTap: _pickDate,
                    child: InputDecorator(
                      decoration: const InputDecoration(labelText: 'Data'),
                      child: Text(
                        _store.dataMedicao != null
                            ? _dateFmt.format(_store.dataMedicao!)
                            : 'Selecione (opcional)',
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Horário Início / Fim
                  Row(children: [
                    Expanded(
                      child: InkWell(
                        onTap: () async {
                          final t = await _pickTime(context, _store.horaInicio);
                          if (t != null) _store.setHoraInicio(t);
                        },
                        child: InputDecorator(
                          decoration:
                              const InputDecoration(labelText: 'Hora Início'),
                          child: Text(
                            _store.horaInicio?.format(context) ?? 'Selecione',
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: InkWell(
                        onTap: () async {
                          final t = await _pickTime(context, _store.horaFim);
                          if (t != null) _store.setHoraFim(t);
                        },
                        child: InputDecorator(
                          decoration:
                              const InputDecoration(labelText: 'Hora Fim'),
                          child: Text(
                            _store.horaFim?.format(context) ?? 'Selecione',
                          ),
                        ),
                      ),
                    ),
                  ]),
                  const SizedBox(height: 16),

                  // Foto do Funcionário
                  const Text('Foto do Funcionário'),
                  const SizedBox(height: 8),
                  if (_store.foto != null)
                    Image.memory(
                      base64Decode(_store.foto!),
                      height: 150,
                      fit: BoxFit.cover,
                    )
                  else
                    Container(
                      height: 150,
                      color: Colors.grey[200],
                      child: const Center(child: Text('Nenhuma foto')),
                    ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          icon: const Icon(Icons.camera_alt),
                          label: const Text('Tirar Foto'),
                          onPressed: _pickPhoto,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton.icon(
                          icon: const Icon(Icons.photo_library),
                          label: const Text('Galeria'),
                          onPressed: _chooseFromGallery,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Tempo de Mostragem (automático)
                  TextFormField(
                    controller: _store.tempoMostragemCtrl,
                    decoration: const InputDecoration(
                      labelText: 'Tempo Mostragem',
                      suffixText: '(hh:mm:ss)',
                    ),
                    readOnly: true,
                  ),
                  const SizedBox(height: 12),

                  // NEN / LAVG Q5
                  Row(children: [
                    Expanded(
                      child: TextFormField(
                        controller: _store.nenQ5Ctrl,
                        decoration: const InputDecoration(
                          labelText: 'NEN Q5',
                          suffixText: 'dB(A)',
                        ),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: TextFormField(
                        controller: _store.lavgQ5Ctrl,
                        decoration: const InputDecoration(
                          labelText: 'LAVG Q5',
                          suffixText: 'dB(A)',
                        ),
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
                        decoration: const InputDecoration(
                          labelText: 'NEN Q3',
                          suffixText: 'dB(A)',
                        ),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: TextFormField(
                        controller: _store.lavgQ3Ctrl,
                        decoration: const InputDecoration(
                          labelText: 'LAVG Q3',
                          suffixText: 'dB(A)',
                        ),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ]),
                  const SizedBox(height: 16),

                  // Calibração Inicial / Final
                  Row(children: [
                    Expanded(
                      child: TextFormField(
                        controller: _store.calibInicialCtrl,
                        decoration: const InputDecoration(
                          labelText: 'Calibração Inicial',
                          suffixText: 'dB(A)',
                        ),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: TextFormField(
                        controller: _store.calibFinalCtrl,
                        decoration: const InputDecoration(
                          labelText: 'Calibração Final',
                          suffixText: 'dB(A)',
                        ),
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

                  // Tempo de Pausa (automático)
                  TextFormField(
                    controller: _store.tempoPausaCtrl,
                    decoration: const InputDecoration(labelText: 'Tempo Pausa'),
                    readOnly: true,
                  ),
                  const SizedBox(height: 12),

                  // Início Pausa / Fim Pausa
                  Row(children: [
                    Expanded(
                      child: InkWell(
                        onTap: () async {
                          final t =
                              await _pickTime(context, _store.inicioPausa);
                          if (t != null) _store.setInicioPausa(t);
                        },
                        child: InputDecorator(
                          decoration:
                              const InputDecoration(labelText: 'Início Pausa'),
                          child: Text(
                            _store.inicioPausa?.format(context) ?? 'Selecione',
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: InkWell(
                        onTap: () async {
                          final t = await _pickTime(context, _store.finalPausa);
                          if (t != null) _store.setFinalPausa(t);
                        },
                        child: InputDecorator(
                          decoration:
                              const InputDecoration(labelText: 'Fim Pausa'),
                          child: Text(
                            _store.finalPausa?.format(context) ?? 'Selecione',
                          ),
                        ),
                      ),
                    ),
                  ]),
                  const SizedBox(height: 24),

                  // Botões Atualizar / Finalizar
                  Row(children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () async {
                          if (!_formKey.currentState!.validate()) return;
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
                          if (!_formKey.currentState!.validate()) return;
                          await _store.submit(_funcionarioId, 'CONCLUIDO');
                          if (_store.error == null) {
                            await _store.selectEmpresa(_empresaId);
                            Modular.to.pop();
                          }
                        },
                        child: const Text('Finalizar'),
                      ),
                    ),
                  ]),

                  // no build(), embaixo dos botões Finalizar/Atualizar
                  const SizedBox(height: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ElevatedButton.icon(
                        icon: const Icon(Icons.edit),
                        label: const Text('Capturar Assinatura'),
                        onPressed: () async {
                          _store.assinaturaCtrl.clear();
                          await showDialog(
                            context: context,
                            builder: (_) => AlertDialog(
                              title: const Text('Assine abaixo'),
                              content: SizedBox(
                                width:
                                    MediaQuery.of(context).size.width * 0.8,
                                height: 200,
                                child: Signature(
                                  controller: _store.assinaturaCtrl,
                                  backgroundColor: Colors.grey[200]!,
                                ),
                              ),
                              actions: [
                                TextButton(
                                  child: const Text('Limpar'),
                                  onPressed: () =>
                                      _store.assinaturaCtrl.clear(),
                                ),
                                ElevatedButton(
                                  child: const Text('OK'),
                                  onPressed: () async {
                                    await _store.salvarAssinatura();
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                  
                      // logo depois do ElevatedButton.icon(...)
                      Observer(builder: (_) {
                        final bytes = _store.assinaturaBytes;
                        if (bytes == null) return const SizedBox.shrink();
                        return Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 8),
                              const Text('Assinatura capturada:'),
                              const SizedBox(height: 4),
                              Image.memory(bytes, height: 100),
                            ],
                          ),
                        );
                      }),
                    ],
                  ),
                  // Erros de validação
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

                  // Erro geral
                  if (_store.error != null) ...[
                    const SizedBox(height: 12),
                    Text(
                      _store.error!,
                      style:
                          TextStyle(color: Theme.of(context).colorScheme.error),
                    ),
                  ],
                ],
              )),
        );
      }),
    );
  }
}
