# Tech Advisor: Sistema Experto para Recomendación de Lenguajes de Programación

Este repositorio contiene el proyecto final para la materia de Programación Lógica y Funcional. Consiste en un Sistema Experto basado en reglas, desarrollado utilizando Java para la interfaz de usuario y Prolog para la base de conocimiento y la inferencia lógica.

El sistema está diseñado para orientar a estudiantes de Sistemas Computacionales (o principiantes en el área) sobre qué lenguaje de programación y área de especialización (Tech Stack) les conviene aprender, basándose en sus intereses personales, tolerancia a la dificultad y expectativas laborales.

## Características del Sistema

*   Interfaz gráfica interactiva desarrollada en Java (Swing/JavaFX).
*   Base de conocimiento robusta en Prolog con hechos categorizados (lenguajes, usos, dificultad, demanda laboral y entorno ideal).
*   Motor de inferencia lógico que cruza las preferencias del usuario con la base de datos para deducir la mejor recomendación.
*   Conexión bidireccional entre Java y Prolog para el envío de consultas y la recepción de resultados.

## Tecnologías Utilizadas

*   Java (JDK)
*   SWI-Prolog
*   Librería JPL (Java Interface to SWI-Prolog) o TuProlog para la conexión entre ambos entornos.
*   Git y GitHub para el control de versiones.

## Estructura del Repositorio

*   `prolog/`: Contiene el archivo `.pl` con los hechos y reglas lógicas del sistema experto.
*   `java/`: Contiene el código fuente del proyecto en Java, así como las librerías externas necesarias.
*   `docs/`: Documentación del proyecto, incluyendo el manual de usuario en formato PDF y el cronograma de trabajo.

## Requisitos Previos

Para ejecutar y probar este proyecto de manera local, es necesario tener instalado:

1.  Java Development Kit (JDK) versión 8 o superior.
2.  SWI-Prolog instalado y configurado en las variables de entorno del sistema.
3.  Un IDE para Java (VS Code, NetBeans o Eclipse).

## Instrucciones de Ejecución

1.  Clonar el repositorio a tu máquina local:
    `git clone https://github.com/tu-usuario/tech-advisor-expert-system.git`
2.  Abrir la carpeta del proyecto en tu IDE de preferencia.
3.  Asegurarse de que la librería de conexión (JPL.jar o similar) esté correctamente enlazada en el *Build Path* del proyecto.
4.  Ejecutar el archivo principal de Java (Main.java).
5.  Interactuar con la interfaz respondiendo el cuestionario para recibir la recomendación del sistema.

## Autor

*   [Mejorado Martinez Juan Esteban]
*   Ingeniería en Sistemas Computacionales
