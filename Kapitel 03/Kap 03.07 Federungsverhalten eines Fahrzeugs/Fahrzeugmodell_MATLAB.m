%==========================================================================
% Simulation des Fahrzeugmodells innerhalb von MATLAB
%==========================================================================
clear;
clc;

% Daten f�r das Fahrzeugmodell setzen (ggf. auskommentieren)
Fahrzeugmodell_Parameter;

% _________________________________________________________________________
% Aus der Differentialgleichung ergibt sich nach der Laplace-
% transformation:
%
%         d/c*s +1                  l0 - mA/c*g
% Y = -------------------- * X + -------------------- * 1
%     mA/c*s^2 + d/c*s + 1       mA/c*s^2 + d/c*s + 1
%
% Mit der F�hrungs�bertragungsfunktion Gf(s) und der St�r-
% �bertragungsfunktion Gz(s) kann man auch schreiben:
%
% Y = Gf(s) * X + Gz(s) * 1
% _________________________________________________________________________

% _________________________________________________________________________
% Der Ablauf zur Simulation mit MATLAB ist wie folgt:
%
% _________________________________________________________________________
% 1.) F�hrungs- und St�r�bertragungsfunktion aufstellen
%     mit jeweils Z�hler- und Nennerpolynom.
%
num_f = [d/c, 1];           % Z�hler der F�hrungs�bertragungsfunktion 
den_f = [mA/c, d/c, 1];     % Nenner der F�hrungs�bertragungsfunktion

num_z = l0-mA/c*9.81;       % Z�hler der St�r�bertragungsfunktion
den_z = den_f;              % Nenner der St�r�bertragungsfunktion

% _________________________________________________________________________
% 2.) �bertragungsfunktion in Zustandsraumdarstellung umwnadeln
%     und zwar f�r F�hrungs- und St�r�bertragungsfunktion getrennt mit der 
%     Funktion tf (= transfer function). 
%     Siehe auch: help ltimodels
%
[A_f, B_f, C_f, D_f] = tf2ss(num_f*0.05, den_f);
[A_z, B_z, C_z, D_z] = tf2ss(num_z, den_z);

% _________________________________________________________________________
% 3.) Systemobjekte aufstellen
%     und zwar f�r F�hrungs- und St�r�bertragungsfunktion getrennt mit der 
%     Funktion ss (= state space). 
%     Siehe auch: help ltimodels
%
sys_f = ss(A_f,B_f,C_f,D_f);
sys_z = ss(A_z,B_z,C_z,D_z);

% _________________________________________________________________________
% 3.) Simulation
%     Die beiden Systemobjekte m�ssen getrennt simuliert werden; Da es kann
%     das Gesamtergebnis anschlie�en per Addition berechnet werden. 
%
[y_f, t_f] = step(sys_f);   % Sprungantwort der F�hrungs�bertragungsfunktion
    clf;                    % Plot l�schen    
    plot(t_f,y_f,'b'); hold on; grid on;
    
[y_z, t_z] = step(sys_z);   % Sprungantwort der St�r�bertragungsfunktion
    plot(t_z,y_z,'k'); hold off;
    xlabel('Zeit [s]');
    ylabel('y [m]');
    title('F�hrungs- (blau) & St�rsprungantwort (schwarz)');

% F�hrungssprungantwort, aus dem station�ren Gleichgewicht des Fahrzeugs
% heraus:
figure;
    plot(t_f,y_f + l0-mA/c*9.81); hold on; grid on;
    xlabel('Zeit [s]');
    ylabel('y [m]');
    title('F�hrungssprungantwort aus dem stat. Gleichgewicht');

