function [op]=outageCalculation(data,threshold,opt)

[yy,xx,n,emsg,eid] = cdfcalc(data);
if ~isempty(eid)
    error(sprintf('stats:cdfplot:%s',eid),emsg);
end

k = length(xx);
n = reshape(repmat(1:k, 2, 1), 2*k, 1);
xCDF    = [-Inf; xx(n); Inf];
yCDF    = [0; 0; yy(1+n)];

switch opt
    case 'SINR'
%     yPercentage=yCDF;
%     tmp=xCDF(find(yPercentage<=threshold));
    xPercentage=xCDF;
    tmp=yCDF(find(xPercentage<=threshold));
    case 'TPT'
    yPercentage=yCDF;
    tmp=xCDF(find(yPercentage<=threshold));
end

op=tmp(end);
