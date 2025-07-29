function [ind,V,flag]=cal_index(x,F_func,opt)
% calculate index at x
g=F_func(x,opt);
ind=0;V=[];
flag=1;
if norm(g)>1e-4
%     disp('It is not a critical point')
    flag=0;
    return
end


tau=0.002;
l=1e-4;
n=length(x);
maxstep=1e4;
found=0;
k=0;
V=zeros(n,0);
% while k<3 || ~found
while k<2
    v=randn(n,1);
    v=orthv2V(v,V);
    for j=1:maxstep
        v=v+tau*(F_func(x+l*v,opt)-F_func(x-l*v,opt))/(2*l);
        v=orthv2V(v,V);
    end
    k=k+1;
    V=[V,v];
    q=v'*(F_func(x+l*v,opt)-F_func(x-l*v,opt))/(2*l);
%     disp(q)
%     if q<0
%     if q<-1e-4
%         found=1;
%     end
end
% disp('---')
B=zeros(k);
for i=1:k
    for j=1:k
        q=V(:,i)'*...
       (F_func(x+l*V(:,j),opt)-F_func(x-l*V(:,j),opt))/(2*l);
        B(i,j)=q;
    end
end
lambda=eig(B);
% disp(lambda')
ind=sum(real(lambda)>0);
% fprintf('index2=%g\n',ind)

end

function v=orthv2V(v,V)
[~,k]=size(V);
for i=1:k
     v=v-v'*V(:,i)*V(:,i); % orthogonal
end
v=v/norm(v);
end
