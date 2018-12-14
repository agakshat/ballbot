function Ydot = ballbot_dynamics(Y,u,alp,bet,gam,g,rw,Dc,Dv)
% BALLBOT_DYNAMICS return ballbot dynamics
% assume Y = [theta,phi,theta_dot,phi_dot]
% assume u = control

run('parameters.m') % load parameter values
M = [alp alp+bet*cos(Y(2));alp+bet*cos(Y(2)) alp+gam+2*bet*cos(Y(2))];
C = [-bet*sin(Y(2))*Y(4)*Y(4);-bet*sin(Y(2))*Y(4)*Y(4)];
G = [0;-bet*g*sin(Y(2))/rw];
D = [Dc*sign(Y(3))+Dv*Y(3);0];

qddot = M\([u;0] - D - G - C);
Ydot = [Y(3);Y(4);qddot];
end