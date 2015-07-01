function [L,M]=XloadFiles(folder)



% path=['runs/test/' folder '/out/'];
path=['/home/paulm/RF_O2/data_for_eval/' folder '/out/'];

disp('Starting up') ;

try    
    ne_files=dir([path 'ne*.dat']);
    L=length(ne_files);
catch
    disp('no electron data')
    return;
end

try
    phi_files=dir([path 'phi*.dat']);
catch
    disp('no potential data')
    return;
end

try
    O2p_files=dir([path 'O2p*.dat']);
catch
    disp('no O2p data')
    return;
end

try
    Om_files=dir([path 'Om*.dat']);
catch
    disp('no Om data')
    return;
end

try
    Oms_files=dir([path 'Oms*.dat']);
catch
    disp('no Oms data')
    return;
end


%try 
%    Tex_files=dir([path 'Tex*.dat']);
%    Tey_files=dir([path 'Tey*.dat']);
%    Tez_files=dir([path 'Tez*.dat']);
%catch
%    disp('no Te data')
%    return;
%end


disp(['number of datafiles: ' num2str(L)]);



    for k=1:L
        ne_single{k}=load([path ne_files(k).name]);
        phi_single{k}=load([path phi_files(k).name]);
        O2p_single{k}=load([path O2p_files(k).name]);
        Om_single{k}=load([path Om_files(k).name]);
        Oms_single{k}=load([path Oms_files(k).name]);
%        Tex{k}=load([path Tex_files(k).name]);
%        Tey{k}=load([path Tey_files(k).name]);
%        Tez{k}=load([path Tez_files(k).name]);
    end

   
M.ne=ne_single;
M.phi=phi_single;
M.O2p=O2p_single;
M.Om=Om_single;
M.Oms=Oms_single;
%M.Tex=Tex;
%M.Tey=Tey;
%M.Tez=Tez;



save([folder 'M' num2str(L) '.mat'],'L','M');
end
