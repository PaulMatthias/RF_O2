function X=load_files(path,string,start_id,final_id)

    try    
        X_files=dir([path string '*.dat']);
        L=length(X_files);
    catch 
        disp('error: no data / wrong path?')
        return;
    end

    disp(['number of datafiles ' string '*.dat : '  num2str(L)])
    
    if final_id > L
        final_id = L;
        disp(['warning: final_id >' num2str(L) ': less data used, than expected'])      
    end
    
    for k=start_id:final_id       
        X{k+1-start_id}=load([path X_files(k).name]);     
    end
    
end