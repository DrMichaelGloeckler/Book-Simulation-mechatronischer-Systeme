%==========================================================================
% Simulation des Fahrzeugmodells innerhalb von MATLAB
%==========================================================================
clear;
clc;

% Daten für das Fahrzeugmodell setzen (ggf. auskommentieren)
Fahrzeugmodell_Parameter;

% _________________________________________________________________________
% Aus der Differentialgleichung ergibt sich nach der Laplace-
% transformation:
%
%         d/c*s +1                  l0 - mA/c*g
% Y = -------------------- * X + -------------------- * 1
%     mA/c*s^2 + d/c*s + 1       mA/c*s^2 + d/c*s + 1
%
% Mit der Führungsübertragungsfunktion Gf(s) und der Stör-
% übertragungsfunktion Gz(s) kann man auch schreiben:
%
% Y = Gf(s) * X + Gz(s) * 1
% _________________________________________________________________________

% _________________________________________________________________________
% Der Ablauf zur Simulation mit MATLAB ist wie folgt:
%
% _________________________________________________________________________
% 1.) Führungs- und Störübertragungsfunktion aufstellen
%     mit jeweils Zähler- und Nennerpolynom.
%
num_f = [d/c, 1];           % Zähler der Führungsübertragungsfunktion 
den_f = [mA/c, d/c, 1];     % Nenner der Führungsübertragungsfunktion

num_z = l0-mA/c*9.81;       % Zähler der Störübertragungsfunktion
den_z = den_f;              % Nenner der Störübertragungsfunktion

% _________________________________________________________________________
% 2.) Übertragungsfunktion in Zustandsraumdarstellung umwnadeln
%     und zwar für Führungs- und Störübertragungsfunktion getrennt mit der 
%     Funktion tf (= transfer function). 
%     Siehe auch: help ltimodels
%
[A_f, B_f, C_f, D_f] = tf2ss(num_f*0.05, den_f);
[A_z, B_z, C_z, D_z] = tf2ss(num_z, den_z);

% _________________________________________________________________________
% 3.) Systemobjekte aufstellen
%     und zwar für Führungs- und Störübertragungsfunktion getrennt mit der 
%     Funktion ss (= state space). 
%     Siehe auch: help ltimodels
%
sys_f = ss(A_f,B_f,C_f,D_f);
sys_z = ss(A_z,B_z,C_z,D_z);

% _________________________________________________________________________
% 3.) Simulation
%     Die beiden Systemobjekte müssen getrennt simuliert werden; Da es kann
%     das Gesamtergebnis anschließen per Addition berechnet werden. 
%
[y_f, t_f] = step(sys_f);   % Sprungantwort der Führungsübertragungsfunktion
    clf;                    % Plot löschen    
    plot(t_f,y_f,'b'); hold on; grid on;
    
[y_z, t_z] = step(sys_z);   % Sprungantwort der Störübertragungsfunktion
    plot(t_z,y_z,'k'); hold off;
    xlabel('Zeit [s]');
    ylabel('y [m]');
    title('Führungs- (blau) & Störsprungantwort (schwarz)');

% Führungssprungantwort, aus dem stationären Gleichgewicht des Fahrzeugs
% heraus:
figure;
    plot(t_f,y_f + l0-mA/c*9.81); hold on; grid on;
    xlabel('Zeit [s]');
    ylabel('y [m]');
    title('Führungssprungantwort aus dem stat. Gleichgewicht');

