%==========================================================================
% Energiebilanz für das Schwingungsfähige mechan. System mit Masse, Feder 
% und Dämpfer berechnen.
% 
%==========================================================================
clear;              % Workspace aufräumen
clc;                % Command Window löschen

Federpendel;

E_pot = m*g*Y;      % potentielle Energie der Masse
E_kin = m/2*(gradient(Y)./gradient(T)).^2;  % kinetische Energie
                    % gradient(Y)./gradient(T) ist die Geschwindigkeit dY/dt
E_F   = c/2*Y.^2;   % potentielle Energie der Feder
E_ges = E_pot + E_kin + E_F;

% Ergebnis der Berechnung plotten
figure;
plot(T,E_pot,'k--');        % Ergebnis E_pot(t)plotten 
hold on;
grid on;                    % Gitter einschalten
plot(T,E_kin,'k.');         % Ergebnis E_kin(t) plotten 
plot(T,E_F,'k-.');          % Ergebnis E_F(t) plotten 
plot(T,E_ges,'k-');           % Ergebnis E_ges(t) plotten 
xlabel('Zeit t [ms]');      % Beschriftung d. X-Achse
ylabel('Energie E [J]');    % Beschriftung d. Y-Achse
title('Federpendel');       % Titel
axis([0 4.5 -0.8 0.6])      % Achsenskalierung 0<=x<=4.5, -0.8<=y<=0.6

% Arbeit der Dämpfungskraft
Fd = -d*(gradient(Y)./gradient(T));    % Dämpfungskraft 
E_D(1) = 0;                 % Arbeit der Dämpfungskraft
for k=2:length(T)
    E_D(k) = trapz(Y(1:k),Fd(1:k));
end
plot(T,E_D,'r');           % Ergebnis E_D(t) plotten 

