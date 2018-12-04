function [t,phi,phid,phidd,thetadd,times,THETA] = get_trajs(X,alp,bet,gam,g,rw)

syms t;
K = 9;

phi = X(1)*sech(K*(4*t-X(3))/X(3)) + X(2)*sech(K*(4*t-3*X(3))/X(3)) + ...
    -X(1)*sech(K)-X(2)*sech(3*K);
phid = diff(phi,t);
phidd = diff(phid,t);
thetadd = (bet*(g/rw)*sin(phi)+bet*sin(phi)*phid*phid - (alp+gam+2*bet*cos(phi))*phidd)/(alp+bet*cos(phi));

THETA_FUNC = @(time,THS) [THS(2);double(subs(thetadd,t,time))];
[times,THETA] = ode45(THETA_FUNC,[0 X(3)],[0;0]);

end