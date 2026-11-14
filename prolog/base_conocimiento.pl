% ============================================================
% PC Builder Expert - Base de Conocimiento v4.0 (Final Definitiva)
% ============================================================

% ------------------------------------------------------------
% 0. USOS Y PRESUPUESTOS MÍNIMOS
% ------------------------------------------------------------
uso(gaming). uso(programacion). uso(edicion). uso(maestro).

presupuesto_minimo(gaming, 550).
presupuesto_minimo(programacion, 400).
presupuesto_minimo(edicion, 550).
presupuesto_minimo(maestro, 300).

% ------------------------------------------------------------
% 1. HECHOS DE HARDWARE
% ------------------------------------------------------------
cpu(cpu_i3_12100, intel, 'Core i3-12100', lga1700, 60, 120, baja, si).
cpu(cpu_i5_12400, intel, 'Core i5-12400', lga1700, 65, 180, media, si).
cpu(cpu_i5_12400f, intel, 'Core i5-12400F', lga1700, 65, 160, media, no).
cpu(cpu_i5_14600k, intel, 'Core i5-14600K', lga1700, 181, 240, alta, si).
cpu(cpu_i7_12700k, intel, 'Core i7-12700K', lga1700, 125, 350, alta, si).
cpu(cpu_i7_14700k, intel, 'Core i7-14700K', lga1700, 253, 400, alta, si).
cpu(cpu_ryzen5_5600g, amd, 'Ryzen 5 5600G', am4, 65, 140, media, si).
cpu(cpu_ryzen5_5600x, amd, 'Ryzen 5 5600X', am4, 65, 160, media, no).
cpu(cpu_ryzen5_7400, amd, 'Ryzen 5 7400', am5, 65, 150, media, si).
cpu(cpu_ryzen7_5700x, amd, 'Ryzen 7 5700X', am4, 65, 180, alta, no).
cpu(cpu_ryzen7_5800x, amd, 'Ryzen 7 5800X', am4, 105, 250, alta, no).
cpu(cpu_ryzen7_7700x, amd, 'Ryzen 7 7700X', am5, 105, 300, alta, si).
cpu(cpu_ryzen7_7800x3d, amd, 'Ryzen 7 7800X3D', am5, 120, 380, alta, si).
cpu(cpu_ryzen9_7900x, amd, 'Ryzen 9 7900X', am5, 170, 450, alta, si).

gpu(gpu_gtx1650, nvidia, 'GeForce GTX 1650', 75, 120, baja, 4).
gpu(gpu_rx6400, amd, 'Radeon RX 6400', 53, 115, baja, 4).
gpu(gpu_rx6600, amd, 'Radeon RX 6600', 132, 220, media, 8).
gpu(gpu_rtx3060, nvidia, 'GeForce RTX 3060', 170, 300, media, 12).
gpu(gpu_rtx4060, nvidia, 'GeForce RTX 4060', 115, 320, media, 8).
gpu(gpu_rx7600, amd, 'Radeon RX 7600', 165, 280, media, 8).
gpu(gpu_rx6700xt, amd, 'Radeon RX 6700 XT', 230, 450, alta, 12).
gpu(gpu_rtx3070, nvidia, 'GeForce RTX 3070', 220, 500, alta, 8).
gpu(gpu_rtx4070, nvidia, 'GeForce RTX 4070', 200, 550, alta, 12).
gpu(gpu_rtx4070ti, nvidia, 'GeForce RTX 4070 Ti', 285, 750, alta, 12).
gpu(gpu_rx7900xt, amd, 'Radeon RX 7900 XT', 315, 800, alta, 20).

motherboard(mb_a520m, asus, 'PRIME A520M-K', am4, 70, ddr4, no).
motherboard(mb_b550m, msi, 'B550M PRO-VDH', am4, 100, ddr4, no).
motherboard(mb_b550m_wifi, gigabyte, 'B550M DS3H AX', am4, 120, ddr4, si).
motherboard(mb_b650m, gigabyte, 'B650M DS3H', am5, 150, ddr5, no).
motherboard(mb_b650m_wifi, msi, 'PRO B650M-A WIFI', am5, 180, ddr5, si).
motherboard(mb_h610m, asus, 'PRIME H610M-E', lga1700, 90, ddr4, no).
motherboard(mb_b760m, msi, 'PRO B760M-A', lga1700, 130, ddr5, no).
motherboard(mb_b760m_wifi, gigabyte, 'B760M DS3H AX', lga1700, 160, ddr5, si).
motherboard(mb_z790, gigabyte, 'Z790 EAGLE AX', lga1700, 200, ddr5, si).

