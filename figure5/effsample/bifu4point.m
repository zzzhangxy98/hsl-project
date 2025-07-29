function bifu4point(opt,seed1,seed2)
%bifurcation for seesaw
F_func=@seesaw;
testrange=-1:0.02:1;
indexmat=zeros(8,length(testrange));

for j=1:length(testrange)
    opt1=opt;
    opt1.c0=opt1.c0+testrange(j);
    if opt1.c0<0 || opt1.c0>1
        continue
    end
    [sp,downjilu]=makesl(F_func,opt1);
    [index,~,~,~]=judgesl(sp,downjilu);
    indexmat(1,j)=index;
end
for j=1:length(testrange)
    opt1=opt;
    opt1.cs=opt1.cs+testrange(j);
    if opt1.cs<0 || opt1.cs>1
        continue
    end
    [sp,downjilu]=makesl(F_func,opt1);
    [index,~,~,~]=judgesl(sp,downjilu);
    indexmat(2,j)=index;
end
for j=1:length(testrange)
    opt1=opt;
    opt1.cm=opt1.cm+testrange(j);
    if opt1.cm<0 || opt1.cm>1
        continue
    end
    [sp,downjilu]=makesl(F_func,opt1);
    [index,~,~,~]=judgesl(sp,downjilu);
    indexmat(3,j)=index;
end
for j=1:length(testrange)
    opt1=opt;
    opt1.ce=opt1.ce+testrange(j);
    if opt1.ce<0 || opt1.ce>1
        continue
    end
    [sp,downjilu]=makesl(F_func,opt1);
    [index,~,~,~]=judgesl(sp,downjilu);
    indexmat(4,j)=index;
end
for j=1:length(testrange)
    opt1=opt;
    opt1.i0=opt1.i0+testrange(j);
    if opt1.i0<0 || opt1.i0>1
        continue
    end
    [sp,downjilu]=makesl(F_func,opt1);
    [index,~,~,~]=judgesl(sp,downjilu);
    indexmat(5,j)=index;
end
for j=1:length(testrange)
    opt1=opt;
    opt1.is=opt1.is+testrange(j);
    if opt1.is<0 || opt1.is>1
        continue
    end
    [sp,downjilu]=makesl(F_func,opt1);
    [index,~,~,~]=judgesl(sp,downjilu);
    indexmat(6,j)=index;
end
for j=1:length(testrange)
    opt1=opt;
    opt1.im=opt1.im+testrange(j);
    if opt1.im<0 || opt1.im>1
        continue
    end
    [sp,downjilu]=makesl(F_func,opt1);
    [index,~,~,~]=judgesl(sp,downjilu);
    indexmat(7,j)=index;
end
for j=1:length(testrange)
    opt1=opt;
    opt1.ie=opt1.ie+testrange(j);
    if opt1.ie<0 || opt1.ie>1
        continue
    end
    [sp,downjilu]=makesl(F_func,opt1);
    [index,~,~,~]=judgesl(sp,downjilu);
    indexmat(8,j)=index;
end

save(['indexmat_',num2str(seed1),'_',num2str(seed2),'.mat'],"indexmat")
end


