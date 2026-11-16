:- encoding(utf8).
% ============================================================
% PC Builder Expert - Base de Conocimiento v6.2 (Lógica Corregida)
% ============================================================

:- dynamic pref/2.

% ------------------------------------------------------------
% 1. CPUs
% ------------------------------------------------------------
cpu(cpu_i3_12100,       intel, 'Core i3-12100',        lga1700, 60,  4,  8, baja,  si, 110).
cpu(cpu_i5_12400,       intel, 'Core i5-12400',        lga1700, 65,  6, 12, media, si, 150).
cpu(cpu_i5_12400f,      intel, 'Core i5-12400F',       lga1700, 65,  6, 12, media, no, 130).
cpu(cpu_i5_14400f,      intel, 'Core i5-14400F',       lga1700, 65, 10, 16, media, no, 170).
cpu(cpu_i5_14600k,      intel, 'Core i5-14600K',       lga1700, 181, 14, 20, alta,  si, 240).
cpu(cpu_i7_12700k,      intel, 'Core i7-12700K',       lga1700, 125, 12, 20, alta,  si, 300).
cpu(cpu_i7_14700k,      intel, 'Core i7-14700K',       lga1700, 253, 20, 28, alta,  si, 360).
cpu(cpu_i9_14900k,      intel, 'Core i9-14900K',       lga1700, 253, 24, 32, alta,  si, 450).
cpu(cpu_ultra5_245k,    intel, 'Core Ultra 5 245K',    lga1851, 125, 14, 14, alta,  si, 260).
cpu(cpu_ultra7_265k,    intel, 'Core Ultra 7 265K',    lga1851, 125, 20, 20, alta,  si, 380).
cpu(cpu_ryzen5_5600,    amd,   'Ryzen 5 5600',         am4,  65,  6, 12, media, no, 110).
cpu(cpu_ryzen5_5600g,   amd,   'Ryzen 5 5600G',        am4,  65,  6, 12, media, si, 130).
cpu(cpu_ryzen5_5600x,   amd,   'Ryzen 5 5600X',        am4,  65,  6, 12, media, no, 130).
cpu(cpu_ryzen7_5700x,   amd,   'Ryzen 7 5700X',        am4,  65,  8, 16, alta,  no, 170).
cpu(cpu_ryzen7_5700x3d, amd,   'Ryzen 7 5700X3D',      am4, 105,  8, 16, alta,  no, 200).
cpu(cpu_ryzen7_5800x3d, amd,   'Ryzen 7 5800X3D',      am4, 105,  8, 16, alta,  no, 280).
cpu(cpu_ryzen5_7400,    amd,   'Ryzen 5 7400',         am5,  65,  6, 12, media, si, 150).
cpu(cpu_ryzen5_7600,    amd,   'Ryzen 5 7600',         am5,  65,  6, 12, media, si, 170).
cpu(cpu_ryzen5_9600x,   amd,   'Ryzen 5 9600X',        am5,  65,  6, 12, media, si, 220).
cpu(cpu_ryzen7_7700,    amd,   'Ryzen 7 7700',         am5,  65,  8, 16, alta,  si, 260).
cpu(cpu_ryzen7_7700x,   amd,   'Ryzen 7 7700X',        am5, 105,  8, 16, alta,  si, 300).
cpu(cpu_ryzen7_9700x,   amd,   'Ryzen 7 9700X',        am5,  65,  8, 16, alta,  si, 300).
cpu(cpu_ryzen7_7800x3d, amd,   'Ryzen 7 7800X3D',      am5, 120,  8, 16, alta,  si, 380).
cpu(cpu_ryzen7_9800x3d, amd,   'Ryzen 7 9800X3D',      am5, 120,  8, 16, alta,  si, 460).
cpu(cpu_ryzen9_7900x,   amd,   'Ryzen 9 7900X',        am5, 170, 12, 24, alta,  si, 380).
cpu(cpu_ryzen9_9900x,   amd,   'Ryzen 9 9900X',        am5, 120, 12, 24, alta,  si, 420).
cpu(cpu_ryzen9_9950x,   amd,   'Ryzen 9 9950X',        am5, 170, 16, 32, alta,  si, 600).

