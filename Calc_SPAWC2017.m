% Author: Prabhu Chandhar, Chandhar Research Labs, Chennai, India.


function [y] = Calc_SPAWC2017(M,K,del,lambda)

for lp=1:K
rvals(lp,:)=2*rand(1,100000)-1;
el(lp,:)=asin(rvals(lp,:))+pi/2;    
az(lp,:)=2*pi*rand(1,100000);
radii = 500*(rand(100000,1)).^(1/3);
x_j(lp).array = radii(lp,:).*cos(az(lp,:)).*sin(el(lp,:));
y_j(lp).array = radii(lp,:).*sin(az(lp,:)).*sin(el(lp,:));
z_j(lp).array = radii(lp,:).*cos(el(lp,:));
dk(lp,:) = sqrt(x_j(lp).array(1:end).^2+y_j(lp).array(1:end).^2+z_j(lp).array(1:end).^2);
z1(lp,:)= sin(el(lp,:)).*cos(az(lp,:));
end


for lp =1:K-1
for lp_1=1:length(z1(lp,:))
    gk = exp(-i*2*pi*(dk(1,lp_1)+((1/2/dk(1,lp_1))*([1:M].^2*del^2))-(del*([1:M]-1)*z1(1,lp_1)))/lambda);
    gj = exp(-i*2*pi*(dk(lp+1,lp_1)+((1/2/dk(lp+1,lp_1))*([1:M].^2*del^2))-(del*([1:M]-1)*z1(lp+1,lp_1)))/lambda);
    y(lp,lp_1) = abs(gj*conj(gk).')^2;
end

end
