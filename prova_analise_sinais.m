% Prova de Analise de Sinais
clear('all'); close all; clc;

questao_1();

% Questao 2
tempo_total = 1;
frequencia_amostragem = 100;  % [Hz]
numero_total_pontos = frequencia_amostragem*tempo_total;
frequencias = frequencia_amostragem*(0:11*numero_total_pontos-1)/(11*numero_total_pontos);

janela_retangular = rectwin(numero_total_pontos)';


janela_analisada  = blackman(numero_total_pontos)';

janela_analisada_frequencia_dB = abs(fft([janela_analisada zeros(1,10*numero_total_pontos)])); % DFT com zeropadding
janela_analisada_frequencia_dB = 20*log10(janela_analisada_frequencia_dB/janela_analisada_frequencia_dB(1)); % ou max(W)

janela_retangular_frequencia_dB = abs(fft([janela_retangular zeros(1,10*numero_total_pontos)]));
janela_retangular_frequencia_dB = 20*log10(janela_retangular_frequencia_dB/max(janela_retangular_frequencia_dB));

for idx = 1:length(janela_retangular_frequencia_dB); % Substitui -inf por -200 no vetor W_rect
    if janela_retangular_frequencia_dB(idx) == -inf
        janela_retangular_frequencia_dB(idx) = -150;
    end
end

% Plotando os resultados
figure; plot(frequencias, real(janela_retangular_frequencia_dB),'LineWidth',2); hold on;
plot(frequencias, real(janela_analisada_frequencia_dB),'r','LineWidth',2);
axis([0 10 -150 10])
grid on
ylabel('Atenuação (dB)')
xlabel('Frequência [Hz]')
title('Comparação das janelas')
legend('Janela Retangular', 'Janela Parzen')
