function Xdevprofil(folder,nof,Te,ne)

% path=['../' folder '/out/'];
path=folder;
load([path 'M' num2str(nof) '.mat'])

X=M.ne{1}(:,1); % x-domain
t = 1:nof; 

for k=t;

    ne_dev(k) = ne * sum(M.ne{k}(:,2))./length(X);
	phi1_dev(k) = Te * sum(M.phi{k}(1,2));
    phi2_dev(k) = Te * sum(M.phi{k}(end,2));
	Om_dev(k) = ne *sum(M.Om{k}(:,2))./length(X); 

end

figure
subplot(3,1,1)
plot(t,phi1_dev,'b')
hold on
plot(t,phi2_dev,'r')
ylabel('\Phi [V]')
grid on
subplot(3,1,2)
plot(t,ne_dev,'bx-')
hold on
plot(t,Om_dev,'r')
hold off
legend('e^-','Ar^+')
ylabel('density [cm^{-3}]')
subplot(3,1,3)
plot(t,Om_dev-ne_dev,'bx')
xlabel('print step')
grid on

end
