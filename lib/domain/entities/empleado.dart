class Empleado {
  final int id;
  final String nombre;
  final String apellido;
  final String cedula;
  final String firma;
  final String area;
  final String cargo;

  Empleado({
    required this.id,
    required this.nombre,
    required this.apellido,
    required this.cedula,
    required this.firma,
    required this.area,
    required this.cargo,
  });

  // Convertir un empleado a un mapa para guardarlo en la base de datos
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nombre': nombre,
      'apellido': apellido,
      'cedula': cedula,
      'firma': firma,
      'area': area,
      'cargo': cargo,
    };
  }

  // Crear un empleado desde un mapa (cuando obtenemos los datos de la base de datos)
  factory Empleado.fromMap(Map<String, dynamic> map) {
    return Empleado(
      id: map['id'],
      nombre: map['nombre'],
      apellido: map['apellido'],
      cedula: map['cedula'],
      firma: map['firma'],
      area: map['area'],
      cargo: map['cargo'],
    );
  }
}
