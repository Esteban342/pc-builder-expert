package app;

import app.servicio.PrologService;
import javax.swing.*;
import java.util.Map;

public class Main {
    public static void main(String[] args) {
        PrologService servicio;
        try {
            servicio = new PrologService();
        } catch (Exception e) {
            JOptionPane.showMessageDialog(null, "Error crítico al cargar Prolog: " + e.getMessage(), "Error", JOptionPane.ERROR_MESSAGE);
            return;
        }

        JOptionPane.showMessageDialog(null, 
            "Bienvenido a PC Builder Expert.\n\nTe ayudaremos a elegir los mejores componentes para tu computadora.", 
            "Sistema Experto", JOptionPane.INFORMATION_MESSAGE);

        String[] opcionesUso = {"gaming", "programacion", "edicion", "maestro"};
        String usoSeleccionado = (String) JOptionPane.showInputDialog(null, "¿Cuál es el uso principal que le darás a tu PC?", "Paso 1: Uso", JOptionPane.QUESTION_MESSAGE, null, opcionesUso, opcionesUso[0]);
        
        if (usoSeleccionado == null) return;

        String inputPresupuesto = JOptionPane.showInputDialog(null, "¿Cuál es tu presupuesto en dólares (USD)?\n(Ejemplo: 800)", "Paso 2: Presupuesto", JOptionPane.QUESTION_MESSAGE);
        if (inputPresupuesto == null || inputPresupuesto.trim().isEmpty()) return;

        double presupuesto;
        try {
            presupuesto = Double.parseDouble(inputPresupuesto);
        } catch (NumberFormatException e) {
            JOptionPane.showMessageDialog(null, "Por favor, ingresa un número válido.", "Error", JOptionPane.ERROR_MESSAGE);
            return;
        }

        if (!servicio.presupuestoEsSuficiente(usoSeleccionado, presupuesto)) {
            JOptionPane.showMessageDialog(null, "El presupuesto de $" + presupuesto + " es demasiado bajo para un uso de tipo: " + usoSeleccionado + ".\nPor favor, intenta con un presupuesto más alto.", "Presupuesto Insuficiente", JOptionPane.WARNING_MESSAGE);
            return;
        }

        servicio.limpiarPreferencias();
        hacerPreguntasDinamicas(servicio, usoSeleccionado);

        Map<String, String> build = servicio.obtenerMejorBuild(usoSeleccionado, presupuesto);

        if (build == null) {
            JOptionPane.showMessageDialog(null, "No se encontró una combinación compatible para ese presupuesto.", "Sin Resultados", JOptionPane.WARNING_MESSAGE);
            return;
        }

        String idCpu = build.get("cpu");
        String idGpu = build.get("gpu");
        String idMb = build.get("motherboard");
        String idRam = build.get("ram");
        String idAlm = build.get("almacenamiento");

        String nombreCpu = servicio.obtenerNombreComponente("cpu", idCpu);
        String nombreGpu = servicio.obtenerNombreComponente("gpu", idGpu);
        String nombreMb = servicio.obtenerNombreComponente("motherboard", idMb);
        String nombreRam = servicio.obtenerNombreComponente("ram", idRam);
        String nombreAlm = servicio.obtenerNombreComponente("almacenamiento", idAlm);

        double costoTotal = servicio.obtenerCostoTotal(idCpu, idGpu, idMb, idRam, idAlm);
        double watts = servicio.obtenerConsumoEstimado(idCpu, idGpu);
        String fuente = servicio.obtenerFuenteRecomendada(idCpu, idGpu);

        String mensajeResultado = String.format(
            "¡Tu Build Recomendado!\n\n" +
            "CPU: %s\n" +
            "Tarjeta Gráfica: %s\n" +
            "Motherboard: %s\n" +
            "RAM: %s\n" +
            "Almacenamiento: %s\n\n" +
            "Costo Total: $%.2f USD\n" +
            "Consumo Estimado: %.0f W\n" +
            "Fuente recomendada: %s\n\n" +
            "Presupuesto usado: $%.2f / $%.2f",
            nombreCpu, nombreGpu, nombreMb, nombreRam, nombreAlm, 
            costoTotal, watts, fuente, costoTotal, presupuesto
        );

        JOptionPane.showMessageDialog(null, mensajeResultado, "Resultado del Sistema Experto", JOptionPane.INFORMATION_MESSAGE);
    }

