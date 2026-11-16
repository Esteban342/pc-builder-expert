package app;

import app.servicio.PrologService;

import javax.swing.*;
import java.awt.*;
import java.util.Map;

public class Main {

    private static final class Opcion {
        final String texto, valor;
        Opcion(String texto, String valor) { this.texto = texto; this.valor = valor; }
    }

    public static void main(String[] args) {
        app.servicio.DllLoader.cargar();
        PrologService servicio;
        try {
            servicio = new PrologService();
        } catch (Exception e) {
            JOptionPane.showMessageDialog(null, "Error al cargar Prolog:\n" + e.getMessage(), "Error", JOptionPane.ERROR_MESSAGE);
            return;
        }

        JOptionPane.showMessageDialog(null,
            "Bienvenido a PC Builder Expert.\n\nResponde unas preguntas y te recomendaré el mejor armado posible para tu presupuesto.",
            "PC Builder Expert", JOptionPane.INFORMATION_MESSAGE);

        // 1. Uso
        Opcion[] usos = {
            new Opcion("Gaming", "gaming"),
            new Opcion("Edición de video, 3D o fotos", "edicion"),
            new Opcion("Programación", "programacion"),
            new Opcion("Oficina, clases y estudio", "maestro")
        };
        Opcion uso = elegir("¿Cuál es el uso principal de tu PC?", "Paso 1: Uso", usos);
        if (uso == null) return;

        // 2. Periféricos
        Opcion[] perifericos = {
            new Opcion("Ninguno, ya tengo todo", "0"),
            new Opcion("Solo monitor (~$120)", "120"),
            new Opcion("Monitor, teclado y ratón (~$180)", "180")
        };
        Opcion peri = elegir("¿Qué periféricos ya tienes? (los que falten se suman al costo)", "Paso 2: Periféricos", perifericos);
        if (peri == null) return;
        double costoPeri = Double.parseDouble(peri.valor);

        // 3. Presupuesto
        String entrada = JOptionPane.showInputDialog(null,
            "¿Cuál es tu presupuesto total en USD (incluye periféricos si los vas a comprar)?\nEjemplo: 1000",
            "Paso 3: Presupuesto", JOptionPane.QUESTION_MESSAGE);
        if (entrada == null || entrada.trim().isEmpty()) return;
        double presupuestoTotal;
        try {
            presupuestoTotal = Double.parseDouble(entrada.trim().replace(",", "."));
        } catch (NumberFormatException e) {
            JOptionPane.showMessageDialog(null, "Escribe solo un número, por ejemplo 1000.", "Dato inválido", JOptionPane.WARNING_MESSAGE);
            return;
        }
        if (presupuestoTotal <= 0) return;
        
        double presupuestoTorre = presupuestoTotal - costoPeri;
        
        if (presupuestoTorre <= 0) {
            JOptionPane.showMessageDialog(null, "El presupuesto es muy bajo para incluir periféricos.", "Error", JOptionPane.WARNING_MESSAGE);
            return;
        }

        // 4. VALIDACIÓN TEMPRANA (AQUÍ ESTÁ EL ARREGLO)
        if (!servicio.presupuestoEsSuficiente(uso.valor, presupuestoTorre)) {
            JOptionPane.showMessageDialog(null,
                String.format("Con $%.0f para la PC no alcanza para un equipo de tipo \"%s\".\nAumenta el presupuesto o cambia el uso.", presupuestoTorre, uso.texto),
                "Presupuesto insuficiente", JOptionPane.WARNING_MESSAGE);
            return;
        }

        // 5. Reutilizar
        Opcion[] reutiliza = {
            new Opcion("No, compro todo", "ninguno"),
            new Opcion("Tengo RAM DDR4", "ram_ddr4"),
            new Opcion("Tengo RAM DDR5", "ram_ddr5"),
            new Opcion("Tengo un SSD", "ssd")
        };
        Opcion reu = elegir("¿Tienes alguna pieza que puedas reutilizar?\n(no se suma su costo; la placa se elige compatible)", "Paso 4: Reutilizar", reutiliza);
        if (reu == null) return;

        // 6. Tamaño
        Opcion[] tamanos = {
            new Opcion("Normal (ATX)", "normal"),
            new Opcion("Compacta (mATX)", "compacta"),
            new Opcion("Mini (ITX, muy pequeña)", "mini"),
            new Opcion("Sin preferencia", "indiferente")
        };
        Opcion tam = elegir("¿Qué tamaño de PC prefieres?", "Paso 5: Tamaño", tamanos);
        if (tam == null) return;

        // 7. Marca
        Opcion[] marcas = {
            new Opcion("Sin preferencia", "indiferente"),
            new Opcion("Intel", "intel"),
            new Opcion("AMD", "amd")
        };
        Opcion marca = elegir("¿Prefieres alguna marca de procesador?", "Paso 6: Marca", marcas);
        if (marca == null) return;

        // 8. Preguntas del Uso
        servicio.limpiarPreferencias();
        servicio.insertarPreferencia("tamano", tam.valor);
        servicio.insertarPreferencia("marca_cpu", marca.valor);
        servicio.insertarPreferencia("reutiliza", reu.valor);
        preguntasDelUso(servicio, uso.valor);

        // 9. Obtener Resultado
        Map<String, String> build = servicio.obtenerMejorBuild(uso.valor, presupuestoTorre);
        if (build == null) {
            JOptionPane.showMessageDialog(null,
                "No encontré combinaciones compatibles con esas respuestas y ese presupuesto.\nPrueba con un presupuesto mayor o con opciones menos exigentes.",
                "Sin resultados", JOptionPane.WARNING_MESSAGE);
            return;
        }

        mostrarResultado(servicio, build, presupuestoTotal, costoPeri, peri.texto);
    }

