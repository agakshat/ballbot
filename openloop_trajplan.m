%% load ballbot parameters and set initial and final desired states
clearvars;
run('parameters.m');
x0 = [0.35;-0.35;15];
thetadf = 1/rw;

%% optimization
func = @(x) cost_function(x,alp,bet,gam,g,rw,Dc,Dv,thetadf);

options = optimset('Display','iter');
[x,fval,exitflag] = fminsearch(func,x0,options);

%% visualize results
[t,phi,phid,times,THETA,tau] = get_trajs(x,alp,bet,gam,g,rw,Dc,Dv);
phival = double(subs(phi,t,times));
phidval = double(subs(phid,t,times));

render([THETA(:,1) phival],times,rw);
plot_the_plots(times,THETA,phival,phidval,tau,rw);