    private static void hacerPreguntasDinamicas(PrologService servicio, String uso) {
        if (uso.equals("gaming")) {
            String[] res = {"1080p_60hz", "1080p_144hz", "1440p_144hz", "4k_144hz"};
            String r1 = (String) JOptionPane.showInputDialog(null, "¿A qué resolución y tasa de refresco apuntas?", "Gaming", JOptionPane.QUESTION_MESSAGE, null, res, res[0]);
            if (r1 != null) servicio.insertarPreferencia("pref_gaming_resolucion", r1);

            String[] juegos = {"esports", "aaa", "simulacion", "vr"};
            String r2 = (String) JOptionPane.showInputDialog(null, "¿Qué tipo de juegos disfrutas más?", "Gaming", JOptionPane.QUESTION_MESSAGE, null, juegos, juegos[0]);
            if (r2 != null) servicio.insertarPreferencia("pref_gaming_juegos", r2);

            String[] prioridad = {"gpu", "cpu"};
            String r3 = (String) JOptionPane.showInputDialog(null, "¿Prefieres gastar más en la Tarjeta Gráfica (GPU) o en el Procesador (CPU)?", "Gaming", JOptionPane.QUESTION_MESSAGE, null, prioridad, prioridad[0]);
            if (r3 != null) servicio.insertarPreferencia("pref_gaming_prioridad", r3);
            
        } else if (uso.equals("edicion")) {
            String[] software = {"premiere", "davinci", "blender", "arquitectura_3d", "fotografia"};
            String r1 = (String) JOptionPane.showInputDialog(null, "¿Qué software usas más?", "Edición", JOptionPane.QUESTION_MESSAGE, null, software, software[0]);
            if (r1 != null) servicio.insertarPreferencia("pref_edicion_software", r1);

            String[] res = {"1080p", "4k", "8k"};
            String r2 = (String) JOptionPane.showInputDialog(null, "¿En qué resolución editas principalmente?", "Edición", JOptionPane.QUESTION_MESSAGE, null, res, res[0]);
            if (r2 != null) servicio.insertarPreferencia("pref_edicion_resolucion", r2);

            String[] prioridad = {"render_gpu", "render_cpu"};
            String r3 = (String) JOptionPane.showInputDialog(null, "¿Prefieres que el renderizado sea rápido por GPU (Tarjeta) o por CPU (Procesador)?", "Edición", JOptionPane.QUESTION_MESSAGE, null, prioridad, prioridad[0]);
            if (r3 != null) servicio.insertarPreferencia("pref_edicion_prioridad", r3);

        } else if (uso.equals("programacion")) {
            String[] area = {"web_movil", "data_ia", "videojuegos", "ciberseguridad", "backend_cloud"};
            String r1 = (String) JOptionPane.showInputDialog(null, "¿Qué tipo de desarrollo haces?", "Programación", JOptionPane.QUESTION_MESSAGE, null, area, area[0]);
            if (r1 != null) servicio.insertarPreferencia("pref_prog_area", r1);

            String[] entorno = {"ligero", "pesado", "compilacion_pesada"};
            String r2 = (String) JOptionPane.showInputDialog(null, "¿Qué tan pesado es tu entorno de desarrollo?", "Programación", JOptionPane.QUESTION_MESSAGE, null, entorno, entorno[0]);
            if (r2 != null) servicio.insertarPreferencia("pref_prog_entorno", r2);

            String[] monitores = {"uno", "dos", "tres_o_mas"};
            String r3 = (String) JOptionPane.showInputDialog(null, "¿Cuántos monitores piensas conectar?", "Programación", JOptionPane.QUESTION_MESSAGE, null, monitores, monitores[0]);
            if (r3 != null) servicio.insertarPreferencia("pref_prog_monitores", r3);

        } else if (uso.equals("maestro")) {
            String[] tareas = {"ofimatica", "diseno_ligero", "base_datos", "docencia_virtual", "gestion_administrativa"};
            String r1 = (String) JOptionPane.showInputDialog(null, "¿Cuáles son tus tareas principales?", "Maestro", JOptionPane.QUESTION_MESSAGE, null, tareas, tareas[0]);
            if (r1 != null) servicio.insertarPreferencia("pref_maestro_tareas", r1);

            String[] formato = {"mini_pc", "torre", "todo_en_uno"};
            String r2 = (String) JOptionPane.showInputDialog(null, "¿Qué formato prefieres?", "Maestro", JOptionPane.QUESTION_MESSAGE, null, formato, formato[0]);
            if (r2 != null) servicio.insertarPreferencia("pref_maestro_formato", r2);
            
            String[] ram = {"8gb", "16gb", "32gb"};
            String r3 = (String) JOptionPane.showInputDialog(null, "¿Cuánta memoria RAM necesitas para tu trabajo diario?", "Maestro", JOptionPane.QUESTION_MESSAGE, null, ram, ram[0]);
            if (r3 != null) servicio.insertarPreferencia("pref_maestro_ram", r3);
        }
    }
}