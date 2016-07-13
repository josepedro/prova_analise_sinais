% Prova de Analise de Sinais
clear('all'); close all; clc;

% 1) Com base no sinal x(t)
numero_termos_serie_fourier = 10;
taxa_amostragem = numero_termos_serie_fourier*2; % numero de pontos por segundo
tempos_periodo = 0:1/taxa_amostragem:2*pi; % vetor de tempos num periodo
sinal_x_t(obter_indice(tempos_periodo,0):obter_indice(tempos_periodo,pi/2)) = 2.5;
sinal_x_t(obter_indice(tempos_periodo,pi/2):obter_indice(tempos_periodo,pi)) = - 0.5;
sinal_x_t(obter_indice(tempos_periodo,pi):obter_indice(tempos_periodo,3*pi/2)) = 0.5;
sinal_x_t(obter_indice(tempos_periodo,3*pi/2):obter_indice(tempos_periodo,2*pi)) = - 2.5;
%sinal_x_t = [sinal_x_t sinal_x_t(1:round(length(sinal_x_t)/2))];

% a) 10 primeiros coeficientes da Serie de Fourier na forma discreta com DFT
coeficientes_serie_fourier = fft(sinal_x_t);
coeficientes_serie_fourier = coeficientes_serie_fourier(1:length(coeficientes_serie_fourier)/2);
figure; plot(abs(coeficientes_serie_fourier), 'o');