rend_cpu(cpu_i3_12100,40,25).     rend_cpu(cpu_i5_12400,60,45).    rend_cpu(cpu_i5_12400f,60,45).
rend_cpu(cpu_i5_14400f,64,60).    rend_cpu(cpu_i5_14600k,80,78).   rend_cpu(cpu_i7_12700k,78,72).
rend_cpu(cpu_i7_14700k,88,92).    rend_cpu(cpu_i9_14900k,90,98).   rend_cpu(cpu_ultra5_245k,78,75).
rend_cpu(cpu_ultra7_265k,85,85).  rend_cpu(cpu_ryzen5_5600,60,40).  rend_cpu(cpu_ryzen5_5600g,55,35).
rend_cpu(cpu_ryzen5_5600x,62,42). rend_cpu(cpu_ryzen7_5700x,68,50). rend_cpu(cpu_ryzen7_5700x3d,88,50).
rend_cpu(cpu_ryzen7_5800x3d,90,55). rend_cpu(cpu_ryzen5_7400,62,42). rend_cpu(cpu_ryzen5_7600,70,45).
rend_cpu(cpu_ryzen5_9600x,76,55). rend_cpu(cpu_ryzen7_7700,74,58). rend_cpu(cpu_ryzen7_7700x,76,62).
rend_cpu(cpu_ryzen7_9700x,80,62). rend_cpu(cpu_ryzen7_7800x3d,100,62). rend_cpu(cpu_ryzen7_9800x3d,100,62).
rend_cpu(cpu_ryzen9_7900x,82,80). rend_cpu(cpu_ryzen9_9900x,84,88). rend_cpu(cpu_ryzen9_9950x,86,100).

% ------------------------------------------------------------
% 2. GPUs
% ------------------------------------------------------------
gpu(integrada,          none,   'Graficos integrados', 0,   baja,   0,   0, 0).
gpu(gpu_gtx1650,        nvidia, 'GeForce GTX 1650',    75,  baja,   4, 230, 120).
gpu(gpu_rx6400,         amd,    'Radeon RX 6400',      53,  baja,   4, 165, 115).
gpu(gpu_arc_b580,       intel,  'Arc B580',           190,  media, 12, 270, 250).
gpu(gpu_rx6600,         amd,    'Radeon RX 6600',     132,  media,  8, 225, 200).
gpu(gpu_rtx4060,        nvidia, 'GeForce RTX 4060',   115,  media,  8, 240, 300).
gpu(gpu_rx7600,         amd,    'Radeon RX 7600',     165,  media,  8, 240, 250).
gpu(gpu_rtx5060,        nvidia, 'GeForce RTX 5060',   145,  media,  8, 240, 300).
gpu(gpu_rx7600xt,       amd,    'Radeon RX 7600 XT',  190,  media, 16, 245, 330).
gpu(gpu_rx9060xt,       amd,    'Radeon RX 9060 XT 16GB', 160, media, 16, 240, 350).
gpu(gpu_rtx5060ti,      nvidia, 'GeForce RTX 5060 Ti 16GB', 180, media, 16, 240, 450).
gpu(gpu_rx6700xt,       amd,    'Radeon RX 6700 XT',  230,  alta,  12, 267, 350).
gpu(gpu_rx7700xt,       amd,    'Radeon RX 7700 XT',  245,  alta,  12, 267, 400).
gpu(gpu_rx7800xt,       amd,    'Radeon RX 7800 XT',  263,  alta,  16, 267, 480).
gpu(gpu_rtx4070s,       nvidia, 'GeForce RTX 4070 Super', 220, alta, 12, 267, 600).
gpu(gpu_rx9070,         amd,    'Radeon RX 9070',     220,  alta,  16, 304, 600).
gpu(gpu_rtx5070,        nvidia, 'GeForce RTX 5070',   250,  alta,  12, 267, 600).
gpu(gpu_rx9070xt,       amd,    'Radeon RX 9070 XT',  304,  alta,  16, 304, 699).
gpu(gpu_rtx5070ti,      nvidia, 'GeForce RTX 5070 Ti', 300, alta,  16, 304, 1099).
gpu(gpu_rtx4080s,       nvidia, 'GeForce RTX 4080 Super', 320, alta, 16, 310, 1000). 
gpu(gpu_rtx5080,        nvidia, 'GeForce RTX 5080',   360,  alta,  16, 304, 1300). 
gpu(gpu_rtx5090,        nvidia, 'GeForce RTX 5090',   575,  alta,  32, 336, 2400). 

