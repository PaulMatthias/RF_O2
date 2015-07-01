function energy(folder,s_ind,f_ind,nof)
dim=320; % # debye-length
dimv=400; % velocity
m_Om=2.66e-26; % mass Om
lambda_db=0.00021 ; %cm
omega_pe= 3.99e9; % s⁻1
offset=200;
dvt=857;

% path=['../' folder '/out/'];
path=folder;

load([path 'V' num2str(nof) '.mat'])

X=V.vfOmx{s_ind}(:,1); % x-domain

r=length(s_ind:f_ind);

vfOmx_aver = zeros(length(X),401);
vfOmsx_aver = zeros(length(X),401);
 vfOmy_aver = vfOmx_aver;
%    vfOmz_aver = vfOmx_aver;

vfOmx_count = zeros(dimv);
%vfOmz_count=vfOmx_count;
vfOmsx_count = zeros(dimv);
vfOmsx_count_all=vfOmx_count;
vfOmx_count_all = zeros(dimv);
%vfOmz_count_all=vfOmx_count;
scale=zeros;



printf("Summation of vf\n");

 for k=s_ind:f_ind
    vfOmx_aver = vfOmx_aver + V.vfOmx{k};
    vfOmsx_aver = vfOmsx_aver + V.vfOmsx{k};
 %   vfOmy_aver = vfOmy_aver + V.vfOmy{k};
 %   vfOmz_aver = vfOmz_aver + V.vfOmz{k};
 end

 printf("Calculating average\n");
 vfOmx_aver = vfOmx_aver/r;
 vfOmsx_aver = vfOmsx_aver/r;
% vfOmy_aver = vfOmy_aver/r; %mal dimensionierungsfaktor
% vfOmz_aver = vfOmz_aver/r;


vfOmy_aver=vfOmx_aver+vfOmsx_aver;

%init ROI
k=160;
 for l=1:int16(dimv/2-30)
   vfOmx_calc1(l)=vfOmsx_aver(k,l);
 end
m=60;
 for l=50:int16(dimv/2)
   vfOmx_calc2(l+1-50)=vfOmy_aver(m,l);
 end



%add particle of same vel 
  vfOmx_count=sum(vfOmx_aver');
%  vfOmz_count=sum(vfOmz_aver');

%scaling for velocities
for l=1:int16(dimv)
  scale(int16(dimv)+1-l)=l/(dimv)*omega_pe*lambda_db*8;
end

%create scaled matrix
vfOmx_count_all = [scale , vfOmx_count];
%vfOmz_count_all = [scale , vfOmz_count];



%add all particles
%for l=1:dimv
%  for k=1:dim
%  vfOmx_count_all(l)=vfOmx_count_all(l)+vfOmx_aver(k,l);
%  vfOmz_count_all(l)=vfOmz_count_all(l)+vfOmz_aver(k,l);
%  end
%end



%add scale for y-axis equals x-axis in discharge 
for l=1:int16(dim)
  dy(l)=0.02105*l;
end

%add energy scale
for l=1:int16(dimv/2)+1
 % dx(l+dimv/2)=0.03948*l*l;
 % dx(dimv/2+2-l)=-0.03948*l*l;
  dx(l+dimv/2)=0.05735*l*l/2;
  dx(dimv/2+2-l)=-0.05735*l*l/2; %factor /2 not physically motivated
end

lx = 50:350;
[X,Y]=meshgrid(dx(lx),dy);

ex=50:200;
lex=dx(ex);

figure

subplot(4,1,1)
xlabel('eV')
ylabel('d in cm')
mesh(X,Y,log(vfOmx_aver(:,lx)))
title('Om vx distribution')


subplot(4,1,2)
xlabel('eV')
ylabel("d in cm")
mesh(X,Y,log(vfOmsx_aver(:,lx)))
title('Oms vx distribution')


subplot(4,1,3)
xlabel('eV')
ylabel("d in cm")
mesh(X,Y,log(vfOmy_aver(:,lx))) 
title('sum of Om distribution')
%title('Oms v_xdistribution in bulk')

subplot(4,1,4)
xlabel('eV')
ylabel("counts at d = ?")
plot(-lex,vfOmx_calc2) 
title('Om v_xdistribution at sheath')




end

