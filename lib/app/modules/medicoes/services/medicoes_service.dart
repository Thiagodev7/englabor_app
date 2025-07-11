// lib/app/modules/medicoes/services/medicoes_service.dart

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../utils/env.dart';
import '../../../utils/api_exception.dart';

class MedicoesService {
  final _base = '${Env.API_URL}/api/v1/medicoes';

  Future<Map<String, dynamic>> create(Map<String, dynamic> dto) async {
    final resp = await http.post(
      Uri.parse(_base),
      headers: {
        'Content-Type': 'application/json',
        'x-api-key': Env.API_TOKEN,
      },
      body: jsonEncode(dto),
    );

    final body = jsonDecode(resp.body) as Map<String, dynamic>;
    if (resp.statusCode != 200 || body['success'] != true) {
      final msg = body['message'] as String? ?? 'Erro ${resp.statusCode}';
      List<FieldError>? fieldErrors;
      if (body.containsKey('errors')) {
        fieldErrors = (body['errors'] as List)
            .map((e) => FieldError.fromJson(e as Map<String, dynamic>))
            .toList();
      }
      throw ApiException(msg, fieldErrors);
    }

    return body['data'] as Map<String, dynamic>;
  }

  Future<Map<String, dynamic>> update(int id, Map<String, dynamic> dto) async {
    final resp = await http.put(
      Uri.parse('$_base/$id'),
      headers: {
        'Content-Type': 'application/json',
        'x-api-key': Env.API_TOKEN,
      },
      body: jsonEncode(dto),
    );

    final body = jsonDecode(resp.body) as Map<String, dynamic>;
    if (resp.statusCode != 200 || body['success'] != true) {
      final msg = body['message'] as String? ?? 'Erro ${resp.statusCode}';
      List<FieldError>? fieldErrors;
      if (body.containsKey('errors')) {
        fieldErrors = (body['errors'] as List)
            .map((e) => FieldError.fromJson(e as Map<String, dynamic>))
            .toList();
      }
      throw ApiException(msg, fieldErrors);
    }

    return body['data'] as Map<String, dynamic>;
  }

  Future<List<Map<String, dynamic>>> listByFuncionario(int funcId) async {
  final resp = await http.get(
    Uri.parse('$_base/funcionario/$funcId'),
    headers: {'x-api-key': Env.API_TOKEN},
  );
  final body = jsonDecode(resp.body) as Map<String, dynamic>;


  if (resp.statusCode == 200 && body['success'] == false
      && (body['message'] as String).contains('Nenhuma medição encontrada')) {
    return [];
  }

  if (resp.statusCode != 200 || body['success'] != true) {
    final msg = body['message'] as String? ?? 'Erro ${resp.statusCode}';
    List<FieldError>? fieldErrors;
    if (body.containsKey('errors')) {
      fieldErrors = (body['errors'] as List)
        .map((e) => FieldError.fromJson(e as Map<String, dynamic>))
        .toList();
    }
    throw ApiException(msg, fieldErrors);
  }

  final data = body['data'];
  if (data == null) return [];
  return [data as Map<String, dynamic>];
}
}