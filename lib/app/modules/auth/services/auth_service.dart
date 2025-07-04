// lib/app/modules/auth/services/auth_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../../utils/env.dart';

class AuthService {
  final String _baseUrl = Env.API_URL;
  final String _token   = Env.API_TOKEN;

  /// Retorna mapa com 'token' e 'user' em caso de sucesso,
  /// ou lança Exception com a mensagem do servidor.
  Future<Map<String, dynamic>> login(String identifier, String password) async {
    final url  = Uri.parse('$_baseUrl/api/v1/login');
    final resp = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'x-api-key': _token,
      },
      body: jsonEncode({
        'identifier': identifier,
        'password':   password,
      }),
    );

    final body = jsonDecode(resp.body) as Map<String, dynamic>;

    if (resp.statusCode == 200 && body['success'] == true) {
      final data = body['data'] as Map<String, dynamic>;
      return {
        'token': data['token'] as String,
        'user':  data['user']  as Map<String, dynamic>,
      };
    } else {
      // no erro, a API envia { success: false, message: '...' }
      final msg = body['message'] as String? ?? 'Erro desconhecido';
      throw Exception(msg);
    }
  }
}