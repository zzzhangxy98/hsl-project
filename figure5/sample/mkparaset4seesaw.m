%make parameters set of every solution landscape for bifurcation
load("dgreall.mat")
load('lhsmat10w_8.mat')
load('dgspallseesaw.mat')
load('dgGallseesaw.mat')
paraset=cell(6,1000);
newindex=find(reall==1);%find the non-trivial solution landscape index
indall=zeros(1,sum(reall));
tmp=ones(6,1);%record the length of paraset
for ipoint=1:length(newindex)
    Gtmp=Gall{ipoint};
    sptmp=spall{ipoint};
    e=Gtmp.Edges;
    e=table2array(e);
    downjilu=[];
    for i=1:length(e(:,1))
        s=str2num(e{i,1});
        t=str2num(e{i,2});
        downjilu=[downjilu;[s t]];
    end
    ind=judgesl(sptmp,downjilu);
    indall(ipoint)=ind;
    if ind<10
        opt=struct;
        opt.d=0.2;
        opt.dt1=0.002;
        opt.dt2=0.002;
        opt.max=200000;
        opt.m=1;
        opt.l=1e-4;
        opt.eps=1e-8;
        opt.s=1;
        opt.n=4;%dimension
        opt.c0=a(newindex(ipoint),1);
        opt.cs=a(newindex(ipoint),2);
        opt.cm=a(newindex(ipoint),3);
        opt.ce=a(newindex(ipoint),4);
        opt.i0=a(newindex(ipoint),5);
        opt.is=a(newindex(ipoint),6);
        opt.im=a(newindex(ipoint),7);
        opt.ie=a(newindex(ipoint),8);
        paraset(ind-3,tmp(ind-3))={opt};
        tmp(ind-3)=tmp(ind-3)+1;
        if tmp(ind-3)>1000
            continue
        end
    end
end
save("paraset.mat",'paraset','tmp')
save('dgindall.mat','indall')
