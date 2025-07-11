import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../utils/env.dart';

class EquipamentosService {
  final _base = '${Env.API_URL}/api/v1/equipamentos';

  Future<List<Map<String, dynamic>>> list() async {
    final r = await http.get(
      Uri.parse(_base),
      headers: {'x-api-key': Env.API_TOKEN},
    );
    final b = jsonDecode(r.body) as Map<String, dynamic>;
    return List<Map<String, dynamic>>.from(b['data']);
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
    return b['data'];
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
    return b['data'];
  }

  Future<void> delete(int id) async {
    await http.delete(
      Uri.parse('$_base/$id'),
      headers: {'x-api-key': Env.API_TOKEN},
    );
  }
}