rend_gpu(integrada,10,15).
rend_gpu(gpu_gtx1650,18,15).   rend_gpu(gpu_rx6400,15,12).    rend_gpu(gpu_arc_b580,45,40).
rend_gpu(gpu_rx6600,40,30).    rend_gpu(gpu_rtx4060,42,45).   rend_gpu(gpu_rx7600,42,35).
rend_gpu(gpu_rtx5060,45,48).   rend_gpu(gpu_rx7600xt,46,40).  rend_gpu(gpu_rx9060xt,55,50).
rend_gpu(gpu_rtx5060ti,53,55). rend_gpu(gpu_rx6700xt,58,45).  rend_gpu(gpu_rx7700xt,62,55).
rend_gpu(gpu_rx7800xt,68,60).  rend_gpu(gpu_rtx4070s,72,75).  rend_gpu(gpu_rx9070,75,70).
rend_gpu(gpu_rtx5070,72,75).   rend_gpu(gpu_rx9070xt,82,78).  rend_gpu(gpu_rtx5070ti,85,88).
rend_gpu(gpu_rtx4080s,90,92).  rend_gpu(gpu_rtx5080,96,96).   rend_gpu(gpu_rtx5090,100,100).

% ------------------------------------------------------------
% 3. Placas madre
% ------------------------------------------------------------
motherboard(mb_a520m,     asus,    'PRIME A520M-K',           am4,    ddr4, matx, no, 70).
motherboard(mb_b550m,     msi,     'B550M PRO-VDH',           am4,    ddr4, matx, no, 100).
motherboard(mb_b550m_wifi,gigabyte,'B550M DS3H AX',           am4,    ddr4, matx, si, 120).
motherboard(mb_b550_atx,  gigabyte,'B550 AORUS ELITE AX',     am4,    ddr4, atx,  si, 160).
motherboard(mb_a620m,     asus,    'A620M-PLUS',              am5,    ddr5, matx, no, 100). 
motherboard(mb_b650m,     gigabyte,'B650M DS3H',              am5,    ddr5, matx, no, 150).
motherboard(mb_b650m_wifi,msi,     'PRO B650M-A WIFI',        am5,    ddr5, matx, si, 180).
motherboard(mb_b550i_itx, asus,    'ROG STRIX B550-I GAMING', am4,    ddr4, itx,  si, 220). 
motherboard(mb_b650i_itx, asus,    'ROG STRIX B650-I GAMING', am5,    ddr5, itx,  si, 260). 
motherboard(mb_b650_atx,  asus,    'TUF GAMING B650-PLUS WIFI', am5,  ddr5, atx,  si, 200). 
motherboard(mb_b850_atx,  gigabyte,'B850 AORUS ELITE WIFI7',  am5,    ddr5, atx,  si, 230). 
motherboard(mb_h610m,     asus,    'PRIME H610M-E',           lga1700,ddr4, matx, no, 90).
motherboard(mb_b760m,     msi,     'PRO B760M-A',             lga1700,ddr5, matx, no, 130).
motherboard(mb_b760m_wifi,gigabyte,'B760M DS3H AX',           lga1700,ddr5, matx, si, 160).
motherboard(mb_z790,      gigabyte,'Z790 EAGLE AX',           lga1700,ddr5, atx,  si, 200).
motherboard(mb_b860m,     msi,     'MAG B860M MORTAR WIFI',   lga1851,ddr5, matx, si, 180). 
motherboard(mb_z890,      gigabyte,'Z890 AORUS ELITE',        lga1851,ddr5, atx,  si, 300). 

% ------------------------------------------------------------
% 4. RAM
% ------------------------------------------------------------
ram(ram_ddr4_8gb_3200,  ddr4, 8,  3200, 35).
ram(ram_ddr4_16gb_3200, ddr4, 16, 3200, 70).
ram(ram_ddr4_32gb_3600, ddr4, 32, 3600, 150).   
ram(ram_ddr5_16gb_5600, ddr5, 16, 5600, 130).   
ram(ram_ddr5_32gb_5600, ddr5, 32, 5600, 380).   
ram(ram_ddr5_32gb_6000, ddr5, 32, 6000, 420).   
ram(ram_ddr5_64gb_6000, ddr5, 64, 6000, 850).   
ram(ram_ddr4_16gb_3600, ddr4, 16, 3600, 85).    
ram(ram_ddr4_32gb_3200, ddr4, 32, 3200, 140).   
ram(ram_ddr5_16gb_6000, ddr5, 16, 6000, 190).   