ram(ram_ddr4_8gb_3200, ddr4, 8, 3200, 25).
ram(ram_ddr4_16gb_3200, ddr4, 16, 3200, 45).
ram(ram_ddr4_32gb_3600, ddr4, 32, 3600, 85).
ram(ram_ddr5_16gb_5200, ddr5, 16, 5200, 60).
ram(ram_ddr5_32gb_6000, ddr5, 32, 6000, 110).
ram(ram_ddr5_64gb_6000, ddr5, 64, 6000, 210).

almacenamiento(alm_hdd_1tb, hdd, 1000, 35).
almacenamiento(alm_hdd_2tb, hdd, 2000, 55).
almacenamiento(alm_ssd_sata_500gb, ssd_sata, 500, 30).
almacenamiento(alm_ssd_sata_1tb, ssd_sata, 1000, 55).
almacenamiento(alm_ssd_nvme_500gb, ssd_nvme, 500, 40).
almacenamiento(alm_ssd_nvme_1tb, ssd_nvme, 1000, 65).
almacenamiento(alm_ssd_nvme_2tb, ssd_nvme, 2000, 120).
almacenamiento(alm_ssd_nvme_4tb, ssd_nvme, 4000, 220).

% ------------------------------------------------------------
% 2. HECHOS DINÁMICOS Y VALORES POR DEFECTO
% ------------------------------------------------------------
:- dynamic(pref_gaming_resolucion/1). :- dynamic(pref_gaming_juegos/1). :- dynamic(pref_gaming_prioridad/1).
:- dynamic(pref_edicion_software/1). :- dynamic(pref_edicion_resolucion/1). :- dynamic(pref_edicion_prioridad/1).
:- dynamic(pref_prog_area/1). :- dynamic(pref_prog_entorno/1). :- dynamic(pref_prog_monitores/1).
:- dynamic(pref_maestro_tareas/1). :- dynamic(pref_maestro_formato/1). :- dynamic(pref_maestro_ram/1).

pref_gaming_resolucion('1080p_60hz'). pref_gaming_juegos(esports). pref_gaming_prioridad(gpu).
pref_edicion_software(premiere). pref_edicion_resolucion('1080p'). pref_edicion_prioridad(render_gpu).
pref_prog_area(web_movil). pref_prog_entorno(ligero). pref_prog_monitores(uno).
pref_maestro_tareas(ofimatica). pref_maestro_formato(torre). pref_maestro_ram('16gb').

% ------------------------------------------------------------
% 3. REGLAS DE COMPATIBILIDAD Y CÁLCULO
% ------------------------------------------------------------
compatible_socket(CPU_ID, MB_ID) :- cpu(CPU_ID, _, _, Socket, _, _, _, _), motherboard(MB_ID, _, _, Socket, _, _, _).
compatible_ram(MB_ID, RAM_ID) :- motherboard(MB_ID, _, _, _, _, TipoDDR_MB, _), ram(RAM_ID, TipoDDR_RAM, _, _, _), TipoDDR_MB == TipoDDR_RAM.

compatible_tier(CPU_ID, MB_ID) :- 
    cpu(CPU_ID, _, _, _, _, _, GamaCPU, _),
    motherboard(MB_ID, _, _, _, PrecioMB, _, _),
    ( GamaCPU == baja -> PrecioMB =< 130 ; true ),
    ( GamaCPU == media -> PrecioMB =< 180 ; true ), 
    ( GamaCPU == alta -> (MB_ID \= mb_h610m, MB_ID \= mb_a520m) ; true ).

consumo_estimado(CPU_ID, GPU_ID, Watts) :- cpu(CPU_ID, _, _, _, TDP_CPU, _, _, _), ( gpu(GPU_ID, _, _, TDP_GPU, _, _, _) -> true ; TDP_GPU = 0 ), Base is TDP_CPU + TDP_GPU, Watts is Base * 1.30.
fuente_recomendada(CPU_ID, GPU_ID, Rango) :- consumo_estimado(CPU_ID, GPU_ID, Watts), Min is ceiling(Watts / 50) * 50, Max is Min + 100, atom_concat(Min, 'W - ', T1), atom_concat(T1, Max, T2), atom_concat(T2, 'W', Rango).

