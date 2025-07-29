function F=seesaw(X,opt)
oct4=X(1,:);
sox2=X(2,:);
mes=X(3,:);
ects=X(4,:);

% c0=1;cs=1;cm=1;ce=1;
% i0=1;is=1;im=1;ie=1;
% d0=0.2;ds=0.2;dm=1;de=1;
% kpact=0.35;kpinh=0.7;kdinh=0.3;ka=1.3;ki=0.55;
% npact=1;npinh=8;ndinh=8;na=9;ni=10;
% w=0.8;KM=0.4;

c0=opt.c0;cs=opt.cs;cm=opt.cm;ce=opt.ce;
i0=opt.i0;is=opt.is;im=opt.im;ie=opt.ie;
%d0=opt.d0;ds=opt.ds;dm=opt.dm;de=opt.de;
%i0=0;is=0;im=0;ie=0;
d0=0.2;ds=0.2;dm=1;de=1;
kpact=0.35;kpinh=0.7;kdinh=0.3;ka=1.3;ki=0.55;
npact=1;npinh=8;ndinh=8;na=9;ni=10;
w=0.8;KM=0.4;

doct4dt=d0*(c0+i0*(kpinh^npinh./(kpinh^npinh+mes.^npinh)).*(kpinh^npinh./(kpinh^npinh+ects.^npinh))...
    .*(KM+(oct4.*sox2).^npact./(kpact^npact+(oct4.*sox2).^npact))-oct4);
dsox2dt=ds*(cs+is*(kpinh^npinh./(kpinh^npinh+mes.^npinh)).*(kpinh^npinh./(kpinh^npinh+ects.^npinh))...
    .*(KM+(oct4.*sox2).^npact./(kpact^npact+(oct4.*sox2).^npact))-sox2);
dmesdt=dm*(cm+im*w*(oct4.^na./(ka^na+oct4.^na))+im*(ki^ni./(ki^ni+sox2.^ni)).*(kdinh^ndinh./(kdinh^ndinh+ects.^ndinh))-mes);
dectsdt=de*(ce+ie*w*(sox2.^na./(ka^na+sox2.^na))+ie*(ki^ni./(ki^ni+oct4.^ni)).*(kdinh^ndinh./(kdinh^ndinh+mes^ndinh))-ects);

F=[doct4dt;dsox2dt;dmesdt;dectsdt];
end
