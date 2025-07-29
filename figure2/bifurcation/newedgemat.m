edgematrix=zeros(99);
% paratable=zeros(0,3,8);
unfind=0;
unjust=0;
posall=cell(1,16);
% pointrange=[11;12;13;14;15;21;22;23;31;32;41];
%k paraset
for ipoint1=1:11
    for ipoint2=1:100
        try 
            load(['indexmat_',num2str(ipoint1),'_',num2str(ipoint2),'.mat'])
        catch
            continue
        end
        indexmatk(indexmatk==0)=99;
        indexmatr(indexmatr==0)=99;
        for i=1:length(indexmatk(:,1))
            lenbifu=length(indexmatk(1,:));
            unfind=unfind+sum(indexmatk(i,:)==99);
            unjust=unjust+sum(indexmatk(i,:)>=90);
            
            pospair=[indexmatk(i,1:lenbifu-1);indexmatk(i,2:lenbifu)];
            deltapos=pospair(1,:)-pospair(2,:);
            pospair(:,deltapos==0)=[];

            if ~isempty(pospair)
                finalpos=unique(pospair','rows');
            end
            
            for j=1:length(finalpos(:,1))
                pos1=finalpos(j,1);
                pos2=finalpos(j,2);
                edgematrix(pos1,pos2)=edgematrix(pos1,pos2)+1;
            end   

            posall{i}=[posall{i};finalpos];
        end
        for i=1:length(indexmatr(:,1))
            lenbifu=length(indexmatr(1,:));
            unfind=unfind+sum(indexmatr(i,:)==99);
            unjust=unjust+sum(indexmatr(i,:)>=90);
            
            pospair=[indexmatr(i,1:lenbifu-1);indexmatr(i,2:lenbifu)];
            deltapos=pospair(1,:)-pospair(2,:);
            pospair(:,deltapos==0)=[];

            if ~isempty(pospair)
                finalpos=unique(pospair','rows');
            end
            
            for j=1:length(finalpos(:,1))
                pos1=finalpos(j,1);
                pos2=finalpos(j,2);
                edgematrix(pos1,pos2)=edgematrix(pos1,pos2)+1;
            end   

            posall{i+8}=[posall{i+8};finalpos];
        end
    end
end
% oldposall=posall;
for i=1:length(posall)
    [tmp,ia,ic]=unique(posall{i},'rows');
    acount=accumarray(ic,1);
    posall{i}=[tmp acount];
end
save('newedgematrix.mat','edgematrix')
save("newposall.mat",'posall')
unjust=unjust-unfind
unfind

%% modify edgematrix for plot
% load('edgematrix.mat')
% edgematrix(42:end,:)=[];
% edgematrix(:,42:end)=[];
% edgematrix(33:40,:)=[];
% edgematrix(:,33:40)=[];
% edgematrix(24:30,:)=[];
% edgematrix(:,24:30)=[];
% edgematrix(16:20,:)=[];
% edgematrix(:,16:20)=[];
% edgematrix(5:10,:)=[];
% edgematrix(:,5:10)=[];
% labelstr=cellstr(["1","2","3","4","11","12","13","14","15","21","22","23","31","32","41"]);
% heatmap(labelstr,labelstr,edgematrix)
% % heatmap(edgematrix)
% xlabel('index of solution landscape',FontSize=28,FontName='Times New Roman')
% ylabel('index of solution landscape',FontSize=28,FontName='Times New Roman')
% set(gca,fontsize=13,fontname='Times New Roman')
