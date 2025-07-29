load('dgreall.mat')
index=find(reall>0);
num=sum(reall);
spall=cell(1,num);
for iseed=1:num
    load(['dgseesaw',num2str(index(iseed)),'.mat'])
    spall(iseed)={sp};
end
save(['dgspall','seesaw','.mat'],"spall")
