package app.servicio;

import java.io.File;

public class DllLoader {
    public static void cargar() {
        try {
            String[] rutasDll = {
                System.getProperty("user.dir") + File.separator,
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
                System.out.println("DLLs cargadas desde: " + rutaEncontrada);
            } else {
                System.err.println("No se encontraron las DLLs de Prolog.");
            }
        } catch (Exception e) {
            System.err.println("Error al cargar DLLs: " + e.getMessage());
        }
    }
}