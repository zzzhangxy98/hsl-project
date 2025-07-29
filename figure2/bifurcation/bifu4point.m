function bifu4point(opt,seed1,seed2)
F_func=@parforodefunall;
testrangek=[0.0001,0.001,0.01,0.1,0.5,0.9,0.95,0.99,0.995,0.999,1,1.001,1.005,1.01,1.05,1.1,1.5,2,2.5,5,10];%*
% testranger=-1.2:0.06:1.2;%+
testranger=testrangek;
indexmatk=zeros(8,length(testrangek));
indexmatr=zeros(8,length(testranger));
% pararange=['k1';'k2';'k3';'k4';'k5';'k6';'r0x';'r0y';
%     'r1';'r2';'r3';'r4';'r5';'r6';'d1';'d2';];

%r
for j=1:length(testranger)
    opt1=opt;
    opt1.r0x=opt1.r0x*testranger(j);
    
    [sp]=makesl(F_func,opt1);
    [index,~,~,~]=judgesl(sp);
    indexmatr(1,j)=index;
end
for j=1:length(testranger)
    opt1=opt;
    opt1.r1=opt1.r1*testranger(j);
    
    [sp]=makesl(F_func,opt1);
    [index,~,~,~]=judgesl(sp);
    indexmatr(2,j)=index;
end
for j=1:length(testranger)
    opt1=opt;
    opt1.r2=opt1.r2*testranger(j);
    
    [sp]=makesl(F_func,opt1);
    [index,~,~,~]=judgesl(sp);
    indexmatr(3,j)=index;
end
for j=1:length(testranger)
    opt1=opt;
    opt1.r3=opt1.r3*testranger(j);
    
    [sp]=makesl(F_func,opt1);
    [index,~,~,~]=judgesl(sp);
    indexmatr(4,j)=index;
end
for j=1:length(testranger)
    opt1=opt;
    opt1.r0y=opt1.r0y*testranger(j);
    
    [sp]=makesl(F_func,opt1);
    [index,~,~,~]=judgesl(sp);
    indexmatr(5,j)=index;
end
for j=1:length(testranger)
    opt1=opt;
    opt1.r4=opt1.r4*testranger(j);
    
    [sp]=makesl(F_func,opt1);
    [index,~,~,~]=judgesl(sp);
    indexmatr(6,j)=index;
end
for j=1:length(testranger)
    opt1=opt;
    opt1.r5=opt1.r5*testranger(j);
    
    [sp]=makesl(F_func,opt1);
    [index,~,~,~]=judgesl(sp);
    indexmatr(7,j)=index;
end
for j=1:length(testranger)
    opt1=opt;
    opt1.r6=opt1.r6*testranger(j);
    
    [sp]=makesl(F_func,opt1);
    [index,~,~,~]=judgesl(sp);
    indexmatr(8,j)=index;
end
%k
for j=1:length(testrangek)
    opt1=opt;
    opt1.k1=opt1.k1*testrangek(j);
    [sp]=makesl(F_func,opt1);
    [index,~,~,~]=judgesl(sp);
    indexmatk(1,j)=index;
end
for j=1:length(testrangek)
    opt1=opt;
    opt1.k2=opt1.k2*testrangek(j);
    [sp]=makesl(F_func,opt1);
    [index,~,~,~]=judgesl(sp);
    indexmatk(2,j)=index;
end
for j=1:length(testrangek)
    opt1=opt;
    opt1.k3=opt1.k3*testrangek(j);
    [sp]=makesl(F_func,opt1);
    [index,~,~,~]=judgesl(sp);
    indexmatk(3,j)=index;
end
for j=1:length(testrangek)
    opt1=opt;
    opt1.k4=opt1.k4*testrangek(j);
    [sp]=makesl(F_func,opt1);
    [index,~,~,~]=judgesl(sp);
    indexmatk(4,j)=index;
end
for j=1:length(testrangek)
    opt1=opt;
    opt1.k5=opt1.k5*testrangek(j);
    [sp]=makesl(F_func,opt1);
    [index,~,~,~]=judgesl(sp);
    indexmatk(5,j)=index;
end
for j=1:length(testrangek)
    opt1=opt;
    opt1.k6=opt1.k6*testrangek(j);
    [sp]=makesl(F_func,opt1);
    [index,~,~,~]=judgesl(sp);
    indexmatk(6,j)=index;
end
for j=1:length(testrangek)
    opt1=opt;
    opt1.d1=opt1.d1*testrangek(j);
    [sp]=makesl(F_func,opt1);
    [index,~,~,~]=judgesl(sp);
    indexmatk(7,j)=index;
end
for j=1:length(testrangek)
    opt1=opt;
    opt1.d2=opt1.d2*testrangek(j);
    [sp]=makesl(F_func,opt1);
    [index,~,~,~]=judgesl(sp);
    indexmatk(8,j)=index;
end
save(['indexmat_',num2str(seed1),'_',num2str(seed2),'.mat'],"indexmatr","indexmatk")
end