% ------------------------------------------------------------
% 5. Almacenamiento
% ------------------------------------------------------------
almacenamiento(alm_hdd_1tb,        hdd,       1000,  55).   
almacenamiento(alm_hdd_4tb,        hdd,       4000, 100).   
almacenamiento(alm_ssd_sata_500gb, ssd_sata,   500,  45).   
almacenamiento(alm_ssd_sata_1tb,   ssd_sata,  1000,  75).   
almacenamiento(alm_nvme3_500gb,    ssd_nvme3,  500,  50).   
almacenamiento(alm_nvme4_500gb,    ssd_nvme4,  500,  60).   
almacenamiento(alm_nvme4_1tb,      ssd_nvme4, 1000, 100).   
almacenamiento(alm_nvme4_2tb,      ssd_nvme4, 2000, 170).   
almacenamiento(alm_nvme4_4tb,      ssd_nvme4, 4000, 340).   
almacenamiento(alm_nvme5_1tb,      ssd_nvme5, 1000, 150).   
almacenamiento(alm_nvme5_2tb,      ssd_nvme5, 2000, 260).   

% ------------------------------------------------------------
% 6. Fuentes
% ------------------------------------------------------------
fuente(f_500w,  evga,    'EVGA 500 BR 80+ Bronze',       500,  bronze,   no, 50).
fuente(f_550w,  corsair, 'CX550 80+ Bronze',             550,  bronze,   no, 55).
fuente(f_650w,  corsair, 'RM650e 80+ Gold ATX 3.1',      650,  gold,     si, 90).
fuente(f_750w,  corsair, 'RM750e 80+ Gold ATX 3.1',      750,  gold,     si, 115).
fuente(f_850w,  corsair, 'RM850e 80+ Gold ATX 3.1',      850,  gold,     si, 130).
fuente(f_1000w, corsair, 'RM1000e 80+ Gold ATX 3.1',    1000,  gold,     si, 170).
fuente(f_1200w, corsair, 'AX1200 80+ Titanium',         1200,  titanium, si, 300). 
fuente(f_850w_gold, seasonic, 'Focus GX-850 80+ Gold',    850, gold,     no, 150). 
fuente(f_1000w_plat, corsair, 'HX1000i 80+ Platinum',   1000, platinum, no, 220). 

% ------------------------------------------------------------
% 7. Gabinetes
% ------------------------------------------------------------
gabinete(g_itx_nr200p, coolermaster, 'NR200P',           itx,  [itx],        330,  60, 110). 
gabinete(g_matx_basico,generic,      'mATX basico',      matx, [matx, itx], 300, 150,  40). 
gabinete(g_mid_h510,   nzxt,         'H510',             mid,  [atx, matx, itx], 381, 165,  90).
gabinete(g_mid_4000d,  corsair,      '4000D Airflow',    mid,  [atx, matx, itx], 360, 170, 110). 
gabinete(g_mid_lancool,lian_li,      'Lancool 216',      mid,  [atx, matx, itx], 384, 170, 120). 
gabinete(g_mid_pop,    fractal,      'Pop Air',          mid,  [atx, matx, itx], 405, 170, 100). 
gabinete(g_full_o11,   lian_li,      'O11 Dynamic EVO',  full, [atx, matx, itx], 420, 166, 150). 
gabinete(g_mid_meshify, fractal, 'Meshify 2', mid, [atx, matx, itx], 467, 170, 150). 
gabinete(g_matx_lancool205, lian_li, 'Lancool 205 Mesh', matx, [matx, itx], 330, 170, 90). 

% ------------------------------------------------------------
% 8. Coolers
% ------------------------------------------------------------
cooler(cool_stock,    stock, 'Cooler de caja (stock)',    65,   0,  0).
cooler(cool_low,      aire,  'Noctua NH-L9i (Bajo perfil)', 95,  37, 50).
cooler(cool_hyper212, aire,  'Hyper 212 Black',           160, 159, 45). 
cooler(cool_nhd15,    aire,  'NH-D15',                    250, 165, 110). 
cooler(cool_aio240,   aio,   'Corsair iCUE H100i 240mm',  250,   0, 120). 
cooler(cool_aio360,   aio,   'Arctic Liquid Freezer III 360', 300,   0, 130). 

