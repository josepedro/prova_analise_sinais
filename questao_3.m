%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Universidade Federal de Santa Catarina.
%% José Pedro de Santana Neto, maio de 2016
%%
%% You can redistribute it and/or
%% modify it under the terms of the GNU Affero General Public License as
%% published by the Free Software Foundation, either version 3 of the
%% License, or (at your option) any later version.
%% The library is distributed in the hope that it will be useful,
%% but WITHOUT ANY WARRANTY; without even the implied warranty of
%% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
%% GNU Affero General Public License for more details. 
%% see <http://www.gnu.org/licenses/>.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Questao_3
function questao_3 = questao_3()
	
	% A)
	amplitudes = [0.1 0.02 0.3 0.4]; % [metro]
	frequencias_angulares = [20 44 83 135]; % [rad/s]
	fatores_amortecimento = [0.02 0.03 0.01 0.02]; % qsi
	frequencias_naturais_amortecidas = [
		frequencias_angulares(1) * sqrt(1 - fatores_amortecimento(1)^2) ...
		frequencias_angulares(2) * sqrt(1 - fatores_amortecimento(2)^2) ...
		frequencias_angulares(3) * sqrt(1 - fatores_amortecimento(3)^2) ...
		frequencias_angulares(4) * sqrt(1 - fatores_amortecimento(4)^2) ...
	];

	tempos_totais_medicao = [1 10 100]; % [segundos]
	frequencia_amostragem = 180; % pontos por segundo [Hz]

	tempos_medicao = {
		% 1 segundo
		0 : 1/frequencia_amostragem : tempos_totais_medicao(1)-1/frequencia_amostragem ...
		% 10 segundos
		0 : 1/frequencia_amostragem : tempos_totais_medicao(2)-1/frequencia_amostragem ...
		% 100 segundos
		0 : 1/frequencia_amostragem : tempos_totais_medicao(3)-1/frequencia_amostragem
	};
	
	numero_total_pontos = tempos_totais_medicao(3)*frequencia_amostragem; % numero de elementos
	f = frequencia_amostragem*(0:numero_total_pontos-1)/numero_total_pontos; % [Hz]
	f_1 = linspace(0,180,length(tempos_medicao{1}));
	f_10 = linspace(0,180,length(tempos_medicao{2}));
	f_100 = linspace(0,180,length(tempos_medicao{3}));
	w = f*2*pi;              % vetor da frequência (rad/s)

	% Sistema de quatro graus de liberdade:
	h_1 = amplitudes(1)/frequencias_naturais_amortecidas(1) * exp(-fatores_amortecimento(1) ...
	 * frequencias_angulares(1) .* tempos_medicao{1}) .* sin(frequencias_naturais_amortecidas(1) ...
	  *tempos_medicao{1}) + amplitudes(2)/frequencias_naturais_amortecidas(2) * ...
	   exp(-fatores_amortecimento(2) * frequencias_angulares(2) * tempos_medicao{1}) .* ...
	    sin(frequencias_naturais_amortecidas(2)*tempos_medicao{1})...
	    + amplitudes(3)/frequencias_naturais_amortecidas(3) * exp(-fatores_amortecimento(3) * ...
	     frequencias_angulares(3) * tempos_medicao{1}) .* sin(frequencias_naturais_amortecidas(3) ... 
	     *tempos_medicao{1}) + amplitudes(4)/frequencias_naturais_amortecidas(4) * ... 
	     exp(-fatores_amortecimento(4) * frequencias_angulares(4) * tempos_medicao{1}) .* ... 
	     sin(frequencias_naturais_amortecidas(4)*tempos_medicao{1}); 
	h_10 = amplitudes(1)/frequencias_naturais_amortecidas(1) * exp(-fatores_amortecimento(1) ... 
	 * frequencias_angulares(1) .* tempos_medicao{2}) .* sin(frequencias_naturais_amortecidas(1) ... 
	 *tempos_medicao{2}) + amplitudes(2)/frequencias_naturais_amortecidas(2) * exp(-fatores_amortecimento(2) ...
	  * frequencias_angulares(2) * tempos_medicao{2}) .* sin(frequencias_naturais_amortecidas(2)*tempos_medicao{2})...
	    + amplitudes(3)/frequencias_naturais_amortecidas(3) * exp(-fatores_amortecimento(3) * ...
	     frequencias_angulares(3) * tempos_medicao{2}) .* sin(frequencias_naturais_amortecidas(3) ... 
	     *tempos_medicao{2}) + amplitudes(4)/frequencias_naturais_amortecidas(4) * ... 
	      exp(-fatores_amortecimento(4) * frequencias_angulares(4) * tempos_medicao{2}) .* ...
	       sin(frequencias_naturais_amortecidas(4)*tempos_medicao{2}); 
	h_100 = amplitudes(1)/frequencias_naturais_amortecidas(1) * exp(-fatores_amortecimento(1) ...
	 * frequencias_angulares(1) .* tempos_medicao{3}) .* sin(frequencias_naturais_amortecidas(1) ... 
	 *tempos_medicao{3}) + amplitudes(2)/frequencias_naturais_amortecidas(2) * ... 
	 exp(-fatores_amortecimento(2) * frequencias_angulares(2) * tempos_medicao{3}) ...
	  .* sin(frequencias_naturais_amortecidas(2)*tempos_medicao{3})...
	    + amplitudes(3)/frequencias_naturais_amortecidas(3) * exp(-fatores_amortecimento(3) ...
	     * frequencias_angulares(3) * tempos_medicao{3}) .* sin(frequencias_naturais_amortecidas(3) ... 
	     *tempos_medicao{3}) + amplitudes(4)/frequencias_naturais_amortecidas(4) * ...
	      exp(-fatores_amortecimento(4) * frequencias_angulares(4) * tempos_medicao{3}) ...
	       .* sin(frequencias_naturais_amortecidas(4)*tempos_medicao{3}); 

	% Magnitude FRF referência:
	Href = amplitudes(1) ./  ... 
	(frequencias_angulares(1).^2 - w.^2 ...
	 + 1i*2*fatores_amortecimento(1)*frequencias_angulares(1).*w) ...
	  + amplitudes(2) ./ ...
	   (frequencias_angulares(2).^2 - w.^2 ...
	    + 1i*2*fatores_amortecimento(2)*frequencias_angulares(2).*w)...
	    + amplitudes(3) ./ ...
	     (frequencias_angulares(3).^2 - w.^2 ...
	      + 1i*2*fatores_amortecimento(3)*frequencias_angulares(3).*w) ...
	       + amplitudes(4) ./ ...
	        (frequencias_angulares(4).^2 - w.^2 ...
	         + 1i*2*fatores_amortecimento(4)*frequencias_angulares(4).*w);

	H_1 = fft(h_1)/frequencia_amostragem;
	H_10 = fft(h_10)/frequencia_amostragem;
	H_100 = fft(h_100)/frequencia_amostragem;
	% Excitação
	x = randn(1,numero_total_pontos);  
	X = fft(x,numero_total_pontos)/frequencia_amostragem;
	% Resposta 
	Y = Href.*X;
	y = conv(x,h_100);
	y = y(1:numero_total_pontos);
	% Em escala log
	XdB = 20*log10(abs(X));
	YdB = 20*log10(abs(Y));
	HrefdB = 20*log10(abs(Href));
	HdB_1 = 20*log10(abs(H_1));
	HdB_10 = 20*log10(abs(H_10));
	HdB_100 = 20*log10(abs(H_100));
	%PLOtempos_totais_medicao 3(a)
	figure(5)
	subplot(1,2,1)
	plot(f,XdB)
	xlabel('Frequencia (Hz)','Interpreter','latex','Fontsize',20)
	ylabel('Amplitude (dB)','Interpreter','latex','Fontsize',20)
	title('Excitacao X - Ruido Branco','Interpreter','latex','Fontsize',20)
	grid on
	xlim([0 90])
	subplot(1,2,2)
	plot(f,YdB)
	xlabel('Frequencia (Hz)','Interpreter','latex','Fontsize',20)
	ylabel('Amplitude (dB)','Interpreter','latex','Fontsize',20)
	title('Resposta Y','Interpreter','latex','Fontsize',20)
	grid on
	xlim([0 90])
	
	%PLOtempos_totais_medicao 3(b)
	figure(6)
	plot(f,HrefdB,'b','LineWidth',3)
	hold on
	plot(f_1,HdB_1,'k-.','LineWidth',1.2)
	plot(f_10,HdB_10,'g--','LineWidth',1.2)
	plot(f_100,HdB_100,'r:','LineWidth',1.2)
	xlim([0 60])
	k=legend('H referencia','H tempo\_total = 1','H tempo\_total = 10','H tempo\_total = 100');
	set(k,'Interpreter','latex','Fontsize',20)
	title('FRF - H','Interpreter','latex','Fontsize',20)
	xlabel('Frequencia (Hz)','Interpreter','latex','Fontsize',20)
	ylabel('Amplitude (dB)','Interpreter','latex','Fontsize',20)


	% 3(c)
	% -1<tau<1
	[Rxx_1, tau_1] = xcorr(x,x,frequencia_amostragem,'unbiased'); 
	[Rxy_1, tau_1] = xcorr(x,y,frequencia_amostragem,'unbiased'); % Correlação-cruzada
	tau_1 = tau_1/frequencia_amostragem;
	Sxx_1 = fft(Rxx_1);Sxy_1=fft(Rxy_1);H1_1=Sxy_1./Sxx_1;
	H1_1=abs(H1_1/frequencia_amostragem);
	f_1=linspace(0,180,length(Rxy_1));
	% -10<tau<10

	[Rxx_10, tau_10] = xcorr(x,x,frequencia_amostragem*10,'unbiased'); 
	[Rxy_10, tau_10] = xcorr(x,y,frequencia_amostragem*10,'unbiased'); % Correlação-cruzada
	tau_10 = tau_10/frequencia_amostragem;
	Sxx_10 = fft(Rxx_10);Sxy_10=fft(Rxy_10);H1_10=Sxy_10./Sxx_10;
	H1_10=abs(H1_10/frequencia_amostragem);
	f_10=linspace(0,180,length(Rxy_10));
	% -100<tau<100

	[Rxx_100, tau_100] = xcorr(x,x,frequencia_amostragem*100,'unbiased'); 
	[Rxy_100, tau_100] = xcorr(x,y,frequencia_amostragem*100,'unbiased'); % Correlação-cruzada
	tau_100 = tau_100/frequencia_amostragem;
	Sxx_100 = fft(Rxx_100);Sxy_100=fft(Rxy_100);H1_100=Sxy_100./Sxx_100;
	H1_100=abs(H1_100/frequencia_amostragem);
	f_100=linspace(0,180,length(Rxy_100));

	figure(7)
	subplot(1,3,1)
	plot(f_1,20*log10(H1_1),'r')
	hold on
	plot(f,HrefdB,'b','LineWidth',1.5)
	xlim([0 60])
	xlabel('Frequencia (Hz)','Interpreter','latex','Fontsize',20)
	ylabel('Amplitude (dB)','Interpreter','latex','Fontsize',20)
	k=legend('H1 tau (-1,1)','H referencia');
	set(k,'Interpreter','latex','Fontsize',20)

	subplot(1,3,2)
	plot(f_10,20*log10(H1_10),'r')
	hold on
	plot(f,HrefdB,'b','LineWidth',1.5)
	xlim([0 60])
	xlabel('Frequencia (Hz)','Interpreter','latex','Fontsize',20)
	ylabel('Amplitude (dB)','Interpreter','latex','Fontsize',20)
	k=legend('H1 tau (-10,10)','H referencia');
	set(k,'Interpreter','latex','Fontsize',20)

	subplot(1,3,3)
	plot(f_100,20*log10(H1_100),'r')
	hold on
	plot(f,HrefdB,'b','LineWidth',1.5)
	xlim([0 60])
	xlabel('Frequencia (Hz)','Interpreter','latex','Fontsize',20)
	ylabel('Amplitude (dB)','Interpreter','latex','Fontsize',20)
	k=legend('H1 tau(-100,100)','H referencia');
	set(k,'Interpreter','latex','Fontsize',20)

	%3(d)
	%Definindo um perido de janela tempos_totais_medicaor = [1 5 20] [s]
	tempos_totais_medicaor_1 = 1; numero_total_pontosr_1 = frequencia_amostragem*tempos_totais_medicaor_1;
	tempos_totais_medicaor_5 = 5;  numero_total_pontosr_5 = frequencia_amostragem*tempos_totais_medicaor_5;
	tempos_totais_medicaor_20 = 20;  numero_total_pontosr_20 = frequencia_amostragem*tempos_totais_medicaor_20;

	Sxx_W_1 = cpsd(x,x, rectwin(numero_total_pontosr_1), 0, numero_total_pontos,frequencia_amostragem, 'twosided'); % Sxx utilizando o Método de Welch
	Sxy_W_1 = cpsd(y,x, rectwin(numero_total_pontosr_1), 0, numero_total_pontos,frequencia_amostragem,'twosided'); % Sxy utilizando o Método de Welch
	H1_W_1 = Sxy_W_1./Sxx_W_1;
	H1_W_1=abs(H1_W_1)/frequencia_amostragem;

	Sxx_W_5 = cpsd(x,x, rectwin(numero_total_pontosr_5), 0, numero_total_pontos,frequencia_amostragem, 'twosided'); % Sxx utilizando o Método de Welch
	Sxy_W_5 = cpsd(y,x, rectwin(numero_total_pontosr_5), 0, numero_total_pontos,frequencia_amostragem,'twosided'); % Sxy utilizando o Método de Welch
	H1_W_5 = Sxy_W_5./Sxx_W_5;
	H1_W_5=abs(H1_W_5)/frequencia_amostragem;

	Sxx_W_20 = cpsd(x,x, rectwin(numero_total_pontosr_20), 0, numero_total_pontos,frequencia_amostragem, 'twosided'); % Sxx utilizando o Método de Welch
	Sxy_W_20 = cpsd(y,x, rectwin(numero_total_pontosr_20), 0, numero_total_pontos,frequencia_amostragem,'twosided'); % Sxy utilizando o Método de Welch
	H1_W_20 = Sxy_W_20./Sxx_W_20;
	H1_W_20=abs(H1_W_20)/frequencia_amostragem;

	figure(8)
	subplot(1,3,1)
	plot(f,HrefdB,'b','LineWidth',1.5)
	hold on
	plot(f,20*log10(H1_W_1),'r')
	xlim([0 60])
	xlabel('Frequencia (Hz)','Interpreter','latex','Fontsize',20)
	ylabel('Amplitude (dB)','Interpreter','latex','Fontsize',20)
	k=legend('H referencia','H1 retangular = 1');
	set(k,'Interpreter','latex','Fontsize',20)

	subplot(1,3,2)
	plot(f,HrefdB,'b','LineWidth',1.5)
	hold on
	plot(f,20*log10(H1_W_5),'r')
	xlim([0 60])
	xlabel('Frequencia (Hz)','Interpreter','latex','Fontsize',20)
	ylabel('Amplitude (dB)','Interpreter','latex','Fontsize',20)
	k=legend('H referencia','H1 retangular = 5');
	set(k,'Interpreter','latex','Fontsize',20)

	subplot(1,3,3)
	plot(f,HrefdB,'b','LineWidth',1.5)
	hold on
	plot(f,20*log10(H1_W_20),'r')
	xlim([0 60])
	xlabel('Frequencia (Hz)','Interpreter','latex','Fontsize',20)
	ylabel('Amplitude (dB)','Interpreter','latex','Fontsize',20)
	k=legend('H referencia','H1 retangular = 20');
	set(k,'Interpreter','latex','Fontsize',20)

	%3(e)
	%Definindo um perido de janela tempos_totais_medicaor = [10] [s]

	tempos_totais_medicaor_10 = 10;  numero_total_pontosr_10 = frequencia_amostragem*tempos_totais_medicaor_10;

	%MÉtempos_totais_medicaoODO DE WELCH PARA DIFEREnumero_total_pontostempos_totais_medicaoES OVERLAP
	Sxx_O_25 = cpsd(x,x, rectwin(numero_total_pontosr_10), numero_total_pontosr_10/4, numero_total_pontos,frequencia_amostragem, 'twosided'); % Sxx utilizando o Método de Welch
	Sxy_O_25 = cpsd(y,x, rectwin(numero_total_pontosr_10), numero_total_pontosr_10/4, numero_total_pontos,frequencia_amostragem,'twosided'); % Sxy utilizando o Método de Welch
	H1_O_25 = Sxy_O_25./Sxx_O_25;
	H1_O_25=abs(H1_O_25)/frequencia_amostragem;

	Sxx_O_50 = cpsd(x,x, rectwin(numero_total_pontosr_10), numero_total_pontosr_10/2, numero_total_pontos,frequencia_amostragem, 'twosided'); % Sxx utilizando o Método de Welch
	Sxy_O_50 = cpsd(y,x, rectwin(numero_total_pontosr_10), numero_total_pontosr_10/2, numero_total_pontos,frequencia_amostragem,'twosided'); % Sxy utilizando o Método de Welch
	H1_O_50 = Sxy_O_50./Sxx_O_50;
	H1_O_50=abs(H1_O_50)/frequencia_amostragem;

	Sxx_O_75 = cpsd(x,x, rectwin(numero_total_pontosr_10), 3*numero_total_pontosr_10/4, numero_total_pontos,frequencia_amostragem, 'twosided'); % Sxx utilizando o Método de Welch
	Sxy_O_75 = cpsd(y,x, rectwin(numero_total_pontosr_10), 3*numero_total_pontosr_10/4, numero_total_pontos,frequencia_amostragem,'twosided'); % Sxy utilizando o Método de Welch
	H1_O_75 = Sxy_O_75./Sxx_O_75;
	H1_O_75=abs(H1_O_75)/frequencia_amostragem;

	figure(9)

	subplot(1,3,1)
	plot(f,HrefdB,'b','LineWidth',1.5)
	hold on
	plot(f,20*log10(H1_O_25),'r')
	xlim([0 60])
	xlabel('Frequencia (Hz)','Interpreter','latex','Fontsize',20)
	ylabel('Amplitude (dB)','Interpreter','latex','Fontsize',20)
	k=legend('H referencia','H1 overlap = 25\%');
	set(k,'Interpreter','latex','Fontsize',20)

	subplot(1,3,2)
	plot(f,HrefdB,'b','LineWidth',1.5)
	hold on
	plot(f,20*log10(H1_O_50),'r')
	xlim([0 60])
	xlabel('Frequencia (Hz)','Interpreter','latex','Fontsize',20)
	ylabel('Amplitude (dB)','Interpreter','latex','Fontsize',20)
	k=legend('H referencia','H1 overlap = 50\%');
	set(k,'Interpreter','latex','Fontsize',20)


	subplot(1,3,3)
	plot(f,HrefdB,'b','LineWidth',1.5)
	hold on
	plot(f,20*log10(H1_O_75),'r')
	xlim([0 60])
	xlabel('Frequencia (Hz)','Interpreter','latex','Fontsize',20)
	ylabel('Amplitude (dB)','Interpreter','latex','Fontsize',20)
	k=legend('H referencia','H1 overlap = 75\%');
	set(k,'Interpreter','latex','Fontsize',20)

	%3(f)

	%MÉtempos_totais_medicaoODO DE WELCH COM AS JAnumero_total_pontosELAS Utempos_totais_medicaoILIZADAS numero_total_pontosA QUEStempos_totais_medicaoÃO 2

	Sxx_Rec = cpsd(x,x, rectwin(numero_total_pontosr_10), numero_total_pontosr_10/2, numero_total_pontos,frequencia_amostragem, 'twosided'); % Sxx utilizando o Método de Welch
	Sxy_Rec = cpsd(y,x, rectwin(numero_total_pontosr_10), numero_total_pontosr_10/2, numero_total_pontos,frequencia_amostragem,'twosided'); % Sxy utilizando o Método de Welch
	H1_Rec = Sxy_Rec./Sxx_Rec;
	H1_Rec=abs(H1_Rec)/frequencia_amostragem;
	A=corrcoef(HrefdB,H1_Rec);
	A=abs(A(1,2));

	Sxx_tempos_totais_medicaouk= cpsd(x,x, blackman(numero_total_pontosr_10), numero_total_pontosr_10/2, numero_total_pontos,frequencia_amostragem, 'twosided'); % Sxx utilizando o Método de Welch
	Sxy_tempos_totais_medicaouk = cpsd(y,x, blackman(numero_total_pontosr_10), numero_total_pontosr_10/2, numero_total_pontos,frequencia_amostragem,'twosided'); % Sxy utilizando o Método de Welch
	H1_tempos_totais_medicaouk = Sxy_tempos_totais_medicaouk./Sxx_tempos_totais_medicaouk;
	H1_tempos_totais_medicaouk=abs(H1_tempos_totais_medicaouk)/frequencia_amostragem;
	B=corrcoef(HrefdB,H1_tempos_totais_medicaouk);
	B=abs(B(1,2));

	Sxx_tempos_totais_medicaorian = cpsd(x,x, poisson_window(numero_total_pontosr_10,2), numero_total_pontosr_10/2, numero_total_pontos,frequencia_amostragem, 'twosided'); % Sxx utilizando o Método de Welch
	Sxy_tempos_totais_medicaorian = cpsd(y,x, poisson_window(numero_total_pontosr_10,2), numero_total_pontosr_10/2, numero_total_pontos,frequencia_amostragem,'twosided'); % Sxy utilizando o Método de Welch
	H1_tempos_totais_medicaorian = Sxy_tempos_totais_medicaorian./Sxx_tempos_totais_medicaorian;
	H1_tempos_totais_medicaorian=abs(H1_tempos_totais_medicaorian)/frequencia_amostragem;
	C=corrcoef(HrefdB,H1_tempos_totais_medicaorian);
	C=abs(C(1,2));

	%PLOtempos_totais_medicao 3(f)
	texto_correlacao_x = 123;
	texto_correlacao_y = 11;
	figure(10)
	subplot(1,3,1)
	plot(f,HrefdB,'b','LineWidth',1.5)
	hold on
	plot(f,20*log10(H1_Rec),'r')
	strmax = ['Correlacao = ', num2str(A)];
	text(45,-115,strmax,'HorizontalAlignment','right','Interpreter','latex','Fontsize',20);
	axis([0 60 -120 -40])
	xlabel('Frequencia (Hz)','Interpreter','latex','Fontsize',20)
	ylabel('Amplitude (dB)','Interpreter','latex','Fontsize',20)
	k=legend('H referencia','H1 retangular');
	set(k,'Interpreter','latex','Fontsize',20)

	subplot(1,3,2)
	plot(f,HrefdB,'b','LineWidth',1.5)
	hold on
	plot(f,20*log10(H1_tempos_totais_medicaouk),'r')
	strmax = ['Correlacao = ', num2str(B)];
	text(45,-105,strmax,'HorizontalAlignment','right','Interpreter','latex','Fontsize',20);
	xlim([0 60])
	xlabel('Frequencia (Hz)','Interpreter','latex','Fontsize',20)
	ylabel('Amplitude (dB)','Interpreter','latex','Fontsize',20)
	k=legend('H referencia','H1 Blackman');
	set(k,'Interpreter','latex','Fontsize',20)


	subplot(1,3,3)
	plot(f,HrefdB,'b','LineWidth',1.5)
	hold on
	plot(f,20*log10(H1_tempos_totais_medicaorian),'r')
	strmax = ['Correlacao = ', num2str(C)];
	text(45,-105,strmax,'HorizontalAlignment','right','Interpreter','latex','Fontsize',20);
	xlim([0 60])
	xlabel('Frequencia (Hz)','Interpreter','latex','Fontsize',20)
	ylabel('Amplitude (dB)','Interpreter','latex','Fontsize',20)
	k=legend('H referencia','H1 Poisson');
	set(k,'Interpreter','latex','Fontsize',20)