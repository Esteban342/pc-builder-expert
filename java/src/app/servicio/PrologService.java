package app.servicio;

import org.jpl7.Query;
import org.jpl7.Term;

import java.util.HashMap;
import java.util.Map;

public class PrologService {

    private static final String RUTA_BC = "../prolog/base_conocimiento.pl";

    public PrologService() {
        try {
            // Carga de DLLs (Mantenemos la solución que te funcionó)
            System.load("C:\\Program Files\\swipl\\bin\\libwinpthread-1.dll");
            System.load("C:\\Program Files\\swipl\\bin\\libgcc_s_seh-1.dll");
            System.load("C:\\Program Files\\swipl\\bin\\libgmp-10.dll");
            System.load("C:\\Program Files\\swipl\\bin\\zlib1.dll");
            System.load("C:\\Program Files\\swipl\\bin\\libswipl.dll");
            System.load("C:\\Program Files\\swipl\\bin\\jpl.dll");
        } catch (UnsatisfiedLinkError e) {
            System.err.println("Aviso: Carga manual de DLLs falló o ya estaban cargadas.");
        }
        cargarBaseConocimiento();
    }

    private void cargarBaseConocimiento() {
        Query q = new Query("consult('" + RUTA_BC + "')");
        if (!q.hasSolution()) {
            throw new RuntimeException("No se pudo cargar la base de conocimiento: " + RUTA_BC);
        }
        q.close();
    }

    /**
     * LIMPIA las respuestas del usuario anterior.
     * Vital para que si el usuario hace otra consulta, no se mezclen sus respuestas viejas.
     */
        public void limpiarPreferencias() {
        String[] predicados = {
            "pref_gaming_resolucion", "pref_gaming_juegos", "pref_gaming_prioridad",
            "pref_edicion_software", "pref_edicion_resolucion", "pref_edicion_prioridad",
            "pref_prog_area", "pref_prog_entorno", "pref_prog_monitores",
            "pref_maestro_tareas", "pref_maestro_formato", "pref_maestro_ram"
        };
        for (String pred : predicados) {
            try {
                Query q = new Query("retractall(" + pred + "(_))");
                q.hasSolution();
                q.close();
            } catch (Exception e) {
                System.err.println("Aviso: No se pudo limpiar " + pred);
            }
        }
    }

    /**
     * INYECTA una respuesta del cuestionario en Prolog.
     * Ejemplo: insertarPreferencia("pref_gaming_prioridad", "gpu")
     * Genera en Prolog: assertz(pref_gaming_prioridad(gpu)).
     */
    public void insertarPreferencia(String predicado, String valor) {
        // Usamos comillas simples por si el valor tiene espacios o caracteres especiales
        String consulta = "assertz(" + predicado + "('" + valor + "'))";
        Query q = new Query(consulta);
        if (!q.hasSolution()) {
            System.err.println("Error al insertar preferencia: " + consulta);
        }
        q.close();
    }

    public boolean presupuestoEsSuficiente(String uso, double presupuesto) {
        String consulta = String.format("presupuesto_suficiente(%s, %f)", uso, presupuesto);
        Query q = new Query(consulta);
        boolean ok = q.hasSolution();
        q.close();
        return ok;
    }

    /**
     * Obtiene el MEJOR build. Ahora incluye el Almacenamiento (ALM).
     */
    public Map<String, String> obtenerMejorBuild(String uso, double presupuesto) {
        String consulta = String.format(
                "mejor_build(%s, %f, CPU, GPU, MB, RAM, ALM)", uso, presupuesto);
        Query q = new Query(consulta);
        
        if (!q.hasSolution()) {
            q.close();
            return null;
        }
        
        Map<String, Term> sol = q.oneSolution();
        Map<String, String> build = new HashMap<>();
        build.put("cpu",         sol.get("CPU").name());
        build.put("gpu",         sol.get("GPU").name());
        build.put("motherboard", sol.get("MB").name());
        build.put("ram",         sol.get("RAM").name());
        build.put("almacenamiento", sol.get("ALM").name());
        q.close();
        return build;
    }

