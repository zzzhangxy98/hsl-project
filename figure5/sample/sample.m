%sample SL 
parpool("Processes",32)
load("lhsmat10w_8.mat")
F_func=@seesaw;
reall=zeros(length(a),1);
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
    opt.n=4;%dimension
    opt.c0=a(i,1);
    opt.cs=a(i,2);
    opt.cm=a(i,3);
    opt.ce=a(i,4);
    opt.i0=a(i,5);
    opt.is=a(i,6);
    opt.im=a(i,7);
    opt.ie=a(i,8);
%    opt.d0=a(i,9);
%    opt.ds=a(i,10);
%    opt.dm=a(i,11);
%    opt.de=a(i,12);
    [re]=makesl(F_func,num2str(i),opt);
    reall(i)=re; 
end
save('reall.mat','reall')

    
    
