load('dgreall.mat')
index=find(reall>0);
num=sum(reall);
Gall=cell(1,num);
for iseed=1:num
    load(['dgseesaw',num2str(index(iseed)),'.mat'])
    Gall(iseed)={G};
end
save(['dgGall','seesaw','.mat'],"Gall")
