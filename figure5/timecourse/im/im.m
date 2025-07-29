load('optseesaw.mat')
F_func=@seesaw;
load("jiluini.mat")
T=0.05;dt=0.1;
sqrtdt=sqrt(dt);
parapieces=20;
relaxstep=5000;
maxrleaxstep=50000;
n=4;
pararange=0.3;
maxseed=1000;

%8-6
jilufinal=[];
jilumid1=[];
for seed=1:maxseed
    rng("shuffle");
    xn=jiluini(:,seed);
    opt1=opt;
    opt1.c0=0;
    opt1.ce=0;
    opt1.cm=0;
    opt1.cs=0;
    opt1.i0=1;
    opt1.ie=1;
    opt1.im=1;
    opt1.is=1;
    fid1=fopen(['im_s_seed_',num2str(seed),'.txt'],'wt');
    jilutmp=[];
    for j=1:parapieces
        opt1.im=opt1.im-pararange/(parapieces);
        for i=1:relaxstep
            Fgo=F_func(xn,opt1);
            Frand=T*randn(n,1);
            xn=xn+dt*Fgo+sqrtdt*Frand;
            %store
            xs=reshape(xn,1,[]);
            if mod(i,100)==0
                fprintf(fid1,'%f ',xs);
                fprintf(fid1,'\n');
            end
        end
        jilutmp=[jilutmp;xs'];  
    end
    jilumid1=[jilumid1 jilutmp];
%% relax
    for i=1:maxrleaxstep
        Fgo=F_func(xn,opt1);
        Frand=T*randn(n,1);
        xn=xn+dt*Fgo+sqrtdt*Frand;
        %store
        xs=reshape(xn,1,[]);
        if mod(i,100)==0
            fprintf(fid1,'%f ',xs);
            fprintf(fid1,'\n');
        end
    end
    jilufinal=[jilufinal xs'];
    fclose(fid1);
end
save('imsjilu.mat',"jilufinal","jilumid1")
fjiluall=[jilumid1;jilufinal];
% timeall=length(jiluall(:,1));
% cv=zeros(timeall,1);
% for timepoint=1:timeall
%     cv(timepoint)=std(jiluall(timepoint,:))/mean(jiluall(timepoint,:));
% end
% plot(cv(1:2:timeall))
% plot(cv(2:2:timeall))
% legend('cv x a','cv y a','cv x p','cv y p','Location','northwest')
% figure()
% hold on
% for i=1:length(jiluini(1,:))
%     tmppair=[jiluini(:,i) jilufinal(:,i)];
%     plot(tmppair(1,:),tmppair(2,:),'-o')
% end
% plot([0 1],[0 1],'r')
% hold off
% title('fcs2')

jilufinal=[];
for seed=1:maxseed
    rng("shuffle");
    xn=jiluini(:,seed);
    opt1=opt;
    opt1.c0=0;
    opt1.ce=0;
    opt1.cm=0;
    opt1.cs=0;
    opt1.i0=1;
    opt1.ie=1;
    opt1.im=1-pararange;
    opt1.is=1;
    fid1=fopen(['im_d_seed_',num2str(seed),'.txt'],'wt');
%% relax
    for i=1:maxrleaxstep
        Fgo=F_func(xn,opt1);
        Frand=T*randn(n,1);
        xn=xn+dt*Fgo+sqrtdt*Frand;
        %store
        xs=reshape(xn,1,[]);
        if mod(i,100)==0
            fprintf(fid1,'%f ',xs);
            fprintf(fid1,'\n');
        end
    end
    jilufinal=[jilufinal xs'];
    fclose(fid1);


end
save('imdjilu.mat',"jilufinal")
% find(jilufinal(1,:)<1)
% saveas(gcf,['fcstrace_T_',num2str(T),'.png'])
% figure()
% hold on
% for i=1:length(jiluini(1,:))
%     tmppair=[jiluini(:,i) jilufinal(:,i)];
%     plot(tmppair(1,:),tmppair(2,:),'-o')
% end
% plot([0 1],[0 1],'r')
% hold off
% title('directly')

%% plot
%     a=load(['trace_ini_s_seed_',num2str(seed),'.txt']);
%     hold on
%     plot(a(:,1),a(:,2))
%     plot([0 1],[0 1],'r')
