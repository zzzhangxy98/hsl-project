function F=plotodefun(opt)
syms x y
F_func=@parforodefunall;
k1=opt.k1;k2=opt.k2;k3=opt.k3;
k4=opt.k4;k5=opt.k5;k6=opt.k6;
r0x=opt.r0x;r0y=opt.r0y;
r1=opt.r1;r2=opt.r2;r3=opt.r3;
r4=opt.r4;r5=opt.r5;r6=opt.r6;
d1=opt.d1;d2=opt.d2;
n1=2;n2=2;
dxdt=(r0x+r1.*k1.*x.^n1+r2.*k2.*y.^n2+r3.*k3.*x.^n1.*y.^n2)./(1+k1.*x.^n1+k2.*y.^n2+k3.*x.^n1.*y.^n2)-d1.*x;
dydt=(r0y+r5.*k5.*x.^n1+r4.*k4.*y.^n2+r6.*k6.*x.^n1.*y.^n2)./(1+k5.*x.^n1+k4.*y.^n2+k6.*x.^n1.*y.^n2)-d2.*y;
f1=@(x,y) (r0x+r1.*k1.*x.^n1+r2.*k2.*y.^n2+r3.*k3.*x.^n1.*y.^n2)./(1+k1.*x.^n1+k2.*y.^n2+k3.*x.^n1.*y.^n2)-d1.*x;
f2=@(x,y) (r0y+r5.*k5.*x.^n1+r4.*k4.*y.^n2+r6.*k6.*x.^n1.*y.^n2)./(1+k5.*x.^n1+k4.*y.^n2+k6.*x.^n1.*y.^n2)-d2.*y;
figure()
% ezplot(dxdt);
p1=fimplicit(f1,LineWidth=2);
hold on 
% ezplot(dydt)
p2=fimplicit(f2,LineWidth=2);
axis([0 2 0 2])
% hold off
F=[dxdt;dydt];
%% quiver 
% mapmin=-0.001;
% mapmax=1;
% mapstep=0.03;
% range=mapmin:mapstep:mapmax;
% 
% % range = 0.1:0.1:0.6;
% % range = 0.2:0.01:0.8;
% [X,Y] = meshgrid(range);
% U=zeros(length(X));
% V=zeros(length(X));
% for j=1:length(X)
%     
%     F = F_func([X(j,:);Y(j,:)],opt);
%     U(j,:)=F(1,:);
%     V(j,:)=F(2,:);
% end
% z = sqrt(U .^ 2 + V .^ 2);
% U1 = U./z / 2;
% V1 = V./z / 2;
% 
% hold on
% q=quiver(X,Y,U1,V1,'LineWidth',0.5);
% plot([mapmin,mapmin],[mapmin,mapmax],'k','LineWidth',0.5);
% plot([mapmin,mapmax],[mapmin,mapmin],'k','LineWidth',0.5);
% plot([mapmax,mapmax],[mapmin,mapmax],'k','LineWidth',0.5);
% plot([mapmin,mapmax],[mapmax,mapmax],'k','LineWidth',0.5);
% mags = sqrt(sum(cat(2, reshape(U, numel(q.UData), []), reshape(V, numel(q.UData), []), ...
%             reshape(q.WData, numel(q.UData), [])).^2, 2));
% 
% %// Get the current colormap
% currentColormap = colormap(jet);
% 
% %// Now determine the color to make each arrow using a colormap
% [~, ~, ind] = histcounts(mags, size(currentColormap, 1));
% 
% %// Now map this to a colormap to get RGB
% cmap = uint8(ind2rgb(ind(:), currentColormap) * 255);
% cmap(:,:,4) = 255;
% cmap = permute(repmat(cmap, [1 3 1]), [2 1 3]);
% 
% %// We repeat each color 3 times (using 1:3 below) because each arrow has 3 vertices
% set(q.Head, ...
%     'ColorBinding', 'interpolated', ...
%     'ColorData', reshape(cmap(1:3,:,:), [], 4).');   %'
% 
% %// We repeat each color 2 times (using 1:2 below) because each tail has 2 vertices
% set(q.Tail, ...
%     'ColorBinding', 'interpolated', ...
%     'ColorData', reshape(cmap(1:2,:,:), [], 4).');
% colorbar();
% xlim([0 mapmax]);
% ylim([0 mapmax]);
% xlabel('X',FontSize=28,FontName='Times New Roman')
% ylabel('Y',FontSize=28,FontName='Times New Roman')
% set(gca,fontsize=28,fontname='Times New Roman')

end