cuello_botella(CPU_ID, GPU_ID) :- cpu(CPU_ID, _, _, _, _, _, baja, _), gpu(GPU_ID, _, _, _, _, alta, _).
cuello_botella_inverso(CPU_ID, GPU_ID) :- cpu(CPU_ID, _, _, _, _, _, alta, _), gpu(GPU_ID, _, _, _, _, baja, _).

% ------------------------------------------------------------
% 4. REGLAS DE APTITUD POR USO
% ------------------------------------------------------------
cpu_apto_para(gaming, CPU_ID) :- cpu(CPU_ID, _, _, _, _, _, Gama, _), Gama \= baja.
cpu_apto_para(edicion, CPU_ID) :- cpu(CPU_ID, _, _, _, _, _, Gama, _), Gama \= baja.
cpu_apto_para(programacion, CPU_ID) :- cpu(CPU_ID, _, _, _, _, _, Gama, _), Gama \= baja.
cpu_apto_para(maestro, CPU_ID) :- cpu(CPU_ID, _, _, _, _, _, _, si).
cpu_apto_para(maestro, CPU_ID) :- cpu(CPU_ID, _, _, _, _, _, baja, _).

gpu_apto_para(gaming, GPU_ID) :- 
    gpu(GPU_ID, _, _, _, _, Gama, VRAM), 
    Gama \= baja,
    ( pref_gaming_juegos(vr) -> VRAM >= 12 ; true ).

gpu_apto_para(edicion, GPU_ID) :- 
    gpu(GPU_ID, _, _, _, _, Gama, VRAM), 
    Gama \= baja, 
    VRAM >= 8,
    ( (pref_edicion_software(blender) ; pref_edicion_software(arquitectura_3d)) -> gpu(GPU_ID, nvidia, _, _, _, _, _) ; true ).

gpu_apto_para(programacion, GPU_ID) :- gpu(GPU_ID, _, _, _, _, _, _).
gpu_apto_para(programacion, 'integrada').
gpu_apto_para(maestro, 'integrada').

% ------------------------------------------------------------
% 5. PUNTAJES Y BONIFICACIONES
% ------------------------------------------------------------
puntaje_cpu(gaming, baja, 0). puntaje_cpu(gaming, media, 2). puntaje_cpu(gaming, alta, 3).
puntaje_cpu(programacion, baja, 1). puntaje_cpu(programacion, media, 2). puntaje_cpu(programacion, alta, 3).
puntaje_cpu(edicion, baja, 0). puntaje_cpu(edicion, media, 2). puntaje_cpu(edicion, alta, 3).
% El i5 (media) vale 4, el i7/Ryzen 9 (alta) vale 2 para que el sistema prefiera el i5 en maestros.
puntaje_cpu(maestro, baja, 1). puntaje_cpu(maestro, media, 3). puntaje_cpu(maestro, alta, 4).

puntaje_gpu(gaming, baja, 0). puntaje_gpu(gaming, media, 2). puntaje_gpu(gaming, alta, 3).
puntaje_gpu(programacion, baja, 1). puntaje_gpu(programacion, media, 1). puntaje_gpu(programacion, alta, 0). puntaje_gpu(programacion, 'integrada', 4).
puntaje_gpu(edicion, baja, 0). puntaje_gpu(edicion, media, 2). puntaje_gpu(edicion, alta, 3).
puntaje_gpu(maestro, baja, 3). puntaje_gpu(maestro, media, 1). puntaje_gpu(maestro, alta, 0).
puntaje_gpu(_, 'integrada', 1).

bonus_gaming_prioridad_gpu(GPU_ID, 5) :- gpu(GPU_ID, _, _, _, _, alta, _).
bonus_gaming_prioridad_cpu(CPU_ID, 5) :- cpu(CPU_ID, _, _, _, _, _, alta, _).
bonus_gaming_resolucion(GPU_ID, 3) :- gpu(GPU_ID, _, _, _, _, _, VRAM), VRAM >= 12.
bonus_gaming_vr(GPU_ID, 5) :- gpu(GPU_ID, _, _, _, _, _, VRAM), VRAM >= 12.

