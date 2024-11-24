%==========================================================================
% Beispiel 01: Transformation in Zustandsraumdarstellung
% 
% Die �bertragungsfunktion lautet:  
%
%               Ua(s)        3*s^2 + 2*s + 1
%       G(s) =  ----  =  -----------------------
%               Ue(s)    7*s^3 + 2*s^2 + 4*s + 6
%==========================================================================
clear;          % Workspace aufr�umen
clc;            % Command Window l�schen

num=[3 2 1];    % Z�hlerpolynom als 1x3 Vektor
                % (b3=0 muss nicht eingegeben werden)
den=[7 2 4 6];  % Nennerpolynom als 1x4 Vektor

[A,B,C,D] = tf2ss(num,den)
