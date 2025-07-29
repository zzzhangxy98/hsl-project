function F=parforodefunall(X,opt)
x=X(1,:);
y=X(2,:);
k1=opt.k1;k2=opt.k2;k3=opt.k3;
k4=opt.k4;k5=opt.k5;k6=opt.k6;
d1=opt.d1;d2=opt.d2;
r0x=opt.r0x;r0y=opt.r0y;
r1=opt.r1;r2=opt.r2;r3=opt.r3;
r4=opt.r4;r5=opt.r5;r6=opt.r6;
n1=2;n2=2;
dxdt=(r0x+r1.*k1.*x.^n1+r2.*k2.*y.^n2+r3.*k3.*x.^n1.*y.^n2)./(1+k1.*x.^n1+k2.*y.^n2+k3.*x.^n1.*y.^n2)-d1.*x;
dydt=(r0y+r5.*k5.*x.^n1+r4.*k4.*y.^n2+r6.*k6.*x.^n1.*y.^n2)./(1+k5.*x.^n1+k4.*y.^n2+k6.*x.^n1.*y.^n2)-d2.*y;
F=[dxdt;dydt];
end