bonus_edicion_resolucion(GPU_ID, 5) :- gpu(GPU_ID, _, _, _, _, _, VRAM), VRAM >= 12.
bonus_edicion_prioridad_gpu(GPU_ID, 4) :- gpu(GPU_ID, _, _, _, _, alta, _).

bonus_prog_entorno_pesado(CPU_ID, 3) :- cpu(CPU_ID, _, _, _, _, _, alta, _).
bonus_prog_ciberseguridad(CPU_ID, 4) :- cpu(CPU_ID, _, _, _, _, _, alta, _).

bonus_maestro_docencia(RAM_ID, 3) :- ram(RAM_ID, _, Cap, _, _), Cap >= 16.

% --- RAM (Puntaje Universal) ---
puntaje_ram(gaming, 8, -10). puntaje_ram(gaming, 16, 3). puntaje_ram(gaming, 32, 5). puntaje_ram(gaming, 64, 6).
puntaje_ram(edicion, 8, -10). puntaje_ram(edicion, 16, 2). puntaje_ram(edicion, 32, 5). puntaje_ram(edicion, 64, 7).
puntaje_ram(programacion, 8, -5). puntaje_ram(programacion, 16, 3). puntaje_ram(programacion, 32, 5). puntaje_ram(programacion, 64, 6).

% Puntaje para Maestro (ya está obligado a cumplir con la elección en build_valido)
puntaje_ram(maestro, 8, 2).
puntaje_ram(maestro, 16, 5).
puntaje_ram(maestro, 32, 7).
puntaje_ram(maestro, 64, 8).

% --- Almacenamiento (Puntaje escalonado universal) ---
puntaje_almacenamiento(Tipo, Cap, Puntaje) :-
    ( Tipo == ssd_nvme -> Base = 5 ; Tipo == ssd_sata -> Base = 3 ; Tipo == hdd -> Base = -5 ),
    ( Cap >= 4000 -> Bonus = 4 ; Cap >= 2000 -> Bonus = 3 ; Cap >= 1000 -> Bonus = 2 ; Cap >= 500 -> Bonus = 1 ; Bonus = 0 ),
    Puntaje is Base + Bonus.

% ------------------------------------------------------------
% 6. REGLA MAESTRA Y RESTRICCIONES
% ------------------------------------------------------------
presupuesto_suficiente(Uso, Presupuesto) :- presupuesto_minimo(Uso, Min), Presupuesto >= Min.

costo_total(CPU_ID, GPU_ID, MB_ID, RAM_ID, ALM_ID, Total) :-
    cpu(CPU_ID, _, _, _, _, P_CPU, _, _),
    ( GPU_ID == 'integrada' -> P_GPU = 0 ; gpu(GPU_ID, _, _, _, P_GPU, _, _) ),
    motherboard(MB_ID, _, _, _, P_MB, _, _),
    ram(RAM_ID, _, _, _, P_RAM),
    almacenamiento(ALM_ID, _, _, P_ALM),
    Total is P_CPU + P_GPU + P_MB + P_RAM + P_ALM.

dentro_presupuesto(CPU_ID, GPU_ID, MB_ID, RAM_ID, ALM_ID, Presupuesto) :-
    costo_total(CPU_ID, GPU_ID, MB_ID, RAM_ID, ALM_ID, Total),
    Total =< Presupuesto.

build_valido(Uso, CPU_ID, GPU_ID, MB_ID, RAM_ID, ALM_ID, Presupuesto) :-
    uso(Uso),
    cpu_apto_para(Uso, CPU_ID),
    gpu_apto_para(Uso, GPU_ID),
    motherboard(MB_ID, _, _, _, _, _, _),
    compatible_socket(CPU_ID, MB_ID),
    compatible_tier(CPU_ID, MB_ID),
    compatible_ram(MB_ID, RAM_ID),
    almacenamiento(ALM_ID, _, _, _),
    ram(RAM_ID, _, CapRam, _, _),
    
    % REGLA ESTRICTA: Respetar elección del usuario en Maestro
    ( Uso == maestro -> 
    ( (pref_maestro_ram('8gb') -> CapRam >= 8) ;
      (pref_maestro_ram('16gb') -> CapRam >= 16) ;
      (pref_maestro_ram('32gb') -> CapRam >= 32) )
    ; ( (Uso == gaming ; Uso == edicion) -> CapRam >= 16 ; true ) 
    ),
    
    ( GPU_ID == 'integrada' -> true ; 
      \+ cuello_botella(CPU_ID, GPU_ID),
      ( Uso == gaming -> \+ cuello_botella_inverso(CPU_ID, GPU_ID) ; true )
    ),
    dentro_presupuesto(CPU_ID, GPU_ID, MB_ID, RAM_ID, ALM_ID, Presupuesto).

