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
