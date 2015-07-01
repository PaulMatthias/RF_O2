function energdstrO2p(folder,s_ind,f_ind,nof)
dim=320; % # debye-length
dimv=400; % velocity
m_O2p=1; % mass Om
lambda_db=0.02101 ; %cm
omega_pe= 3.99e9; % s⁻1


% path=['../' folder '/out/'];
path=folder;

load([path 'V' num2str(nof) '.mat'])

X=V.vfO2px{s_ind}(:,1); % x-domain

r=length(s_ind:f_ind);

vfO2px_aver = zeros(length(X),401);
    vfO2py_aver = vfO2px_aver;
    vfO2pz_aver = vfO2px_aver;

vfO2px_count = zeros(200);
vfO2pz_count=vfO2px_count;
vfO2px_count_all = zeros(dimv);
vfO2pz_count_all=vfO2px_count;
scale=zeros;



printf("Summation of vf\n");

 for k=s_ind:f_ind
    vfO2px_aver = vfO2px_aver + V.vfO2px{k};
 %   vfO2py_aver = vfO2py_aver + V.vfO2py{k};
 %   vfO2pz_aver = vfO2pz_aver + V.vfO2pz{k};
 end

printf("Calculating average\n");
 vfO2px_aver = vfO2px_aver/r;
% vfO2py_aver = vfO2py_aver/r; %2pal dimensionierungsfaktor
 %vfO2pz_aver = vfO2pz_aver/r;


%init ROI
%for k=1:(dim/2)
% for l=1:int16(dimv)
%   vfO2px_calc(k,l)=vfO2px_aver(k,l);
%   vfO2pz_calc(k,l)=vfO2pz_aver(50,l+int16(dimv/2));
% end
%end
m=10;
for l=50:int16(dimv/2)
   vfO2px_calc2(l+1-50)=vfO2px_aver(m,l);
 end




%add particle of same vel 
  vfO2px_count=sum(vfO2px_aver');
 % vfO2pz_count=sum(vfO2pz_aver');

%scaling for velocities
for l=1:int16(dim)
%  dy(l)=0.02105*l;
  dy(l)=l;
end

%add energy scale
for l=1:int16(dimv/2)+1
  dx(l+dimv/2)=0.0287*l*l/20;
  dx(dimv/2+2-l)=-0.0287*l*l/20;  % not physically motivated /20
end

lx = 50:350;
[X,Y]=meshgrid(dx(lx),dy);

ex=50:200;
lex=dx(ex);

%add all particles
%for l=1:dimv
%  for k=1:dim
%  vfO2px_count_all(l)=vfO2px_count_all(l)+vfO2px_aver(k,l);
%  vfO2pz_count_all(l)=vfO2pz_count_all(l)+vfO2pz_aver(k,l);
%  end
%end


figure
subplot(2,1,1)
mesh(X,Y,log(vfO2px_aver(:,lx)))
title('O_2^+ v_x distribution')
ylabel('\lambda_{Db}')
xlabel('eV')
grid on
subplot(2,1,2)
plot(-lex,vfO2px_calc2)
title('O_2^+ v_x distribution')
ylabel('counts')
xlabel('eV')
title('')
legend('v_x at the anode')
grid on

end

