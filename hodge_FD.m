function out = hodge_FD(Hodge1, tInterval)
% HODGE_FD computes effective Hodge diffusion dimension from heat trace.
%
% INPUT
%   Hodge1    : 1-Hodge Laplacian
%   tInterval : fitting interval [tmin tmax]
%
% OUTPUT
%   out.lambda   : eigenvalues of Hodge1
%   out.beta1    : dimension of harmonic subspace
%   out.tvals    : diffusion time values
%   out.Z        : heat trace
%   out.Zplus    : decaying heat trace Z(t)-beta1
%   out.dH       : effective Hodge spectral dimension
%   out.dH_local : local effective dimension
%   out.C        : fitted constant
%   out.Zfit     : fitted heat trace over fitting range
%   out.idx      : fitting index
%
% (C) Moo K. Chung
% University of Wisconsin-Madison
% mkchung@wisc.edu

tmin = tInterval(1);
tmax = tInterval(2);

tvals = logspace(-3,3,300);

nEig = min(10000, size(Hodge1,1)-2);
lambda = eigs(Hodge1,nEig,'smallestabs');
lambda = sort(real(lambda));
tol = 1e-8;
lambda(lambda < tol) = 0;
beta1 = sum(lambda == 0);

Z = zeros(size(tvals));
for i = 1:length(tvals)
    Z(i) = sum(exp(-tvals(i)*lambda));
end

Zplus = Z - beta1;

logt = log(tvals);
logZplus = log(Zplus);

dH_local = -2 * gradient(logZplus)./gradient(logt);

idx = find(tvals >= tmin & tvals <= tmax & Zplus > 0);

p = polyfit(log(tvals(idx)),log(Zplus(idx)),1);

dH = -2*p(1);
C = exp(p(2));

Zfit = C * tvals(idx).^(-dH/2);

tfit_plot = tvals(tvals >= tmin/2 & tvals <= tmax*4);
Zfit_plot = C * tfit_plot.^(-dH/2);

figure;
loglog(tvals,Zplus,'k','LineWidth',2)
hold on
loglog(tfit_plot,Zfit_plot,'r--','LineWidth',2)
xlabel('Diffusion time t')
ylabel('Heat trace Z(t)-\beta_1')
title(['Diffusion Dimension d_H = ' num2str(dH,'%.2f')])
set(gca,'FontSize',16,'LineWidth',1.5)
axis square

out.lambda = lambda;
out.beta1 = beta1;
out.tvals = tvals;
out.Z = Z;
out.Zplus = Zplus;
out.dH = dH;
out.dH_local = dH_local;
out.C = C;
out.Zfit = Zfit;
out.idx = idx;
out.tfit_plot = tfit_plot;
out.Zfit_plot = Zfit_plot;

end