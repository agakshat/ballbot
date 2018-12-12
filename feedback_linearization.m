clearvars;
run('parameters.m');

Y = sym('Y',[4,1]);
syms u;
Q = 10*eye(4);
R = 10;
Yd = ballbot_dynamics(0,[Y;u]);
dfdy = jacobian(Yd,Y);
dfdu = diff(Yd,u);

y0 = [0;0;0;0];
u0 = 1;
yd = [0;0.1;0;0];

A = double(vpa(subs(dfdy,[Y;u],[y0;u0])));
B = double(vpa(subs(dfdu,[Y;u],[y0;u0])));

K = lqr(A,B,Q,R);

u = -K*(Y-yd);