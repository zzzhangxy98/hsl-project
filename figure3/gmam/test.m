% test
load('opt21.mat')
%% the pathway from 2-saddle to 1-saddle
F_func=@parforodefunall;
% F_func=@F_muller;
opt.tau=1e-6;
opt.N=100;
opt.max=1e6;
opt.eps=1e-10;
f=1.1;
opt.r1=0.9+f*0.;
opt.r4=0.9+0.;
opt.r0x=f*0.0336;
opt.r0y=0.0336;
opt.r0x=f*0.063;
opt.r0y=0.063;
% x0=[0.128207773300257;0.0892586976837881];%0.0336 0.5 s
% x1=[0.0133019440557146;2.25787203918535];%0.0336 0.5 y
% x1=[0.107628754709765;0.200378781643481];%0.0336 0.5 1sd
x0=[0.248417421922617;0.168346761642977];%0.063 s
% x1=[0.0713558708934605;1.07703238209344];%0.063 y
x1=[0.164309090346643;0.395610276914215];%0.063 1sd
% x0=sp{1}(:,3);
% x1=sp{1}(:,1);
% delta=0.03; 
% opt.r1=1.0+10*delta;
% opt.r4=1.0+5*delta;
% opt.r0x=0+2*delta;
% opt.r0y=0+delta;
% x0=[0.0247416;1.58926];%0.02
% x0=[1.83254;0.009943];%0.02
% x1=[0.557093;0.663407];%0.02
% x0=[0.0338084;1.71231];%0.03
% x0=[2.05652;0.012554];%0.03
% x1=[0.653406;0.829142];%0.03
% x0=[0.00079;1.30881];
% x1=[0;0];
[perf,info]=mygMAM(x0,x1,F_func,opt);

%%  output
% figure()
% semilogy(info.E)
% figure()
% plot3(perf.x(1,:),perf.x(2,:),perf.x(3,:))
sum(info.myE(:,info.step))*1000
sum(info.myA(:,info.step))*1000
info.E(info.step)*1000
aa=sum(sum(info.myE,1));
bb=sum(sum(info.myA,1));
% save('oou0_xo.mat','info')
