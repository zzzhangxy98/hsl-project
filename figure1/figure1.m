%% initial
load("opt23.mat")
% opt.k1=0.25;
% opt.k2=0.6944;
% opt.k3=0.1736;
% opt.k4=0;
% opt.k5=1;
% opt.k6=0;
opt.r0x=0.22;
opt.r0y=0.22;
opt.r1=0.75;
% opt.r2=1.076;
% opt.r3=6.632;
opt.r4=0.75;
% opt.r5=0;
% opt.r6=0;
% opt.d1=1.452;
% opt.d2=0.198;
%% plot phase diagram
F=plotodefun(opt);

%% make solutioin landscape
F_func=@parforodefunall;
seed='1';
[sp]=makesl(F_func,seed,opt);

load('parforodefunall1.mat')
figure()
plot(G)