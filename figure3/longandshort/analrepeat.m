%ananlysis the initial state and the final state
repeatall=50;
dnumlxall=zeros(1,repeatall);
f1numlxall=zeros(1,repeatall);
f1x2yall=zeros(1,repeatall);
f1y2xall=zeros(1,repeatall);
f1diffnumall=zeros(1,repeatall);
f2numlxall=zeros(1,repeatall);
f2x2yall=zeros(1,repeatall);
f2y2xall=zeros(1,repeatall);
f2diffnumall=zeros(1,repeatall);
nfnumlxall=zeros(1,repeatall);
nfx2yall=zeros(1,repeatall);
nfy2xall=zeros(1,repeatall);
nfdiffnumall=zeros(1,repeatall);
for i=1:repeatall
    load(['repeat_',num2str(i-1),'djilu.mat'])
    refpos=jilufinal(1,:)-jilufinal(2,:);
    refpos=refpos>0;%refops>0:LX refpos<0:LY
    dlx=find(refpos>0);
    dnumlxall(i)=length(dlx);
    load(['repeat_',num2str(i-1),'fcs1jilu.mat'])
    fcspos=jilufinal(1,:)-jilufinal(2,:);
    fcspos=fcspos>0;
    dlx=find(fcspos>0);
    f1numlxall(i)=length(dlx);
    diff4fcs=fcspos-refpos;
    fcsx2y=find(diff4fcs>0);
    fcsy2x=find(diff4fcs<0);
    f1x2yall(i)=length(fcsx2y);
    f1y2xall(i)=length(fcsy2x);
    f1diffnumall(i)=length(fcsx2y)+length(fcsy2x);
    
    load(['repeat_',num2str(i-1),'nfcsjilu.mat'])
    nfcspos=jilufinal(1,:)-jilufinal(2,:);
    nfcspos=nfcspos>0;
    dlx=find(nfcspos>0);
    nfnumlxall(i)=length(dlx);
    diff4nfcs=nfcspos-refpos;
    nfcsx2y=find(diff4nfcs>0);
    nfcsy2x=find(diff4nfcs<0);
    nfx2yall(i)=length(nfcsx2y);
    nfy2xall(i)=length(nfcsy2x);
    nfdiffnumall(i)=length(nfcsx2y)+length(nfcsy2x);
end
save('repeat.mat')

lxnum4long=mean(f1numlxall)
lxnum4short=mean(nfnumlxall)
