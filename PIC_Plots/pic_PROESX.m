%% PROES-part
% loading of EVDF data


close all
clear all
clc

%input parameter
ne=5e9; % cm^-3
Te=10;  % eV
Ti_Te=0.005; % Ti/Te
pressure=8; % Pa
folder='8Palong';

PROESloadflag=1;

if PROESloadflag==1
   [s,vftotal]=load_distelec(folder); 
else
    s=5000;
    load([folder 'M' num2str(s) '.mat']);
end

c=299793458;            % speed of light
y0=4*pi*1e-7;
e0=(c.^2*y0)^-1; 
q=1.602176e-19;         % elemtary charge
me	= 9.10938215e-31;		% kg
kB	= 1.38065e-23;
f_RF=13.56e6;


% wp=sqrt(ne*1e6*q.^2/(me*e0));                   % plasma frequency
wp=sqrt(3.1826e9*ne);
Ldb=sqrt(e0.*kB.*Te*11605./(ne*1e6.*q.^2));    % debye length

x=1:401;

v0=wp/0.2*0.5*Ldb;
vel=(x-201)/10/2.5*0.4*v0;

dti=5;
dtout=1*dti;

RF_steps=floor(wp/(0.2*f_RF));
RF_frames=round(RF_steps/10);

%temp=size(vftotal,1);
%vftotalX=vftotal(round(temp/2),:,:);

temp=size(vftotal,1);               %adept to O2
vftotalX=vftotal(round(temp/2),:,:);

C=mean(vftotalX,3); % frame-average
B=mean(C,1);        % space-average
B=squeeze(B);       % reduction of singleton-dimensions

D=fliplr(B(1:200))+B(202:end);
D=[B(201) D];

 % Excitation of 2p1 level from groundstate ~750,4nm
A=load('O2_ex1D.dat'); % c1: energy c2: Xsection m^2

% averaged distribution function

v=0:1e4:5e6;

TeMax=2.6;
fv0=sqrt(2/pi*(me/(kB*TeMax*11605))^3).*v.^2.*exp(-me*v.^2/(2*kB*TeMax*11605));

E=vel.^2/2*me/q;
E0=v.^2/2*me/q;

B1=trapz(vel,B);
D1=trapz(vel(201:end),D);

figure
    title('x-section and averaged EEDF')
    
    subplot(2,1,1)
        plot(A(:,1),A(:,2),'rx-') 
        xlabel('energy [eV]')
        ylabel('cross section [m^2]')

    subplot(2,1,2)
        semilogy(E,B/B1,'b.-')
        hold on
        semilogy(E(201:end),D/D1,'k--')
        semilogy(E0,fv0,'rx-')
        hold off
        xlabel('energy [eV]')
        ylabel('probability')
        
trapz(v,fv0)
trapz(vel,B)

%% Phase resolved optical emission spectroscopy (PROES)

    velX=vel(201:end);
    n_AR=3./5.*1.2e22; % neutral density

    h=sqrt(A(:,1)*q.*2./me);
    sigma=interp1(h/1e6,A(:,2)*1e20,velX/1e6,'linear');
    sigma=sigma*1e-20;
    sigma(isnan(sigma))=0;
    
    n=1;
    
    for l=1:RF_frames % 1:RFsteps/10 Frames
        
    vfe=vftotal(:,200:-1:1,l)+vftotal(:,202:end,l);
    vfe=[vftotal(:,201,l) vfe];
    
    S=size(vfe(:,:,end));
    
     SIGMA=bsxfun(@times,sigma,ones(S));
     VELX=bsxfun(@times,velX,ones(S));
        
        P(n,:)=n_AR*trapz(velX,SIGMA.*vfe.*4.*pi.*VELX.^3,2);
        n=n+1;

    end
    
    figure
    
    pcolor(P')
    shading interp
     
    
