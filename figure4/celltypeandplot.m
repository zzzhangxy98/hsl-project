%% initialization 
load('opt23.mat')
opt.ux=0;opt.uy=0;
F_func=@parforodefunall;
%% cell type for accuracy trace
load('ajiluall4plot.mat')
load('aattrpos_inidelta_0.mat')
recall=[];%test the number of attractors
for i=1:length(attrpos)
    tmp=attrpos{i};
    newattrpos=zeros(2,3)+NaN;% rearange the attrpos to the sequence:LX S2 LY 
    tmpdel=tmp(1,:)-tmp(2,:);
    testrec=0;
    for j=1:length(tmpdel)
        if tmpdel(j)>0.8
            newattrpos(:,1)=tmp(:,j);
            testrec=testrec+1;
        elseif tmpdel(j)<-0.8
            newattrpos(:,3)=tmp(:,j);
            testrec=testrec+1;
        else
            newattrpos(:,2)=tmp(:,j);
            testrec=testrec+1;
        end
    end
    recall=[recall testrec];
    attrpos{i}=newattrpos;
end


%% judge cell type by relaxing
numall=zeros(3,length(jiluall(1,:)));%num of "LX S2 LY" in all the traces
tmax=100;
for i=1:length(jiluall)/2
    tmptrace=jiluall(2*i-1:2*i,:);
    num4trace=zeros(3,length(tmptrace(1,:)));%num of "LX S2 LY" in tmptrace
    for j=1:length(tmptrace(1,:))
        opt1=opt;
        tmppos=tmptrace(:,j);
        if j<=100 %initial relaxstep
            refpos=attrpos{1};
        elseif j>100 && j<=500 %change parameters
            tmpind=ceil((j-100)/10)+1;
            refpos=attrpos{tmpind};
            opt1.r0x=opt.r0x+0.05*(tmpind-1);
        elseif j>500 %final relax
            opt1.r0x=opt.r0x+2;
            refpos=attrpos{41};
        end
        [~,xtmp] = ode45(@(t,x) F_func(x,opt1), [0 tmax], tmppos);
        relaxedpos=xtmp(end,:);
        [LIA,LOC]=ismembertol(relaxedpos,refpos',0.01,'ByRows',true,'DataScale',1);
        if LIA
            num4trace(LOC,j)=num4trace(LOC,j)+1;
        end
    end
    numall=numall+num4trace;
end
aundefnum=1000-sum(numall);%the number of undefined cells
save('anum4plot.mat',"aundefnum","numall")


%% plot
% load('anum4plot.mat')
% figure()
% colorlist=[31 101 173;94 171 136;118 61 138]/255;%x s y
% hold on 
% a=plot(numall(2,:)/1000,'LineStyle','-','LineWidth',2,'Color',colorlist(2,:));
% a=plot(numall(3,:)/1000,'LineStyle','-','LineWidth',2,'Color',colorlist(3,:));
% a=plot(numall(1,:)/1000,'LineStyle','-','LineWidth',2,'Color',colorlist(1,:));
% xlim([00 300])
% legend('stem cell','Lineage Y','Lineage X')
% xlabel('Time(A.U.)')
% ylabel('Percentage')
% set(gca,fontsize=18,fontname='Times New Roman')
% hold off

%% find critical time point
% [x,y]=find(num4s<0.1,1);
% plot(x,y,'k',MarkerSize=10)
% [x,y]=find(num4lx<0.9,1);
% plot(x,y,'k',MarkerSize=10)
% [maxy,indexy]=max(num4ly);
% newnum4ly=num4ly(indexy:length(num4ly));
% [x,y]=find(newnum4ly<0.1*max(num4ly),1);


%% cell type for progression trace
load('pjiluall4plot.mat')
load('pattrpos_inidelta_0.mat')
% attrpos_beifen=attrpos;
recall=[];%test the number of attractors
for i=1:length(attrpos)
    tmp=attrpos{i};
    newattrpos=zeros(2,3)+NaN;% rearange the attrpos to the sequence:LX S2 LY 
    tmpdel=tmp(1,:)-tmp(2,:);
    testrec=0;
    for j=1:length(tmpdel)
        if tmpdel(j)>0.8
            newattrpos(:,1)=tmp(:,j);
            testrec=testrec+1;
        elseif tmpdel(j)<-0.8
            newattrpos(:,3)=tmp(:,j);
            testrec=testrec+1;
        else
            newattrpos(:,2)=tmp(:,j);
            testrec=testrec+1;
        end
    end
    recall=[recall testrec];
    attrpos{i}=newattrpos;
end

%% judge cell type by relaxing
numall=zeros(3,length(jiluall(1,:)));%num of "LX S2 LY" in all the traces
tmax=100;
for i=1:length(jiluall)/2
    tmptrace=jiluall(2*i-1:2*i,:);
    num4trace=zeros(3,length(tmptrace(1,:)));%num of "LX S2 LY" in tmptrace
    for j=1:length(tmptrace(1,:))
        opt1=opt;
        tmppos=tmptrace(:,j);
        if j<=100 %initial relaxstep
            refpos=attrpos{1};
        elseif j>100 && j<=500 %change parameters
            tmpind=ceil((j-100)/10)+1;
            refpos=attrpos{tmpind};
            opt1.r1=opt.r1+0.05*(tmpind-1);
        elseif j>500 %final relax
            opt1.r1=opt.r1+2;
            refpos=attrpos{41};
        end
        [~,xtmp] = ode45(@(t,x) F_func(x,opt1), [0 tmax], tmppos);
        relaxedpos=xtmp(end,:);
        [LIA,LOC]=ismembertol(relaxedpos,refpos',0.01,'ByRows',true,'DataScale',1);
        if LIA
            num4trace(LOC,j)=num4trace(LOC,j)+1;
        end
    end
    numall=numall+num4trace;
end
pundefnum=1000-sum(numall);%the number of undefined cells
save('pnum4plot.mat',"pundefnum","numall")

%% plot
% load('pnum4plot.mat')
% figure()
% colorlist=[31 101 173;94 171 136;118 61 138]/255;%x s y
% hold on 
% a=plot(numall(2,:)/1000,'LineStyle','-','LineWidth',2,'Color',colorlist(2,:));
% a=plot(numall(3,:)/1000,'LineStyle','-','LineWidth',2,'Color',colorlist(3,:));
% a=plot(numall(1,:)/1000,'LineStyle','-','LineWidth',2,'Color',colorlist(1,:));
% % xlim([00 300])
% legend('stem cell','Lineage Y','Lineage X')
% xlabel('Time(A.U.)')
% ylabel('Percentage')
% set(gca,fontsize=18,fontname='Times New Roman')
% hold off

%% find critical time point
% [x,y]=find(num4s<0.1,1);
% plot(x,y,'k',MarkerSize=10)
% [x,y]=find(num4lx<0.9,1);
% plot(x,y,'k',MarkerSize=10)
% [maxy,indexy]=max(num4ly);
% newnum4ly=num4ly(indexy:length(num4ly));
% [x,y]=find(newnum4ly<0.1*max(num4ly),1);

%% undefined cells
% figure()
% hold on
% plot(100*aundefnum/1000,'LineWidth',1.5)
% plot(100*pundefnum/1000,'LineWidth',1.5)
% 
% legend('accuracy','progression')
% title('undefined cells')
% xlabel('Time(A.U.)')
% ylabel('Percentage (%)')
% set(gca,fontsize=18,fontname='Times New Roman')
% hold off
