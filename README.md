# PC Builder Expert: Sistema Experto para Armado y Compatibilidad de Computadoras

Este repositorio contiene el proyecto final para la materia de Programación Lógica y Funcional. Consiste en un Sistema Experto basado en reglas, desarrollado utilizando Java para la interfaz de usuario y Prolog para la base de conocimiento y la inferencia lógica.

El sistema está diseñado para orientar a los usuarios en la elección de componentes de hardware para armar una computadora personal. A través de un cuestionario interactivo, el sistema deduce el mejor "Build" posible basándose en el presupuesto del usuario, el uso principal (Gaming, Edición, Programación o Maestro) y restricciones físicas reales.

## Características del Sistema

*   **Interfaz gráfica moderna:** Desarrollada en Java Swing utilizando **FlatLaf** (Modo Oscuro Ejecutivo), cumpliendo estrictamente con el requisito de no usar HTML, CSS ni JavaScript.
*   **Catálogo masivo de hardware:** Base de conocimiento en Prolog con más de **110 componentes reales** (CPUs, GPUs, Motherboards, RAM, SSD/HDD, Fuentes y Gabinetes) con sus precios y consumos (TDP) reales.
*   **Lógica de inferencia compleja (El Cerebro):**
    *   **Compatibilidad Física:** Valida sockets (AM4, AM5, LGA1700), tipo de RAM (DDR4/DDR5) y chipsets.
    *   **Validación de Espacio:** Asegura que la tarjeta gráfica quepa a lo largo en el gabinete y que el cooler no exceda la altura máxima.
    *   **Cálculo de Fuente de Poder:** Suma el TDP del CPU y la GPU, añade un 30% de margen de seguridad, y exige fuentes con certificación Gold si la GPU es de gama alta.
    *   **Detección de Cuello de Botella:** Evita combinaciones ilógicas (ej. un CPU de gama baja con una GPU de gama alta, o viceversa).
    *   **Reglas por Software:** Filtra componentes según el software (ej. exige tarjetas NVIDIA para Blender, o 32GB de RAM para Inteligencia Artificial local y Máquinas Virtuales).
*   **Ajuste de Presupuesto:** El sistema descuenta el costo de periféricos (monitor, teclado, ratón) para calcular el presupuesto real de la torre.

## Tecnologías Utilizadas

*   Java (JDK 17 o superior)
*   SWI-Prolog (versión 9 o 10)
*   Librería JPL (Java Interface to SWI-Prolog) para la conexión entre ambos entornos.
*   **FlatLaf** para la mejora visual de la interfaz.
*   Patrón de arquitectura de software MVC (Modelo-Vista-Controlador).
*   Git y GitHub para el control de versiones.

## Estructura del Repositorio

*   `prolog/`: Contiene el archivo `base_conocimiento.pl` con los hechos, reglas lógicas y perfiles del sistema experto.
*   `java/`: Contiene el código fuente del proyecto en Java.
    *   `src/app/`: Código fuente (Main, Servicios, etc.).
    *   `lib/`: Librerías externas necesarias (`jpl.jar`, `flatlaf.jar`).
    *   `bin/`: Archivos `.dll` de SWI-Prolog necesarios para la conexión nativa (Portabilidad).
    *   `ejecutar.bat`: Script automatizado para compilar y ejecutar el proyecto en Windows.

## Requisitos Previos (Para Ejecutar desde el Código)

Para ejecutar y probar este proyecto de manera local (desde el código fuente), es necesario tener instalado:

1.  Java Development Kit (JDK) versión 17 o superior.
2.  SWI-Prolog (se recomienda instalarlo en la ruta por defecto `C:\Program Files\swipl`).
3.  Un IDE para Java (VS Code, NetBeans o Eclipse) o terminal de comandos.

## Instrucciones de Ejecución

### Opción A: Desde el código fuente (Desarrollo)
1. Clonar el repositorio:
   `git clone https://github.com/Esteban342/pc-builder-expert.git`
2. Abrir la carpeta del proyecto en tu IDE o terminal.
3. Asegurarse de tener el archivo `jpl.jar` y los archivos `.dll` en sus carpetas correspondientes (`java/lib/` y `java/bin/`).
4. Ejecutar el archivo `.bat` desde la terminal en la raíz del proyecto:
   `.\java\ejecutar.bat`

### Opción B: Usando el Ejecutable (.exe) - Para el Usuario Final
1. Descargar la carpeta comprimida (ZIP) de la versión final.
2. Descomprimir la carpeta `PCBuilderExpert`.
3. Hacer doble clic en el archivo `PCBuilderExpert.exe`. 
*(Esta versión empaquetada con `jpackage` incluye todo lo necesario para correr en Windows sin instalar Java ni Prolog).*

## Autores

*   **Esteban342** (Mejorado Martinez Juan Esteban) - *Desarrollo Lógico y Java*
*   **Cristian** - *Documentación y Video*
*   **Chuchin** - *Manual de Usuario y Pruebas*
*   **Jesús** - *Cronograma y Reporte Técnico*

*Ingeniería en Sistemas Computacionales*
