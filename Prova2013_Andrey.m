% Universidade Federal de Santa Catarina - PosMec 
% EMC6711 - An�lise Digital de Sinais
% Professor J�lio A. Cordioli
% Prova 3 MATLAB - 2013
% Autor: Andrey Hense
% Data: 18.09.2013

% $$$$ Rodar em separado cada quest�o! (Ctrl+Enter)$$$$

%% *********************** Quest�o 1 *********************************
clear all
close all
N = 20;                  % N�mero de pontos
T = 2*pi;                % Tempo de medi��o
fs = N/T;                % Frequencia de amostragem
t = 0 : 1/fs : T-1/fs;   % Vetor do tempo

% Definindo o vetor x (discretizado)
x(1:N/4)       = 2.5;  % 2,5,  0      < t < pi/4
x(N/4+1:N/2)   = -0.5; % -0,5, pi/2   < t < pi
x(N/2+1:3*N/4) = 0.5;  % 0,5,  pi     < t < 3*pi/4
x(3*N/4 + 1:N) = -2.5; % -2,5, 3*pi/4 < t < 2*pi

X = fft(x); % DFT de x
ck = X/N;   % Coefeicientes da s�rie de fourier eq.(3.45) do livro do Shin

% a)-----------------------------------------------------------------------
Coeficientes = ck(2:11); % 10 primeiros coeficientes da s�rie
% b)-----------------------------------------------------------------------
f = fs*(0:N-1)/N; % Defini��o vetor de frequencia

figure
subplot(2,2,1)
stem(f(1:10),abs(ck(1:10)),'fill')
grid on
xlabel('Frequencia [Hz]')
ylabel('Magnitude')
title('Gr�fico de Magnitude')

subplot(2,2,2)
stem(f(1:10),angle(ck(1:10)),'fill')
grid on
xlabel('Frequencia [Hz]')
ylabel('Fase [rad]')
title('Gr�fico de Fase')

% c)-----------------------------------------------------------------------
% Definindo o vetor x refer�ncia da fun��o
n = 1000;                    % utilizando mais pontos para ficar melhor discretizado no gr�fico
x_ref(1:n/4)       = 2.5;
x_ref(n/4+1:n/2)   = -0.5;
x_ref(n/2+1:3*n/4) = 0.5;
x_ref(3*n/4 + 1:n) = -2.5;
t_ref = linspace(0,2*pi,n);

% x_n = abs(ifft([Coeficientes zeros(1,N-length(Coeficientes))])*N);

% Utiliza-se a eq.(3.34) para calcular a fun��o com os 10 primeiros termos da s�rie de fourier
x_n2 = zeros(1,N);
for n = 1:10 
    x_n2 = x_n2 + ck(n+1)*exp(1i*2*pi*n*t/T);
end

subplot(2,2,3)
plot(t_ref,x_ref) % plota a fun��o no tempo
hold on
% plot(t,x_n, 'ro-', 'MarkerFaceColor','r')
plot(t,2*x_n2, 'ro-', 'MarkerFaceColor','r') % plota a s�rie com os 10 primeiros termos
grid on
legend('Sinal x(t)', 'S�rie de Fourier com 10 termos')
xlim([0 2*pi])
xlabel('Tempo [s]')
ylabel('x(t)')
title('Compara��o fun��o no tempo com a s�rie de Fourier')

%% *********************** Quest�o 2 *********************************
% clear all
% close all
% % wintool(sigwin.parzenwin(100),sigwin.rectwin(100))

% T      = 1;    % Largura da janela
% fs     = 100;  % Frequencia de amostragem [Hz]
% N      = fs*T; % Numero de pontos da janela
% % Fmax = FS/2;    % Corresponde a maxima frequencia no sinal
% % k = -N/2:(N/2)-1; % Representa o tempo  de -512 amostras a +511 amostras

% % Janela Retangular
% w_rect = rectwin(N)';

% % Janela Parzen
% w_par  = parzenwin(N)';         % J� est� normalizada
% % w_par_norm = w_par/max(w_par); % Normaliza��o da janela parzen pelo maior valor dentro do vetor w

% % % Janela Parzen no dominio da frequencia em dB
% W     = abs(fft([w_par zeros(1,10*N)])); % DFT com zeropadding
% W_par = 20*log10(W/W(1)); % ou max(W)

% f = fs*(0:11*N-1)/(11*N); % Defini��o vetor de frequencia

% % Janela retangular no dominio da frequencia em dB
% Wr = fft([w_rect zeros(1,10*N)]);
% W_rect = 20*log10(Wr/max(Wr));
% Wr_abs = abs(W_rect);

% for idx = 1:length(W_rect); % Substitui -inf por -200 no vetor W_rect
%     if W_rect(idx) == -inf
%         W_rect(idx) = -150;
%     end
% end

