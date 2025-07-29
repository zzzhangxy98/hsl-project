edgematrix=zeros(9);
% paratable=zeros(0,3,8);
unfound=0;
unjust=0;
posall=cell(1,16);
% pointrange=[11;12;13;14;15;21;22;23;31;32;41];
%k paraset
for ipoint1=1:6
    for ipoint2=1:50
        try 
            load(['indexmat_',num2str(ipoint1),'_',num2str(ipoint2),'.mat'])
        catch
            continue
        end
        indexmat(indexmat==0)=99;
        
        for i=1:length(indexmat(:,1))
            tmpformerposall=[];
            tmpafterposall=[];
            for j=1:length(indexmat(1,:))-1
               formerpos=indexmat(i,j);
               afterpos=indexmat(i,j+1);
               if formerpos==afterpos
                   continue
               elseif formerpos==99 
                   unfound=unfound+1;
                   continue
               elseif afterpos==99
                   continue
               elseif formerpos>=10
                   unjust=unjust+1;
                   continue
               elseif afterpos>=10
                   continue
               else
                   edgematrix(formerpos,afterpos)=edgematrix(formerpos,afterpos)+1;
                   tmpformerposall=[tmpformerposall formerpos];
                   tmpafterposall=[tmpafterposall afterpos];
               end
            end
            posall{i}=[posall{i} [tmpformerposall;tmpafterposall]];
        end
    end
end

for i=1:length(posall)
    [tmp,ia,ic]=unique(posall{i}','rows');
    acount=accumarray(ic,1);
    posall{i}=[tmp acount];
end
save('edgematrix.mat','edgematrix')
save("posall.mat",'posall')
unjust
unfound

%% modify edgematrix for plot
% load('edgematrix.mat')
% edgematrix(33:40,:)=[];
% edgematrix(:,33:40)=[];
% edgematrix(24:30,:)=[];
% edgematrix(:,24:30)=[];
% edgematrix(16:20,:)=[];
% edgematrix(:,16:20)=[];
% edgematrix(5:10,:)=[];
% edgematrix(:,5:10)=[];
% tmp=edgematrix(2,:);
% edgematrix(2,:)=edgematrix(3,:);
% edgematrix(3,:)=edgematrix(4,:);
% edgematrix(4,:)=tmp;
% tmp=edgematrix(:,2);
% edgematrix(:,2)=edgematrix(:,3);
% edgematrix(:,3)=edgematrix(:,4);
% edgematrix(:,4)=tmp;
% labelstr=cellstr(["1","2","3","4","11","12","13","14","15","21","22","23","31","32","41"]);
% heatmap(labelstr,labelstr,edgematrix)
% % xlabel('index of solution landscape',FontSize=28,FontName='Times New Roman')
% % ylabel('index of solution landscape',FontSize=28,FontName='Times New Roman')
% set(gca,fontsize=13,fontname='Times New Roman')