    /**
     * Calcula el costo total. Ahora incluye el Almacenamiento (ALM).
     */
    public double obtenerCostoTotal(String cpuId, String gpuId, String mbId, String ramId, String almId) {
        String consulta = String.format(
                "costo_total(%s, %s, %s, %s, %s, Total)", cpuId, gpuId, mbId, ramId, almId);
        Query q = new Query(consulta);
        if (q.hasSolution()) {
            double total = q.oneSolution().get("Total").doubleValue();
            q.close();
            return total;
        }
        q.close();
        return -1;
    }

    public double obtenerConsumoEstimado(String cpuId, String gpuId) {
        // Si la GPU es integrada, Prolog lo maneja gracias al IF-THEN-ELSE que pusimos
        String consulta = String.format("consumo_estimado(%s, '%s', Watts)", cpuId, gpuId);
        Query q = new Query(consulta);
        if (q.hasSolution()) {
            double w = q.oneSolution().get("Watts").doubleValue();
            q.close();
            return w;
        }
        q.close();
        return -1;
    }

    public String obtenerFuenteRecomendada(String cpuId, String gpuId) {
        String consulta = String.format("fuente_recomendada(%s, '%s', Rango)", cpuId, gpuId);
        Query q = new Query(consulta);
        if (q.hasSolution()) {
            String r = q.oneSolution().get("Rango").name();
            q.close();
            return r;
        }
        q.close();
        return "No disponible";
    }

    /**
     * ¡NUEVO MÉTODO MÁGICO PARA LA INTERFAZ!
     * Busca el nombre bonito de un componente para no mostrar el ID técnico.
     * Ejemplo: Si le pasas "cpu", "cpu_i5_12400f", te devuelve "Intel Core i5-12400F".
     */
    public String obtenerNombreComponente(String tipo, String id) {
        // Si es gráficos integrados, lo devolvemos directo
        if (id.equals("integrada")) return "Gráficos Integrados (iGPU)";

        String consulta = "";
        String variableNombre = "Modelo";
        String marca = "Marca";

        switch (tipo.toLowerCase()) {
            case "cpu":
                consulta = String.format("cpu(%s, %s, %s, _, _, _, _, _)", id, marca, variableNombre);
                break;
            case "gpu":
                consulta = String.format("gpu(%s, %s, %s, _, _, _, _)", id, marca, variableNombre);
                break;
            case "motherboard":
                consulta = String.format("motherboard(%s, %s, %s, _, _, _, _)", id, marca, variableNombre);
                break;
            case "ram":
                // Para RAM armamos un nombre con su capacidad y tipo
                consulta = String.format("ram(%s, Tipo, Cap, Frec, _)", id);
                Query qRam = new Query(consulta);
                if (qRam.hasSolution()) {
                    Map<String, Term> sol = qRam.oneSolution();
                    String nombreRam = sol.get("Cap").intValue() + "GB " + 
                                       sol.get("Tipo").name().toUpperCase() + " " + 
                                       sol.get("Frec").intValue() + "MHz";
                    qRam.close();
                    return nombreRam;
                }
                return id;
            case "almacenamiento":
                consulta = String.format("almacenamiento(%s, Tipo, Cap, _)", id);
                Query qAlm = new Query(consulta);
                if (qAlm.hasSolution()) {
                    Map<String, Term> sol = qAlm.oneSolution();
                    String nombreAlm = sol.get("Cap").intValue() + "GB " + 
                                       sol.get("Tipo").name().replace("_", " ").toUpperCase();
                    qAlm.close();
                    return nombreAlm;
                }
                return id;
            default:
                return id;
        }

        Query q = new Query(consulta);
        if (q.hasSolution()) {
            Map<String, Term> sol = q.oneSolution();
            String marcaStr = sol.get("Marca").name().toUpperCase();
            String modeloStr = sol.get("Modelo").name().replace("'", "");
            q.close();
            return marcaStr + " " + modeloStr;
        }
        q.close();
        return id;
    }
}