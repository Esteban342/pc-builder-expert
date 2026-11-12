% ============================================================
% PC Builder Expert - Base de Conocimiento
% Sistema Experto para Armado y Compatibilidad de PCs
% ============================================================

% ------------------------------------------------------------
% 0. USOS DISPONIBLES DEL SISTEMA
% gaming        -> PC para videojuegos
% programacion  -> PC para desarrollo de software
% edicion       -> PC para edición de video profesional
% maestro       -> PC de oficina / estudio / maestro (uso básico)
% ------------------------------------------------------------
uso(gaming).
uso(programacion).
uso(edicion).
uso(maestro).

% Presupuesto mínimo razonable por uso (en USD) para evitar
% recomendar builds ilógicos.
presupuesto_minimo(gaming,       500).
presupuesto_minimo(programacion, 450).
presupuesto_minimo(edicion,      600).
presupuesto_minimo(maestro,      350).

% ------------------------------------------------------------
% 1. CPUs
% cpu(ID, Marca, Modelo, Socket, TDP_W, Precio_USD, Gama)
% ------------------------------------------------------------
cpu(cpu_ryzen5_5600, amd,   'Ryzen 5 5600',    am4,     65,  140, media).
cpu(cpu_ryzen5_7600, amd,   'Ryzen 5 7600',    am5,     65,  230, media).
cpu(cpu_ryzen7_5800x,amd,   'Ryzen 7 5800X',   am4,    105,  250, alta).
cpu(cpu_i3_12100f,   intel, 'Core i3-12100F',  lga1700, 58,  100, baja).
cpu(cpu_i5_12400f,   intel, 'Core i5-12400F',  lga1700, 65,  185, media).
cpu(cpu_i7_12700k,   intel, 'Core i7-12700K',  lga1700,125,  350, alta).

% ------------------------------------------------------------
% 2. GPUs
% gpu(ID, Marca, Modelo, TDP_W, Precio_USD, Gama)
% ------------------------------------------------------------
gpu(gpu_rtx3060,   nvidia, 'GeForce RTX 3060',  170, 330, media).
gpu(gpu_rtx4060,   nvidia, 'GeForce RTX 4060',  115, 300, media).
gpu(gpu_rtx3070,   nvidia, 'GeForce RTX 3070',  220, 500, alta).
gpu(gpu_rx6600,    amd,    'Radeon RX 6600',    132, 220, baja).
gpu(gpu_rx6700xt,  amd,    'Radeon RX 6700 XT', 230, 480, alta).

% ------------------------------------------------------------
% 3. Motherboards
% motherboard(ID, Marca, Modelo, Socket, Precio_USD, TipoDDR)
% ------------------------------------------------------------
motherboard(mb_asus_b550m_a,      asus,     'PRIME B550M-A',         am4,     100, ddr4).
motherboard(mb_msi_b650_p,        msi,      'PRO B650-P WIFI',       am5,     180, ddr5).
motherboard(mb_gigabyte_z790_eagle,gigabyte,'Z790 EAGLE AX',         lga1700, 200, ddr5).
motherboard(mb_asus_h610m_k,      asus,     'PRIME H610M-K D4',      lga1700,  90, ddr4).

% ------------------------------------------------------------
% 4. RAM
% ram(ID, Tipo, Capacidad_GB, Frecuencia_MHz, Precio_USD)
% ------------------------------------------------------------
ram(ram_ddr4_16gb_3200, ddr4, 16, 3200, 45).
ram(ram_ddr5_16gb_5200, ddr5, 16, 5200, 60).
ram(ram_ddr5_16gb_6000, ddr5, 16, 6000, 80).

% ============================================================
% REGLAS DE COMPATIBILIDAD FÍSICA
% ============================================================

% Socket CPU - Motherboard
compatible_socket(CPU_ID, MB_ID) :-
    cpu(CPU_ID, _, _, Socket, _, _, _),
    motherboard(MB_ID, _, _, Socket, _, _).

% Tipo de RAM - Motherboard
compatible_ram(MB_ID, RAM_ID) :-
    motherboard(MB_ID, _, _, _, _, TipoDDR_MB),
    ram(RAM_ID, TipoDDR_RAM, _, _, _),
    TipoDDR_MB == TipoDDR_RAM.

