% =========================
% CONFIGURACIÓN DINÁMICA
% =========================

:- dynamic ultima_compra/1.
:- dynamic historial_compra/1.

% =========================
% HECHOS (COMPONENTES)
% =========================

procesador(intel_core_i3).
procesador(intel_core_i5).
procesador(intel_core_i7).
procesador(intel_core_i9).
procesador(amd_ryzen3).
procesador(amd_ryzen5).
procesador(amd_ryzen7).
procesador(intel_core_ultra9_285k).
procesador(amd_ryzen9_9950x3d).
procesador(intel_core_ultra7_265k).
procesador(amd_ryzen7_9700x).

ram(4). ram(8). ram(16). ram(32). ram(64). ram(128).
ram(g_skill_trident_z5_rgb_64gb).
ram(corsair_dominator_titanium_32gb).

gpu(integrada).
gpu(gtx1650).
gpu(rtx2060).
gpu(rtx3060).
gpu(rtx4070).
gpu(nvidia_geforce_rtx_4090).
gpu(asus_rog_strix_rtx_4080_super).
gpu(amd_radeon_rx_7900_xtx).

almacenamiento(hdd1tb).
almacenamiento(ssd256).
almacenamiento(ssd512).
almacenamiento(ssd1tb).
almacenamiento(samsung_990_pro_4tb).
almacenamiento(crucial_t705_2tb).

% =========================
% LAPTOPS
% =========================

laptop(gamer, asus_rog_strix_scar_18_2026).
laptop(gamer, msi_raider_ge78_hx).

laptop(productividad_diseno, apple_macbook_pro_16_m4_max).

laptop(corporativa_trabajo, lenovo_thinkpad_x1_carbon_gen_13).

laptop(workstation, precision_7780_workstation).
laptop(workstation, hp_zbook_fury_g10).

% =========================
% OFERTAS Y COMPATIBILIDAD
% =========================

oferta_descuento(15).

compatibilidad(procesador(intel_core_i9), gpu(nvidia_geforce_rtx_4090)).
compatibilidad(procesador(amd_ryzen9_9950x3d), gpu(asus_rog_strix_rtx_4080_super)).
compatibilidad(procesador(intel_core_i7), gpu(rtx4070)).

% =========================
% PRODUCTOS COMPLEMENTARIOS
% =========================

complementario(laptop, mouse).
complementario(laptop, teclado).
complementario(laptop, parlantes).
complementario(laptop, audifonos).
complementario(laptop, mochila).

complementario(pc, monitor).
complementario(pc, teclado).
complementario(pc, mouse).
complementario(pc, parlantes).

% =========================
% MENÚ PRINCIPAL
% =========================

inicio :-
    nl, write('=== TIENDA DE INFORMATICA ==='), nl,
    write('1. Armar PC manualmente'), nl,
    write('2. Ver Laptops disponibles'), nl,
    write('3. Comprar Laptop (Asistente inteligente)'), nl,
    write('4. Ver productos complementarios'), nl,
    write('5. Ver ofertas especiales'), nl,
    write('6. Ver historial de compras'), nl,
    write('0. Salir'), nl,
    write('Seleccione una opcion: '),
    read(Opcion),
    ejecutar_opcion(Opcion).

ejecutar_opcion(0) :- write('¡Gracias por su visita!'), !.
ejecutar_opcion(1) :- armar_pc, inicio.
ejecutar_opcion(2) :- mostrar_catalogo, inicio.
ejecutar_opcion(3) :- cuestionario_laptop, inicio.
ejecutar_opcion(4) :- recomendar_por_historial, inicio.
ejecutar_opcion(5) :- mostrar_ofertas, inicio.
ejecutar_opcion(6) :- mostrar_historial, inicio.
ejecutar_opcion(_) :- write('Opcion no valida.'), nl, inicio.

% =========================
% CATÁLOGO
% =========================

mostrar_catalogo :-
    nl, write('--- CATALOGO ---'), nl,
    forall(laptop(Tipo, Modelo),
    (write('- '), write(Modelo), write(' ['), write(Tipo), write(']'), nl)).

% =========================
% GUARDAR COMPRA
% =========================

guardar_compra(Tipo) :-
    retractall(ultima_compra(_)),
    assert(ultima_compra(Tipo)),
    assert(historial_compra(Tipo)).

% =========================
% SISTEMA INTELIGENTE LAPTOPS
% =========================

cuestionario_laptop :-
    nl, write('--- ASISTENTE INTELIGENTE ---'), nl,
    write('Responde con s/n'), nl,
    preguntar_gaming.

preguntar_gaming :-
    write('¿Vas a usar la laptop para videojuegos de alta gama? (s/n): '),
    leer_si_no(R),
    (R == s -> preguntar_gaming_detalle ; preguntar_profesional).

preguntar_gaming_detalle :-
    write('¿Quieres jugar en calidad ultra? (s/n): '),
    leer_si_no(R1),
    write('¿Te importa la portabilidad? (s/n): '),
    leer_si_no(R2),
    recomendar_gamer(R1, R2).

preguntar_profesional :-
    write('¿Eres profesional de ingenieria o 3D? (s/n): '),
    leer_si_no(R),
    (R == s -> preguntar_workstation ; preguntar_diseno).

