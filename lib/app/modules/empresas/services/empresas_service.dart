// lib/app/modules/empresas/services/empresas_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../utils/env.dart';

class EmpresasService {
  final _baseUrl = Env.API_URL;
  final _token   = Env.API_TOKEN;

  Future<List<Map<String, dynamic>>> fetchRaw() async {
    final url = Uri.parse('$_baseUrl/api/v1/empresas');
    final resp = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'x-api-key': _token,
    });
    final body = jsonDecode(resp.body) as Map<String, dynamic>;
    if (resp.statusCode == 200 && body['success'] == true) {
      return List<Map<String, dynamic>>.from(body['data'] as List);
    }
    throw Exception(body['message'] ?? 'Erro ao buscar empresas');
  }

  Future<Map<String, dynamic>> createRaw(String nome, String cnpj) async {
    final url = Uri.parse('$_baseUrl/api/v1/empresas');
    final resp = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'x-api-key': _token,
      },
      body: jsonEncode({'nome': nome, 'cnpj': cnpj}),
    );
    final body = jsonDecode(resp.body) as Map<String, dynamic>;
    if (resp.statusCode == 200 && body['success'] == true) {
      return body['data'] as Map<String, dynamic>;
    }
    throw Exception(body['message'] ?? 'Erro ao criar empresa');
  }

  Future<void> deleteRaw(int id) async {
    final url = Uri.parse('$_baseUrl/api/v1/empresas/$id');
    final resp = await http.delete(url, headers: {
      'x-api-key': _token,
    });
    final body = jsonDecode(resp.body) as Map<String, dynamic>;
    if (!(resp.statusCode == 200 && body['success'] == true)) {
      throw Exception(body['message'] ?? 'Erro ao deletar empresa');
    }
  }
}