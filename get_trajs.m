function [t,phi,phid,times,THETA,tau] = get_trajs(X,alp,bet,gam,g,rw,Dc,Dv)

syms t;
K = 9;

phi = [X(1)*sech(K*(4*t-X(5)^2)/X(5)^2) + X(2)*sech(K*(4*t-3*X(5)^2)/X(5)^2) + ...
    -X(1)*sech(K)-X(2)*sech(3*K); X(3)*sech(K*(4*t-X(5)^2)/X(5)^2) + X(4)*sech(K*(4*t-3*X(5)^2)/X(5)^2) + ...
    -X(3)*sech(K)-X(4)*sech(3*K)];

phid = diff(phi,t);
phidd = diff(phid,t);
thetadd = (bet*(g/rw)*sin(phi)+bet*sin(phi).*phid.*phid - (alp+gam+2*bet*cos(phi)).*phidd)./(alp+bet*cos(phi));

THETA_FUNC = @(time,THS) [THS(3);THS(4);double(subs(thetadd,t,time))];
[times,THETA] = ode45(THETA_FUNC,[0 X(5)^2],[0;0;0;0]); % THETA is th_x,th_y,thdot_x,thdot_y

fun = @(x) reshape(x,size(times,1),2);
tau = alp*fun(double(subs(thetadd,t,times))) + Dc*sign(THETA(:,3:end)) + Dv*THETA(:,3:end)...
    - bet*sin(fun(double(subs(phi,t,times)))).*(fun(double(subs(phid,t,times))).^2)...
    + alp+bet*cos(fun(double(subs(phi,t,times)))).*fun(double(subs(phidd,t,times)));

end