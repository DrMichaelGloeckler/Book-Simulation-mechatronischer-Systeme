%==========================================================================
% Beispiel: Schwingungsf�higes mechan. System mit Masse, Feder und D�mpfer
% 
% Die Differenzialgleichung lautet:  
%       m/d*d^2/dt^2(y) + d/c*dy/dt + y = -m*g/c
%
% Daraus ergibt sich die �bertragungsfunktion:  
%               y(s)         -m*g/c
%       G(s) =  ----  =  -------------------    mit: H(s) = Sprungfunktion
%               H(s)     m/c*s^2 + d/c*s + 1
%==========================================================================
clear;              % Workspace aufr�umen
clc;                % Command Window l�schen
 
m  = 0.2;           % Masse [kg]
c  = 10;            % Federsteifigkeit [N/m]
d  = 0.5;           % D�mpfungskonstante [Ns/m]
g  = 9.81;          % Erdbeschleunigung [m/s/s]
 
% Koeffizienten des Z�hlers
num = [-m*g/c];     % b0 = 1
% Koeffizienten des Nenners
den = [m/c,d/c,1];  % a2 = m/c, a1 = d/c, a0 = 1
 
% �bertragungsfunktion aus den Koeffizienten von Z�hler und Nenner bilden
sys = tf(num,den);
 
% Simulation der Sprungantwort (Einheitssprung)
[Y,T,X] = step(sys);
 
% Ergebnis der Simulation plotten
plot(T,Y);          % Ergebnis Ua(t) = Y(T) plotten 
grid on;                    % Gitter einschalten
xlabel('Zeit t [ms]');      % Beschriftung d. X-Achse
ylabel('Position y [m]');   % Beschriftung d. Y-Achse
title('Federpendel');       % Titel
axis([0 4.5 -0.35 0])       % Achsenskalierung 0<=x<=4.5, -0.35<=y<=0
