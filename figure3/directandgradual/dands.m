maxrepeat=1000;
sxnum=zeros(1,maxrepeat);
dxnum=zeros(1,maxrepeat);
load("opt21.mat");
% load("jiluini1w.mat")
rng("shuffle");
T=0.02;dt=0.1;
sqrtdt=sqrt(dt);
relaxstep=1000;
maxrleaxstep=2000;
n=2;
pararange=0.1;
factor=1.1;
maxseed=1000;
opt.ux=0;
opt.uy=0;
jiluini=0.3*abs(randn(2,maxseed));
for repeat=1:maxrepeat
    %% xtrace
    jilufinal=[];
    for seed=1:maxseed
        
        xn=jiluini(:,seed);
        opt1=opt;
    %     fid1=fopen(['strace_T_',num2str(T),'_seed_',num2str(seed),'.txt'],'wt');
        %change para
        for i=1:relaxstep
            opt1.r0x=opt1.r0x+factor*pararange/relaxstep;
            opt1.r0y=opt1.r0y+pararange/relaxstep;
            Fgo=parforodefunall(xn,opt1);
            Frand=T*randn(n,1);
            xn=xn+dt*Fgo+sqrtdt*Frand;
            %store
    %         xs=reshape(xn,1,[]);
    %         if mod(i,100)==0
    %             fprintf(fid1,'%f ',xs);
    %             fprintf(fid1,'\n');
    %         end
        end
        %relax
        remainrelax=maxrleaxstep-2*relaxstep;
        for i=1:remainrelax
            Fgo=parforodefunall(xn,opt1);
            Frand=T*randn(n,1);
            xn=xn+dt*Fgo+sqrtdt*Frand;
            %store
    %         xs=reshape(xn,1,[]);
    %         if mod(i,100)==0
    %             fprintf(fid1,'%f ',xs);
    %             fprintf(fid1,'\n');
    %         end
        end
        jilufinal=[jilufinal xn];
    %     fclose(fid1);
    end
    % save('sjilu.mat',"jilufinal")
    %anal
    deltatrace=jilufinal(1,:)-jilufinal(2,:);
    indextrace=deltatrace>0;
    sxnum(repeat)=sum(indextrace);
    %% djilu
    jilufinal=[];
    for seed=1:maxseed
%         rng("shuffle");
        xn=jiluini(:,seed);
        opt1=opt;
        opt1.r0x=opt1.r0x+factor*pararange;
        opt1.r0y=opt1.r0y+pararange;
    %     fid1=fopen(['dtrace_T_',num2str(T),'_seed_',num2str(seed),'.txt'],'wt');
        % relax
        for i=1:maxrleaxstep
            Fgo=parforodefunall(xn,opt1);
            Frand=T*randn(n,1);
            xn=xn+dt*Fgo+sqrtdt*Frand;
            %store
    %         xs=reshape(xn,1,[]);
    %         if mod(i,100)==0
    %             fprintf(fid1,'%f ',xs);
    %             fprintf(fid1,'\n');
    %         end
        end
        jilufinal=[jilufinal xn];
    %     fclose(fid1);
    end
    % save('djilu.mat',"jilufinal")
    %anal
    deltatrace=jilufinal(1,:)-jilufinal(2,:);
    indextrace=deltatrace>0;
    dxnum(repeat)=sum(indextrace);
end
save("dands.mat","dxnum","sxnum")
