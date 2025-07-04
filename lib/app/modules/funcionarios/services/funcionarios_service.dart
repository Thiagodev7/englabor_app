import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import '../../../utils/env.dart';

class FuncionariosService {
  final _baseUrl = Env.API_URL;
  final _token   = Env.API_TOKEN;

  Future<List<Map<String, dynamic>>> fetchByEmpresa(int empresaId) async {
    final url = Uri.parse('$_baseUrl/api/v1/funcionarios/empresa/$empresaId');
    final resp = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'x-api-key': _token,
    });
    final body = jsonDecode(resp.body) as Map<String, dynamic>;
    if (resp.statusCode == 200 && body['success'] == true) {
      return List<Map<String, dynamic>>.from(body['data'] as List);
    }
    throw Exception(body['message'] ?? 'Erro ao buscar funcionários');
  }

  Future<Map<String, dynamic>> createRaw(int empresaId, String nome, String matricula, String setor, String ghe, String cargo) async {
    final url = Uri.parse('$_baseUrl/api/v1/funcionarios');
    final resp = await http.post(url,
      headers: {
        'Content-Type': 'application/json',
        'x-api-key': _token,
      },
      body: jsonEncode({
        'empresa_id': empresaId,
        'nome': nome,
        'matricula': matricula,
        'setor': setor,
        'ghe': ghe,
        'cargo': cargo,
      }),
    );
    final body = jsonDecode(resp.body) as Map<String, dynamic>;
    if (resp.statusCode == 200 && body['success'] == true) {
      return body['data'] as Map<String, dynamic>;
    }
    throw Exception(body['message'] ?? 'Erro ao criar funcionário');
  }

  Future<void> deleteRaw(int id) async {
    final url = Uri.parse('$_baseUrl/api/v1/funcionarios/$id');
    final resp = await http.delete(url, headers: {
      'x-api-key': _token,
    });
    final body = jsonDecode(resp.body) as Map<String, dynamic>;
    if (!(resp.statusCode == 200 && body['success'] == true)) {
      throw Exception(body['message'] ?? 'Erro ao deletar funcionário');
    }
  }

  Future<Map<String, dynamic>> updateRaw(int id, int empresaId, String nome, String matricula, String setor, String ghe, String cargo) async {
    final url = Uri.parse('$_baseUrl/api/v1/funcionarios/$id');
    final resp = await http.put(url,
      headers: {
        'Content-Type': 'application/json',
        'x-api-key': _token,
      },
      body: jsonEncode({
        'empresa_id': empresaId,
        'nome': nome,
        'matricula': matricula,
        'setor': setor,
        'ghe': ghe,
        'cargo': cargo,
      }),
    );
    final body = jsonDecode(resp.body) as Map<String, dynamic>;
    if (resp.statusCode == 200 && body['success'] == true) {
      return body['data'] as Map<String, dynamic>;
    }
    throw Exception(body['message'] ?? 'Erro ao atualizar funcionário');
  }

  Future<Map<String, dynamic>> importByEmpresa(int empresaId, Uint8List bytes, String filename) async {
    final uri = Uri.parse('${Env.API_URL}/api/v1/funcionarios/import/$empresaId');
    final req = http.MultipartRequest('POST', uri)
      ..headers['x-api-key'] = Env.API_TOKEN
      ..files.add(http.MultipartFile.fromBytes('file', bytes, filename: filename));

    final streamed = await req.send();
    final body = jsonDecode(await streamed.stream.bytesToString()) as Map<String, dynamic>;

    if (streamed.statusCode == 200 && body['success'] == true) {
      return body['data'] as Map<String, dynamic>;
    }
    throw Exception(body['message'] ?? 'Falha na importação');
  }
}
