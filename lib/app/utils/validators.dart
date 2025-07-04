// lib/app/utils/validators.dart

/// Remove tudo que não for dígito
String _onlyDigits(String s) => s.replaceAll(RegExp(r'\D'), '');

/// Valida CNPJ com dígitos verificadores
bool isValidCNPJ(String cnpj) {
  cnpj = _onlyDigits(cnpj);
  if (cnpj.length != 14) return false;

  // Números repetidos não são válidos
  if (RegExp(r'^(\d)\1*$').hasMatch(cnpj)) return false;

  List<int> numbers = cnpj.split('').map(int.parse).toList();

  // Função para calcular cada dígito
  int calc(List<int> nums, List<int> pos) {
    final sum = nums.asMap().entries
      .map((e) => e.value * pos[e.key])
      .reduce((a, b) => a + b);
    final mod = sum % 11;
    return (mod < 2) ? 0 : 11 - mod;
  }

  final pos1 = [5,4,3,2,9,8,7,6,5,4,3,2];
  final pos2 = [6,5,4,3,2,9,8,7,6,5,4,3,2];

  final d1 = calc(numbers.sublist(0,12), pos1);
  final d2 = calc(numbers.sublist(0,12)..add(d1), pos2);

  return d1 == numbers[12] && d2 == numbers[13];
}