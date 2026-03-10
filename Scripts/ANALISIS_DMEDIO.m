%% =====================================================
%% ESTE SCRIPT SE USA PARA CALCULAR LOS COEFICIENTES DEL
%% POLINOMIO DE TERCER GRADO QUE MODELA LA RELACIÓN
%% ENTRE LA FUERZA APLICADA Y EL NÚMERO NCAD QUE PRODUCE
%% EL CONVERTIDOR DE ANALÓGICO  DIGITAL PARA EL SENSOR
%% QUE MIDE LA FUERZA DEL DEDO MEDIO.
%% 
%% SE CALCULAN TAMBIÉN:
%%    - COEFICIENTE DE DETERMINACIÓN R2
%%    - DESVIACIÓN STANDAR
%%    - MAE
%%    - MAPE
%% =====================================================

%% Configuración inicial
clear all; close all; clc;

%% Datos experimentales proporcionados
NCAD = [0, 20, 24, 41, 42, 43, 57, 61, 64, 72, 74, 82, 82, 88, 95, 97, ...
        100, 108, 114, 118, 120, 132, 132, 135, 137, 140, 143, 143, 145, ...
        150, 153, 153, 160, 166, 167, 171, 172, 176, 176, 176, 179, 185, ...
        189, 193, 195, 203, 208, 211, 215, 216, 226, 230, 230, 234, 234, ...
        239, 244, 244, 248, 249, 250, 258, 259, 260, 260, 261, 266, 268, ...
        268, 272, 272, 273, 274, 280, 281, 284, 284, 288, 289, 291, 291, ...
        291, 292, 294, 295, 296, 301, 301, 302, 305, 306, 309, 310, 313, ...
        313, 316, 317, 319, 319, 323, 324, 326, 330, 335, 336, 336, 337, ...
        338, 340, 340, 342, 342, 342, 343, 343, 345, 345, 345, 346, 348, ...
        348, 350, 351, 352, 357, 360, 363, 366, 369, 373, 378, 380, 380, ...
        381, 386, 387, 389, 392, 395, 395, 400, 403, 405, 405, 407, 407, ...
        407, 409, 409, 410, 412, 416, 416, 417, 418, 422, 423, 424, 428, ...
        428, 431, 432, 432, 432, 433, 433, 434, 434, 434, 436]';

Fuerza = [0, 59, 69, 84, 88, 109, 118, 104, 188, 185, 138, 178, 229, 228, ...
          168, 189, 258, 219, 288, 239, 298, 338, 298, 354, 302, 310, 320, ...
          388, 364, 388, 358, 368, 430, 389, 499, 455, 488, 558, 500, 405, ...
          438, 524, 588, 589, 503, 578, 592, 623, 732, 790, 792, 833, 784, ...
          898, 986, 824, 898, 998, 1047, 1094, 1085, 1138, 1098, 1288, 1193, ...
          1208, 1294, 1338, 1242, 1367, 1435, 1424, 1387, 1674, 1425, 1419, ...
          1543, 1529, 1697, 1579, 1628, 1728, 1788, 1998, 1679, 1887, 1794, ...
          1933, 1794, 1986, 1887, 2288, 2038, 1998, 2198, 2399, 2098, 2520, ...
          2298, 2394, 2594, 2290, 2697, 3048, 3298, 3244, 2588, 2678, 3296, ...
          2525, 3388, 2693, 2890, 3208, 3084, 3428, 3504, 3507, 3428, 3374, ...
          2844, 2945, 3080, 3284, 3482, 3289, 3682, 3689, 3848, 3899, 4098, ...
          4223, 4049, 4344, 4588, 4488, 4643, 4788, 4799, 4392, 4640, 4748, ...
          5090, 4843, 5338, 4880, 5228, 5683, 4998, 5086, 5724, 5871, 5878, ...
          5386, 5589, 6339, 5978, 6578, 6084, 6744, 7028, 6628, 6409, 6504, ...
          6629, 6584, 6698, 6788, 6824, 6608]';

%% Separar datos en dos rangos
% Rango 1: 0 <= NCAD <= 195
idx_rango1 = NCAD <= 195;
NCAD1 = NCAD(idx_rango1);
Fuerza1 = Fuerza(idx_rango1);

% Rango 2: 196 <= NCAD <= 1023
idx_rango2 = NCAD >= 196;
NCAD2 = NCAD(idx_rango2);
Fuerza2 = Fuerza(idx_rango2);

%% Ajuste polinomial cúbico para Rango 1 (0-195)
disp('=== RANGO 1: 0 <= NCAD <= 195 ===');

% Ajuste polinomial de grado 3
p1 = polyfit(NCAD1, Fuerza1, 3);