    private static Opcion elegir(String pregunta, String titulo, Opcion[] opciones) {
        String[] textos = new String[opciones.length];
        for (int i = 0; i < opciones.length; i++) textos[i] = opciones[i].texto;
        int i = JOptionPane.showOptionDialog(null, pregunta, titulo, JOptionPane.DEFAULT_OPTION,
            JOptionPane.QUESTION_MESSAGE, null, textos, textos[0]);
        return (i < 0) ? null : opciones[i];
    }

    private static void preguntasDelUso(PrologService s, String uso) {
        switch (uso) {
            case "gaming": {
                Opcion juegos = elegir("¿Qué tipo de juegos disfrutas más?", "Gaming", new Opcion[]{
                    new Opcion("Competitivos (Valorant, CS2, LoL)", "esports"),
                    new Opcion("Juegos AAA (Cyberpunk, Starfield)", "aaa"),
                    new Opcion("Simulación o estrategia", "simulacion"),
                    new Opcion("Realidad virtual", "vr")});
                if (juegos != null) s.insertarPreferencia("gaming_juegos", juegos.valor);

                Opcion res = elegir("¿A qué resolución quieres jugar?", "Gaming", new Opcion[]{
                    new Opcion("1080p (Full HD)", "1080p"),
                    new Opcion("1440p (2K)", "1440p"),
                    new Opcion("4K", "4k")});
                if (res != null) s.insertarPreferencia("gaming_resolucion", res.valor);

                Opcion prio = elegir("¿Qué prefieres invertir más?", "Gaming", new Opcion[]{
                    new Opcion("Equilibrado", "equilibrado"),
                    new Opcion("Priorizar tarjeta gráfica (GPU)", "gpu"),
                    new Opcion("Priorizar procesador (CPU)", "cpu")});
                if (prio != null) s.insertarPreferencia("gaming_prioridad", prio.valor);
                break;
            }
            case "edicion": {
                Opcion sw = elegir("¿Qué software usas más?", "Edición", new Opcion[]{
                    new Opcion("Premiere o DaVinci Resolve (video)", "premiere"),
                    new Opcion("Blender (render 3D)", "blender"),
                    new Opcion("Arquitectura 3D (Revit, Lumion)", "arquitectura_3d"),
                    new Opcion("Fotografía (Photoshop, Lightroom)", "fotografia")});
                if (sw != null) s.insertarPreferencia("edicion_software", sw.valor);

                Opcion res = elegir("¿En qué resolución editas?", "Edición", new Opcion[]{
                    new Opcion("1080p", "1080p"),
                    new Opcion("4K", "4k"),
                    new Opcion("8K o RAW", "8k")});
                if (res != null) s.insertarPreferencia("edicion_resolucion", res.valor);

                Opcion prio = elegir("Para renderizar, ¿qué pieza debe ser más rápida?", "Edición", new Opcion[]{
                    new Opcion("Tarjeta gráfica (GPU)", "render_gpu"),
                    new Opcion("Procesador (CPU)", "render_cpu")});
                if (prio != null) s.insertarPreferencia("edicion_prioridad", prio.valor);
                break;
            }
            case "programacion": {
                Opcion area = elegir("¿Qué tipo de desarrollo haces?", "Programación", new Opcion[]{
                    new Opcion("Web y móvil", "web_movil"),
                    new Opcion("Ciencia de datos e IA", "data_ia"),
                    new Opcion("Videojuegos (Unity, Unreal)", "videojuegos"),
                    new Opcion("Ciberseguridad", "ciberseguridad"),
                    new Opcion("Backend y cloud (Docker, Kubernetes)", "backend_cloud")});
                if (area != null) s.insertarPreferencia("prog_area", area.valor);

                Opcion vms = elegir("¿Usas máquinas virtuales o Docker?", "Programación", new Opcion[]{
                    new Opcion("No", "no"),
                    new Opcion("A veces", "aveces"),
                    new Opcion("Todo el tiempo", "siempre")});
                if (vms != null) s.insertarPreferencia("prog_vms", vms.valor);

                Opcion ia = elegir("¿Ejecutas modelos de IA en tu propia PC?", "Programación", new Opcion[]{
                    new Opcion("No", "no"),
                    new Opcion("Modelos pequeños", "pequeno"),
                    new Opcion("Modelos grandes", "grande")});
                if (ia != null) s.insertarPreferencia("prog_ia_local", ia.valor);
                break;
            }
            case "maestro": {
                Opcion tareas = elegir("¿Cuál es tu uso principal?", "Oficina", new Opcion[]{
                    new Opcion("Ofimática (Word, Excel, PowerPoint)", "ofimatica"),
                    new Opcion("Clases en línea y videollamadas", "docencia_virtual"),
                    new Opcion("Diseño ligero (Canva, presentaciones)", "diseno_ligero"),
                    new Opcion("Gestión administrativa y calificaciones", "gestion_administrativa")});
                if (tareas != null) s.insertarPreferencia("maestro_tareas", tareas.valor);

                Opcion ram = elegir("¿Cuánta RAM necesitas para tu trabajo diario?", "Oficina", new Opcion[]{
                    new Opcion("Básico (8 GB)", "8gb"),
                    new Opcion("Cómodo para varias pestañas (16 GB)", "16gb"),
                    new Opcion("Trabajo pesado (32 GB)", "32gb")});
                if (ram != null) s.insertarPreferencia("maestro_ram", ram.valor);
                break;
            }
        }
    }

