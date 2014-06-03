function [ dq ] = rhs_q( x3, Psi2, Psi4, m, M, l, fp, fc)
%% Wylicznie prawych stron równañ ró¿niczkowych
dq = Psi2/(m*sin(x3)^2 + M + fc) - (Psi4*m*cos(x3))/((l*m + fp/l)*(m*sin(x3)^2 + M + fc));

end

