%sample SL 
parpool("Processes",32)
load("lhsmat10w_7.mat")
F_func=@parforodefunall;
reall=zeros(length(a),1);
spall=cell(length(a),1);
parfor i =1:length(a)
    opt=struct;
    opt.d=0.2;
    opt.dt1=0.002;
    opt.dt2=0.002;
    opt.max=200000;
    opt.m=1;
    opt.l=1e-4;
    opt.eps=1e-8;
    opt.s=1;
    opt.n=2;
    opt.k1=10*a(i,1);
    opt.k2=10*a(i,2);
    opt.k3=10*a(i,3);
    opt.d1=10*a(i,4);
    opt.r0x=10*a(i,5);
    opt.r1=10*a(i,6);
    opt.r2=0;
    opt.r3=10*a(i,7);
    opt.k4=10*a(i,1);
    opt.k5=10*a(i,2);
    opt.k6=10*a(i,3);
    opt.d2=10*a(i,4);
    opt.r0y=10*a(i,5);
    opt.r4=10*a(i,6);
    opt.r5=0;
    opt.r6=10*a(i,7);
    [re,sp]=makesl(F_func,num2str(i),opt);
    reall(i)=re;
    spall{i}=sp;
end
save('reall.mat','reall')
save('spall.mat','spall')

    
    