    private static void mostrarResultado(PrologService s, Map<String, String> b,
                                          double presupuestoTotal, double costoPeri, String textoPeri) {
        double torre = Double.parseDouble(b.get("total"));
        double total = torre + costoPeri;
        
        StringBuilder sb = new StringBuilder();
        sb.append("¡TU PC RECOMENDADA!\n\n");
        sb.append("==================================================\n");
        sb.append("CPU:           ").append(s.obtenerNombre(b.get("cpu"))).append("\n");
        sb.append("GPU:           ").append(s.obtenerNombre(b.get("gpu"))).append("\n");
        sb.append("Placa madre:   ").append(s.obtenerNombre(b.get("motherboard"))).append("\n");
        sb.append("RAM:           ").append(s.obtenerNombre(b.get("ram"))).append("\n");
        sb.append("Almacenamiento:").append(" ").append(s.obtenerNombre(b.get("almacenamiento"))).append("\n");
        sb.append("Fuente:        ").append(s.obtenerNombre(b.get("fuente"))).append("\n");
        sb.append("Gabinete:      ").append(s.obtenerNombre(b.get("gabinete"))).append("\n");
        sb.append("Cooler:        ").append(s.obtenerNombre(b.get("cooler"))).append("\n\n");
        sb.append(String.format("Consumo estimado: %s W\n", b.get("consumo")));
        sb.append("==================================================\n");
        sb.append(String.format("Presupuesto total: $%.2f USD\n", presupuestoTotal));
        sb.append("Periféricos: ").append(textoPeri).append("\n");
        sb.append(String.format("Costo de la torre: $%.2f USD\n", torre));
        sb.append(String.format("Costo total con periféricos: $%.2f USD\n", total));
        sb.append(String.format("Sobrante del presupuesto: $%.2f USD\n", presupuestoTotal - total));

        JTextArea area = new JTextArea(sb.toString());
        area.setEditable(false);
        area.setFont(new Font(Font.MONOSPACED, Font.PLAIN, 14));
        JScrollPane scroll = new JScrollPane(area);
        scroll.setPreferredSize(new Dimension(640, 480));
        JOptionPane.showMessageDialog(null, scroll, "Tu PC Recomendada", JOptionPane.INFORMATION_MESSAGE);
    }
}