% Mostrar coeficientes
fprintf('Coeficientes del polinomio cúbico:\n');
fprintf('F(NCAD) = %.6f * NCAD^3 + %.6f * NCAD^2 + %.6f * NCAD + %.6f\n\n', ...
        p1(1), p1(2), p1(3), p1(4));

% Calcular valores predichos
Fuerza1_pred = polyval(p1, NCAD1);

% Calcular residuos
residuos1 = Fuerza1 - Fuerza1_pred;

% Calcular R²
SS_res1 = sum(residuos1.^2);
SS_tot1 = sum((Fuerza1 - mean(Fuerza1)).^2);
R2_1 = 1 - (SS_res1/SS_tot1);

% Calcular desviación estándar de residuos
std_res1 = std(residuos1);

% Calcular error medio absoluto
MAE1 = mean(abs(residuos1));

% Mostrar resultados
fprintf('Coeficiente de determinación R²: %.4f\n', R2_1);
fprintf('Desviación estándar de residuos: %.2f\n', std_res1);
fprintf('Error medio absoluto: %.2f\n\n', MAE1);

%% Ajuste polinomial cúbico para Rango 2 (196-1023)
disp('=== RANGO 2: 196 <= NCAD <= 1023 ===');

% Ajuste polinomial de grado 3
p2 = polyfit(NCAD2, Fuerza2, 3);

% Mostrar coeficientes
fprintf('Coeficientes del polinomio cúbico:\n');
fprintf('F(NCAD) = %.6f * NCAD^3 + %.6f * NCAD^2 + %.6f * NCAD + %.6f\n\n', ...
        p2(1), p2(2), p2(3), p2(4));

% Calcular valores predichos
Fuerza2_pred = polyval(p2, NCAD2);

% Calcular residuos
residuos2 = Fuerza2 - Fuerza2_pred;

% Calcular R²
SS_res2 = sum(residuos2.^2);
SS_tot2 = sum((Fuerza2 - mean(Fuerza2)).^2);
R2_2 = 1 - (SS_res2/SS_tot2);

% Calcular desviación estándar de residuos
std_res2 = std(residuos2);

% Calcular error medio absoluto
MAE2 = mean(abs(residuos2));

% Mostrar resultados
fprintf('Coeficiente de determinación R²: %.4f\n', R2_2);
fprintf('Desviación estándar de residuos: %.2f\n', std_res2);
fprintf('Error medio absoluto: %.2f\n\n', MAE2);

%% Gráficas
figure('Position', [100, 100, 1200, 500]);

% Subgráfica 1: Rango 0-195
subplot(1, 2, 1);
scatter(NCAD1, Fuerza1, 40, 'b', 'filled', 'DisplayName', 'Datos experimentales');
hold on;
NCAD1_fine = linspace(min(NCAD1), max(NCAD1), 200);
plot(NCAD1_fine, polyval(p1, NCAD1_fine), 'r-', 'LineWidth', 2, 'DisplayName', 'Ajuste cúbico');
xlabel('NCAD (lectura ADC)');
ylabel('Fuerza (g)');
title('Rango 1: 0 ≤ NCAD ≤ 195');
legend('Location', 'northwest');
grid on;
text(10, max(Fuerza1)*0.8, sprintf('R² = %.4f\nσ = %.1f\nMAE = %.1f', R2_1, std_res1, MAE1), ...
     'FontSize', 10, 'BackgroundColor', 'white');

% Subgráfica 2: Rango 196-1023
subplot(1, 2, 2);
scatter(NCAD2, Fuerza2, 40, 'b', 'filled', 'DisplayName', 'Datos experimentales');
hold on;
NCAD2_fine = linspace(min(NCAD2), max(NCAD2), 200);
plot(NCAD2_fine, polyval(p2, NCAD2_fine), 'r-', 'LineWidth', 2, 'DisplayName', 'Ajuste cúbico');
xlabel('NCAD (lectura ADC)');
ylabel('Fuerza (g)');
title('Rango 2: 196 ≤ NCAD ≤ 1023');
legend('Location', 'northwest');
grid on;
text(250, max(Fuerza2)*0.8, sprintf('R² = %.4f\nσ = %.1f\nMAE = %.1f', R2_2, std_res2, MAE2), ...
     'FontSize', 10, 'BackgroundColor', 'white');

%% Gráfica completa
figure;
scatter(NCAD, Fuerza, 30, 'b', 'filled', 'DisplayName', 'Datos experimentales');
hold on;

% Graficar ambas funciones
NCAD_all = 0:1023;
Fuerza_all = zeros(size(NCAD_all));

% Aplicar función del rango 1 para NCAD <= 195
idx_all1 = NCAD_all <= 195;
Fuerza_all(idx_all1) = polyval(p1, NCAD_all(idx_all1));

% Aplicar función del rango 2 para NCAD >= 196
idx_all2 = NCAD_all >= 196;
Fuerza_all(idx_all2) = polyval(p2, NCAD_all(idx_all2));

