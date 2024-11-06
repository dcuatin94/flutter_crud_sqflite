class Computadora {
  final int? id;
  final String nombre;
  final String procesador;
  final String discoDuro;
  final String ram;

  Computadora(
      {this.id,
      required this.nombre,
      required this.procesador,
      required this.discoDuro,
      required this.ram});

  //Convertir un objeto Computadora a un Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nombre': nombre,
      'procesador': procesador,
      'discoDuro': discoDuro,
      'ram': ram,
    };
  }

  //Convertir un Map en un el Objeto Computadora
  factory Computadora.fromMap(Map<String, dynamic> map) {
    return Computadora(
        id: map['id'],
        nombre: map['nombre'],
        procesador: map['procesador'],
        discoDuro: map['discoDuro'],
        ram: map['ram']);
  }
}
