clearvars;
run('parameters.m');

x0 = [0.35;-0.35;15];
thetadf = 1/rw;

func = @(x) cost_function(x,alp,bet,gam,g,rw,Dc,Dv,thetadf);

options = optimset('Display','iter');
[x,fval,exitflag] = fminsearch(func,x0,options);

[t,phi,~,~,~,times,THETA] = get_trajs(x,alp,bet,gam,g,rw);
phival = double(subs(phi,t,times));

render([THETA(:,1) phival],rw);