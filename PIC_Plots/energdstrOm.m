function energdstrOm(folder,s_ind,f_ind,nof)
dim=320; % # debye-length
dimv=400; % velocity
m_Om=1; % mass Om
lambda_db=0.021 ; %cm
omega_pe= 3.99e9; % s⁻1


% path=['../' folder '/out/'];
path=folder;

load([path 'V' num2str(nof) '.mat'])

X=V.vfOmx{s_ind}(:,1); % x-domain

r=length(s_ind:f_ind);

vfOmx_aver = zeros(length(X),401);
    vfOmy_aver = vfOmx_aver;
    vfOmz_aver = vfOmx_aver;

vfOmx_count = zeros(dimv);
vfOmz_count=vfOmx_count;
vfOmx_count_all = zeros(dimv);
vfOmz_count_all=vfOmx_count;
scale=zeros;



printf("Summation of vf\n");

 for k=s_ind:f_ind
    vfOmx_aver = vfOmx_aver + V.vfOmx{k};
 %   vfOmy_aver = vfOmy_aver + V.vfOmy{k};
    vfOmz_aver = vfOmz_aver + V.vfOmz{k};
 end

printf("Calculating average\n");
 vfOmx_aver = vfOmx_aver/r;
% vfOmy_aver = vfOmy_aver/r; %mal dimensionierungsfaktor
 vfOmz_aver = vfOmz_aver/r;


 %init ROI
%for k=1:150
% for l=1:int16(dimv/2)
%   vfOmx_calc(k,l)=vfOmx_aver(k+50,l);
%   vfOmz_calc(k,l)=vfOmz_aver(50+k,l+int16(dimv/2));
% end
%end



%add particle of same vel 
  vfOmx_count=sum(vfOmx_aver');
  vfOmz_count=sum(vfOmz_aver');

%scaling for velocities
for l=1:int16(dimv)
  scale(int16(dimv)+1-l)=l/(dimv)*omega_pe*lambda_db*8;
end

%create scaled matrix
vfOmx_count_all = [scale , vfOmx_count];
vfOmz_count_all = [scale , vfOmz_count];



%add all particles
%for l=1:dimv
%  for k=1:dim
%  vfOmx_count_all(l)=vfOmx_count_all(l)+vfOmx_aver(k,l);
%  vfOmz_count_all(l)=vfOmz_count_all(l)+vfOmz_aver(k,l);
%  end
%end


figure
subplot(2,1,1)
mesh(vfOmx_aver)
title('Om vx distribution')
zlim([0, 10])
caxis([0, 10])

subplot(2,1,2)
mesh(vfOmz_aver) 
title('Om v distribution')



end

