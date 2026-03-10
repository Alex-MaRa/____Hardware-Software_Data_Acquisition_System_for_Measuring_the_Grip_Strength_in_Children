%% =====================================================
%% ESTE SCRIPT SE USA PARA CALCULAR LOS COEFICIENTES DEL
%% POLINOMIO DE TERCER GRADO QUE MODELA LA RELACIÓN
%% ENTRE LA FUERZA APLICADA Y EL NÚMERO NCAD QUE PRODUCE
%% EL CONVERTIDOR DE ANALÓGICO  DIGITAL PARA EL SENSOR
%% QUE MIDE LA FUERZA DEL DEDO MEÑIQUE.
%% 
%% SE CALCULAN TAMBIÉN:
%%    - COEFICIENTE DE DETERMINACIÓN R2
%%    - DESVIACIÓN STANDAR
%%    - MAE
%%    - MAPE
%% =====================================================



% Limpiar entorno
clear all; close all; clc;

% Datos experimentales: NCAD (0-1023) y Fuerza (g)
NCAD = [0, 11, 14, 18, 28, 30, 33, 36, 40, 46, 60, 60, 64, 71, 73, 76, ...
        81, 82, 84, 94, 100, 103, 109, 112, 119, 125, 125, 126, 138, 140, ...
        141, 144, 145, 146, 156, 157, 157, 158, 164, 171, 173, 179, 188, ...
        191, 191, 196, 201, 205, 210, 219, 220, 226, 226, 226, 234, 240, ...
        243, 247, 249, 258, 261, 272, 274, 279, 281, 283, 286, 292, 292, ...
        295, 296, 300, 304, 304, 308, 310, 313, 316, 318, 325, 327, 328, ...
        332, 339, 340, 340, 340, 344, 348, 349, 353, 353, 356, 357, 357, ...
        363, 366, 368, 373, 373, 374, 380, 380, 386, 388, 395, 396, 396, ...
        397, 397, 400, 400, 404, 406, 408, 410, 411, 412, 413, 414, 418, ...
        418, 419, 420, 429]';

Fuerza = [0, 89, 184, 121, 284, 188, 282, 304, 323, 284, 428, 434, 494, ...
          493, 380, 499, 586, 388, 588, 424, 698, 488, 728, 498, 746, 758, ...
          699, 588, 588, 838, 608, 868, 688, 698, 880, 690, 780, 898, 694, ...
          880, 748, 788, 992, 898, 821, 988, 1008, 988, 1208, 1304, 1045, ...
          1184, 1406, 1248, 1489, 1588, 1280, 1688, 1584, 1896, 1848, 2084, ...
          1878, 1898, 2184, 1948, 2208, 2378, 2398, 2004, 2489, 2494, 2588, ...
          2298, 2684, 2684, 2774, 2544, 2884, 3084, 2828, 2808, 2924, 3008, ...
          3089, 3588, 3449, 3244, 3576, 3638, 4038, 3899, 4382, 3890, 4070, ...
          4298, 4232, 4340, 5196, 4988, 4884, 5184, 4890, 5380, 5680, 5264, ...
          6499, 6088, 5831, 5584, 6654, 5884, 5834, 6998, 5968, 6958, 6088, ...
          6228, 7388, 6876, 6854, 6486, 6676, 6896, 7384]';

% 1. Separar datos en dos rangos
idx_rango1 = NCAD <= 195;
idx_rango2 = NCAD >= 196;

NCAD1 = NCAD(idx_rango1);
F1 = Fuerza(idx_rango1);
NCAD2 = NCAD(idx_rango2);
F2 = Fuerza(idx_rango2);

% 2. Ajustar polinomios cúbicos (grado 3)
p1 = polyfit(NCAD1, F1, 3);
p2 = polyfit(NCAD2, F2, 3);

% 3. Evaluar polinomios en los puntos correspondientes
F1_ajustada = polyval(p1, NCAD1);
F2_ajustada = polyval(p2, NCAD2);

% 4. Calcular métricas para cada rango
% Función para calcular métricas con protección contra división por cero
function [R2, std_dev, MAE, MAPE, max_RE] = calcular_metricas(y_real, y_ajust)
    % R² (coeficiente de determinación)
    SS_res = sum((y_real - y_ajust).^2);
    SS_tot = sum((y_real - mean(y_real)).^2);
    R2 = 1 - SS_res/SS_tot;
    
    % Desviación estándar de los residuos
    std_dev = std(y_real - y_ajust);
    
    % Error absoluto medio (MAE)
    MAE = mean(abs(y_real - y_ajust));
    
    % Error relativo porcentual (evitando división por cero)
    err_rel = abs(y_real - y_ajust) ./ abs(y_real);
    % Filtrar casos donde y_real != 0
    idx_valid = y_real ~= 0;
    if any(idx_valid)
        err_rel_valid = err_rel(idx_valid) * 100;
        MAPE = mean(err_rel_valid);
        max_RE = max(err_rel_valid);
    else
        MAPE = NaN;
        max_RE = NaN;
    end
