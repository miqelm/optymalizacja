clear all
syms('x1', 'real')
syms('x2', 'real')
syms('x3', 'real')
syms('x4', 'real')
syms('m', 'real')
syms('g', 'real')
syms('M', 'real')
syms('l', 'real')
syms('fc', 'real')
syms('fp', 'real')
syms('u', 'real')
syms('f1', 'real')
syms('f2', 'real')
syms('f3', 'real')
syms('f4', 'real')
syms('H', 'real')
syms('Psi1', 'real')
syms('Psi2', 'real')
syms('Psi3', 'real')
syms('Psi4', 'real')

f1 = x1;
f2 = (u + m * l * sin(x3) * x4^2 - m * g * sin(x3) * cos(x3))/(M + m * sin(x3)^2 + fc);
f3 = x4;
f4 = (-m * g * sin(x3) - m * cos(x3) * f2)/(m * l + fp/l);

H = Psi1 * x2 + Psi2 * f2 + Psi3 * x4 + Psi4 * f4 - x3^2;

dPsi1 = -diff(H, x1);
dPsi2 = -diff(H, x2);
dPsi3 = -diff(H, x3);
dPsi4 = -diff(H, x4);
diff(H, u)