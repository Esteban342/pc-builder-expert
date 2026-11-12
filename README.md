# PC Builder Expert: Sistema Experto para Armado y Compatibilidad de Computadoras

Este repositorio contiene el proyecto final para la materia de Programación Lógica y Funcional. Consiste en un Sistema Experto basado en reglas, desarrollado utilizando Java para la interfaz de usuario y Prolog para la base de conocimiento y la inferencia lógica.

El sistema está diseñado para orientar a los usuarios en la elección de componentes de hardware (CPU, GPU, Motherboard y RAM) para armar una computadora personal. A través de un cuestionario interactivo, el sistema deduce el mejor "Build" basándose en el presupuesto del usuario y el uso principal que le dará a la PC (Gaming, Edición, Programación o Estudio/Maestro).

## Características del Sistema

*   Interfaz gráfica interactiva desarrollada en Java utilizando `JOptionPane` (ventanas emergentes nativas), cumpliendo estrictamente con el requisito de no usar HTML, CSS ni JavaScript.
*   Base de conocimiento robusta en Prolog con componentes reales del mercado (procesadores AMD/Intel, tarjetas NVIDIA/AMD, etc.) con sus precios y consumos (TDP) reales.
*   **Lógica de inferencia compleja:**
    *   **Compatibilidad de Socket:** Asegura que el CPU y la Motherboard sean físicamente compatibles (AM4, AM5, LGA1700).
    *   **Cálculo de Fuente de Poder:** Suma el TDP del CPU y la GPU, añade un 30% de margen de seguridad y recomienda el rango de Watts necesario.
    *   **Detección de Cuello de Botella:** Evita combinaciones ilógicas (ej. un CPU de gama baja con una GPU de gama alta) para no desperdiciar el presupuesto.
    *   **Validación de Presupuesto y Uso:** Filtra los componentes según el enfoque del usuario (ej. priorizar CPU para programación o priorizar GPU para Gaming) sin exceder el dinero disponible.

## Tecnologías Utilizadas

*   Java (JDK 25)
*   SWI-Prolog (versión 10.x)
*   Librería JPL (Java Interface to SWI-Prolog) para la conexión entre ambos entornos.
*   Patrón de arquitectura de software MVC (Modelo-Vista-Controlador).
*   Git y GitHub para el control de versiones.

## Estructura del Repositorio

*   `prolog/`: Contiene el archivo `base_conocimiento.pl` con los hechos (componentes) y reglas lógicas del sistema experto.
*   `java/`: Contiene el código fuente del proyecto en Java bajo el patrón MVC.
    *   `src/app/`: Código fuente (Main, Servicios, etc.).
    *   `lib/`: Librerías externas necesarias (jpl.jar).
    *   `bin/`: Archivos `.dll` de SWI-Prolog necesarios para la conexión nativa.
    *   `ejecutar.bat`: Script automatizado para compilar y ejecutar el proyecto en Windows.

## Requisitos Previos

Para ejecutar y probar este proyecto de manera local, es necesario tener instalado:

1.  Java Development Kit (JDK) versión 17 o superior.
2.  SWI-Prolog instalado y configurado en las variables de entorno del sistema.
3.  Un IDE para Java (VS Code, NetBeans o Eclipse) o simplemente usar la terminal de comandos.

## Instrucciones de Ejecución

1. Clonar el repositorio a tu máquina local:
   ```bash
   git clone https://github.com/Esteban342/pc-builder-expert.git

2. Abrir la carpeta del proyecto en tu IDE de preferencia o terminal.

3. Asegurarse de tener el archivo jpl.jar y los archivos .dll de Prolog en sus respectivas carpetas (java/lib/ y java/bin/).

4. Ejecutar el archivo .bat desde la terminal en la raíz del proyecto:

.\java\ejecutar.bat

(Este script se encarga de configurar las rutas de las librerías nativas, compilar el código y abrir la interfaz).

5. Interactuar con las ventanas emergentes respondiendo el cuestionario para recibir la recomendación del sistema.

Autor

(Mejorado Martinez Juan Esteban)

Ingeniería en Sistemas Computacionales
