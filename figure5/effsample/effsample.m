%enhanced sample for the SLs whose num <100
parpool("Processes",10)
F_func=@seesaw;
samplenum=100;
load("paraset.mat")
num4paraset=tmp;
for ipoint=1:6   
    jrange=min(100,num4paraset(ipoint)-1);
    for jpoint=1:jrange
        opt=paraset{ipoint,jpoint};
        seed=0.01*randn(8,samplenum);
%         spall=cell(1,samplenum);
        indexall=cell(1,samplenum);
        optall=cell(1,samplenum);
        parfor jseed=1:samplenum
            opt1=opt;
            tmpseed=seed(:,jseed);
            opt1.c0=max(1,abs(opt1.c0+tmpseed(1)));%the para range is [0,1]
            opt1.cs=max(1,abs(opt1.cs+tmpseed(2)));
            opt1.ie=max(1,abs(opt1.ie+tmpseed(3)));
            opt1.ie=max(1,abs(opt1.ie+tmpseed(4)));
            opt1.ie=max(1,abs(opt1.ie+tmpseed(5)));
            opt1.ie=max(1,abs(opt1.ie+tmpseed(6)));
            opt1.ie=max(1,abs(opt1.ie+tmpseed(7)));
            opt1.ie=max(1,abs(opt1.ie+tmpseed(8)));
            [sp,downjilu]=makesl(F_func,opt1);
%             spall{jseed}=sp;
            optall{jseed}=opt1;
            if ~isempty(sp{1})
                [index,~,~,~]=judgesl(sp,downjilu);
            else
                index=0;
            end
            indexall{jseed}=index;
        end
        %renew paraset and tmp
        for ii=1:length(indexall)
            ind=indexall{ii};
            if ind==7 || ind==8 || ind==9
                paraset(ind-3,tmp(ind-3))=optall(ii);
                tmp(ind-3)=tmp(ind-3)+1;
            end
        end
        save(['sample_',num2str(ipoint),'_',num2str(jpoint),'.mat'],"indexall",'optall')
    end
end
save('eff_paraset.mat',"paraset","tmp")
