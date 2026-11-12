package app;

import app.servicio.PrologService;
import javax.swing.*;
import java.util.Map;

public class Main {
    public static void main(String[] args) {
        // 1. Iniciar el servicio (conecta con Prolog)
        PrologService servicio;
        try {
            servicio = new PrologService();
        } catch (Exception e) {
            JOptionPane.showMessageDialog(null, "Error crítico al cargar Prolog: " + e.getMessage(), "Error", JOptionPane.ERROR_MESSAGE);
            return;
        }

        // 2. Mensaje de bienvenida
        JOptionPane.showMessageDialog(null, 
            "Bienvenido a PC Builder Expert.\n\nTe ayudaremos a elegir los mejores componentes para tu computadora.", 
            "Sistema Experto", 
            JOptionPane.INFORMATION_MESSAGE);

        // 3. Preguntar el Uso
        String[] opcionesUso = {"gaming", "programacion", "edicion", "maestro"};
        String usoSeleccionado = (String) JOptionPane.showInputDialog(
                null,
                "¿Cuál es el uso principal que le darás a tu PC?",
                "Paso 1: Uso",
                JOptionPane.QUESTION_MESSAGE,
                null,
                opcionesUso,
                opcionesUso[0]
        );

        if (usoSeleccionado == null) {
            JOptionPane.showMessageDialog(null, "Análisis cancelado.");
            return;
        }

        // 4. Preguntar el Presupuesto
        String inputPresupuesto = JOptionPane.showInputDialog(
                null,
                "¿Cuál es tu presupuesto en dólares (USD)?\n(Ejemplo: 800)",
                "Paso 2: Presupuesto",
                JOptionPane.QUESTION_MESSAGE
        );

        if (inputPresupuesto == null || inputPresupuesto.trim().isEmpty()) {
            JOptionPane.showMessageDialog(null, "Análisis cancelado.");
            return;
        }

        double presupuesto;
        try {
            presupuesto = Double.parseDouble(inputPresupuesto);
        } catch (NumberFormatException e) {
            JOptionPane.showMessageDialog(null, "Por favor, ingresa un número válido.", "Error", JOptionPane.ERROR_MESSAGE);
            return;
        }

        // 5. Validar que el presupuesto alcance
        if (!servicio.presupuestoEsSuficiente(usoSeleccionado, presupuesto)) {
            JOptionPane.showMessageDialog(null, 
                "El presupuesto de $" + presupuesto + " es demasiado bajo para un uso de tipo: " + usoSeleccionado + ".\nPor favor, intenta con un presupuesto más alto.", 
                "Presupuesto Insuficiente", 
                JOptionPane.WARNING_MESSAGE);
            return;
        }

        // 6. Obtener el mejor Build de Prolog
        Map<String, String> build = servicio.obtenerMejorBuild(usoSeleccionado, presupuesto);

        if (build == null) {
            JOptionPane.showMessageDialog(null, "No se encontró una combinación compatible para ese presupuesto.", "Sin Resultados", JOptionPane.WARNING_MESSAGE);
            return;
        }

        // 7. Obtener detalles extra (Costo, Watts, Fuente)
        String cpu = build.get("cpu");
        String gpu = build.get("gpu");
        String mb = build.get("motherboard");
        String ram = build.get("ram");

        double costoTotal = servicio.obtenerCostoTotal(cpu, gpu, mb, ram);
        double watts = servicio.obtenerConsumoEstimado(cpu, gpu);
        String fuente = servicio.obtenerFuenteRecomendada(cpu, gpu);

        // 8. Mostrar el resultado final
        String mensajeResultado = String.format(
            "¡Tu Build Recomendado!\n\n" +
            "CPU: %s\n" +
            "Tarjeta Gráfica (GPU): %s\n" +
            "Motherboard: %s\n" +
            "RAM: %s\n\n" +
            "Costo Total: $%.2f USD\n" +
            "Consumo Estimado: %.0f W\n" +
            "Fuente recomendada: %s\n\n" +
            "Presupuesto usado: $%.2f / $%.2f",
            cpu, gpu, mb, ram, costoTotal, watts, fuente, costoTotal, presupuesto
        );

        JOptionPane.showMessageDialog(null, mensajeResultado, "Resultado del Sistema Experto", JOptionPane.INFORMATION_MESSAGE);
    }
}