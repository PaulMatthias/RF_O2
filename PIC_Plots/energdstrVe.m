function energdstrVe(folder,s_ind,f_ind,nof)
dim=320; % # debye-length
dimv=400; % velocity
m_Om=1; % mass Om
lambda_db=0.021 ; %cm
omega_pe= 3.99e9; % s⁻1


% path=['../' folder '/out/'];
path=folder;

load([path 'W' num2str(nof) '.mat'])

X=W.vfex{s_ind}(:,1); % x-domain

r=length(s_ind:f_ind);

vfex_aver = zeros(length(X),401);
    vfey_aver = vfex_aver;
    vfez_aver = vfex_aver;

vfex_count = zeros(dimv);
vfez_count=vfex_count;
vfex_count_all = zeros(dimv);
vfez_count_all=vfex_count;
scale=zeros;



printf("Summation of vf\n");

 for k=s_ind:f_ind
    vfex_aver = vfex_aver + W.vfex{k};
%    vfey_aver = vfey_aver + M.vfey{k};
    vfez_aver = vfez_aver + W.vfez{k};
 end
 
printf("Calculating average\n");
 vfex_aver = vfex_aver/r;
% vfey_aver = vfey_aver/r; %mal dimensionierungsfaktor
 vfez_aver = vfez_aver/r;


 %init ROI
for k=1:150
 for l=1:int16(dimv/2)
   vfex_calc(k,l)=vfex_aver(k+50,l);
   vfez_calc(k,l)=vfez_aver(k+50,l+int16(dimv/2));
 end
end



%add particle of same vel 
%  vfex_count=sum(vfex_calc');
%  vfez_count=sum(vfez_calc');
  vfex_count=sum(vfex_aver');
  vfez_count=sum(vfez_aver');


%scaling for velocities
%for l=1:int16(dimv/2)
%  scale(int16(dimv/2)+1-l)=l/(dimv/2)*omega_pe*lambda_db*8;
%end
for l=1:int16(dimv)
  scale(int16(dimv)+1-l)=(dimv/2-l)/(dimv/2)*omega_pe*lambda_db*8;
end


%create scaled matrix
vfex_count_all = [scale , vfex_count];



%add all particles
%for l=1:dimv
%  for k=1:dim
%  vfex_count_all(l)=vfex_count_all(l)+vfex_aver(k,l);
%  vfez_count_all(l)=vfez_count_all(l)+vfez_aver(k,l);
%  end
%end


figure
subplot(2,1,1)
mesh(vfex_aver)
title('Om_vx distribution')

subplot(2,1,2)
mesh(vfez_aver)
title('Om_v distribution')


%figure
%subplot(3,1,1)
%mesh(vfex_aver)
%title('vx distribution')
%ylabel('v')
%grid on
%subplot(3,1,2)
%plot(vfex_count_all) 
%title('vx count')
%ylabel('')
%grid on
%subplot(3,1,3)
%plot(vfez_count)
%title('v abs')
%xlabel('')
%grid on


end

