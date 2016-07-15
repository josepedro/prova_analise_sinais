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

function w = poisson_window(n,alpha)

% HANNPOISSWIN Symmetric Hanning-Poisson window
%    HANNPOISSWIN(N,ALPHA) returns a symmetric N point Hanning-
%    Poisson window with parameter ALPHA.
%
%    The window is similar to the Poisson window, and as ALPHA
%    increases, the zeros of the sidelobe structure disappear,
%    and the lobes merge into the assymptote.  The window has
%    no sidelobes for alpha >= 2, and as such, is useful in hill
%    climbing optimization methods.
 
%  Joe Henning - Jan 2014

if nargin < 2
   fprintf('??? Bad alpha input to hannpoisswin ==> alpha must be specified\n');
   w = [];
   return;
end

if (n == 1)
   w = 1;
   return
end
 
if ~rem(n,2)
   % Even length window
   m = n/2;
   x = (0:m-1)'/(n-1);
   h = 0.5*(1 - cos(2*pi*x));
   h = [h; h(end:-1:1)];
else
   % Odd length window
   m = (n+1)/2;
   x = (0:m-1)'/(n-1);
   h = 0.5*(1 - cos(2*pi*x));
   h = [h; h(end-1:-1:1)];
end

x = 0:n-1;
p = exp(-alpha/(n-1)*abs(n-1-2*x)).';

w = p;%.*h;