% % Plotando os resultados
% figure
% plot(f,W_rect,'LineWidth',2)    % Plota janela retangular
% hold on
% plot(f,W_par,'r','LineWidth',2) % Plota janela Parzen
% axis([0 10 -150 10])
% grid on
% ylabel('Atenua��o (dB)')
% xlabel('Frequ�ncia [Hz]')
% title('Compara��o das janelas')
% legend('Janela Retangular', 'Janela Parzen')


% % -> Explique as diferen�as observadas entre cada janela e a vantagem e desvantagem de cada uma.

% % A janela retangular possui o menor erro de espalhamento, ou seja, menor
% % largura do l�bulo principal poss�vel para as janelas (1/T para o primeiro
% % cruzamento do zero). A janela Parzen, possui uma largura do l�bulo 
% % principal quatro vezes maior (4/T para o primeiro cruzamento do zero), 
% % como observado na figura. No entanto, a janela possui um maior decaimento
% % (-24 dB/oitava) e o primeiro l�bulo secund�rio est� 53 dB abaixo do l�bulo
% % principal. A janela retangular possui um decaimento de 6 dB/oitava e o
% % maior l�bulo secund�rio est� a 13,3 dB abaixo do l�bulo principal.

% % Tendo essas caracter�sticas a janela retangular � boa para identificar
% % picos pr�ximos na frequ�ncia, mas como seu decaimento � lento � dif�cil
% % identificar resson�ncias com amplitudes bastante distintas, como pode ser
% % visto no exemplo 4.8 do Shin. A janela retangular tamb�m conserva melhor a
% % energia do sinal.0

% % A janela Parzen possui um grande erro de espalhamento, tendo
% % caracter�sticas contr�rias a da janela retangular. Identifica picos com
% % amplitudes grandes (pequeno erro de vazamento), mas picos pr�ximos s�o
% % dificeis de serem identificados (grande erro de espalhamento).

% %% *********************** Quest�o 3 *********************************
% clear all
% close all
% % Dados do problema
% A1   = 0.1;  % m
% A2   = 0.02; % m
% A3   = 0.2 ; % m
% A4   = 0.2 ; % m 
% wn1  = 12.4; % rad/s  
% wn2  = 44;   % rad/s  
% wn3  = 63 ;  % rad/s  
% wn4   = 75 ; % rad/s  
% ksi1 = 0.01;
% ksi2 = 0.02;
% ksi3 = 0.03;
% ksi4 = 0.01;
% wd1 = wn1 * sqrt(1 - ksi1^2); % Frequencia natural amortecida 1
% wd2 = wn2 * sqrt(1 - ksi2^2); % Frequencia natural amortecida 2 
% wd3 = wn3 * sqrt(1 - ksi3^2); % Frequencia natural amortecida 3
% wd4 = wn4 * sqrt(1 - ksi4^2); % Frequencia natural amortecida 4

% % a)-----------------------------------------------------------------------
% T  = 100;                 % tempo total de medi��o [s]
% fs = 80;                  % frequencia de amostragem [Hz]
% t  = 0 : 1/fs : T-1/fs;   % Vetor do tempo [s]
% N  = length(t);           % numero de elementos

% f = fs*(0:N-1)/N;        % Defini��o vetor de frequencia [Hz]
% w = f*2*pi;              % vetor da frequ�ncia (rad/s)

% % Sistema de quatro graus de liberdade:
% h = A1/wd1 * exp(-ksi1 * wn1 .* t) .* sin(wd1*t) + A2/wd2 * exp(-ksi2 * wn2 * t) .* sin(wd2*t)...
%     + A3/wd3 * exp(-ksi3 * wn3 * t) .* sin(wd3*t) + A4/wd4 * exp(-ksi4 * wn4 * t) .* sin(wd4*t); 

% % Magnitude FRF refer�ncia:
% H_ref = A1 ./ (wn1.^2 - w.^2 + 1i*2*ksi1*wn1.*w) + A2 ./ (wn2.^2 - w.^2 + 1i*2*ksi2*wn2.*w)...
%     + A3 ./ (wn3.^2 - w.^2 + 1i*2*ksi3*wn3.*w) + A4 ./ (wn4.^2 - w.^2 + 1i*2*ksi4*wn4.*w);

% H = fft(h)/fs; % FRF (DFT de resposta impulsiva)
% % Plota compara��o entre FRF refer�ncia e DFT da resposta impulsiva
% subplot(2,2,1)
% plot(f,20*log10(abs(H)),'r','LineWidth',2)
% hold on
% plot(f,20*log10(abs(H_ref)),'k','LineWidth',2)
% xlim([0 40])
% legend('H','H_{ref}')
% xlabel('Frequ�ncia [Hz]')
% ylabel('Magnitude (dB)')
% title('a) Compara��o entre FRF refer�ncia e DFT da resposta impulsiva')

