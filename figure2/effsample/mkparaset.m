%make parameters set of every solution landscape for bifurcation
irange=10;
load('lhsmat10w_7.mat')
load(['indexall',num2str(irange),'.mat'])
pointrange=[11;12;13;14;15;21;22;23;31;32;41];
paraset=cell(11,1000);
tmp=zeros(11,1);%record the length of paraset
for i=1:length(pointrange)
    newindex=find(indexmat==pointrange(i));%find the index
    tmp(i)=tmp(i)+length(newindex);
    for ipoint=1:length(newindex)
        opt=struct;
        opt.d=0.2;
        opt.dt1=0.002;
        opt.dt2=0.002;
        opt.max=200000;
        opt.m=1;
        opt.l=1e-4;
        opt.eps=1e-8;
        opt.s=1;
        opt.n=2;%dimension
        opt.k1=irange*a(newindex(ipoint),1);
        opt.k2=irange*a(newindex(ipoint),2);
        opt.k3=irange*a(newindex(ipoint),3);
        opt.d1=irange*a(newindex(ipoint),4);
        opt.r0x=irange*a(newindex(ipoint),5);
        opt.r1=irange*a(newindex(ipoint),6);
        opt.r2=0;
        opt.r3=irange*a(newindex(ipoint),7);
        opt.k4=irange*a(newindex(ipoint),1);
        opt.k5=irange*a(newindex(ipoint),2);
        opt.k6=irange*a(newindex(ipoint),3);
        opt.d2=irange*a(newindex(ipoint),4);
        opt.r0y=irange*a(newindex(ipoint),5);
        opt.r4=irange*a(newindex(ipoint),6);
        opt.r5=0;
        opt.r6=irange*a(newindex(ipoint),7);
        paraset(i,ipoint)={opt};
    end
end
save(['symparaset',num2str(irange),'.mat'],'paraset','tmp')