% ------------------------------------------------------------
% 9. Nombres legibles
% ------------------------------------------------------------
nombre(integrada, 'Gráficos integrados (iGPU)') :- !.
nombre(Id, N) :- cpu(Id, M, Mo, _, _, _, _, _, _, _), format(atom(N), '~w ~w', [M, Mo]).
nombre(Id, N) :- gpu(Id, _, Mo, _, _, V, _, _), format(atom(N), '~w (~wGB VRAM)', [Mo, V]).
nombre(Id, N) :- motherboard(Id, M, Mo, _, _, _, _, _), format(atom(N), '~w ~w', [M, Mo]).
nombre(Id, N) :- ram(Id, T, C, F, _), format(atom(N), '~wGB ~w ~wMHz', [C, T, F]).
nombre(Id, N) :- almacenamiento(Id, T, C, _), format(atom(N), '~wGB ~w', [C, T]).
nombre(Id, N) :- fuente(Id, M, Mo, W, _, _, _), format(atom(N), '~w ~w (~wW)', [M, Mo, W]).
nombre(Id, N) :- gabinete(Id, M, Mo, T, _, _, _, _), format(atom(N), '~w ~w (~w)', [M, Mo, T]).
nombre(Id, N) :- cooler(Id, _, Mo, _, _, _), format(atom(N), '~w', [Mo]).

% ------------------------------------------------------------
% 10. Perfiles y Utilidades
% ------------------------------------------------------------
perfil(economica,   0.70, 'Económica').
perfil(equilibrada, 0.90, 'Equilibrada').
perfil(maximo,      1.00, 'Máximo rendimiento').

presupuesto_minimo(gaming, 650).
presupuesto_minimo(edicion, 800).
presupuesto_minimo(programacion, 500).
presupuesto_minimo(maestro, 400).
presupuesto_suficiente(Uso, P) :- presupuesto_minimo(Uso, Min), P >= Min.

pref_def(K, D, V) :- ( pref(K, X) -> V = X ; V = D ).

precio(cpu, Id, P) :- cpu(Id, _, _, _, _, _, _, _, _, P).
precio(gpu, Id, P) :- gpu(Id, _, _, _, _, _, _, P).
precio(mb,  Id, P) :- motherboard(Id, _, _, _, _, _, _, P).
precio(ram, Id, P) :- ram(Id, _, _, _, P).
precio(alm, Id, P) :- almacenamiento(Id, _, _, P).
precio(psu, Id, P) :- fuente(Id, _, _, _, _, _, P).
precio(gab, Id, P) :- gabinete(Id, _, _, _, _, _, _, P).
precio(cool, Id, P) :- cooler(Id, _, _, _, _, P).

reusa(ram) :- pref_def(reutiliza, ninguno, X), member(X, [ram_ddr4, ram_ddr5]).
reusa(alm) :- pref_def(reutiliza, ninguno, ssd).
costo(ram, _, 0) :- reusa(ram), !.
costo(alm, _, 0) :- reusa(alm), !.
costo(Tipo, Id, P) :- precio(Tipo, Id, P).

tdp_cpu(C, T) :- cpu(C, _, _, _, T, _, _, _, _, _).
tdp_gpu(G, T) :- gpu(G, _, _, T, _, _, _, _).

cert_rank(titanium, 3). cert_rank(platinum, 2). cert_rank(gold, 1). cert_rank(bronze, 0).

% ------------------------------------------------------------
% 12. Restricciones y Filtros
% ------------------------------------------------------------
marca_ok(Marca) :- pref_def(marca_cpu, indiferente, M), ( M == indiferente -> true ; M == Marca ).

cpu_uso_ok(gaming, Nuc, Gama, _) :- Gama \== baja, pref_def(gaming_streaming, no, S), ( S == si -> Nuc >= 8 ; true ).
cpu_uso_ok(edicion, Nuc, Gama, _) :- Gama \== baja, pref_def(edicion_frecuencia, pocas, F), ( F == diario -> Nuc >= 8 ; true ).
cpu_uso_ok(programacion, Nuc, Gama, _) :-
    Gama \== baja,
    ( pref_def(prog_area, web_movil, A), member(A, [ciberseguridad, backend_cloud]) -> Nuc >= 8 ; true ),
    ( pref_def(prog_vms, no, V), V == siempre -> Nuc >= 8 ; true ).
cpu_uso_ok(maestro, _, _, Gr) :- Gr == si.

valor_cpu(gaming, RJ, _, RJ). valor_cpu(edicion, _, RT, RT). valor_cpu(programacion, _, RT, RT). valor_cpu(maestro, _, RT, RT).

