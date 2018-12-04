function J = cost_function(X,alp,bet,gam,g,rw,Dc,Dv,thetadf)

% COST_FUNCTION returns cost function for Ballbot 
% as defined in Eqn. 17 in Nagarajan et al. 2014
% input X assumed to [phi_p^a1,phi_p^a2,T]

[t,phi,phid,phidd,thetadd,times,THETA] = get_trajs(X,alp,bet,gam,g,rw);
tau = alp*double(subs(thetadd,t,times)) + Dc*sign(THETA(:,2)) + Dv*THETA(:,2)...
    - bet*sin(double(subs(phi,t,times))).*(double(subs(phid,t,times)).^2)...
    + alp+bet*cos(double(subs(phi,t,times))).*double(subs(phidd,t,times));

w1 = 50;
w2 = 50;
w3 = 2;
w4 = 0.1;

J = w1*(THETA(end,1)-thetadf)^2 + w2*THETA(end,2)^2 + 0.5*w3*X(3)^2 ...
    + w4*sum((tau(1:end-1).^2).*(times(2:end)-times(1:end-1)));
end