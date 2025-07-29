function [perf,info]=mygMAM(x0,x1,g_func,opt,U)

% parameters
n = opt.N;
m=length(x0);
maxstep = opt.max;
g1 = linspace(0,1,n);

%% initialization
if nargin < 5
    x = (x1-x0)*g1+x0;
else
    x=U;
    [~,mU]=size(U);
    dx = x-circshift(x,[0 1]);
    dx(:,1) = zeros(m,1);
    lx = cumsum(sqrt(sum(dx.^2)));
    lx = lx/lx(mU);
    x = (interp1(lx,x',g1))';
end
info.E=zeros(1,maxstep+1);
info.myE=zeros(100,maxstep+1);
info.myA=zeros(99,maxstep+1);

%% iterate
for step=1:maxstep
% 1. x_update
    [x,Ek,myEk,myA] = update(x,g_func,opt);
    info.E(step+1)=Ek;
    info.myE(:,step+1)=myEk;
    info.myA(:,step+1)=myA;
%     plot(x(1,:),x(2,:),'r','LineWidth',2)
%     drawnow
% 2. reparametrize  
    dx = x-circshift(x,[0 1]);
    dx(:,1) = zeros(m,1);
    lx = cumsum(sqrt(sum(dx.^2)));
    lx = lx/lx(n);
    x = (interp1(lx,x',g1))';
    if abs(info.E(step+1)-info.E(step))<opt.eps
        break
    end
end

perf.x=x;
info.step=step;
info.E=info.E(2:step+1);

end

%% Thomas algorithm
function [U,Ek,myEk,myA]=update(phi,g_func,opt)
% prepare parameters
[m,n]=size(phi);
tau=opt.tau;
A=zeros(2,n);
d=zeros(m,n);
gV=zeros(m,n);
nV=zeros(1,n);
Lk=zeros(m,n);
Lk(:,1)=phi(:,2)-phi(:,1);
NLK=norm(phi(:,2)-phi(:,1));
for j=2:n-1
    gV(:,j)=g_func(phi(:,j),opt);
    nV(j)=norm(gV(:,j));
    eps=1e-3/nV(j);
    d(:,j)=phi(:,j)-tau/eps*(g_func(phi(:,j)+eps*gV(:,j),opt)-gV(:,j));
    Lk(:,j)=(phi(:,j+1)-phi(:,j));
    NLK=NLK+norm(phi(:,j+1)-phi(:,j));
end
Ek=nV(2);
gk=nV/NLK;
A(1,2:n-1)=(n-1)^2*tau*(gk(2:n-1)).^2;
A(2,2:n-1)=1+2*A(1,2:n-1);
for j=2:n-1
    d(:,j)=d(:,j)+(n-1)^2*gk(j)*tau/2*...
        ((gk(j+1)-gk(j))*(phi(:,j+1)-phi(:,j))+(gk(j)-gk(j-1))*(phi(:,j)-phi(:,j-1)));
    Ek=Ek+norm(gV(:,j+1)+gV(:,j));
end
Ek=Ek*NLK/(2*n-2);
myEk=diag(gV'*Lk);
newgV=0.5*(gV(:,2:n)+gV(:,1:n-1));
% newLk=0.5*(Lk(:,2:n)+Lk(:,1:n-1));
% newgV=gV(:,1:n-1);
% newLk=Lk(:,1:n-1);

% Thomas algorithm
U=phi;
e=zeros(1,n);
f=zeros(m,n);
e(2)=A(1,2)/A(2,2);
f(:,2)=(d(:,2)+A(1,2)*U(:,1))/A(2,2);
for j=2:n-2
    z=A(2,j+1)-A(1,j+1)*e(j);
    e(j+1)=A(1,j+1)/z;
    f(:,j+1)=(d(:,j+1)+A(1,j+1)*f(:,j))/z;
end
for j=n-1:-1:2
    U(:,j)=f(:,j)+e(:,j)*U(:,j+1);
end
newLk=U-phi;
tempaction=vecnorm(newgV+newLk(:,2:length(newLk)),2);
myA=tempaction.^2;
end