% ============================================================
% REGLAS DE WATTS / FUENTE
% ============================================================
consumo_estimado(CPU_ID, GPU_ID, Watts) :-
    cpu(CPU_ID, _, _, _, TDP_CPU, _, _),
    gpu(GPU_ID, _, _, TDP_GPU, _, _),
    Base is TDP_CPU + TDP_GPU,
    Watts is Base * 1.30.   % +30% margen de seguridad

fuente_recomendada(CPU_ID, GPU_ID, Rango) :-
    consumo_estimado(CPU_ID, GPU_ID, Watts),
    Min is ceiling(Watts / 50) * 50,
    Max is Min + 100,
    atom_concat(Min, 'W - ', T),
    atom_concat(T, Max, T2),
    atom_concat(T2, 'W', Rango).

% ============================================================
% DETECCIÓN DE CUELLO DE BOTELLA
% ============================================================
cuello_botella(CPU_ID, GPU_ID) :-
    cpu(CPU_ID, _, _, _, _, _, baja),
    gpu(GPU_ID, _, _, _, _, alta).

cuello_botella_inverso(CPU_ID, GPU_ID) :-
    cpu(CPU_ID, _, _, _, _, _, alta),
    gpu(GPU_ID, _, _, _, _, _, baja).

% ============================================================
% FILTROS DE APTITUD POR USO
% (qué combinaciones "tienen sentido" para cada perfil)
% ============================================================

cpu_apto_para(gaming,       CPU_ID) :- cpu(CPU_ID, _, _, _, _, _, G), G \= baja.
cpu_apto_para(programacion, CPU_ID) :- cpu(CPU_ID, _, _, _, _, _, G), G \= baja.
cpu_apto_para(edicion,      CPU_ID) :- cpu(CPU_ID, _, _, _, _, _, G), G \= baja.
cpu_apto_para(maestro,      CPU_ID) :- cpu(CPU_ID, _, _, _, _, _, _).

gpu_apto_para(gaming,       GPU_ID) :- gpu(GPU_ID, _, _, _, _, G), G \= baja.
gpu_apto_para(programacion, GPU_ID) :- gpu(GPU_ID, _, _, _, _, _).
gpu_apto_para(edicion,      GPU_ID) :- gpu(GPU_ID, _, _, _, _, G), G \= baja.
gpu_apto_para(maestro,      GPU_ID) :- gpu(GPU_ID, _, _, _, _, G), G \= alta.

ram_apto_para(_, RAM_ID) :- ram(RAM_ID, _, _, _, _).

% ============================================================
% PUNTAJES DE PREFERENCIA POR USO
% (mayor puntaje = mejor encaje)
% ============================================================

% CPU
puntaje_cpu(gaming,       baja, 0).  puntaje_cpu(gaming,       media, 2).  puntaje_cpu(gaming,       alta, 3).
puntaje_cpu(programacion, baja, 1).  puntaje_cpu(programacion, media, 2).  puntaje_cpu(programacion, alta, 3).
puntaje_cpu(edicion,      baja, 0).  puntaje_cpu(edicion,      media, 2).  puntaje_cpu(edicion,      alta, 3).
puntaje_cpu(maestro,      baja, 3).  puntaje_cpu(maestro,      media, 1).  puntaje_cpu(maestro,      alta, 0).

% GPU
puntaje_gpu(gaming,       baja, 0).  puntaje_gpu(gaming,       media, 2).  puntaje_gpu(gaming,       alta, 3).
puntaje_gpu(programacion, baja, 3).  puntaje_gpu(programacion, media, 1).  puntaje_gpu(programacion, alta, 0).
puntaje_gpu(edicion,      baja, 0).  puntaje_gpu(edicion,      media, 2).  puntaje_gpu(edicion,      alta, 3).
puntaje_gpu(maestro,      baja, 3).  puntaje_gpu(maestro,      media, 1).  puntaje_gpu(maestro,      alta, 0).

% RAM (para edición preferimos DDR5 por ancho de banda)
puntaje_ram(edicion,      ddr5, 3).
puntaje_ram(edicion,      ddr4, 0).
puntaje_ram(gaming,       _,    0).
puntaje_ram(programacion, _,    0).
puntaje_ram(maestro,      _,    0).

% Puntaje total de un build para un uso
puntaje_build(Uso, CPU_ID, GPU_ID, _MB_ID, RAM_ID, Puntaje) :-
    cpu(CPU_ID, _, _, _, _, _, GC),
    gpu(GPU_ID, _, _, _, _, GG),
    ram(RAM_ID, Tipo, _, _, _),
    puntaje_cpu(Uso, GC, PC),
    puntaje_gpu(Uso, GG, PG),
    puntaje_ram(Uso, Tipo, PR),
    Puntaje is PC + PG + PR.