end

% Calcular métricas para ambos rangos
[R2_1, std_dev1, MAE1, MAPE1, max_RE1] = calcular_metricas(F1, F1_ajustada);
[R2_2, std_dev2, MAE2, MAPE2, max_RE2] = calcular_metricas(F2, F2_ajustada);

% 5. Mostrar resultados
fprintf('=== RANGO 1 (0 <= NCAD <= 195) ===\n');
fprintf('Polinomio: F(NCAD) = %.6f*NCAD³ + %.6f*NCAD² + %.6f*NCAD + %.6f\n', ...
        p1(1), p1(2), p1(3), p1(4));
fprintf('R² = %.6f\n', R2_1);
fprintf('Desviación estándar de residuos = %.6f g\n', std_dev1);
fprintf('MAE = %.6f g\n', MAE1);
fprintf('Error relativo medio porcentual (MAPE) = %.6f%%\n', MAPE1);
fprintf('Error relativo máximo porcentual = %.6f%%\n\n', max_RE1);

fprintf('=== RANGO 2 (196 <= NCAD <= 1023) ===\n');
fprintf('Polinomio: F(NCAD) = %.6f*NCAD³ + %.6f*NCAD² + %.6f*NCAD + %.6f\n', ...
        p2(1), p2(2), p2(3), p2(4));
fprintf('R² = %.6f\n', R2_2);
fprintf('Desviación estándar de residuos = %.6f g\n', std_dev2);
fprintf('MAE = %.6f g\n', MAE2);
fprintf('Error relativo medio porcentual (MAPE) = %.6f%%\n', MAPE2);
fprintf('Error relativo máximo porcentual = %.6f%%\n\n', max_RE2);

% 6. Graficar resultados
figure('Position', [100, 100, 1200, 500]);

% Gráfico 1: Datos y ajuste
subplot(1, 2, 1);
hold on;
scatter(NCAD1, F1, 40, 'b', 'filled', 'DisplayName', 'Datos Rango 1');
scatter(NCAD2, F2, 40, 'r', 'filled', 'DisplayName', 'Datos Rango 2');
NCAD_fit1 = linspace(0, 195, 200);
NCAD_fit2 = linspace(196, 450, 200); % 450 es el máximo NCAD en datos
plot(NCAD_fit1, polyval(p1, NCAD_fit1), 'b-', 'LineWidth', 2, ...
     'DisplayName', sprintf('Ajuste R1 (R²=%.4f)', R2_1));
plot(NCAD_fit2, polyval(p2, NCAD_fit2), 'r-', 'LineWidth', 2, ...
     'DisplayName', sprintf('Ajuste R2 (R²=%.4f)', R2_2));
xlabel('NCAD (ADC reading)');
ylabel('Fuerza (g)');
title('Ajuste polinómico cúbico por rangos');
legend('Location', 'northwest');
grid on;

% Gráfico 2: Errores relativos porcentuales
subplot(1, 2, 2);
hold on;
% Calcular errores relativos para todos los puntos
err_rel_total = zeros(size(NCAD));
for i = 1:length(NCAD)
    if NCAD(i) <= 195
        F_ajust = polyval(p1, NCAD(i));
    else
        F_ajust = polyval(p2, NCAD(i));
    end
    if Fuerza(i) ~= 0
        err_rel_total(i) = abs(Fuerza(i) - F_ajust) / abs(Fuerza(i)) * 100;
    else
        err_rel_total(i) = 0;
    end
end

scatter(NCAD1, err_rel_total(idx_rango1), 40, 'b', 'filled', ...
        'DisplayName', 'Rango 1');
scatter(NCAD2, err_rel_total(idx_rango2), 40, 'r', 'filled', ...
        'DisplayName', 'Rango 2');
yline(MAPE1, 'b--', 'LineWidth', 1.5, ...
      'DisplayName', sprintf('MAPE R1: %.2f%%', MAPE1));
yline(MAPE2, 'r--', 'LineWidth', 1.5, ...
      'DisplayName', sprintf('MAPE R2: %.2f%%', MAPE2));
xlabel('NCAD (ADC reading)');
ylabel('Error relativo porcentual (%)');
title('Errores relativos por punto');
legend('Location', 'northwest');
ylim([0, max(err_rel_total)*1.1]);
grid on;

% 7. Exportar coeficientes para uso en microcontrolador
fprintf('=== PARA IMPLEMENTACIÓN EN PIC ===\n');
fprintf('Rango 1 coeficientes (a3, a2, a1, a0):\n');
fprintf('%.6e, %.6e, %.6e, %.6e\n\n', p1(1), p1(2), p1(3), p1(4));
fprintf('Rango 2 coeficientes (a3, a2, a1, a0):\n');
fprintf('%.6e, %.6e, %.6e, %.6e\n', p2(1), p2(2), p2(3), p2(4));