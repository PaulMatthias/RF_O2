
function Xaverprofil_light(folder,s_ind,f_ind,nof,Te,ne) 



path=folder;
load([path 'M' num2str(nof) '.mat'])

X=M.ne{s_ind}(:,1); % x-domain
r=length(s_ind:f_ind);

ne_aver = zeros(length(X),1);
    phi_aver = ne_aver;
    O2p_aver = ne_aver;
    Om_aver = ne_aver;
%    Oms_aver = ne_aver;

 for k=s_ind:f_ind
	ne_aver = ne_aver + M.ne{k}(:,2);
	phi_aver = phi_aver + M.phi{k}(:,2);
        O2p_aver = O2p_aver + M.O2p{k}(:,2);
        Om_aver = Om_aver + M.Om{k}(:,2);
 %       Oms_aver = Oms_aver + M.Oms{k}(:,2);
 end

 phi_dim = Te;
 
 ne_aver=ne * ne_aver/r;
 phi_aver=phi_dim * phi_aver/r;
 O2p_aver=ne * O2p_aver/r;
 Om_aver=ne * Om_aver/r;
% Oms_aver=ne * Oms_aver/r;
 
figure
subplot(3,1,1)
plot(phi_aver)
title('potential')
xlabel('\lambda_{Db} /2')
ylabel('\Phi [V]')
h=legend('Potential');
legend(h,'location', 'northeastoutside')
grid on
subplot(3,1,2)
plot(X,ne_aver,'Linewidth',2)
hold on
plot(X,O2p_aver,'r','Linewidth',2)
%hold on
plot(X,Om_aver,'g','Linewidth',2)
%hold on
%plot(X,Oms_aver,'','Linewidth',2)
h=legend('e^-','O2⁺','O^-');
legend(h,'location', 'northeastoutside')
hold off
title('specie densities')
ylabel('density [cm^{-3}]')
grid on
subplot(3,1,3)
plot(X,O2p_aver-ne_aver-Om_aver,'bx')
title('quasi neutrality')
xlabel('\lambda_{db}')
h=legend('quasi neutrality');
legend(h,'location', 'northeastoutside')
grid on


end
