String? validarCedulaEcuatoriana(String? cedula) {
  if (cedula == null || cedula.isEmpty) {
    return 'La cédula es obligatoria';
  }
  if (cedula.length != 10) {
    return 'La cédula debe tener 10 dígitos';
  }

  final int provincia = int.parse(cedula.substring(0, 2));
  if (provincia < 1 || provincia > 24) {
    return 'Los dos primeros dígitos no corresponden a ninguna provincia';
  }

  final int tercerDigito = int.parse(cedula[2]);
  if (tercerDigito < 0 || tercerDigito > 5) {
    return 'El tercer dígito no es válido';
  }

  final List<int> coeficientes = [2, 1, 2, 1, 2, 1, 2, 1, 2];
  int suma = 0;

  for (int i = 0; i < coeficientes.length; i++) {
    int digito = int.parse(cedula[i]) * coeficientes[i];
    if (digito >= 10) digito -= 9;
    suma += digito;
  }

  final int digitoVerificador = int.parse(cedula[9]);
  int decenaSuperior = ((suma + 9) ~/ 10) * 10;
  int calculadoVerificador = decenaSuperior - suma;

  if (calculadoVerificador == 10) calculadoVerificador = 0;
  if (calculadoVerificador != digitoVerificador) {
    return 'La cédula es inválida';
  }

  return null; // Cédula válida
}
