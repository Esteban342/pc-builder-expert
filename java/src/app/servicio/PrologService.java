package app.servicio;

import org.jpl7.Query;
import org.jpl7.Term;

import java.io.File;
import java.util.LinkedHashMap;
import java.util.Locale;
import java.util.Map;

public class PrologService {

    private static final String RUTA_BC = buscarRuta();

    private static String buscarRuta() {
        // Busca el archivo .pl en las rutas posibles (desarrollo y ejecutable)
        String[] rutas = {
            "base_conocimiento.pl", 
            "app/base_conocimiento.pl",
            "../prolog/base_conocimiento.pl", 
            "prolog/base_conocimiento.pl"
        };
        for (String r : rutas) {
            if (new File(r).exists()) return r.replace("\\", "/");
        }
        throw new RuntimeException("No se encontró base_conocimiento.pl.");
    }

    public PrologService() {
        try {
            // Busca las DLLs en la misma carpeta de la app (Portátil) o en la ruta de desarrollo
            String[] rutasDll = {
                System.getProperty("user.dir") + File.separator + "bin" + File.separator,
                System.getProperty("user.dir") + File.separator + "app" + File.separator + "bin" + File.separator,
                "C:\\Program Files\\swipl\\bin\\"
            };
            
            String rutaEncontrada = null;
            for (String ruta : rutasDll) {
                if (new File(ruta + "jpl.dll").exists()) {
                    rutaEncontrada = ruta;
                    break;
                }
            }

            if (rutaEncontrada != null) {
                System.load(rutaEncontrada + "libwinpthread-1.dll");
                System.load(rutaEncontrada + "libgcc_s_seh-1.dll");
                System.load(rutaEncontrada + "libgmp-10.dll");
                System.load(rutaEncontrada + "zlib1.dll");
                System.load(rutaEncontrada + "libswipl.dll");
                System.load(rutaEncontrada + "jpl.dll");
            } else {
                System.err.println("Aviso: No se encontraron las DLLs de Prolog.");
            }
        } catch (UnsatisfiedLinkError e) {
            System.err.println("Aviso: carga manual de DLL omitida, usando PATH.");
        }

        Query q = new Query("consult('" + RUTA_BC + "')");
        try {
            if (!q.hasSolution()) throw new RuntimeException("No se pudo cargar la base de conocimiento.");
        } finally {
            q.close();
        }
    }

    public void limpiarPreferencias() {
        ejecutar("retractall(pref(_, _))");
    }

    public void insertarPreferencia(String clave, String valor) {
        ejecutar("assertz(pref('" + clave + "', '" + valor + "'))");
    }

    public boolean presupuestoEsSuficiente(String uso, double presupuesto) {
        return existe(String.format(Locale.US, "presupuesto_suficiente(%s, %.2f)", uso, presupuesto));
    }

    /**
     * Ahora solo devuelve 1 Build usando el perfil "maximo" (100% del presupuesto).
     */
    public Map<String, String> obtenerMejorBuild(String uso, double presupuesto) {
        Query q = new Query(String.format(Locale.US,
            "mejor_build(%s, maximo, %.2f, C, G, M, R, A, F, B, K, Total)", uso, presupuesto));
        
        try {
            if (!q.hasSolution()) return null;
            
            Map<String, Term> s = q.oneSolution();
            Map<String, String> b = new LinkedHashMap<>();
            b.put("cpu", s.get("C").name());
            b.put("gpu", s.get("G").name());
            b.put("motherboard", s.get("M").name());
            b.put("ram", s.get("R").name());
            b.put("almacenamiento", s.get("A").name());
            b.put("fuente", s.get("F").name());
            b.put("gabinete", s.get("B").name());
            b.put("cooler", s.get("K").name());
            b.put("total", String.format(Locale.US, "%.2f", s.get("Total").doubleValue()));
            b.put("consumo", String.format(Locale.US, "%.0f", consumo(b.get("cpu"), b.get("gpu"))));
            return b;
        } finally {
            q.close();
        }
    }

    public String obtenerNombre(String id) {
        Query q = new Query("nombre(" + id + ", N)");
        try {
            if (q.hasSolution()) return q.oneSolution().get("N").name();
            return id;
        } finally {
            q.close();
        }
    }

    private double consumo(String cpu, String gpu) {
        Query q = new Query(String.format(Locale.US, "consumo_sistema(%s, %s, W)", cpu, gpu));
        try {
            if (q.hasSolution()) return q.oneSolution().get("W").doubleValue();
            return -1;
        } finally {
            q.close();
        }
    }

    private boolean existe(String consulta) {
        Query q = new Query(consulta);
        try { return q.hasSolution(); } finally { q.close(); }
    }

    private void ejecutar(String consulta) {
        Query q = new Query(consulta);
        try { q.hasSolution(); } finally { q.close(); }
    }
}