function [index,spnum,attrnum,attrpos]=judgesl(sp,downjilu)
%judge sl for seesaw
%the number of sp
spnum=0;
for isp=1:length(sp)
    try
        spnum=spnum+length(sp{isp}(1,:));
    catch
    end
end
attrnum=length(sp{1}(1,:));%record the number of attractors of each SL
attrpos=[];

%relate to index
index=99;
if spnum==5
    if attrnum==3
        attrpos=[0,0,0];
        for i=1:3
            attrpos(i)=judgeattr(sp{1}(:,i));
        end
        flag=ismember(attrpos,[1,2,3]);
        if all(flag)%the attractors are made up of [1 2 3]
            if length(downjilu(:,1))==4
                indc=sum(downjilu(:,4))-6;%the index of center attractor
                if attrpos(indc)==1
                    index=8;
                elseif attrpos(indc)==2
                    index=7;
                elseif attrpos(indc)==3
                    index=9;
                else
                    index=30;
                    disp('warning:index=30')
                end
            else
                disp('warning:more or less connections')
            end
        else
            disp('warning:the attractors are out of control')
        end
    else
        disp('warning:sp=5,index=99')
    end
            
elseif spnum==3
    if attrnum==2
        attrpos=[0,0];
        %make attrpos
        for i=1:2
            attrpos(i)=judgeattr(sp{1}(:,i));
        end
        
        if isequal(attrpos,[1,2]) || isequal(attrpos,[2,1])
            index=4;
        elseif isequal(attrpos,[1,3]) || isequal(attrpos,[3,1])
            index=6;
        elseif isequal(attrpos,[2,3]) || isequal(attrpos,[3,2])
            index=5;
        else
            index=20;
            disp('warning:index=20')
        end
    else
        disp('warning:sp=3,index=99')
    end
elseif spnum==1
    attrpos=judgeattr(sp{1});
    if attrpos==1
        index=2;
    elseif attrpos==2
        index=1;
    elseif attrpos==3
        index=3;
    else
        index=10;
        disp('warning:index=10')
    end
else
    disp('warning:spnum is out of control')
end


    function label=judgeattr(sp)
        %judge by the position of attractors. sp is a 4*1 vector.
        stemness=sp(1)+sp(2);
        bias=(sp(1)+sp(3))-(sp(2)+sp(4));
        if stemness>1.5 %stem
            label=1;
        elseif stemness<1.5 && bias>0%me
            label=2;
        elseif stemness<1.5 && bias<0%ect
            label=3;
        else
            label=4;
        end
    end

end