% ============================================================
% COSTO Y PRESUPUESTO
% ============================================================
costo_total(CPU_ID, GPU_ID, MB_ID, RAM_ID, Total) :-
    cpu(CPU_ID, _, _, _, _, P_CPU, _),
    gpu(GPU_ID, _, _, _, P_GPU, _),
    motherboard(MB_ID, _, _, _, P_MB, _),
    ram(RAM_ID, _, _, _, P_RAM),
    Total is P_CPU + P_GPU + P_MB + P_RAM.

dentro_presupuesto(CPU_ID, GPU_ID, MB_ID, RAM_ID, Presupuesto) :-
    costo_total(CPU_ID, GPU_ID, MB_ID, RAM_ID, Total),
    Total =< Presupuesto.

presupuesto_suficiente(Uso, Presupuesto) :-
    presupuesto_minimo(Uso, Min),
    Presupuesto >= Min.

% ============================================================
% REGLA PRINCIPAL: BUILD RECOMENDADO SEGÚN USO
% ============================================================
build_recomendado(Uso, CPU_ID, GPU_ID, MB_ID, RAM_ID) :-
    uso(Uso),
    cpu_apto_para(Uso, CPU_ID),
    gpu_apto_para(Uso, GPU_ID),
    ram_apto_para(Uso, RAM_ID),
    motherboard(MB_ID, _, _, _, _, _),
    compatible_socket(CPU_ID, MB_ID),
    compatible_ram(MB_ID, RAM_ID),
    \+ cuello_botella(CPU_ID, GPU_ID).

build_valido(Uso, CPU_ID, GPU_ID, MB_ID, RAM_ID, Presupuesto) :-
    build_recomendado(Uso, CPU_ID, GPU_ID, MB_ID, RAM_ID),
    dentro_presupuesto(CPU_ID, GPU_ID, MB_ID, RAM_ID, Presupuesto).

% ============================================================
% SELECCIÓN DEL MEJOR BUILD
% Criterio: maximizar (puntaje_uso * 10000 + costo),
% es decir: primero el que mejor encaje con el uso, y a igual
% puntaje el que use más presupuesto (hardware más potente).
% ============================================================
mejor_build(Uso, Presupuesto, CPU_ID, GPU_ID, MB_ID, RAM_ID) :-
    presupuesto_suficiente(Uso, Presupuesto),
    findall(PuntajeTotal-build(C, G, M, R),
            ( build_valido(Uso, C, G, M, R, Presupuesto),
              puntaje_build(Uso, C, G, M, R, P),
              costo_total(C, G, M, R, Costo),
              PuntajeTotal is P * 10000 + Costo ),
            Lista),
    Lista \= [],
    predsort(compare_desc, Lista, [_-build(CPU_ID, GPU_ID, MB_ID, RAM_ID)|_]).

compare_desc(Order, A-_, B-_) :- compare(Order, B, A).

% ============================================================
% UTILIDAD DE IMPRESIÓN (para pruebas desde consola Prolog)
% ============================================================
mostrar_mejor_build(Uso, Presupuesto) :-
    mejor_build(Uso, Presupuesto, CPU_ID, GPU_ID, MB_ID, RAM_ID),
    cpu(CPU_ID, _, MCPU, _, _, _, _),
    gpu(GPU_ID, _, MGPU, _, _, _),
    motherboard(MB_ID, _, MMB, _, _, _),
    ram(RAM_ID, Tipo, Cap, Frec, _),
    costo_total(CPU_ID, GPU_ID, MB_ID, RAM_ID, Total),
    consumo_estimado(CPU_ID, GPU_ID, Watts),
    fuente_recomendada(CPU_ID, GPU_ID, Fuente),
    format('=== Build para ~w con $~2f USD ===~n', [Uso, Presupuesto]),
    format('CPU: ~w~nGPU: ~w~nMotherboard: ~w~nRAM: ~w GB ~w ~w MHz~n',
           [MCPU, MGPU, MMB, Cap, Tipo, Frec]),
    format('Costo total: $~2f~nConsumo estimado: ~w W~nFuente: ~w~n',
           [Total, Watts, Fuente]).