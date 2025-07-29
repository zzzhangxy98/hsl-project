load("opt23.mat");
load('jiluini4pa.mat')
dt=0.1;
sqrtdt=sqrt(dt);
parapieces=40;
relaxstep=1000;
maxrleaxstep=10000;
n=2;
pararange=2.0;
maxseed=1000;
opt0=opt;

for T=0.06:0.01:0.1
    for inidelta=-0.05:0.025:0.05
        opt.r1=opt0.r1+inidelta;
        opt.r4=opt0.r4+inidelta;
	opt.r0x=opt0.r0x+inidelta;
	opt.r0y=opt0.r0y+inidelta;
        %a
        jilufinal=[];
        % jiluini=[];
        jilumid1=[];
        % jilumid2=[];
        jilurelax=[];
        for seed=1:maxseed
            rng("shuffle");
        %     xn=abs(0.1*randn(2,1)+[1.14051962548869;1.14051949382408]);
        %     jiluini=[jiluini xn];
            xn=jiluini(:,seed);
            opt1=opt;
            opt1.ux=0;
            opt1.uy=0;
            fid1=fopen(['atrace_T_',num2str(T),'inidelta_',num2str(inidelta),'_seed_',num2str(seed),'.txt'],'wt');
            jilutmp=[];
            for i=1:maxrleaxstep
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
            jilurelax=[jilurelax xs'];

            for j=1:parapieces
                opt1.r0x=opt1.r0x+pararange/parapieces;
        %         opt1.r0y=opt1.r0y+pararange/parapieces;
        %         opt1.r1=opt1.r1+pararange/parapieces;
        %         opt1.r4=opt1.r4-pararange/parapieces;
                for i=1:relaxstep
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
                jilutmp=[jilutmp;xs'];  
            end
            jilumid1=[jilumid1 jilutmp];
            
            for i=1:maxrleaxstep
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
        save(['ajilu_',num2str(T),'_',num2str(inidelta),'.mat'],"jilufinal","jilumid1","jilurelax")

        
        %p
        jilufinal=[];
        % jiluini=[];
        jilumid1=[];
        % jilumid2=[];
        jilurelax=[];
        for seed=1:maxseed
            rng("shuffle");
        %     xn=abs(0.1*randn(2,1)+[1.14051962548869;1.14051949382408]);
        %     jiluini=[jiluini xn];
            xn=jiluini(:,seed);
            opt1=opt;
            opt1.ux=0;
            opt1.uy=0;
            fid1=fopen(['ptrace_T_',num2str(T),'inidelata_',num2str(inidelta),'_seed_',num2str(seed),'.txt'],'wt');
            for i=1:maxrleaxstep
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
            jilurelax=[jilurelax xs'];

            jilutmp=[];
            for j=1:parapieces
        %         opt1.r0x=opt1.r0x+pararange/parapieces;
        %         opt1.r0y=opt1.r0y+pararange/parapieces;
                opt1.r1=opt1.r1+pararange/parapieces;
        %         opt1.r4=opt1.r4-pararange/parapieces;
                for i=1:relaxstep
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
                jilutmp=[jilutmp;xs'];  
            end
            jilumid1=[jilumid1 jilutmp];
        
            for i=1:maxrleaxstep
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
        save(['pjilu_',num2str(T),'_',num2str(inidelta),'.mat'],"jilufinal","jilumid1","jilurelax")
        
    end
end