objetivo(gaming, cpu, O) :- pref_def(gaming_prioridad, equilibrado, P), ( P == cpu -> O = 100 ; P == gpu -> O = 60 ; O = 80 ).
objetivo(gaming, gpu, O) :- pref_def(gaming_prioridad, equilibrado, P), ( P == gpu -> O = 100 ; P == cpu -> O = 60 ; O = 80 ).
objetivo(edicion, cpu, O) :- pref_def(edicion_prioridad, render_gpu, P), ( P == render_cpu -> O = 100 ; O = 70 ).
objetivo(edicion, gpu, O) :- pref_def(edicion_prioridad, render_gpu, P), ( P == render_gpu -> O = 100 ; O = 60 ).
objetivo(programacion, cpu, 70). objetivo(programacion, gpu, 40).
objetivo(maestro, cpu, 60). objetivo(maestro, gpu, 10).

vram_min_gaming(_, vr, 12) :- !.
vram_min_gaming('4k', _, 12) :- !.
vram_min_gaming('1440p', esports, 8) :- !.
vram_min_gaming('1440p', _, 12) :- !.
vram_min_gaming(_, _, 8).

tiene_igpu(CPU) :- cpu(CPU, _, _, _, _, _, _, _, si, _).
gpu_uso_ok(maestro, Id, _, _, _) :- Id == integrada.
gpu_uso_ok(programacion, Id, _, _, _) :- 
    Id == integrada, 
    pref_def(prog_ia_local, no, no).
gpu_uso_ok(programacion, Id, _, VRAM, Marca) :-
    Id \== integrada, pref_def(prog_ia_local, no, IA),
    ( IA == grande -> VRAM >= 16 ; IA == pequeno -> VRAM >= 8 ; true ),
    ( pref_def(prog_area, web_movil, A), A == data_ia -> Marca == nvidia ; true ).
gpu_uso_ok(gaming, Id, Gama, VRAM, _) :-
    Id \== integrada, Gama \== baja,
    pref_def(gaming_resolucion, '1080p', R), pref_def(gaming_juegos, esports, J),
    vram_min_gaming(R, J, Min), VRAM >= Min.
gpu_uso_ok(edicion, Id, Gama, VRAM, Marca) :-
    Id \== integrada, Gama \== baja, VRAM >= 8,
    pref_def(edicion_resolucion, '1080p', R), rend_gpu(Id, _, RT),
    ( R == '4k' -> VRAM >= 12, RT >= 55 ; R == '8k' -> VRAM >= 16, RT >= 75 ; true ),
    pref_def(edicion_software, premiere, S),
    ( (S == blender ; S == arquitectura_3d) -> Marca == nvidia ; true ).

valor_gpu(gaming, RJ, _, RJ). valor_gpu(edicion, _, RT, RT). valor_gpu(programacion, _, RT, RT). valor_gpu(maestro, _, RT, RT).

compatible_cuello(_, _, integrada) :- !.
compatible_cuello(Uso, C, G) :-
    cpu(C, _, _, _, _, _, _, Gc, _, _), gpu(G, _, _, _, Gg, _, _, _),
    \+ (Gc == baja, Gg == alta),
    ( Uso == gaming -> \+ (Gc == alta, Gg == baja) ; true ),
    rend_cpu(C, CJ, CT), rend_gpu(G, GJ, GT),
    ( Uso == gaming -> RC = CJ, RG = GJ ; RC = CT, RG = GT ),
    ( Uso == gaming -> RG - RC =< 25 ; RG - RC =< 35 ),
    RC - RG =< 50.

% ------------------------------------------------------------
% 13. Listas Ordenadas
% ------------------------------------------------------------
ordenar(Pares, Lista) :- keysort(Pares, Ord), pairs_values(Ord, Lista).

lista_cpu(Uso, Lista) :-
    findall(K-Id, ( cpu(Id, Marca, _, _, _, Nuc, _, Gama, Gr, _),
          marca_ok(Marca), cpu_uso_ok(Uso, Nuc, Gama, Gr),
          rend_cpu(Id, RJ, RT), valor_cpu(Uso, RJ, RT, V),
          objetivo(Uso, cpu, Obj), K is abs(V - Obj) ), Pares),
    ordenar(Pares, Lista).

lista_gpu(Uso, Lista) :-
    findall(K-Id, ( gpu(Id, Marca, _, _, Gama, VRAM, _, _),
          gpu_uso_ok(Uso, Id, Gama, VRAM, Marca),
          rend_gpu(Id, RJ, RT), valor_gpu(Uso, RJ, RT, V),
          objetivo(Uso, gpu, Obj), K is abs(V - Obj) ), Pares),
    ordenar(Pares, Lista).

