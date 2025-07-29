function [sp,downjilu]=makesl(F_func,opt)
%%version: 2024.1.8
%change: change hiosd_ng to hiosd_h
% maxmode to eigs(6.14)(changed back on 6.28)
%oed45 to find LM
%use the realpart(delete on 6.28)
%!!!bug in the ismembertol!!!
%jilu format:[khigh;indexhigh;klow;indexlow]
%% inipara
% F_func=@triples2aoo;
% seed=10;
% load('optm.mat')
% opt.seed=seed;

re=0;
kd=opt.n;
x0=rand(kd,1);
% x0=[0;0];
%kd=length(x0);%dimension
sp=cell(kd+1,1);
sp(:)={zeros(kd,0)};
% spv=cell(kd+1,1);
% spv(:)={zeros(kd,0)};
%% inix
k=0;
tmax=2000;
V0=zeros(kd,0);
% V0=maxmode(F_func,x0,k,opt);
% [V0,D]=eigs(@(x) F_func([1;1;2],opt),3,3)
% [perf,info]=HiOSD_H(F_func,x0,V0,k,opt);
options = odeset('RelTol',1e-5);
[~,xtmp] = ode45(@(t,x) F_func(x,opt), [0 tmax], x0,options);
xfinal=xtmp(end,:)';
% xfinal=perf.xfinal;
[ind,~,flag]=cal_index(xfinal,F_func,opt);
if ~flag
    x0=2*rand(kd,1);
%     [perf,info]=HiOSD_H(F_func,x0,V0,k,opt);
    [~,xtmp] = ode45(@(t,x) F_func(x,opt), [0 tmax], x0);
    xfinal=xtmp(end,:)';
    [ind,~,flag]=cal_index(xfinal,F_func,opt);
end
if flag
    sp{ind+1}=[sp{ind+1} xfinal];
end
other=[];

for xunhuan=1:2
%% upsearch
    upjilu=zeros(4:0);
    for k=1:kd
%         if k==2
%             disp(1);
%         end
        if isempty(sp{k}) && flag%find stationary points and have not this index saddle
            continue
        elseif isempty(sp{k}) && ~flag%not find stationary points
            inix=rand(kd,1);
%             inix=[1,1,1];
            Vall=maxmode(F_func,inix,kd,opt);
            sele=nchoosek(1:kd,k);
            for ii=1:nchoosek(kd,k)
                V0=Vall(:,sele(ii,:));
                [perf,info]=HiOSD_H(F_func,inix+0.001*sum(V0,2),V0,k,opt);
                if info.step==opt.max
    %                 disp('not found')
                else
                    [ind,~,flag]=cal_index(perf.xfinal,F_func,opt);
                    if flag
                        sp{ind+1}=[sp{ind+1} perf.xfinal];
                        break
                    end
                end
            end
            
        else%sp is not empty
            for m=1:length(sp{k}(1,:))
                inix=sp{k}(:,m);
                Vall=maxmode(F_func,inix,kd,opt);
%                 [Vall,dtmp]=eigs(@(x) F_func(inix,opt),kd,kd);
                sele=nchoosek(1:kd,k);
                for ii=1:nchoosek(kd,k)
                    V0=Vall(:,sele(ii,:));
                    [perf,info]=HiOSD_H(F_func,inix+0.001*sum(V0,2),V0,k,opt);
                    if info.step==opt.max
        %                 disp('not found')
                    else
                        [ind,~]=cal_index(perf.xfinal,F_func,opt);
                        try
                            [LIA,LOC]=ismembertol(perf.xfinal',sp{ind+1}',0.0001,'ByRows',true,'DataScale',1);
                            if ~LIA
                                sp{ind+1}=[sp{ind+1} perf.xfinal];
            %                     spv{k+1}=[spv{k+1} perf.V];%to do:connection relationship
                                upjilu=[upjilu;[ind length(sp{ind+1}(1,:)) k-1 m]];
                            else
                                upjilu=[upjilu;[ind LOC k-1 m]];
                            end
                        catch
                            other=[other perf.xfinal];
                        end
                    end 
    
                    [perf,info]=HiOSD_H(F_func,inix-0.001*sum(V0,2),V0,k,opt);
                    if info.step==opt.max
        %                 disp('not found')
                    else
                        [ind,~]=cal_index(perf.xfinal,F_func,opt);
                        try
                            [LIA,LOC]=ismembertol(perf.xfinal',sp{ind+1}',0.0001,'ByRows',true,'DataScale',1);
                            if ~LIA
                                sp{ind+1}=[sp{ind+1} perf.xfinal];
            %                     spv{k+1}=[spv{k+1} perf.V];%to do:connection relationship
                                upjilu=[upjilu;[ind length(sp{ind+1}(1,:)) k-1 m]];
                            else
                                upjilu=[upjilu;[ind LOC k-1 m]];
                            end 
                        catch
                            other=[other perf.xfinal];
                        end
                    end 
                end
            end
        end
    end
    %% downsearch
    downjilu=zeros(4:0);
    for k=length(sp):-1:2
        if isempty(sp{k})
            continue
        else
            for m=1:length(sp{k}(1,:))
                inix=sp{k}(:,m);
                Vall=maxmode(F_func,inix,k-1,opt);%recalculate V or use the spv
