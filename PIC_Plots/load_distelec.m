function [s,vftotal]=load_distelec(folder)

folder=['/home/paulm/RF_O2/runs/data/' folder '/out/'];

% clear all
% close all
% clc
% 
% Te=5;
% ne=5e8;
% folder='../runsARGON30Pa25V0.03m_X/out/';
% RF_step=465;
% out_step=25;
% start=10;
% stop=99985;
% 
% c=299793458;            % speed of light
% y0=4*pi*1e-7;
% e0=(c.^2*y0)^-1; 
% q=1.602176e-19;         % elemtary charge
% me	= 9.10938215e-31;		% kg
% kB	= 1.38065e-23;
% 
% wp=sqrt(ne*1e6*q.^2/(me*e0));                   % plasma frequency
% Ldb=sqrt(e0.*kB.*Te*11605./(ne*1e6.*q.^2));    % debye length
% 
% x=1:401;
% 
% v0=wp/0.2*0.5*Ldb;
% vel=(x-200)/10/2.5*0.4*v0;
 
% filename_x='vfex_time*.dat';
% filename_y='vfey_time*.dat';
%filename_z='vfez_time*.dat';
filename_z='vfez*.dat';
% files_x=dir([folder filename_x]);
% files_y=dir([folder filename_y]);
files_z=dir([folder filename_z]);

s=length(files_z);
Z=load([folder files_z(1).name]);
S=size(Z);
H=zeros(S);
n=1;
vftotal=zeros([S s]);

for k=1:s
    
% X=load([folder files_x(k).name]);
% Y=load([folder files_y(k).name]);
Z=load([folder files_z(k).name]);

% vftotal(:,:,n)=H+sqrt(X.^2+Y.^2+Z.^2);
vftotal(:,:,n)=Z;

n=n+1;
end

save([folder '/vftotal' num2str(s) '.mat'],'vftotal')

% S=size(X);
% n=0;

% for l=start:out_step:RF_step+start-1
% 
%     n=n+1;
%     H=zeros(S);
% 
%     for k=l:RF_step:stop
% 
%         ks=sprintf('%08d',k);
% 
%         % filename_x='vfex*.dat';
%         % filename_y='vfey*.dat';
%         % filename_z='vfez*.dat';
% 
%         filename_x=['vfex' ks '.dat'];
%         filename_y=['vfey' ks '.dat'];
%         filename_z=['vfez' ks '.dat'];
% 
%         X=load([folder filename_x]);
%         Y=load([folder filename_y]);
%         Z=load([folder filename_z]);
% 
%         vftotal(:,:,n)=H+sqrt(X.^2+Y.^2+Z.^2);
% 
%     end
% 
% end
% 
% s_y=size(vftotal(:,:,1),1);
% s_x=size(vftotal(:,:,1),2);
% 
% [vel_mesh_x,space_mesh_y]=meshgrid(vel,1:s_y);
% 
% 
% pcolor(vel_mesh_x,space_mesh_y,vftotal(:,:,1))
% shading interp
end
