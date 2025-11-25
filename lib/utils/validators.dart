/// Archivo de utilidades para validaciones
/// Creado para el examen de CI/CD - Unidad III
/// 
/// Este archivo contiene 5 funciones de validación que serán probadas
/// mediante pruebas unitarias automatizadas en GitHub Actions.
library;

class Validators {
  /// Función 1: Validar Email
  /// Recibe un string. Retorna true si contiene "@" y ".", de lo contrario false.
  static bool validarEmail(String email) {
    if (email.isEmpty) return false;
    return email.contains('@') && email.contains('.');
  }

  /// Función 2: Seguridad Contraseña
  /// Recibe un string. Retorna true si la longitud es mayor a 6 caracteres.
  static bool validarSeguridadPassword(String password) {
    return password.length > 6;
  }

  /// Función 3: Calculadora Descuento
  /// Recibe precio y % descuento. Retorna el precio final calculado.
  static double calcularDescuento(double precio, double porcentajeDescuento) {
    if (precio < 0 || porcentajeDescuento < 0 || porcentajeDescuento > 100) {
      throw ArgumentError('Valores inválidos para el cálculo de descuento');
    }
    final descuento = precio * (porcentajeDescuento / 100);
    return precio - descuento;
  }

  /// Función 4: Rango Válido
  /// Recibe un número. Retorna true si está entre 1 y 10 (inclusive).
  static bool validarRango(int numero) {
    return numero >= 1 && numero <= 10;
  }

  /// Función 5: Texto a Mayúsculas
  /// Recibe un texto y lo retorna totalmente capitalizado.
  static String textoAMayusculas(String texto) {
    return texto.toUpperCase();
  }
}
