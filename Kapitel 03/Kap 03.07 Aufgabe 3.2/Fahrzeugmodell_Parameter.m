%==========================================================================
% Parameter f�r das Fahrzeugmodell
% 
%==========================================================================
clear;          % Workspace aufr�umen
clc;            % Command Window l�schen

% Parameter f�r das Fahrzeugmodell setzen
mA = 1400;          % Masse [kg]
c  = 55270;         % Federsteifigkeit [N/m]
d  = 3079;          % D�mpfungskonstante [N*s/m]
					% Anmerkung: f�r ein reales Fahrzeug w�re diese D�mpfung zu klein
l0 = 0.5;           % Abstand x-y [m]
g  = 9.81;          % Erdbeschleunigung [m.s2]

% Filterzeitkonstante f. Tiefpassfilter
T1 = 5e-3;

%y0 = 0;             % Anfangsposition = 0
% y0 = l0;            % Anfangsposition = l0
y0 = l0 - mA*g/c;   % Anfangsposition = Gleichgewichtslage