% % b)-----------------------------------------------------------------------
% randn('state',0);
% x = randn(1,N);  % Ru�do branco
% y1 = conv(x,h);  % C�lculo da resposta do sistema por convolu��o
% y = y1(1:N);     % Parte da convolu��o de interesse

% maxlags = 10*fs; % -10 < tau < 10

% [Rxx, tau] = xcorr(x,x,maxlags,'unbiased'); % Autocorrela��o x
% % [Ryy, tau] = xcorr(y,y,maxlags,'unbiased'); 
% [Rxy, tau] = xcorr(x,y,maxlags,'unbiased'); % Correla��o-cruzada
% tau = tau/fs;

% N1  = 2*maxlags;
% f1  = fs*(0:N1-1)/N1;
% Sxx = fft(Rxx(1:N1));    % DFT da autocorrela��o     = Densidade Espectral
% Sxy = fft(Rxy(1:N1))/fs; % DFT da correla��o-cruzada = Densidade Espectral-Cruzada

% H1b = Sxy./Sxx; % Estimativa de H1

% % Plota compara��o entre FRF refer�ncia e FRF calculado atrav�z da FFT da correla��o e correla��o-cruzada
% subplot(2,2,2)
% plot(f1(1:N1/2+1), 20*log10(abs(H1b(1:N1/2+1))));
% hold on
% xlabel('Frequencia [Hz]','LineWidth',2); 
% ylabel('Magnitude (dB)')
% plot(f,20*log10(abs(H_ref)),'k','LineWidth',2)
% xlim([0 40])
% legend('H1(f)','H_{ref}')
% title('b) Compara��o entre FRF refer�ncia e FRF calculado')


% % c)-----------------------------------------------------------------------
% % Redefinindo o per�odo da janela para Tr = 10s
% fs = 80;
% Tr = 10;
% Nr = Tr*fs;
% tr = 0 : 1/fs : Tr - 1/fs;   % Vetor do tempo [s]
% fr = fs*(0:Nr-1)/Nr;         % Defini��o vetor de frequencia [Hz]

% Sxx = cpsd(x,x, rectwin(Nr), Nr/2, Nr, fs, 'twosided'); % Sxx utilizando o M�todo de Welch
% Sxy = cpsd(y,x, rectwin(Nr), Nr/2, Nr, fs, 'twosided'); % Sxy utilizando o M�todo de Welch

% H1_rect = Sxy./Sxx/fs; % Estimativa de H1. Divide por fs para corre��o da amplitude.

% % Plota compara��o entre FRF refer�ncia e FRF calculado pelo m�todo de Welch usando janela retangular.
% subplot(2,2,3)
% plot(fr, 20*log10(abs(H1_rect)));
% hold on
% xlabel('Frequencia [Hz]','LineWidth',2); 
% ylabel('Magnitude (dB)')
% plot(f,20*log10(abs(H_ref)),'k','LineWidth',2)
% axis([0 40 -120 -20])
% legend('H1(f) com janela retangular','H_{ref}')
% title('c) Compara��o entre FRF refer�ncia e FRF calculado')

% % d)-----------------------------------------------------------------------
% % Utilizando janela Parzen
% Sxx = cpsd(x,x, parzenwin(Nr), Nr/2, Nr, fs, 'twosided'); % Sxx utilizando o M�todo de Welch
% Sxy = cpsd(y,x, parzenwin(Nr), Nr/2, Nr, fs, 'twosided'); % Sxy utilizando o M�todo de Welch

% H1_par = Sxy./Sxx/fs; % Estimativa de H1. Divide por fs para corre��o da amplitude.

% % Plota compara��o entre FRF refer�ncia e FRF calculado pelo m�todo de Welch usando janela Parzen.
% subplot(2,2,4)
% plot(fr, 20*log10(abs(H1_par)));
% hold on
% xlabel('Frequencia [Hz]','LineWidth',2); 
% ylabel('Magnitude (dB)')
% plot(f,20*log10(abs(H_ref)),'k','LineWidth',2)
% axis([0 40 -120 -20])
% legend('H1(f) com janela Parzen','H_{ref}')
% title('d) Compara��o entre FRF refer�ncia e FRF calculado')

% % Coment�rios:
% % a) Aparece um erro de aliasing na curva calculada a partir da
% % resposta impulsiva. Pode-se melhorar esse erro utilizando uma frequencia
% % de amostragem maior.
% % b) � possivel verificar o erro devido ao truncamento do sinal no gr�fico.
% % Em 100 segundos a resposta impulsiva � quase zero, no entanto, ao se cortar o
% % sinal em 10 segundos parte do sinal � perdida (para verificar isso basta plotar
% % plot(t,h)).
% % c) A curva melhora em rela��o a b) pois utilizando o m�todo de Welch s�o
% % realizadas diversas m�dias melhornado o sinal.
% % d) A janela Parzen tem um decaimento mais suave melhorando a transformada
% % de Fourier do sinal.



















