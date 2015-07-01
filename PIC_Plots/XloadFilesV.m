function [L,V]=XloadFilesV(folder)


path=['/home/paulm/RF_O2/data_for_eval/' folder '/out/'];
printf("reading velocities\n");

try
   vfOmx_files=dir([path 'vfOmx*.dat']);
   vfOmsx_files=dir([path 'vfOmsx*.dat']);
%   vfOmy_files=dir([path 'vfOmy*.dat']);
   vfOmz_files=dir([path 'vfOmz*.dat']);
    L=length(vfOmx_files);
catch
    disp('no vfOm data')
  return;   
end

try

   vfO2px_files=dir([path 'vfO2px*.dat']);
%   vfO2pz_files=dir([path 'vfO2pz*.dat']);

   L2=length(vfOmx_files);
catch
    disp('no vfO2p data')
  return;   
end


disp('Starting up,') ;
disp(L) ; 

for k=1:L
	vfOmx_single{k}=load([path vfOmx_files(k).name]);
	vfOmsx_single{k}=load([path vfOmsx_files(k).name]);
 %      vfOmy{k}=load([path vfOmy_files(k).name]);
 %       vfOmz_single{k}=load([path vfOmz_files(k).name]);

        vfO2px_single{k}=load([path vfO2px_files(k).name]);

%        vfO2pz_single{k}=load([path vfO2pz_files(k).name]);

end

V.vfOmx=vfOmx_single;
V.vfOmsx=vfOmsx_single;
%M.vfOmy=vfOmy;
%V.vfOmz=vfOmz_single;


V.vfO2px=vfO2px_single;
%V.vfO2pz=vfO2pz_single;

save([folder 'V' num2str(L) '.mat'],'L','V');

end
