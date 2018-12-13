%% load ballbot parameters and set initial and final desired states
clearvars;
run('parameters.m');
x0 = [0.35;-0.35;0.35;-0.35;2];
thetadf = [1/rw,1/rw];

%% optimization
func = @(x) cost_function(x,alp,bet,gam,g,rw,Dc,Dv,thetadf);

% options = optimset('Display','iter','PlotFcns',@optimplotfval);
options = optimset('Display','iter','TolFun',1e-2,'TolX',1e-2,'PlotFcns',@optimplotfval);
[x,fval,exitflag] = fminsearch(func,x0,options);

%% visualize results
[t,phi,phid,times,THETA,tau] = get_trajs(x,alp,bet,gam,g,rw,Dc,Dv);
phival = reshape(double(subs(phi,t,times)),size(times,1),2);
phidval = reshape(double(subs(phid,t,times)),size(times,1),2);

yw = rw*(THETA(:,2)+phival(:,2));
xw = rw*(THETA(:,1)+phival(:,1));

render([THETA(:,1) phival(:,1)],times,rw,xw,yw);
plot_the_plots(times,THETA,phival,phidval,tau,rw);

%% save openloop tape
% save('openlooptape.mat','THETA','phival','phidval','tau','times');