%                 [Vall,~]=eigs(@(x) F_func(inix,opt),kd,k-1,'largestreal');
    %             sele=nchoosek(1:k-1,k-2);
                for ii=1:k-1
                    V1=Vall(:,ii);%direction to be satble
                    V0=direc(Vall, k-2, ii);%other direction to be unstable

                    [perf,info]=HiOSD_H(F_func,inix+0.001*V1,V0,k-2,opt);
    %                 [perf,info]=HiOSD_H(F_func,sp{k}(:,m)+0.001*spv{k}(:,m),spv{k}(:,m),k-1,opt);
                    if info.step==opt.max
    %                     disp('not found')
                    else
                        [ind,~]=cal_index(perf.xfinal,F_func,opt);
                        try
                            [LIA,LOC]=ismembertol(perf.xfinal',sp{ind+1}',0.0001,'ByRows',true,'DataScale',1);
                            if ~LIA
                                sp{ind+1}=[sp{ind+1} perf.xfinal];
            %                     spv{k+1}=[spv{k+1} perf.V];%to do:connection relationship
                                downjilu=[downjilu;[k-1 m ind length(sp{ind+1}(1,:))]];
                            else
                                downjilu=[downjilu;[k-1 m ind LOC]];
                            end 
                        catch
                            other=[other perf.xfinal];
                        end
                    end 


                    [perf,info]=HiOSD_H(F_func,inix-0.001*V1,V0,k-2,opt);
    %                 [perf,info]=HiOSD_H(F_func,sp{k}(:,m)-0.001*spv{k}(:,m),spv{k}(:,m),k-1,opt);
                    if info.step==opt.max
    %                     disp('not found')
                    else
                        [ind,~]=cal_index(perf.xfinal,F_func,opt);
                        try
                            [LIA,LOC]=ismembertol(perf.xfinal',sp{ind+1}',0.0001,'ByRows',true,'DataScale',1);
                            if ~LIA
                                sp{ind+1}=[sp{ind+1} perf.xfinal];
            %                     spv{k+1}=[spv{k+1} perf.V];%to do:connection relationship
                                downjilu=[downjilu;[k-1 m ind length(sp{ind+1}(1,:))]];
                            else
                                downjilu=[downjilu;[k-1 m ind LOC]];
                            end 
                        catch
                            other=[other perf.xfinal];
                        end
                    end 
                end
            end
        end
    end
end
jiluall=[upjilu;downjilu];
jiluall=unique(jiluall,"rows");

% sp(cellfun(@isempty,sp))=[];

%% plot
if ~isempty(jiluall)
    re=1;

    stmp=jiluall(:,1:2);
    ttmp=jiluall(:,3:4);
    ll=length(stmp(:,1));
    s=cell(ll,1);
    t=cell(ll,1);
    for i=1:ll
        s{i}=mat2str(stmp(i,:));
        t{i}=mat2str(ttmp(i,:));
    end
    G=digraph(s,t,'omitselfloops');
%     plot(G)
%     title("triples2")
end
% save([func2str(F_func),seed,'.mat']);
% save([func2str(F_func),num2str(seed),'.mat']);

%% function
function V = direc(V0, k, i)
if i > k
    V = V0(:, 1:k);
else
    V = V0(:, [1:i - 1, i + 1:k + 1]);
end
end
end
