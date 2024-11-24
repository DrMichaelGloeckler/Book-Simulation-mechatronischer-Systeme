%==========================================================================
% Beispiel: Elektr. Schaltung mit ohmschem Widerstand R und Kondensator C
% 
% Die Differenzialgleichung lautet:  
%       R*C*dUa/dt + Ua = Ue
%
% Daraus ergibt sich die Übertragungsfunktion:  
%               Ua(s)        1
%       G(s) =  ----  =  ---------
%               Ue(s)    R*C*s + 1
%==========================================================================
clear;          % Workspace aufräumen
clc;            % Command Window löschen

% Parameter setzen
Ue = 10;        % Eingangsspannung [V]
R  = 250;       % Widerstand [Ohm]
C  = 1e-6;      % Kapazität [F]
 
% Koeffizienten des Zählers
num = [1];      % b0 = 1 (num von Englisch: numerator = Zähler)
% Koeffizienten des Nenners
den = [R*C,1];  % a1 = R*C, a0 = 1 (den von Englisch: denumerator = Nenner) 
 
% Übertragungsfunktion aus den Koeffizienten von Zähler und Nenner bilden
sys = tf(num,den);   %  (tf von Englisch: transfer function = Übertrag.fkt.)
 
% Simulation der Sprungantwort (Einheitssprung)
[Y,T,X] = step(sys);
 
% Ergebnis der Simulation plotten
plot(T*1000,Y*10);          % Ergebnis Ua(t) = Y(T) plotten 
                            % T[ms], Y*10 weil Sprunghöhe=10V anstatt 1V
grid on;                    % Gitter einschalten
xlabel('Zeit t [ms]');      % Beschriftung d. X-Achse
ylabel('Spannung U_A [V]'); % Beschriftung d. Y-Achse
title('Antwort auf 10V Eingangssprung');    % Titel
axis([0 1.4 0 12])          % Achsenskalierung 0<=x<=1.4, 0<=y<=12
