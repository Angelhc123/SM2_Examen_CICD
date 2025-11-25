import 'package:flutter_test/flutter_test.dart';
import 'package:sm2_examenunidad3/utils/validators.dart';

/// Pruebas Unitarias para el archivo validators.dart
/// Examen CI/CD - Unidad III
/// 
/// Este archivo contiene las 5 pruebas unitarias requeridas para validar
/// las funciones de utilidad implementadas.

void main() {
  // ============================================================================
  // Prueba 1: Validar Email
  // ============================================================================
  group('Prueba 1 - Validar Email', () {
    test('Debe retornar true para email válido con @ y .', () {
      expect(Validators.validarEmail('usuario@example.com'), true);
      expect(Validators.validarEmail('test@dominio.org'), true);
      expect(Validators.validarEmail('correo@mail.edu.pe'), true);
    });

    test('Debe retornar false para email sin @', () {
      expect(Validators.validarEmail('usuarioexample.com'), false);
    });

    test('Debe retornar false para email sin .', () {
      expect(Validators.validarEmail('usuario@examplecom'), false);
    });

    test('Debe retornar false para email vacío', () {
      expect(Validators.validarEmail(''), false);
    });
  });

  // ============================================================================
  // Prueba 2: Seguridad Contraseña
  // ============================================================================
  group('Prueba 2 - Seguridad Contraseña', () {
    test('Debe retornar true para contraseña con más de 6 caracteres', () {
      expect(Validators.validarSeguridadPassword('1234567'), true);
      expect(Validators.validarSeguridadPassword('password123'), true);
      expect(Validators.validarSeguridadPassword('MiClave2024'), true);
    });

    test('Debe retornar false para contraseña con 6 caracteres o menos', () {
      expect(Validators.validarSeguridadPassword('123456'), false);
      expect(Validators.validarSeguridadPassword('abc'), false);
      expect(Validators.validarSeguridadPassword(''), false);
    });
  });

  // ============================================================================
  // Prueba 3: Calculadora Descuento
  // ============================================================================
  group('Prueba 3 - Calculadora Descuento', () {
    test('Debe calcular correctamente el precio con descuento del 10%', () {
      final precioFinal = Validators.calcularDescuento(100.0, 10.0);
      expect(precioFinal, 90.0);
    });

    test('Debe calcular correctamente el precio con descuento del 50%', () {
      final precioFinal = Validators.calcularDescuento(200.0, 50.0);
      expect(precioFinal, 100.0);
    });

    test('Debe calcular correctamente el precio con descuento del 25%', () {
      final precioFinal = Validators.calcularDescuento(80.0, 25.0);
      expect(precioFinal, 60.0);
    });

    test('Debe retornar el mismo precio con descuento del 0%', () {
      final precioFinal = Validators.calcularDescuento(150.0, 0.0);
      expect(precioFinal, 150.0);
    });

    test('Debe lanzar error para valores negativos', () {
      expect(() => Validators.calcularDescuento(-100.0, 10.0), throwsArgumentError);
      expect(() => Validators.calcularDescuento(100.0, -10.0), throwsArgumentError);
    });

    test('Debe lanzar error para descuento mayor a 100%', () {
      expect(() => Validators.calcularDescuento(100.0, 150.0), throwsArgumentError);
    });
  });

  // ============================================================================
  // Prueba 4: Rango Válido
  // ============================================================================
  group('Prueba 4 - Rango Válido', () {
    test('Debe retornar true para números entre 1 y 10 (inclusive)', () {
      expect(Validators.validarRango(1), true);
      expect(Validators.validarRango(5), true);
      expect(Validators.validarRango(10), true);
      expect(Validators.validarRango(7), true);
    });

    test('Debe retornar false para números menores a 1', () {
      expect(Validators.validarRango(0), false);
      expect(Validators.validarRango(-5), false);
      expect(Validators.validarRango(-100), false);
    });

    test('Debe retornar false para números mayores a 10', () {
      expect(Validators.validarRango(11), false);
      expect(Validators.validarRango(50), false);
      expect(Validators.validarRango(1000), false);
    });
  });

  // ============================================================================
  // Prueba 5: Texto a Mayúsculas
  // ============================================================================
  group('Prueba 5 - Texto a Mayúsculas', () {
    test('Debe convertir texto en minúsculas a mayúsculas', () {
      expect(Validators.textoAMayusculas('hola mundo'), 'HOLA MUNDO');
      expect(Validators.textoAMayusculas('flutter'), 'FLUTTER');
    });

    test('Debe mantener texto ya en mayúsculas', () {
      expect(Validators.textoAMayusculas('HOLA'), 'HOLA');
      expect(Validators.textoAMayusculas('DART'), 'DART');
    });

    test('Debe convertir texto mixto a mayúsculas', () {
      expect(Validators.textoAMayusculas('HoLa MuNdO'), 'HOLA MUNDO');
      expect(Validators.textoAMayusculas('Flutter 2024'), 'FLUTTER 2024');
    });

    test('Debe manejar texto vacío', () {
      expect(Validators.textoAMayusculas(''), '');
    });

    test('Debe manejar texto con números y símbolos', () {
      expect(Validators.textoAMayusculas('test123!@#'), 'TEST123!@#');
    });
  });
}