chipset_basico(mb_a520m). chipset_basico(mb_a620m). chipset_basico(mb_h610m).
gpu_fuerte(G) :- gpu(G, _, _, _, _, VRAM, _, P), (VRAM >= 12 ; P >= 250).

lista_mb(Uso, C, Lista) :-
    cpu(C, _, _, Socket, _, _, _, Gama, _, _),
    findall(K-Id, ( motherboard(Id, _, _, Socket, Tipo, Form, WiFi, P),
          formato_mb_ok(Form), tipo_mb_reuso_ok(Tipo), wifi_ok(Uso, WiFi),
          ( Gama == alta -> \+ chipset_basico(Id) ; true ),
          ( Uso == maestro -> K = P ; K is -P ) ), Pares),
    ordenar(Pares, Lista).

formato_mb_ok(Form) :- pref_def(tamano, indiferente, T),
    ( T == mini -> Form == itx ; T == compacta -> member(Form, [matx, itx]) ; T == normal -> Form == atx ; true ).
tipo_mb_reuso_ok(Tipo) :- pref_def(reutiliza, ninguno, R),
    ( R == ram_ddr4 -> Tipo == ddr4 ; R == ram_ddr5 -> Tipo == ddr5 ; true ).
wifi_ok(maestro, WiFi) :- pref_def(maestro_tareas, ofimatica, T), ( T == docencia_virtual -> WiFi == si ; true ).
wifi_ok(_, _).

ram_req(gaming, M, I) :- 
    pref_def(gaming_streaming, no, S), 
    pref_def(gaming_resolucion, '1080p', R),
    ( (S == si ; R == '4k') -> M = 32, I = 32 ; M = 16, I = 32 ).

ram_req(edicion, M, I) :- pref_def(edicion_resolucion, '1080p', R),
    ( R == '8k' -> M = 64, I = 64 ; R == '4k' -> M = 32, I = 32 ; M = 16, I = 32 ).
ram_req(programacion, M, I) :- pref_def(prog_vms, no, V), pref_def(prog_ia_local, no, IA), pref_def(prog_area, web_movil, A),
    ( (V == siempre ; IA == grande ; A == videojuegos) -> M = 32, I = 32 ; M = 16, I = 32 ).
ram_req(maestro, M, M) :- pref_def(maestro_ram, '16gb', R), ( R == '8gb' -> M = 8 ; R == '32gb' -> M = 32 ; M = 16 ).

lista_ram(Uso, M, Lista) :-
    motherboard(M, _, _, _, Tipo, _, _, _),
    ram_req(Uso, Min, Ideal),
    findall(K-Id, ( ram(Id, Tipo, Cap, _, _), Cap >= Min, K is abs(Cap - Ideal) ), Pares),
    ordenar(Pares, Lista).

typepen(ssd_nvme5, 20). typepen(ssd_nvme4, 0). typepen(ssd_nvme3, 50). typepen(ssd_sata, 1500). typepen(hdd, 3000).

alm_req(gaming, 500, 1000). alm_req(edicion, 1000, 2000). alm_req(programacion, 500, 1000). alm_req(maestro, 500, 500).

lista_alm(Uso, Lista) :-
    alm_req(Uso, Min, Ideal),
    findall(K-Id, ( almacenamiento(Id, Tipo, Cap, _), Cap >= Min,
          ( Tipo == hdd -> Uso == maestro ; true ),
          ( (Uso == edicion ; Uso == programacion) -> Tipo \== ssd_sata ; true ),
          typepen(Tipo, Pen), K is abs(Cap - Ideal) + Pen ), Pares),
    ordenar(Pares, Lista).

lista_psu(_, TC, TG, G, Lista) :-
    W_req is ceiling(1.3 * (TC + TG)),
    ( (TG >= 250) -> W is max(W_req, 850) ; W = W_req ), 
    precio(gpu, G, P_Gpu),
    ( (TG >= 150 ; P_Gpu >= 250) -> CertMin = gold ; CertMin = bronze ),
    findall(K-Id, ( 
          fuente(Id, _, _, Watts, Cert, Atx3, P),
          Watts >= W, 
          cert_rank(Cert, R), cert_rank(CertMin, RMin), R >= RMin,
          ( TG >= 300 -> Atx3 == si ; true ),
          K is P  
        ), Pares),
    ordenar(Pares, Lista).