calcular_puntaje_total(Uso, CPU_ID, GPU_ID, _MB_ID, RAM_ID, ALM_ID, Puntaje) :-
    cpu(CPU_ID, _, _, _, _, _, GC, _),
    ( GPU_ID == 'integrada' -> GG = 'integrada' ; gpu(GPU_ID, _, _, _, _, GG, _) ),
    ram(RAM_ID, _, Capacidad, _, _),
    almacenamiento(ALM_ID, TipoAlm, CapAlm, _),
    
    puntaje_cpu(Uso, GC, PC), puntaje_gpu(Uso, GG, PG),
    puntaje_ram(Uso, Capacidad, PRAM), puntaje_almacenamiento(TipoAlm, CapAlm, PAlm),
    PuntajeBase is PC + PG + PRAM + PAlm,
    
    ( Uso == gaming -> sumar_bonus_gaming(GPU_ID, CPU_ID, Bonus) ;
      Uso == edicion -> sumar_bonus_edicion(GPU_ID, Bonus) ;
      Uso == programacion -> sumar_bonus_prog(CPU_ID, Bonus) ;
      Uso == maestro -> sumar_bonus_maestro(RAM_ID, Bonus) ;
      Bonus = 0 ),
    Puntaje is PuntajeBase + Bonus.

sumar_bonus_gaming(GPU_ID, CPU_ID, Bonus) :-
    ( bonus_gaming_prioridad_gpu(GPU_ID, B1) -> true ; B1 = 0 ),
    ( bonus_gaming_prioridad_cpu(CPU_ID, B2) -> true ; B2 = 0 ),
    ( bonus_gaming_resolucion(GPU_ID, B3) -> true ; B3 = 0 ),
    ( pref_gaming_juegos(vr) -> bonus_gaming_vr(GPU_ID, B4) ; B4 = 0 ),
    Bonus is B1 + B2 + B3 + B4.

sumar_bonus_edicion(GPU_ID, Bonus) :-
    ( bonus_edicion_resolucion(GPU_ID, B1) -> true ; B1 = 0 ),
    ( bonus_edicion_prioridad_gpu(GPU_ID, B2) -> true ; B2 = 0 ),
    Bonus is B1 + B2.

sumar_bonus_prog(CPU_ID, Bonus) :-
    ( bonus_prog_entorno_pesado(CPU_ID, B1) -> true ; B1 = 0 ),
    ( pref_prog_area(ciberseguridad) -> bonus_prog_ciberseguridad(CPU_ID, B2) ; B2 = 0 ),
    Bonus is B1 + B2.

sumar_bonus_maestro(RAM_ID, Bonus) :-
    ( pref_maestro_tareas(docencia_virtual) -> bonus_maestro_docencia(RAM_ID, B1) ; B1 = 0 ),
    Bonus is B1.

mejor_build(Uso, Presupuesto, CPU_ID, GPU_ID, MB_ID, RAM_ID, ALM_ID) :-
    findall(PuntajeTotal-build(C, G, M, R, A),
            ( build_valido(Uso, C, G, M, R, A, Presupuesto),
              calcular_puntaje_total(Uso, C, G, M, R, A, Puntaje),
              costo_total(C, G, M, R, A, Costo),
              PuntajeTotal is Puntaje * 10000 + Costo ),
            Lista),
    Lista \= [],
    predsort(compare_desc, Lista, [_-build(CPU_ID, GPU_ID, MB_ID, RAM_ID, ALM_ID)|_]).

compare_desc(Order, A-_, B-_) :- compare(Order, B, A).