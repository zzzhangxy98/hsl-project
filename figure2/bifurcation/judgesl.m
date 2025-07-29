function [index,spnum,attrnum,attrpos]=judgesl(sp)
%% judge SLs by the spnum, attrnum and attrpos
spnum=0;
for isp=1:length(sp)
    try
        spnum=spnum+length(sp{isp}(1,:));
    catch
    end
end
attrnum=length(sp{1}(1,:));%record the number of attractors of each SL
attrpos=[0 0 0 0];%[s1 s2 x y]
maxlength=max(max(sp{1}));
for iattr=1:attrnum    
    normsp=norm(sp{1}(:,iattr));           
    if normsp<0.1 %points near zero
        attrpos(1)=attrpos(1)+1;
    elseif abs(sp{1}(1,iattr)-sp{1}(2,iattr))<0.4912*normsp%20 degree
        if normsp<0.5*maxlength
            attrpos(1)=attrpos(1)+1;
        else
            attrpos(2)=attrpos(2)+1;
        end
    else%other points
        if sp{1}(1,iattr)>sp{1}(2,iattr)
            attrpos(3)=attrpos(3)+1;
        else
            attrpos(4)=attrpos(4)+1;
        end
    end       
end


%% relate to index with the help of Simplified HSL
index=99;
if spnum==9
    index=41;
elseif spnum==7
    if isequal(attrpos,[1 0 1 1])
        index=31;
    elseif isequal(attrpos,[0 1 1 1])
        index=32;
    elseif isequal(attrpos,[1 1 0 1])
        index=33;
    elseif isequal(attrpos,[1 1 1 0])
        index=34;
    elseif isequal(attrpos,[1 1 1 1])%4 attr; 3 1-saddle
        index=42;
    else
        index=95;
        disp('warning:index=95')
    end
elseif spnum==5
    if attrnum==2
        if  isequal(attrpos,[0 0 1 1])
            index=22;
        elseif isequal(attrpos,[1 0 0 1])
            index=26;
        elseif isequal(attrpos,[1 0 1 0])
            index=27;
        elseif isequal(attrpos,[0 1 1 0])
            index=28;
        elseif isequal(attrpos,[0 1 0 1])
            index=29;
        elseif isequal(attrpos,[1 1 0 0])
            index=20;
        else
            index=94;
            disp('warning:index=94')
        end
    elseif attrnum==3
        if isequal(attrpos,[1 0 1 1])
            index=21;
        elseif isequal(attrpos,[0 1 1 1])
            index=23;
        elseif isequal(attrpos,[1 1 0 1])
            index=24;
        elseif isequal(attrpos,[1 1 1 0])
            index=25;
        else
            index=93;
            disp('warning:index=93')
        end
    else
        disp('warning:sp=5,but attr')
    end
elseif spnum==3
    if attrnum==2
        if isequal(attrpos,[1 0 1 0])
            index=11;
        elseif isequal(attrpos,[1 0 0 1])
            index=12;
        elseif isequal(attrpos,[0 0 1 1])
            index=13;
        elseif isequal(attrpos,[0 1 1 0])
            index=14;
        elseif isequal(attrpos,[0 1 0 1])
            index=15;
        elseif isequal(attrpos,[1 1 0 0])
            index=16;
        else
            index=92;
            disp('warning:index=92')
        end
    elseif attrnum==1
        if isequal(attrpos,[1 0 0 0])
            index=05;
        elseif isequal(attrpos,[0 0 1 0])
            index=06;
        elseif isequal(attrpos,[0 0 0 1])
            index=07;
        elseif isequal(attrpos,[0 1 0 0])
            index=08;
        else
            index=91;
            disp('warning:index=91')
        end
    else
        disp('warning:sp=3,but attr')
    end
elseif spnum==1
    if isequal(attrpos,[1 0 0 0])
        index=01;
    elseif isequal(attrpos,[0 0 1 0])
        index=02;
    elseif isequal(attrpos,[0 0 0 1])
        index=03;
    elseif isequal(attrpos,[0 1 0 0])
        index=04;
    else
        index=90;
        disp('warning:index=90')
    end
else
    disp('warning:spnum is out of control')
end
