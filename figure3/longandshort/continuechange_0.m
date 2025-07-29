repeat=0;
load("opt21.mat");
%load("jiluini1w.mat")
T=0.02;dt=0.1;
sqrtdt=sqrt(dt);
relaxstep=1000;
relaxstep1=500;
inirelaxstep=100;
maxrleaxstep=2000;
n=2;
pararange=0.1;
pararange1=0.5;
factor=1.1;
maxseed=1000;
jiluini=0.3*abs(randn(2,maxseed));
save("jiluini4trace.mat","jiluini")
%% nfcs
jilufinal=[];
for seed=1:maxseed
    rng("shuffle");
    xn=jiluini(:,seed);
    opt1=opt;
    opt1.r1=0.9;
    opt1.r4=0.9;
    opt1.ux=0;
    opt1.uy=0;
    fid1=fopen(['repeat_',num2str(repeat),'ntrace_T_',num2str(T),'relsetp_',num2str(relaxstep),'_seed_',num2str(seed),'.txt'],'wt');
    %inirelax
    for i=1:inirelaxstep
        Fgo=parforodefunall(xn,opt1);
        Frand=T*randn(n,1);
        xn=xn+dt*Fgo+sqrtdt*Frand;
        %store
        xs=reshape(xn,1,[]);
        if mod(i,100)==0
            fprintf(fid1,'%f ',xs);
            fprintf(fid1,'\n');
        end
    end  
    %change rxry
    for i=1:relaxstep
        opt1.r0x=opt1.r0x+factor*pararange/relaxstep;
        opt1.r0y=opt1.r0y+pararange/relaxstep;
        Fgo=parforodefunall(xn,opt1);
        Frand=T*randn(n,1);
        xn=xn+dt*Fgo+sqrtdt*Frand;
        %store
        xs=reshape(xn,1,[]);
        if mod(i,100)==0
            fprintf(fid1,'%f ',xs);
            fprintf(fid1,'\n');
        end
    end
    %change r1r4
    for i=1:relaxstep1
        opt1.r1=opt1.r1+factor*pararange1/relaxstep1;
        opt1.r4=opt1.r4+pararange1/relaxstep1;
        Fgo=parforodefunall(xn,opt1);
        Frand=T*randn(n,1);
        xn=xn+dt*Fgo+sqrtdt*Frand;
        %store
        xs=reshape(xn,1,[]);
        if mod(i,100)==0
            fprintf(fid1,'%f ',xs);
            fprintf(fid1,'\n');
        end
    end
    %relax
    remainrelax=maxrleaxstep-inirelaxstep-relaxstep1-relaxstep;
    for i=1:remainrelax
        Fgo=parforodefunall(xn,opt1);
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
save(['repeat_',num2str(repeat),'nfcsjilu.mat'],"jilufinal")

%% fcs1
jilufinal=[];
for seed=1:maxseed
    rng("shuffle");
    xn=jiluini(:,seed);
    opt1=opt;
    opt1.r1=0.9;
    opt1.r4=0.9;
    opt1.ux=0;
    opt1.uy=0;
    fid1=fopen(['repeat_',num2str(repeat),'f1trace_T_',num2str(T),'relsetp_',num2str(relaxstep),'_seed_',num2str(seed),'.txt'],'wt');
    %inirelax
    for i=1:inirelaxstep
        Fgo=parforodefunall(xn,opt1);
        Frand=T*randn(n,1);
        xn=xn+dt*Fgo+sqrtdt*Frand;
        %store
        xs=reshape(xn,1,[]);
        if mod(i,100)==0
            fprintf(fid1,'%f ',xs);
            fprintf(fid1,'\n');
        end
    end

    for i=1:relaxstep1
        opt1.r1=opt1.r1+factor*pararange1/relaxstep1;
        opt1.r4=opt1.r4+pararange1/relaxstep1;
        Fgo=parforodefunall(xn,opt1);
        Frand=T*randn(n,1);
        xn=xn+dt*Fgo+sqrtdt*Frand;
        %store
        xs=reshape(xn,1,[]);
        if mod(i,100)==0
            fprintf(fid1,'%f ',xs);
            fprintf(fid1,'\n');
        end
    end

    for i=1:relaxstep
        opt1.r0x=opt1.r0x+factor*pararange/relaxstep;
        opt1.r0y=opt1.r0y+pararange/relaxstep;
        Fgo=parforodefunall(xn,opt1);
        Frand=T*randn(n,1);
        xn=xn+dt*Fgo+sqrtdt*Frand;
        %store
        xs=reshape(xn,1,[]);
        if mod(i,100)==0
            fprintf(fid1,'%f ',xs);
            fprintf(fid1,'\n');
        end
    end

    %relax
    remainrelax=maxrleaxstep-inirelaxstep-relaxstep1-relaxstep;
    for i=1:remainrelax
        Fgo=parforodefunall(xn,opt1);
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
save(['repeat_',num2str(repeat),'fcs1jilu.mat'],"jilufinal")

%% djilu
jilufinal=[];
for seed=1:maxseed
    rng("shuffle");
    xn=jiluini(:,seed);
    opt1=opt;
    opt1.r1=0.9+factor*pararange1;
    opt1.r4=0.9+pararange1;
    opt1.ux=0;
    opt1.uy=0;
    opt1.r0x=opt1.r0x+factor*pararange;
    opt1.r0y=opt1.r0y+pararange;
    fid1=fopen(['repeat_',num2str(repeat),'dtrace_T_',num2str(T),'relsetp_',num2str(relaxstep),'_seed_',num2str(seed),'.txt'],'wt');
    %inirelax
    for i=1:inirelaxstep
        Fgo=parforodefunall(xn,opt1);
        Frand=T*randn(n,1);
        xn=xn+dt*Fgo+sqrtdt*Frand;
        %store
        xs=reshape(xn,1,[]);
        if mod(i,100)==0
            fprintf(fid1,'%f ',xs);
            fprintf(fid1,'\n');
        end
    end
    % relax
    for i=1:(maxrleaxstep-inirelaxstep)
        Fgo=parforodefunall(xn,opt1);
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
save(['repeat_',num2str(repeat),'djilu.mat'],"jilufinal")