preguntar_workstation :-
    write('¿Necesitas renderizado pesado? (s/n): '),
    leer_si_no(R),
    recomendar_workstation(R).

preguntar_diseno :-
    write('¿Trabajas en diseño o edicion? (s/n): '),
    leer_si_no(R),
    (R == s -> preguntar_diseno_detalle ; recomendar_oficina).

preguntar_diseno_detalle :-
    write('¿Prefieres macOS? (s/n): '),
    leer_si_no(R),
    recomendar_diseno(R).
% =========================
% RECOMENDACIONES
% =========================

recomendar_gamer(s, _) :-
    nl, write('>>> GAMER ULTRA'), nl,
    write('- asus_rog_strix_scar_18_2026'), nl,
    write('- msi_raider_ge78_hx'), nl,
    guardar_compra(laptop),
    aplicar_oferta.

recomendar_gamer(n, s) :-
    nl, write('>>> GAMER PORTATIL'), nl,
    write('- msi_raider_ge78_hx'), nl,
    guardar_compra(laptop).

recomendar_gamer(n, n) :-
    nl, write('>>> GAMER EQUILIBRADO'), nl,
    write('- asus_rog_strix_scar_18_2026'), nl,
    guardar_compra(laptop).

recomendar_workstation(s) :-
    nl, write('>>> WORKSTATION ALTO RENDIMIENTO'), nl,
    write('- precision_7780_workstation'), nl,
    write('- hp_zbook_fury_g10'), nl,
    guardar_compra(laptop).

recomendar_workstation(n) :-
    nl, write('>>> WORKSTATION MODERADA'), nl,
    write('- hp_zbook_fury_g10'), nl,
    guardar_compra(laptop).

recomendar_diseno(s) :-
    nl, write('>>> DISEÑO (APPLE)'), nl,
    write('- apple_macbook_pro_16_m4_max'), nl,
    guardar_compra(laptop).

recomendar_diseno(n) :-
    nl, write('>>> DISEÑO GENERAL'), nl,
    write('- lenovo_thinkpad_x1_carbon_gen_13'), nl,
    guardar_compra(laptop).

recomendar_oficina :-
    nl, write('>>> OFICINA Y ESTUDIO'), nl,
    write('- lenovo_thinkpad_x1_carbon_gen_13'), nl,
    guardar_compra(laptop).

% =========================
% OFERTAS
% =========================

aplicar_oferta :-
    oferta_descuento(D),
    write('Descuento disponible: '), write(D), write('%'), nl.

mostrar_ofertas :-
    (oferta_descuento(D) ->
        write('Oferta actual: '), write(D), write('% de descuento'), nl
    ;
        write('No hay ofertas disponibles'), nl).

% =========================
% HISTORIAL Y RECOMENDACIONES
% =========================

recomendar_por_historial :-
    ultima_compra(Tipo),
    nl,
    write('>>> PRODUCTOS COMPLEMENTARIOS:'), nl,
    forall(complementario(Tipo, Producto),
        (write('- '), write(Producto), nl)), !.

recomendar_por_historial :-
    write('Aun no has realizado ninguna compra.'), nl.

mostrar_historial :-
    nl, write('=== HISTORIAL DE COMPRAS ==='), nl,
    (historial_compra(_) ->
        forall(historial_compra(X),
            (write('- '), write(X), nl))
    ;
        write('No hay compras registradas.')
    ), nl.

% =========================
% ARMAR PC Y UTILIDADES
% =========================

armar_pc :-
    nl, write('--- CONFIGURADOR DE PC ---'), nl,
    mostrar_lista('PROCESADORES', procesador),
    seleccionar('procesador', procesador, CPU),
    mostrar_lista('RAM', ram),
    seleccionar('RAM', ram, RAM),
    mostrar_lista('GPU', gpu),
    seleccionar('GPU', gpu, GPU),
    mostrar_lista('ALMACENAMIENTO', almacenamiento),
    seleccionar('Disco', almacenamiento, DISCO),
    nl,
    write('===== CONFIGURACION FINAL ====='), nl,
    write('CPU: '), write(CPU), nl,
    write('RAM: '), write(RAM), nl,
    write('GPU: '), write(GPU), nl,
    write('Disco: '), write(DISCO), nl,
    verificar_compatibilidad(CPU, GPU),
    guardar_compra(pc).

verificar_compatibilidad(CPU, GPU) :-
    (compatibilidad(procesador(CPU), gpu(GPU)) ->
        write('Componentes compatibles'), nl
    ;
        write('Posible incompatibilidad CPU-GPU'), nl).

mostrar_lista(Titulo, Predicado) :-
    nl, write('--- '), write(Titulo), write(' ---'), nl,
    forall(call(Predicado, X), (write('- '), write(X), nl)).

seleccionar(Nombre, Predicado, Valor) :-
    repeat,
    write('Elige '), write(Nombre), write(': '),
    read(Valor),
    (call(Predicado, Valor) -> true ;
    write('No valido. Intenta de nuevo.'), nl, fail).

leer_si_no(Resultado) :-
    read(R),
    ((R == s ; R == n) -> Resultado = R ;
    write('Solo s/n: '), leer_si_no(Resultado)).