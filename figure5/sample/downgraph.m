funcname='seesaw';
reall=zeros(1,100000);
for iseed=1:100000
    try 
        load([funcname,num2str(iseed),'.mat'])
    catch
        continue
    end
    downjilu=unique(downjilu,"rows");
    if ~isempty(downjilu)
        reall(iseed)=1;
    
        stmp=downjilu(:,1:2);
        ttmp=downjilu(:,3:4);
        ll=length(stmp(:,1));
        s=cell(ll,1);
        t=cell(ll,1);
        for i=1:ll
            s{i}=mat2str(stmp(i,:));
            t{i}=mat2str(ttmp(i,:));
        end
        G=digraph(s,t,'omitselfloops');
        save(['dg',funcname,num2str(seed),'.mat'],'G');
    end
end
save('dgreall.mat','reall')
