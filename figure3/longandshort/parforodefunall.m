function F=parforodefunall(X,opt)
% function F=parforodefunAO(X,a1,a2,a3,u)
x=X(1,:);
y=X(2,:);

% b0=0;b1=0.95;b2=0;b3=0;
% % b0=0.15;b1=0.95;b2=0;b3=0.95;
% a1=opt.a1;a2=opt.a2;a3=opt.a3;
% u=0;
% p1=0.55;
% c1=2;
% 
% 
% k1=a1;k2=a2;k3=a3;
% k4=a1;k5=a2;k6=a3;
% d1=p1;d2=p1;
% r0x=0;r0y=0.15;
% r1=0.95;r2=0;r3=0;
% r4=0.95;r5=0;r6=0.95;
% n1=c1;n2=c1;
% ux=u;uy=u;

k1=opt.k1;k2=opt.k2;k3=opt.k3;
k4=opt.k4;k5=opt.k5;k6=opt.k6;
d1=opt.d1;d2=opt.d2;
r0x=opt.r0x;r0y=opt.r0y;
r1=opt.r1;r2=opt.r2;r3=opt.r3;
r4=opt.r4;r5=opt.r5;r6=opt.r6;
n1=2;n2=2;
ux=opt.ux;uy=opt.uy;
dxdt=(r0x+r1.*k1.*x.^n1+r2.*k2.*y.^n2+r3.*k3.*x.^n1.*y.^n2)./(1+k1.*x.^n1+k2.*y.^n2+k3.*x.^n1.*y.^n2)-d1.*x+ux;
dydt=(r0y+r5.*k5.*x.^n1+r4.*k4.*y.^n2+r6.*k6.*x.^n1.*y.^n2)./(1+k5.*x.^n1+k4.*y.^n2+k6.*x.^n1.*y.^n2)-d2.*y+uy;
F=[dxdt;dydt];
end