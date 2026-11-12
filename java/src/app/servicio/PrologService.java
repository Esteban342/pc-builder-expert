package app.servicio;

import org.jpl7.Query;
import org.jpl7.Term;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Servicio que encapsula la conexión con SWI-Prolog mediante JPL.
 * Expone métodos para consultar builds según uso y presupuesto.
 */
public class PrologService {

    private static final String RUTA_BC = "../prolog/base_conocimiento.pl";

    public PrologService() {
    try {
        // Forzar la carga de las dependencias en el orden correcto
        System.load("C:\\Program Files\\swipl\\bin\\libwinpthread-1.dll");
        System.load("C:\\Program Files\\swipl\\bin\\libgcc_s_seh-1.dll");
        System.load("C:\\Program Files\\swipl\\bin\\libgmp-10.dll");
        System.load("C:\\Program Files\\swipl\\bin\\zlib1.dll");
        System.load("C:\\Program Files\\swipl\\bin\\libswipl.dll");
        System.load("C:\\Program Files\\swipl\\bin\\jpl.dll");
    } catch (UnsatisfiedLinkError e) {
        System.err.println("Error al cargar las DLLs de Prolog: " + e.getMessage());
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

    /** Verifica si el presupuesto alcanza el mínimo para el uso indicado. */
    public boolean presupuestoEsSuficiente(String uso, double presupuesto) {
        String consulta = String.format("presupuesto_suficiente(%s, %f)", uso, presupuesto);
        Query q = new Query(consulta);
        boolean ok = q.hasSolution();
        q.close();
        return ok;
    }

    /**
     * Devuelve el MEJOR build posible para un uso y presupuesto dados.
     * @return Map con claves cpu, gpu, motherboard, ram (IDs); o null si no hay build válido.
     */
    public Map<String, String> obtenerMejorBuild(String uso, double presupuesto) {
        String consulta = String.format(
                "mejor_build(%s, %f, CPU, GPU, MB, RAM)", uso, presupuesto);
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
        q.close();
        return build;
    }

    /**
     * Devuelve TODOS los builds válidos para un uso y presupuesto dados.
     * Útil para depuración o para mostrar alternativas al usuario.
     */
    public List<Map<String, String>> obtenerBuildsValidos(String uso, double presupuesto) {
        List<Map<String, String>> resultados = new ArrayList<>();
        String consulta = String.format(
                "build_valido(%s, CPU, GPU, MB, RAM, %f)", uso, presupuesto);
        Query q = new Query(consulta);
        while (q.hasMoreSolutions()) {
            Map<String, Term> sol = q.nextSolution();
            Map<String, String> build = new HashMap<>();
            build.put("cpu",         sol.get("CPU").name());
            build.put("gpu",         sol.get("GPU").name());
            build.put("motherboard", sol.get("MB").name());
            build.put("ram",         sol.get("RAM").name());
            resultados.add(build);
        }
        q.close();
        return resultados;
    }

    public double obtenerCostoTotal(String cpuId, String gpuId, String mbId, String ramId) {
        String consulta = String.format(
                "costo_total(%s, %s, %s, %s, Total)", cpuId, gpuId, mbId, ramId);
        Query q = new Query(consulta);
        if (q.hasSolution()) {
            double total = q.oneSolution().get("Total").doubleValue();
            q.close();
            return total;
        }
        q.close();
        return -1;
    }

    public boolean estaDentroPresupuesto(String cpuId, String gpuId, String mbId,
                                         String ramId, double presupuesto) {
        String consulta = String.format(
                "dentro_presupuesto(%s, %s, %s, %s, %f)",
                cpuId, gpuId, mbId, ramId, presupuesto);
        Query q = new Query(consulta);
        boolean ok = q.hasSolution();
        q.close();
        return ok;
    }

    public double obtenerConsumoEstimado(String cpuId, String gpuId) {
        String consulta = String.format("consumo_estimado(%s, %s, Watts)", cpuId, gpuId);
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
        String consulta = String.format("fuente_recomendada(%s, %s, Rango)", cpuId, gpuId);
        Query q = new Query(consulta);
        if (q.hasSolution()) {
            String r = q.oneSolution().get("Rango").name();
            q.close();
            return r;
        }
        q.close();
        return "No disponible";
    }

    public boolean hayCuelloBotella(String cpuId, String gpuId) {
        String consulta = String.format("cuello_botella(%s, %s)", cpuId, gpuId);
        Query q = new Query(consulta);
        boolean ok = q.hasSolution();
        q.close();
        return ok;
    }

    public boolean sonCompatiblesSocket(String cpuId, String mbId) {
        String consulta = String.format("compatible_socket(%s, %s)", cpuId, mbId);
        Query q = new Query(consulta);
        boolean ok = q.hasSolution();
        q.close();
        return ok;
    }

    public boolean sonCompatiblesRam(String mbId, String ramId) {
        String consulta = String.format("compatible_ram(%s, %s)", mbId, ramId);
        Query q = new Query(consulta);
        boolean ok = q.hasSolution();
        q.close();
        return ok;
    }

    /** Imprime en consola el mejor build (útil para depuración). */
    public void imprimirMejorBuild(String uso, double presupuesto) {
        Map<String, String> b = obtenerMejorBuild(uso, presupuesto);
        if (b == null) {
            System.out.println("No se encontró build válido para uso=" + uso
                    + " presupuesto=$" + presupuesto
                    + " (¿presupuesto por debajo del mínimo?)");
            return;
        }
        double total  = obtenerCostoTotal(b.get("cpu"), b.get("gpu"),
                                          b.get("motherboard"), b.get("ram"));
        double watts  = obtenerConsumoEstimado(b.get("cpu"), b.get("gpu"));
        String fuente = obtenerFuenteRecomendada(b.get("cpu"), b.get("gpu"));
        System.out.printf("=== Mejor build [%s] con $%.2f USD ===%n", uso, presupuesto);
        System.out.printf("  CPU:   %s%n  GPU:   %s%n  MB:    %s%n  RAM:   %s%n",
                b.get("cpu"), b.get("gpu"), b.get("motherboard"), b.get("ram"));
        System.out.printf("  Costo: $%.2f%n  Watts: %.0f W%n  Fuente: %s%n",
                total, watts, fuente);
    }

    public static void main(String[] args) {
        PrologService s = new PrologService();
        double presupuesto = 800.0;
        for (String uso : new String[]{"gaming", "programacion", "edicion", "maestro"}) {
            s.imprimirMejorBuild(uso, presupuesto);
            System.out.println();
        }
    }
}