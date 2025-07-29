maxlength=1000;
for i=[1 10 100]
    load(['paraset',num2str(i),'.mat'])
    newlength=min(maxlength,tmp);%the paraset may not be too long
    for j=1:11
        newpara(j,1:newlength(j))=paraset(j,1:newlength(j));
    end    
    oldtmp=newlength;
    load(['symparaset',num2str(i),'.mat'])
    newlength=min(maxlength,tmp);
    for j=1:11
        newpara(j,oldtmp(j)+1:oldtmp(j)+newlength(j))=paraset(j,1:newlength(j));
    end
    alllength=newlength+oldtmp;
    save(['paraset',num2str(i),'all.mat'],'newpara','alllength')
end
