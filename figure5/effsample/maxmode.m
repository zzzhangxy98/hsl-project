function V=maxmode(F_func,x,k,opt)
n=length(x);
k=min(k,length(x));
V=randn(n,k); V=orth(V);
if k==0
    return;
end
tau=opt.dt2;
l=1e-4;
maxstep=1e5;
for i=1:maxstep
    for j=1:k
        V(:,j)=V(:,j)+tau*(F_func(x+l*V(:,j),opt)-F_func(x-l*V(:,j),opt))/(2*l);
    end
%     V = V+tau*(eye(n)-V*V')*A*V; 
    V=orth(V);
end
end