// lib/app/modules/equipamentos/services/equipamentos_service.dart

import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import '../../../utils/env.dart';

class EquipamentosService {
  final _base = '${Env.API_URL}/api/v1/equipamentos';

  Future<List<Map<String, dynamic>>> list() async {
    final r = await http.get(
      Uri.parse(_base),
      headers: {'x-api-key': Env.API_TOKEN},
    );
    final b = jsonDecode(r.body) as Map<String, dynamic>;
    return List<Map<String, dynamic>>.from(b['data'] as List);
  }

  Future<Map<String, dynamic>> create(Map<String, dynamic> dto) async {
    final r = await http.post(
      Uri.parse(_base),
      headers: {
        'Content-Type': 'application/json',
        'x-api-key': Env.API_TOKEN
      },
      body: jsonEncode(dto),
    );
    final b = jsonDecode(r.body) as Map<String, dynamic>;
    return b['data'] as Map<String, dynamic>;
  }

  Future<Map<String, dynamic>> update(int id, Map<String, dynamic> dto) async {
    final r = await http.put(
      Uri.parse('$_base/$id'),
      headers: {
        'Content-Type': 'application/json',
        'x-api-key': Env.API_TOKEN
      },
      body: jsonEncode(dto),
    );
    final b = jsonDecode(r.body) as Map<String, dynamic>;
    return b['data'] as Map<String, dynamic>;
  }

  Future<void> delete(int id) async {
    await http.delete(
      Uri.parse('$_base/$id'),
      headers: {'x-api-key': Env.API_TOKEN},
    );
  }

  /// Importa um .xlsx de equipamentos
  Future<Map<String, dynamic>> importFromExcel(Uint8List bytes, String filename) async {
    final uri = Uri.parse('$_base/import');
    final req = http.MultipartRequest('POST', uri)
      ..headers['x-api-key'] = Env.API_TOKEN
      ..files.add(
        http.MultipartFile.fromBytes(
          'file',
          bytes,
          filename: filename,
          contentType: MediaType(
            'application',
            'vnd.openxmlformats-officedocument.spreadsheetml.sheet',
          ),
        ),
      );
    final streamed = await req.send();
    final body = jsonDecode(await streamed.stream.bytesToString()) as Map<String, dynamic>;
    if (streamed.statusCode == 200 && body['success'] == true) {
      return body['data'] as Map<String, dynamic>;
    }
    throw Exception(body['message'] ?? 'Falha na importação');
  }
}