import 'package:flutter_nfc_kit/flutter_nfc_kit.dart';

class NfcService {
  static final NfcService _instance = NfcService._internal();
  factory NfcService() => _instance;
  NfcService._internal();

  // Verificar disponibilidad de NFC
  Future<bool> isNfcAvailable() async {
    try {
      NFCAvailability availability = await FlutterNfcKit.nfcAvailability;
      return availability == NFCAvailability.available;
    } catch (e) {
      return false;
    }
  }

  // Leer pulsera NFC y obtener código universitario
  Future<String> readNfcCard() async {
    try {
      // Verificar disponibilidad
      bool available = await isNfcAvailable();
      if (!available) {
        throw Exception('NFC no está disponible en este dispositivo');
      }

      // Iniciar sesión NFC con timeout más corto para lectura inmediata
      NFCTag tag = await FlutterNfcKit.poll(
        timeout: Duration(seconds: 5),
        iosMultipleTagMessage:
            "Múltiples tags detectados, por favor acerque solo una pulsera",
        iosAlertMessage: "Leyendo pulsera...",
      );

      // Verificar que es un tag válido
      if (tag.id.isEmpty) {
        throw Exception('Tag NFC inválido');
      }

      // Leer datos del tag
      String codigoUniversitario = await _extractCodigoFromTag(tag);

      return codigoUniversitario;
    } catch (e) {
      throw Exception('Error al leer NFC: $e');
    } finally {
      // Finalizar sesión NFC
      await FlutterNfcKit.finish(iosAlertMessage: "Lectura completada");
    }
  }

  // Extraer código universitario del tag NFC - Optimizado para MIFARE Classic
  Future<String> _extractCodigoFromTag(NFCTag tag) async {
    try {
      String tagId = tag.id;

      // Método 1: Intentar leer datos NDEF si están disponibles
      if (tag.ndefAvailable == true) {
        try {
          var ndefRecords = await FlutterNfcKit.readNDEFRecords();

          if (ndefRecords.isNotEmpty) {
            for (var record in ndefRecords) {
              if (record.payload != null && record.payload!.isNotEmpty) {
                String payload = String.fromCharCodes(record.payload!);

                // Buscar formato específico: "codigo:XXXXXXXX"
                if (payload.contains('codigo:')) {
                  String codigo = payload.split('codigo:')[1].trim();
                  return codigo;
                }

                // Si el payload es un código directo (solo números/letras)
                if (RegExp(r'^[A-Z0-9]{6,12}$').hasMatch(payload.trim())) {
                  return payload.trim();
                }
              }
            }
          }
        } catch (e) {
          // Error leyendo NDEF, continuar con otros métodos
        }
      }

      // Método 2: Para MIFARE Classic - usar el ID hexadecimal del tag
      if (tag.type.toString().toLowerCase().contains('mifare') ||
          tag.standard.toString().toLowerCase().contains('14443')) {
        // Convertir ID hexadecimal a diferentes formatos
        String hexId = tagId.toLowerCase().replaceAll(' ', '');

        // Opción 1: Usar ID hexadecimal completo como código (en minúsculas)
        if (hexId.length >= 6) {
          String codigoHex = hexId;
          return codigoHex;
        } // Opción 2: Convertir hex a decimal y usar como código
        try {
          int decimalId = int.parse(hexId, radix: 16);
          String codigoDecimal = decimalId.toString();

          // Si es muy largo, tomar los últimos 8 dígitos
          if (codigoDecimal.length > 8) {
            codigoDecimal = codigoDecimal.substring(codigoDecimal.length - 8);
          }

          return codigoDecimal;
        } catch (e) {
          // Error convirtiendo, continuar con fallback
        }
      }

      // Método 3: Fallback - usar ID del tag directamente
      String cleanId = tagId
          .toLowerCase()
          .replaceAll(' ', '')
          .replaceAll(':', '');
      if (cleanId.length >= 6) {
        String codigo =
            cleanId.length > 8
                ? cleanId.substring(cleanId.length - 8)
                : cleanId;
        return codigo;
      }

      throw Exception('No se pudo extraer un código válido de la tarjeta');
    } catch (e) {
      throw Exception('Error al extraer código del tag: $e');
    }
  }

  // Escribir código universitario a una pulsera NFC (para configuración)
  Future<void> writeCodigoToNfc(String codigoUniversitario) async {
    try {
      // Verificar disponibilidad
      bool available = await isNfcAvailable();
      if (!available) {
        throw Exception('NFC no está disponible en este dispositivo');
      }

      // Por ahora, esta funcionalidad está pendiente de implementar
      // según el formato específico de las pulseras NFC
      throw Exception('Funcionalidad de escritura NFC en desarrollo');
    } catch (e) {
      throw Exception('Error al escribir NFC: $e');
    }
  }

  // Leer NFC y mostrar resultado inmediatamente
  Future<String> readNfcWithResult() async {
    try {
      // Verificar disponibilidad
      bool available = await isNfcAvailable();
      if (!available) {
        throw Exception('❌ NFC no está disponible en este dispositivo');
      }

      // Iniciar polling NFC
      NFCTag tag = await FlutterNfcKit.poll(
        timeout: Duration(seconds: 8),
        iosAlertMessage: "🔍 Acerque la pulsera al dispositivo...",
      );

      if (tag.id.isEmpty) {
        throw Exception('❌ Tag NFC inválido (ID vacío)');
      }

      // Extraer código
      String codigo = await _extractCodigoFromTag(tag);

      return codigo;
    } catch (e) {
      rethrow;
    } finally {
      try {
        await FlutterNfcKit.finish(iosAlertMessage: "✅ Lectura completada");
      } catch (e) {
        // Ignorar errores al finalizar
      }
    }
  }

  // Detener cualquier operación NFC en curso
  Future<void> stopNfcSession() async {
    try {
      await FlutterNfcKit.finish();
    } catch (e) {
      // Ignorar errores al finalizar
    }
  }
}
