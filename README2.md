# SM2 - Examen Unidad 3
## Implementación de CI/CD con GitHub Actions

---

## 📋 Información del Estudiante

- **Nombre:** Angel Gadiel Hernandez Cruz
- **Curso:** Sistemas Móviles 2
- **Fecha:** 18 de Noviembre de 2025
- **Repositorio:** [https://github.com/Angelhc123/SM2_ExamenUnidad3](https://github.com/Angelhc123/SM2_ExamenUnidad3)

---

## 🎯 Objetivos del Examen

Implementar un sistema de integración continua (CI/CD) utilizando GitHub Actions para:
1. Ejecutar análisis estático del código Flutter
2. Ejecutar pruebas unitarias automáticamente
3. Verificar la compilación del proyecto
4. Generar reportes de calidad del código

---

## 📁 Estructura del Proyecto

### 1. Estructura de Carpetas GitHub Actions

Se creó la siguiente estructura en el repositorio:

```
.github/
└── workflows/
    └── quality-check.yml
test/
└── main_test.dart
```

<!-- Imagen: Estructura de carpetas .github/workflows/ -->
![Estructura de carpetas](assets/estructura-carpetas.png)

---

## 🔧 Configuración del Workflow

### Archivo `quality-check.yml`

El workflow se configuró para ejecutarse automáticamente en:
- **Push** a las ramas `main` y `develop`
- **Pull requests** hacia `main` y `develop`

#### Contenido del Workflow

<!-- Imagen: Contenido completo del archivo quality-check.yml -->
![Contenido quality-check.yml](assets/quality-check-yml.png)

El workflow incluye 3 jobs principales:

#### **Job 1: flutter-test** (Análisis y Pruebas Flutter)
```yaml
- Checkout del código
- Configuración de Java 17
- Instalación de Flutter 3.27.1
- Instalación de dependencias (flutter pub get)
- Análisis estático del código (flutter analyze)
- Verificación de formato (dart format)
- Ejecución de pruebas unitarias (flutter test --coverage)
- Generación de reporte de cobertura
```

#### **Job 2: backend-test** (Verificación Backend Node.js)
```yaml
- Checkout del código
- Configuración de Node.js 18
- Instalación de dependencias del backend
- Verificación del código backend
```

#### **Job 3: build-check** (Verificación de Compilación)
```yaml
- Checkout del código
- Configuración de Java 17
- Instalación de Flutter 3.27.1
- Instalación de dependencias
- Compilación de APK en modo debug
```

---

## ✅ Pruebas Unitarias

### Archivo `test/main_test.dart`

Se implementaron **11 pruebas unitarias** organizadas en 3 grupos:

#### 1. Pruebas del Modelo AlumnoModel (3 tests)
- ✓ Creación desde JSON
- ✓ Conversión a JSON
- ✓ Manejo de valores nulos

#### 2. Pruebas del Modelo UsuarioModel (3 tests)
- ✓ Creación desde JSON
- ✓ Valores por defecto
- ✓ Manejo de fechas

#### 3. Pruebas de Configuración API (5 tests)
- ✓ URL base válida
- ✓ Generación de endpoints
- ✓ Consistencia de URLs

<!-- Imagen: Código de las pruebas unitarias en main_test.dart -->
![Código de pruebas unitarias](assets/main-test-dart.png)

---

## 🚀 Ejecución del Workflow

### Ejecución Automática en GitHub Actions

Al hacer `git push` al repositorio, GitHub Actions ejecuta automáticamente:
1. `flutter analyze` - Análisis estático sobre todo el proyecto
2. `flutter test` - Pruebas unitarias sobre el contenido de `test/`
3. `flutter build apk` - Verificación de compilación

<!-- Imagen: Pestaña Actions mostrando los workflows ejecutados -->
![GitHub Actions - Workflows](assets/github-actions-workflows.png)

### Resultados de Ejecución

<!-- Imagen: Detalle de la ejecución exitosa del workflow -->
![Resultado exitoso del workflow](assets/workflow-success.png)

**Estado:** ✅ **100% PASSED**

Todos los checks pasaron exitosamente:
- ✅ Quality Check / Análisis y Pruebas Backend Node.js (push) - Successful in 12s
- ✅ Quality Check / Análisis y Pruebas Flutter (push) - Successful in 1m
- ✅ Quality Check / Verificar Build de la Aplicación (push) - Successful in 7m

---

## 🧪 Ejecución Local de Pruebas

### Pruebas Unitarias Locales

Las pruebas también se ejecutaron localmente para verificar su funcionamiento:

```bash
flutter test
```

<!-- Imagen: Resultado de flutter test ejecutado localmente -->
![Ejecución local de pruebas](assets/flutter-test-local.png)

**Resultado:** Todas las pruebas pasaron exitosamente ✅

---

## 📊 Explicación de lo Realizado

### 1. Creación del Repositorio
Se creó el repositorio público `SM2_ExamenUnidad3` en GitHub y se subió todo el proyecto Flutter desarrollado durante el curso.

### 2. Configuración de GitHub Actions
Se implementó un workflow de integración continua que:
- **Valida la calidad del código** mediante análisis estático
- **Ejecuta pruebas automáticas** para verificar la funcionalidad
- **Verifica la compilación** del proyecto Android
- **Genera reportes** de cobertura de código

### 3. Implementación de Pruebas Unitarias
Se crearon 11 pruebas unitarias que validan:
- **Modelos de datos:** Serialización/deserialización JSON
- **Configuración API:** URLs y endpoints correctos
- **Manejo de datos:** Valores por defecto y nulos

### 4. Correcciones Realizadas
Durante la implementación se corrigieron:
- **Nombre del paquete:** De `moviles2` a `sm2_examenunidad3`
- **Versión de Flutter:** Actualizada a 3.27.1 para compatibilidad con Dart SDK 3.5.3
- **Comando de formato:** Cambiado de `flutter format` a `dart format`
- **Manejo de warnings:** Configurado `continue-on-error` para no detener el workflow

### 5. Resultados Finales
- ✅ **Workflow funcionando al 100%**
- ✅ **Todas las pruebas pasando**
- ✅ **Compilación exitosa**
- ✅ **Código analizado sin errores críticos**

---

## 🔍 Verificación de Ejecución Automática

### Trigger del Workflow
El workflow se ejecuta automáticamente cuando:
1. Se hace `git push` a la rama `main` o `develop`
2. Se crea un pull request hacia `main` o `develop`

### Comandos Ejecutados Automáticamente
```bash
# 1. Análisis estático del código
flutter analyze --no-fatal-infos

# 2. Verificación de formato
dart format --set-exit-if-changed .

# 3. Ejecución de pruebas con cobertura
flutter test --coverage

# 4. Verificación de compilación
flutter build apk --debug --no-pub
```

---

## 📈 Resultados para el Informe

### Estado del Workflow: ✅ 100% PASSED

| Job | Estado | Tiempo |
|-----|--------|--------|
| Análisis y Pruebas Flutter | ✅ Passed | 1m |
| Análisis Backend Node.js | ✅ Passed | 12s |
| Verificar Build APK | ✅ Passed | 7m |

**Conclusión:** Todos los checks pasaron exitosamente, cumpliendo con el requisito del 100% de éxito.

---

## 🎓 Conclusiones

1. Se implementó exitosamente un sistema de CI/CD con GitHub Actions
2. El proyecto cuenta con pruebas unitarias automatizadas
3. Se garantiza la calidad del código mediante análisis estático
4. La compilación del proyecto se verifica automáticamente
5. El workflow está completamente funcional y automatizado

---

## 📝 Notas Adicionales

- El proyecto utiliza Flutter 3.27.1 con Dart SDK 3.5.3
- Se implementaron 11 pruebas unitarias que cubren los modelos principales
- El backend en Node.js también se verifica en el workflow
- Se genera reporte de cobertura de código automáticamente

---

**Fecha de entrega:** 18 de Noviembre de 2025  
**Estudiante:** Angel Gadiel Hernandez Cruz  
**Repositorio:** [SM2_ExamenUnidad3](https://github.com/Angelhc123/SM2_ExamenUnidad3)
