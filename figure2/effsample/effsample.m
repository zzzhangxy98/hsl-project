%effective sample
parpool("Processes",10)
%% ini
F_func=@parforodefunall;
pointrange=[7 10];  %corresponding to the ID[22;32]
load('paraset10all.mat')
pararanger=['rx';'r1';'r2';'r3';'ry';'r4';'r5';'r6'];
pararangek=['d1';'k1';'k2';'r3';'d2';'k4';'k5';'k6'];
samplenum=1000;

for ipoint=pointrange
    tmppoint=alllength(ipoint);
    spall=cell(tmppoint,samplenum);
    for jpoint=1:tmppoint
        opt=newpara{ipoint,jpoint};
        seed4r=0.1*randn(8,samplenum);
        seed4k=randn(8,samplenum);
        tmpspall=cell(1,samplenum);
        
        parfor jseed=1:samplenum
            opt1=opt;
            tmpseed4r=seed4r(:,jseed);
            tmpseed4k=seed4k(:,jseed);  
    
            opt1.r0x=abs(opt1.r0x+tmpseed4r(1));
            opt1.r1=abs(opt1.r1+tmpseed4r(2));
            opt1.r2=abs(opt1.r2+tmpseed4r(3));
            opt1.r3=abs(opt1.r3+tmpseed4r(4));
            opt1.r0y=abs(opt1.r0y+tmpseed4r(5));
            opt1.r4=abs(opt1.r4+tmpseed4r(6));
            opt1.r5=abs(opt1.r5+tmpseed4r(7));
            opt1.r6=abs(opt1.r6+tmpseed4r(8));
    
            opt1.d1=abs(opt1.d1+0.01*tmpseed4k(1));
            opt1.k1=abs(opt1.k1+0.5*tmpseed4k(2));
            opt1.k2=abs(opt1.k2+0.5*tmpseed4k(3));
            opt1.k3=abs(opt1.k3+tmpseed4k(4));
            opt1.d2=abs(opt1.d2+0.01*tmpseed4k(5));
            opt1.k4=abs(opt1.k4+0.5*tmpseed4k(6));
            opt1.k5=abs(opt1.k5+0.5*tmpseed4k(7));
            opt1.k6=abs(opt1.k6+tmpseed4k(8));
    
            [tmpsp]=makesl(F_func,opt1);
            tmpspall{jseed}=tmpsp;
        end
        spall(jpoint,:)=tmpspall;
    end
    save(['sample',num2str(ipoint),'.mat'],"spall")
end