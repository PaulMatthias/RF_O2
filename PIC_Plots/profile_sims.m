function profile_sims(folder,s_ind,f_ind,nof,Te,ne) 



path=folder;
load([path 'M' num2str(nof) '.mat'])

X=M.ne{s_ind}(:,1); % x-domain
r=length(s_ind:f_ind);

ne_aver = zeros(length(X),1);
    O2p_aver = ne_aver;
    Om_aver = ne_aver;
    Oms_aver = ne_aver;

 for k=s_ind:f_ind
	ne_aver = ne_aver + M.ne{k}(:,2);
        O2p_aver = O2p_aver + M.O2p{k}(:,2);
        Om_aver = Om_aver + M.Om{k}(:,2);
        Oms_aver = Oms_aver + M.Oms{k}(:,2);
 end

 
 ne_aver=ne * ne_aver/r;
 O2p_aver=ne * O2p_aver/r;
 Om_aver=ne * Om_aver/r;
 Oms_aver=ne * Oms_aver/r;
 
figure
plot(X,ne_aver,'Linewidth',2)
hold on
plot(X,O2p_aver,'r','Linewidth',2)
hold on
plot(X,Om_aver+Oms_aver,'g','Linewidth',2)
hold on
plot(X,Oms_aver,'k','Linewidth',2)
h=legend('e^-','O2⁺','O^-', 'O_s^-');
legend(h,'location', 'northeastoutside')
hold off
title('specie densities')
xlabel('\lambda_{Db}/2')
ylabel('density [cm^{-3}]')
grid on


end
