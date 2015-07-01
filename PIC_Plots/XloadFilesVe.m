function [L,V]=XloadFilesVe(folder)


path=['/home/paulm/RF_O2/data_from_cluster/' folder '/out/'];
printf("reading velocities\n");

try
   vfex_files=dir([path 'vfex*.dat']);
%   vfey_files=dir([path 'vfey*.dat']);
   vfez_files=dir([path 'vfez*.dat']);

    L=length(vfex_files);
catch
    disp('no vfe data')
  return;   
end


disp('Starting up,') ;
disp(L) ; 

for k=1:L
	vfex_single{k}=load([path vfex_files(k).name]);
 %      vfey{k}=load([path vfey_files(k).name]);
        vfez_single{k}=load([path vfez_files(k).name]);
end

W.vfex=vfex_single;
%M.vfey=vfey;
W.vfez=vfez_single;

save([folder 'W' num2str(L) '.mat'],'L','W');

end