plot(NCAD_all, Fuerza_all, 'r-', 'LineWidth', 2, 'DisplayName', 'Función por partes');
xlabel('NCAD (lectura ADC)');
ylabel('Fuerza (g)');
title('Curva completa de calibración FSR-402');
legend('Location', 'northwest');
grid on;

% Línea vertical en el punto de transición
xline(195.5, 'k--', 'LineWidth', 1.5, 'DisplayName', 'Límite entre rangos');
text(195.5, max(Fuerza)*0.5, 'NCAD = 195', 'Rotation', 90, ...
     'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'center');

%% Función para calcular fuerza a partir de NCAD
disp('=== FUNCIÓN PARA CÁLCULO ===');
fprintf('\nPara calcular la fuerza a partir de NCAD:\n\n');
fprintf('function fuerza = calcular_fuerza(NCAD)\n');
fprintf('    if NCAD <= 195\n');
fprintf('        fuerza = %.6f * NCAD^3 + %.6f * NCAD^2 + %.6f * NCAD + %.6f;\n', ...
        p1(1), p1(2), p1(3), p1(4));
fprintf('    else\n');
fprintf('        fuerza = %.6f * NCAD^3 + %.6f * NCAD^2 + %.6f * NCAD + %.6f;\n', ...
        p2(1), p2(2), p2(3), p2(4));
fprintf('    end\n');
fprintf('end\n\n');

%% Validación con algunos puntos
disp('=== VALIDACIÓN CON ALGUNOS PUNTOS ===');
test_points = [0, 20, 100, 195, 200, 300, 400, 436];
fprintf('NCAD\tFuerza Real\tFuerza Calculada\tError\n');
fprintf('------------------------------------------------\n');

for i = 1:length(test_points)
    ncad_test = test_points(i);
    
    % Buscar fuerza real más cercana (si existe)
    [min_diff, idx] = min(abs(NCAD - ncad_test));
    if min_diff == 0
        fuerza_real = Fuerza(idx);
    else
        fuerza_real = NaN;
    end
    
    % Calcular fuerza con función por partes
    if ncad_test <= 195
        fuerza_calc = polyval(p1, ncad_test);
    else
        fuerza_calc = polyval(p2, ncad_test);
    end
    
    if ~isnan(fuerza_real)
        error_val = abs(fuerza_real - fuerza_calc);
        fprintf('%d\t%.1f\t\t%.1f\t\t\t%.1f\n', ncad_test, fuerza_real, fuerza_calc, error_val);
    else
        fprintf('%d\t-\t\t%.1f\t\t\t-\n', ncad_test, fuerza_calc);
    end
end

%% Análisis de residuos
figure('Position', [100, 100, 1000, 400]);

% Residuos rango 1
subplot(1, 2, 1);
scatter(NCAD1, residuos1, 40, 'b', 'filled');
hold on;
plot([min(NCAD1), max(NCAD1)], [0, 0], 'k-', 'LineWidth', 1.5);
plot([min(NCAD1), max(NCAD1)], [std_res1, std_res1], 'r--', 'LineWidth', 1);
plot([min(NCAD1), max(NCAD1)], [-std_res1, -std_res1], 'r--', 'LineWidth', 1);
xlabel('NCAD');
ylabel('Residuos (g)');
title('Residuos - Rango 1 (0-195)');
legend('Residuos', 'Cero', '±1σ', 'Location', 'best');
grid on;

% Residuos rango 2
subplot(1, 2, 2);
scatter(NCAD2, residuos2, 40, 'b', 'filled');
hold on;
plot([min(NCAD2), max(NCAD2)], [0, 0], 'k-', 'LineWidth', 1.5);
plot([min(NCAD2), max(NCAD2)], [std_res2, std_res2], 'r--', 'LineWidth', 1);
plot([min(NCAD2), max(NCAD2)], [-std_res2, -std_res2], 'r--', 'LineWidth', 1);
xlabel('NCAD');
ylabel('Residuos (g)');
title('Residuos - Rango 2 (196-436)');
legend('Residuos', 'Cero', '±1σ', 'Location', 'best');
grid on;

%% Histograma de residuos
figure;
subplot(1, 2, 1);
histogram(residuos1, 20, 'FaceColor', 'b', 'EdgeColor', 'black');
xlabel('Residuos (g)');
ylabel('Frecuencia');
title('Distribución de residuos - Rango 1');
grid on;

subplot(1, 2, 2);
histogram(residuos2, 20, 'FaceColor', 'b', 'EdgeColor', 'black');
xlabel('Residuos (g)');
ylabel('Frecuencia');
title('Distribución de residuos - Rango 2');
grid on;

disp('=== ANÁLISIS COMPLETADO ===');