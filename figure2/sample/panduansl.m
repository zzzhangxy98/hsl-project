%% judge SLs by the spnum, attrnum and attrpos
load('spall.mat')
pararange=10;
indexmat=zeros(length(spall),1);
spnum=zeros(length(spall),1);
attrnum=zeros(length(spall),1);
attrpos=zeros(length(spall),4);
for ii=1:length(spall)
    sp=spall{ii};
    tmpspnum=0;
    for isp=1:length(sp)
        try
            tmpspnum=tmpspnum+length(sp{isp}(1,:));
        catch
        end
    end
    tmpattrnum=length(sp{1}(1,:));%record the number of attractors of each SL
    tmpattrpos=[0 0 0 0];%[s1 s2 x y]
    maxlength=max(max(sp{1}));
    for iattr=1:tmpattrnum    
        normsp=norm(sp{1}(:,iattr));           
        if normsp<0.1%points near zero
            tmpattrpos(1)=tmpattrpos(1)+1;
        elseif abs(sp{1}(1,iattr)-sp{1}(2,iattr))<0.4912*normsp%20`
            if normsp<0.5*maxlength
                tmpattrpos(1)=tmpattrpos(1)+1;
            else
                tmpattrpos(2)=tmpattrpos(2)+1;
            end
        else%other points
            if sp{1}(1,iattr)>sp{1}(2,iattr)
                tmpattrpos(3)=tmpattrpos(3)+1;
            else
                tmpattrpos(4)=tmpattrpos(4)+1;
            end
        end       
    end
    
    
    %% relate to index
    index=99;
    if tmpspnum==9
        index=41;
    elseif tmpspnum==7
        if isequal(tmpattrpos,[1 0 1 1])
            index=31;
        elseif isequal(tmpattrpos,[0 1 1 1])
            index=32;
        elseif isequal(tmpattrpos,[1 1 0 1])
            index=33;
        elseif isequal(tmpattrpos,[1 1 1 0])
            index=34;
        elseif isequal(tmpattrpos,[1 1 1 1])%4 attr; 3 1-saddle
            index=42;
        else
            index=95;
            disp('warning:index=95')
        end
    elseif tmpspnum==5
        if tmpattrnum==2
            if  isequal(tmpattrpos,[0 0 1 1])
                index=22;
            elseif isequal(tmpattrpos,[1 0 0 1])
                index=26;
            elseif isequal(tmpattrpos,[1 0 1 0])
                index=27;
            elseif isequal(tmpattrpos,[0 1 1 0])
                index=28;
            elseif isequal(tmpattrpos,[0 1 0 1])
                index=29;
            elseif isequal(tmpattrpos,[1 1 0 0])
                index=20;
            else
                index=94;
                disp('warning:index=94')
            end
        elseif tmpattrnum==3
            if isequal(tmpattrpos,[1 0 1 1])
                index=21;
            elseif isequal(tmpattrpos,[0 1 1 1])
                index=23;
            elseif isequal(tmpattrpos,[1 1 0 1])
                index=24;
            elseif isequal(tmpattrpos,[1 1 1 0])
                index=25;
            else
                index=93;
                disp('warning:index=93')
            end
        else
            disp('warning:sp=5,but attr')
        end
    elseif tmpspnum==3
        if tmpattrnum==2
            if isequal(tmpattrpos,[1 0 1 0])
                index=11;
            elseif isequal(tmpattrpos,[1 0 0 1])
                index=12;
            elseif isequal(tmpattrpos,[0 0 1 1])
                index=13;
            elseif isequal(tmpattrpos,[0 1 1 0])
                index=14;
            elseif isequal(tmpattrpos,[0 1 0 1])
                index=15;
            elseif isequal(tmpattrpos,[1 1 0 0])
                index=16;
            else
                index=92;
                disp('warning:index=92')
            end
        elseif tmpattrnum==1
            if isequal(tmpattrpos,[1 0 0 0])
                index=05;
            elseif isequal(tmpattrpos,[0 0 1 0])
                index=06;
            elseif isequal(tmpattrpos,[0 0 0 1])
                index=07;
            elseif isequal(tmpattrpos,[0 1 0 0])
                index=08;
            else
                index=91;
                disp('warning:index=91')
            end
        else
            disp('warning:sp=3,but attr')
        end
    elseif tmpspnum==1
        if isequal(tmpattrpos,[1 0 0 0])
            index=01;
        elseif isequal(tmpattrpos,[0 0 1 0])
            index=02;
        elseif isequal(tmpattrpos,[0 0 0 1])
            index=03;
        elseif isequal(tmpattrpos,[0 1 0 0])
            index=04;
        else
            index=90;
            disp('warning:index=90')
        end
    else
        disp('warning:spnum is out of control')
    end
    indexmat(ii)=index;
    spnum(ii)=tmpspnum;
    attrnum(ii)=tmpattrnum;
    attrpos(ii,:)=tmpattrpos;
end
save(['indexall',num2str(pararange),'.mat'],"attrpos","attrnum","spnum","indexmat")

%% plot
% load('indexall10.mat')
% histogram(indexmat,100)
% title('index of range 0-100')
% 
% undefsl=find(indexmat>=90);
% undefnum=length(undefsl)
% 
% nontrivalsl=find(indexmat>10 & indexmat<90);
% nontrivalnum=length(nontrivalsl)
% 
% complexsl=find(indexmat>25 & indexmat<45);
% complexnum=length(complexsl)
