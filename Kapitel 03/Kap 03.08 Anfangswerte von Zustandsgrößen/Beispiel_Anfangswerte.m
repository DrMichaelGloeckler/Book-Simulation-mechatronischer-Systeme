%=================================================================
% BEISPIEL: Anfangswerte für eine Simulation vorgeben,
% Anfangswerte:
% y(t=0) = 3
% dy/dt(t=0) = 7
% d^2(y)/dt^2(t=0) = -2
%
%=================================================================
clear;          % Workspace aufräumen
clc;            % Command Window löschen

%-----------------------------------------------------------------
% Testsystem 3.Ordnung, Übertragungsfunktion gegeben
%
% 2s^3 + 3s^2 + 2s + 1
% G(s) = --------------------
% 7s^3 + 2s^2 + 4s + 6
%
%-----------------------------------------------------------------
num=[2 3 2 1];
den=[7 2 4 6];
%-----------------------------------------------------------------
% Umwandlung in Zustandsraumdarstellung
%-----------------------------------------------------------------
[A,B,C,D] = tf2ss(num,den);
%-----------------------------------------------------------------
% Anfangswert der Ausgangsgröße y mit 1. und 2.Ableitung
%-----------------------------------------------------------------
Y0 = [ -2 ;... % 2.Ableitung von y nach der Zeit
7 ;... % 1.Ableitung von y nach der Zeit
3 ]; % y
%-----------------------------------------------------------------
% daraus: Anfangswert der Zustandsgröße x
% mit: u = sin(5t) => u(0) = sin(5*0),
% du/dt|(t=0) = 5*cos(5*0),
% d2u/dt2|(t=0) = -25*sin(5*0)
%-----------------------------------------------------------------
X0 = inv( [ C*A^2 ;...
            C*A ;...
            C ])* ( Y0 ...
                   - [ D C*B C*A*B; ...
                       0 D C*B; ...
                       0 0 D] ...
                       * [ -25*sin(5*0); ...
                             5*cos(5*0); ...
                             sin(5*0)] );
%-----------------------------------------------------------------
% Simulation
%-----------------------------------------------------------------
Tab = 0.01;         % Simulationsschrittweite 0.01s
T = 2;              % Simulationsdauer T=2s
t = (0:Tab:T);      % Zeit-Stützpunkte
u = sin(5*t);       % Eingangsgröße u
[Y,X] = lsim(A,B,C,D,u,t,X0); % Simulation linearer Systeme
plot(t,Y);          % Ergebnis plotten
grid on;            % Gitter enishcalten
xlabel('Zeit [s]'); % x-Achse beschriften
ylabel('y');        % y-Achse beschriften
title('Simulation mit Anfangswerten der Zustandsgrößen');