lista_gab(Uso, M, G, Lista) :-
    motherboard(M, _, _, _, _, FormMB, _, _),
    gpu(G, _, _, _, _, _, LongG, _),
    findall(K-Id, ( gabinete(Id, _, _, Tam, Forms, MaxGPU, _, P),
          member(FormMB, Forms), LongG =< MaxGPU, tamano_gab_ok(Tam),
          rango_tamano(Tam, R),
          ( Uso == maestro -> K = P ; K is R * 1000 + P ) ), Pares),
    ordenar(Pares, Lista).

tamano_gab_ok(Tam) :- pref_def(tamano, indiferente, T),
    ( T == mini -> Tam == itx ; T == compacta -> member(Tam, [matx, itx]) ; T == normal -> member(Tam, [mid, full]) ; true ).
rango_tamano(full, 0). rango_tamano(mid, 1). rango_tamano(matx, 2). rango_tamano(itx, 3).


lista_cool(C, B, Lista) :-
    tdp_cpu(C, Tc),
    cpu(C, _, _, _, _, _, _, Gama, _, _),
    ( Gama == alta -> ExigirBueno = si ; ExigirBueno = no ), 
    gabinete(B, _, _, _, _, _, MaxCool, _),
    findall(K-Id, ( 
          cooler(Id, _, _, TDPMax, Alt, P),
          TDPMax >= Tc, 
          ( ExigirBueno == si -> Id \== cool_stock ; true ), 
          ( Alt > 0 -> Alt =< MaxCool ; true ), K = P ), Pares),
    ordenar(Pares, Lista).

% ------------------------------------------------------------
% 14. Búsqueda con Poda (Backtracking)
% ------------------------------------------------------------
par_piezas(Uso, Cap, C, G, Gasto) :-
    primero_gpu(Uso), !,
    lista_gpu(Uso, Gs), member(G, Gs), precio(gpu, G, Pg), Pg =< Cap,
    lista_cpu(Uso, Cs), member(C, Cs), compatible_cuello(Uso, C, G),
    ( G == integrada -> tiene_igpu(C) ; true ), 
    precio(cpu, C, Pc), Gasto is Pc + Pg, Gasto =< Cap.
par_piezas(Uso, Cap, C, G, Gasto) :-
    lista_cpu(Uso, Cs), member(C, Cs), precio(cpu, C, Pc), Pc =< Cap,
    lista_gpu(Uso, Gs), member(G, Gs), compatible_cuello(Uso, C, G),
    ( G == integrada -> tiene_igpu(C) ; true ),
    precio(gpu, G, Pg), Gasto is Pc + Pg, Gasto =< Cap.

primero_gpu(gaming) :- pref_def(gaming_prioridad, equilibrado, gpu).
primero_gpu(edicion) :- pref_def(edicion_prioridad, render_gpu, render_gpu).

resto(Uso, Cap, C, G, Gasto0, M, R, A, F, B, K, Total) :-
    lista_mb(Uso, C, Ms), member(M, Ms),  ( (gpu_fuerte(G), chipset_basico(M)) -> fail ; true ), costo(mb, M, Pm),
    G1 is Gasto0 + Pm, G1 =< Cap,
    lista_ram(Uso, M, Rs), member(R, Rs), costo(ram, R, Pr),
    G2 is G1 + Pr, G2 =< Cap,
    lista_alm(Uso, As), member(A, As), costo(alm, A, Pa),
    G3 is G2 + Pa, G3 =< Cap,
    tdp_cpu(C, Tc), tdp_gpu(G, Tg),
    lista_psu(Uso, Tc, Tg, G, Fs), member(F, Fs), precio(psu, F, Pf),
    G4 is G3 + Pf, G4 =< Cap,
    lista_gab(Uso, M, G, Bs), member(B, Bs), precio(gab, B, Pb),
    G5 is G4 + Pb, G5 =< Cap,
    lista_cool(C, B, Ks), member(K, Ks), precio(cool, K, Pk),
    Total is G5 + Pk, Total =< Cap.

mejor_build(Uso, Perfil, Pres, C, G, M, R, A, F, B, K, Total) :-
    perfil(Perfil, Fr, _), Cap is Pres * Fr,
    par_piezas(Uso, Cap, C, G, Gasto0),
    resto(Uso, Cap, C, G, Gasto0, M, R, A, F, B, K, Total), !.

consumo_sistema(C, G, W) :- tdp_cpu(C, Tc), tdp_gpu(G, Tg), W is (Tc + Tg) * 1.3.