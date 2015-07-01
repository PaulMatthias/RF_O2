function XaverVel(folder,s_ind,f_ind,nof)

% path=['../' folder '/out/'];
path=folder;

load([path 'M' num2str(nof) '.mat'])

X=M.vfOmx{s_ind}(:,1); % x-domain
r=length(s_ind:f_ind);

vfOmx_aver = zeros(length(X),401);
    vfOmy_aver = vfOmx_aver;
    vfOmz_aver = vfOmx_aver;


printf("Summation of vf\n");

 for k=s_ind:f_ind
    vfOmx_aver = vfOmx_aver + M.vfOmx{k};
%    vfOmy_aver = vfOmy_aver + M.vfOmy{k};
    vfOmz_aver = vfOmz_aver + M.vfOmz{k};
 end
  

printf("Calculating average\n");
 vfOmx_aver = vfOmx_aver/r;
 vfOmy_aver = vfOmy_aver/r; %mal dimensionierungsfaktor
 vfOmz_aver = vfOmz_aver/r;





figure
subplot(3,1,1)
mesh(vfOmx_aver)
title('vx distribution')
ylabel('v')
grid on
subplot(3,1,2)
%plot(X,vfOmy_aver)
title('vy')
ylabel('')
grid on
subplot(3,1,3)
plot(X,vfOmz_aver)
title('vz')
xlabel('')
grid on


end
