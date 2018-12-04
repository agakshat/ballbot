%% load params and open loop tape
clearvars;
run('parameters.m');
load('openlooptape.mat');
Q = 100*eye(4);
R = 5e3;
Qf = 100*eye(4);

%% setup symbolic derivative eqns of dynamics
bbdyn = @(Y,u) ballbot_dynamics(Y,u,alp,bet,gam,g,rw,Dc,Dv);
Y = sym('Y',[4,1], 'real');
syms u real;
f = bbdyn(Y,u);
dfdy = jacobian(f,Y);
dfdu = diff(f,u);
ALL_DATA = [THETA(:,1) phival THETA(:,2) phidval tau];

%% interpolation to get properly spaced values
dt = (times(end)-times(1))/100;
uni_t = linspace(times(1),times(end));
ALL_DATA = interp1(times,[THETA(:,1) phival THETA(:,2) phidval tau],uni_t);

N = size(ALL_DATA,1);
S = zeros(N,16);
S(end,:) = reshape(Qf,[1,16]);

%% solve Riccati eqn backward in time to get S(t) for all t
for i = N:-1:2
    y0 = ALL_DATA(i,1:4)';
    u0 = ALL_DATA(i,5);
    A = double(subs(dfdy,[Y;u],[y0;u0]));
    B = double(subs(dfdu,[Y;u],[y0;u0]));
    if rank(ctrb(A,B))<4
        fprintf("Not Controllable.\n");
    end
    S(i-1,:) = S(i,:) - dt*Sdot_fn(S(i,:),A,B,Q,R)';
end

%% use S(t) to get desired control starting from some other point
x = [0.3;0;0.2;0];
y = [];
ustar = zeros(N,1);
for i = 1:N
    y = [y x];
    ustar(i) = ALL_DATA(i,5) - (R\B')*reshape(S(i,:),size(A))*(x-ALL_DATA(i,1:4)');
    x = x + dt*bbdyn(x,ustar(i));
end

%% Riccati equation definition
function Sdot = Sdot_fn(S,A,B,Q,R)
S = reshape(S,xsize(A));
Sdot =  -(Q - S*B*(R\B')*S + S*A + A'*S);
Sdot = Sdot(:);
end