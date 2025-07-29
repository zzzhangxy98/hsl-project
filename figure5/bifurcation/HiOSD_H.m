function [perf,info]=HiOSD_H(F_func,x0,V0,k,opt)

%% prepare
x = x0;
n = length(x0);
dt = opt.dt1;
ds = opt.dt2;
l = opt.l;
xold=x0;
%% initialize of V
% V = randn(n,k);
[~,kk]=size(V0);
V = V0;
V = My_orth(V);
if opt.s
    perf.x=zeros(n,opt.max/opt.m);
end
info.nF=zeros(1,opt.max);
% info.E=zeros(1,opt.max);
ii=opt.max; % save the # of steps

%% iterate
for i=1:opt.max
%     disp(i)
    F = F_func(x,opt);
    nF=norm(F);
    info.nF(i)=nF;
%     info.E(i)=energy_protein(x,opt);
    if nF<opt.eps
        ii=i-1;
        break;
    elseif nF>50
%         F=F/nF;
        break
    end
    xnew = x+dt*(F-2*V(:,1:k)*(V(:,1:k)'*F))+0.9*(x-xold);
    xold=x;
    x=xnew;
    for j=1:kk
        V(:,j)=V(:,j)+ds*(F_func(x+l*V(:,j),opt)-...
               F_func(x-l*V(:,j),opt))/(2*l);
    end
    V = My_orth(V);
    if (opt.s) && (mod(i,opt.m)==0)
        perf.x(:,i/opt.m)=x;
    end
end

%% output
if ~opt.s
    perf.x=x;
else
    perf.x=perf.x(:,1:floor(ii/opt.m));
    perf.xfinal=x;
end
perf.V=V;
info.step=ii;
info.nF=info.nF(1:ii);
% info.E=info.E(1:ii);

end

function nV=My_orth(V)
[~,m]=size(V);
if m==0
    nV=V;
    return 
end
nV=V;
nV(:,1)=V(:,1)/norm(V(:,1));
for j=2:m
    q=V(:,j);
    for t=1:j-1
        q=q-q'*nV(:,t)*nV(:,t);
    end
    q=q/norm(q);
    for t=1:j-1
        q=q-q'*nV(:,t)*nV(:,t);
    end
    q=q/norm(q);
    nV(:,j)=q;
end

end
