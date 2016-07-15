% Questao 2
% Prova de Analise de Sinais
function questao_2 = questao_2()
	tempo_total = 1; % [segundos]
	frequencia_amostragem = 100;  % [Hz]
	numero_total_pontos = frequencia_amostragem*tempo_total;
	frequencias = frequencia_amostragem*(0:11*numero_total_pontos-1)/(11*numero_total_pontos);

	janela_retangular = rectwin(numero_total_pontos)';
	janela_retangular_frequencia_dB = abs(fft([janela_retangular zeros(1,10*numero_total_pontos)]));
	janela_retangular_frequencia_dB = 20*log10(janela_retangular_frequencia_dB/max(janela_retangular_frequencia_dB));
	for idx = 1:length(janela_retangular_frequencia_dB); % Substitui -inf por -200 no vetor W_rect
	    if janela_retangular_frequencia_dB(idx) == -inf
	        janela_retangular_frequencia_dB(idx) = -150;
	    end
	end

	janela_analisada_1  = blackman(numero_total_pontos)';
	janela_analisada_1_frequencia_dB = abs(fft([janela_analisada_1 zeros(1,10*numero_total_pontos)])); % DFT com zeropadding
	janela_analisada_1_frequencia_dB = 20*log10(janela_analisada_1_frequencia_dB/max(janela_analisada_1_frequencia_dB));

	janela_analisada_2  = poisson_window(numero_total_pontos, 2)';
	janela_analisada_2_frequencia_dB = abs(fft([janela_analisada_2 zeros(1,10*numero_total_pontos)])); % DFT com zeropadding
	janela_analisada_2_frequencia_dB = 20*log10(janela_analisada_2_frequencia_dB/max(janela_analisada_2_frequencia_dB));


	tempos = (0:length(janela_retangular)-1)/frequencia_amostragem;

	figure(2);
	subplot(1,2,1);
	plot(tempos, janela_retangular,'b','LineWidth',1.5);
	hold on;
	plot(tempos, janela_analisada_1,'r','LineWidth',1.5);
	xlabel('Tempo (s)','Fontsize',15);
	ylabel('Amplitude','Fontsize',15);
	title('w(t)','Fontsize',15);
	k=legend('Janela Retangular','Janela Blackman','Location','south');
	set(k,'FontSize',15);
	ylim([0 1.1]);
	subplot(1,2,2);
	plot(frequencias, janela_retangular_frequencia_dB,'LineWidth',1.5);
	hold on;
	plot(frequencias, janela_analisada_1_frequencia_dB,'r','LineWidth',1.5);
	grid on;
	axis([0 10 -150 0]);
	title('|W(j\omega)|','Fontsize',15);
	ylabel('Atenuação (dB)','Fontsize',15);
	xlabel('Frequência (Hz)','Fontsize',15);
	k=legend('Janela Retangular','Janela Blackman');
	set(k,'FontSize',15);

	figure(3);
	subplot(1,2,1);
	plot(tempos, janela_retangular,'b','LineWidth',1.5);
	hold on;
	plot(tempos, janela_analisada_2, 'r','LineWidth',1.5);
	xlabel('Tempo (s)','Fontsize',15);
	ylabel('Amplitude','Fontsize',15);
	title('w(t)','Fontsize',15);
	k=legend('Janela Retangular','Janela Poisson','Location','south');
	set(k,'FontSize',15);
	ylim([0 1.1]);
	subplot(1,2,2);
	plot(frequencias, janela_retangular_frequencia_dB,'LineWidth',1.5);
	hold on;
	plot(frequencias, janela_analisada_2_frequencia_dB,'r','LineWidth',1.5);
	grid on;
	axis([0 10 -150 0]);
	title('|W(j\omega)|','Fontsize',15);
	ylabel('Atenuação (dB)','Fontsize',15);
	xlabel('Frequência (Hz)','Fontsize',15);
	k=legend('Janela Retangular','Janela Poisson');
	set(k,'FontSize',15);