%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Universidade Federal de Santa Catarina.
%% José Pedro de Santana Neto, julho de 2016
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

% Questao 1
% Prova de Analise de Sinais
function questao_1 = questao_1()

	% 1) Com base no sinal x(t)
	numero_total_pontos = 20; % Número de pontos
	tempo_medicao = 2*pi; % Tempo de medição
	frequencia_amostragem = numero_total_pontos/tempo_medicao; % Frequencia de amostragem
	tempos_periodo = 0 : 1/frequencia_amostragem : tempo_medicao - 1/frequencia_amostragem;   % Vetor do tempo

	% Definindo o vetor x (discretizado)
	sinal_x_t(1:numero_total_pontos/4)       = 2.5;  % 2.5, 0 < t < pi/4
	sinal_x_t(numero_total_pontos/4+1:numero_total_pontos/2)   = -0.5; % -0,5, pi/2 < t < pi
	sinal_x_t(numero_total_pontos/2+1:3*numero_total_pontos/4) = 0.5;  % 0,5,  pi < t < 3*pi/4
	sinal_x_t(3*numero_total_pontos/4 + 1:numero_total_pontos) = -2.5; % -2,5, 3*pi/4 < t < 2*pi

	figure; stem(tempos_periodo, sinal_x_t);

	% a) 10 primeiros coeficientes da Serie de Fourier na forma discreta com DFT
	coeficientes_serie_fourier = fft(sinal_x_t)/numero_total_pontos;
	coeficientes_serie_fourier = coeficientes_serie_fourier(1:10);

	% b) Espectros de magnitude e fase
	frequencias = (frequencia_amostragem/numero_total_pontos) ... 
	*(0:numero_total_pontos-1);
	% magnitude
	figure; stem(frequencias(1:length(coeficientes_serie_fourier)), abs(coeficientes_serie_fourier));
	% fase
	figure; stem(frequencias(1:length(coeficientes_serie_fourier)), angle(coeficientes_serie_fourier));

	% c) Comparar funcao no tempo com os 10 termos
	sinal_x_t_reconstruido(1:numero_total_pontos) = 0;
	numero_total_termos = 10;
	for termo = 1:numero_total_termos-1
	    sinal_x_t_reconstruido = sinal_x_t_reconstruido + ... 
	    coeficientes_serie_fourier(termo + 1)*exp(1i*2*pi*termo*tempos_periodo/tempo_medicao);
	end
	figure; stem(tempos_periodo, sinal_x_t); hold on;
	stem(tempos_periodo, real(sinal_x_t_reconstruido), 'red');
