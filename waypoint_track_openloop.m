%% load ballbot parameters and set initial and final desired states
clearvars;
run('parameters.m');
x0 = [0.35;-0.35;15];
Xdf = [1/rw -1/rw 0]; % waypoints I want to track

%% optimization
func = @(x) cost_function(x,alp,bet,gam,g,rw,Dc,Dv,Xdf);

% options = optimset('Display','iter','PlotFcns',@optimplotfval);
options = optimset('Display','iter');
[x,fval,exitflag] = fminsearch(func,x0,options);

%% visualize results
[t,phi,phid,times,THETA,tau] = get_trajs(x,alp,bet,gam,g,rw,Dc,Dv);
phival = double(subs(phi,t,times));
phidval = double(subs(phid,t,times));

render([THETA(:,1) phival],times,rw);
plot_the_plots(times,THETA,phival,phidval,tau,rw);

%% save openloop tape
% save('openlooptape.mat','THETA','phival','phidval','tau','times');